var bgColor = "#121212";
var lightBlue = "#3a9fbf";
var obsidian_invert = "#dad8d5";
var purple = "#C3BCDB";

var chart = LightweightCharts.createChart(
  document.getElementById("chart-container"),
  {
    price: false,
    rightPriceScale: {
      borderColor: purple,
      scaleMargins: {
        top: 0.3,
        bottom: 0.25,
      },
      borderVisible: false,
    },

    timeScale: {
      borderColor: purple,
      barSpacing: 20, // Barlar arası mesefa güzel kardesim
      rightOffset: 1,
      rightBarStaysOnScroll: true,
    },
    layout: {
      background: { color: bgColor },
      textColor: purple, // Chart Text Color
      fontFamily: "Comfortaa",
      fontSize: 12,
    },
    grid: {
      vertLines: {
        color: "#444",
        visible: false,
      },
      horzLines: {
        color: "#444",
        visible: false,
      },
    },
    crosshair: {
      mode: LightweightCharts.CrosshairMode.Normal,
      vertLine: {
        color: purple,
      },
      horzLine: {
        color: lightBlue,
      },
    },
    handleScroll: {
      vertTouchDrag: false,
    },
    handleScale: {
      axisPressedMouseMove: {
        price: false,
        pinch: true,
      },
    },
  }
);

// Setting the border color for the horizontal axis

// Add Histogram (Volume) chart
var volumeSeries = chart.addHistogramSeries({
  lastValueVisible: false,
  priceLineVisible: false,
  color: "#26a69a",

  priceFormat: {
    type: "volume",
  },
  priceScaleId: "",
  scaleMargins: {
    top: 0.85,
    bottom: 0,
  },
});

async function fetchKlines(url) {
  let response = await fetch(url);
  let data = await response.json();
  return data;
}
function timeToLocal(originalTime) {
  const d = new Date(originalTime);
  return (
    Date.UTC(
      d.getFullYear(),
      d.getMonth(),
      d.getDate(),
      d.getHours(),
      d.getMinutes(),
      d.getSeconds(),
      d.getMilliseconds()
    ) / 1000
  );
}

async function main() {
  function addChartData(arr) {
    let c_time = timeToLocal(arr[0]);
    console.log(c_time);
    let candle = {
      time: c_time,
      open: Number(arr[1]),
      high: Number(arr[2]),
      low: Number(arr[3]),
      close: Number(arr[4]),
    };
    // RED: 'rgba(255,82,82, 0.8)'
    // Green: "rgba(0, 150, 136, 0.8)"
    candleData.push(candle);
    let color = purple;
    if (candleData[candleData.length - 2] != null) {
      if (
        candleData[candleData.length - 2].close >
        candleData[candleData.length - 1].close
      ) {
        color = "rgba(255,82,82, 0.8)";
      } else {
        color = "rgba(0, 150, 136, 0.8)";
      }
    }
    let volume_bar = {
      time: c_time,
      value: Number(arr[5]),
      color: color,
    };

    volumeData.push(volume_bar);
  }

  var klines = await fetchKlines(
    "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1s"
  );

  let candleData = [];
  let volumeData = [];
  klines.forEach(addChartData);
  // Add Candlestick chart
  var candleSeries = chart.addCandlestickSeries({
    priceLineWidth: 1,
    priceFormat: {
      type: "price",
      precision: 6,
      minMove: 0.000001,
    },
    borderVisible: true,
  });
  candleSeries.setData(candleData);
  volumeSeries.setData(volumeData);
  // Update Last Candle

  var socket = new WebSocket(
    "wss://stream.binance.com:9443/ws/btcusdt@kline_1s"
  );

  // When message received from web socket then...
  socket.onmessage = function (event) {
    // Easier and shorter.
    var data = JSON.parse(event.data);

    // "x" means: Is this kline closed? Return "true" if closed. Closed means new line to be added.
    if (data.k.x === true) {
      // Adding a line with my custom function.
      addLine(data);
    } else {
      // Updating line with my custom function.
      updatePrice(data);
    }
  };

  function addLine(data) {
    let time = timeToLocal(data.k.t);
    console.log(time);
    let newCandle = {
      time: time,
      open: Number(data.k.o),
      high: Number(data.k.h),
      low: Number(data.k.l),
      close: Number(data.k.c),
    };
    candleData.push(newCandle);
    candleSeries.update(newCandle);
    let color = purple;
    if (candleData[candleData.length - 2] != null) {
      if (
        candleData[candleData.length - 2].close >
        candleData[candleData.length - 1].close
      ) {
        color = "rgba(255,82,82, 0.8)";
      } else {
        color = "rgba(0, 150, 136, 0.8)";
      }
    }
    let newBar = {
      time: time,
      value: Number(data.k.v),
      color: color,
    };
    volumeData.push(newBar);
    volumeSeries.update(newBar);
  }

  function updatePrice(data) {
    console.log("update Data");
    console.log(data.k.c);
    candleData[candleData.length - 1].open = Number(data.k.o);
    candleData[candleData.length - 1].high = Number(data.k.h);
    candleData[candleData.length - 1].low = Number(data.k.l);
    candleData[candleData.length - 1].close = Number(data.k.c);
    candleSeries.update(candleData[candleData.length - 1]);
  }
  /*
  handleMessage.postMessage("HI FROM JS");
  window.addEventListener("flutterInAppWebViewPlatformReady", function (event) {
    // call flutter handler with name 'mySum' and pass one or more arguments
    window.flutter_inappwebview
      .callHandler("handleMessage", 12, 2, 50)
      .then(function (result) {
        // get result from Flutter side. It will be the number 64.
        console.log(result);
      });
  });
  */
}

main();
