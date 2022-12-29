// Note: Edit the structure!

class appChart {
  buildChart(symbol, interval) {
    const bgColor = "#121212";
    const upColor = "#66BB6A";
    const downColor = "#EF5350";
    const obsidian_invert = "#dad8d5";
    var chart = LightweightCharts.createChart(
      document.getElementById("chart-container"),
      {
        price: false,
        rightPriceScale: {
          borderColor: obsidian_invert,
          scaleMargins: {
            top: 0.1,
          },
          borderVisible: false,
        },

        timeScale: {
          borderColor: obsidian_invert,
          barSpacing: 8, // Barlar arası mesefa güzel kardesim
          rightOffset: 8,
          rightBarStaysOnScroll: true,
        },
        layout: {
          background: { color: bgColor },
          textColor: obsidian_invert, // Chart Text Color
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
            color: obsidian_invert,
          },
          horzLine: {
            color: obsidian_invert,
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
      color: obsidian_invert,

      priceFormat: {
        type: "volume",
      },
      priceScaleId: "",
      scaleMargins: {
        top: 0.91,
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
        let color = obsidian_invert;
        if (candleData[candleData.length - 2] != null) {
          if (
            candleData[candleData.length - 2].close >
            candleData[candleData.length - 1].close
          ) {
            color = downColor;
          } else {
            color = upColor;
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
        "https://api.binance.com/api/v3/klines?symbol=" +
          symbol.toUpperCase() +
          "&interval=" +
          interval
      );

      Number.prototype.countDecimals = function () {
        if (Math.floor(this.valueOf()) === this.valueOf()) return 0;
        return this.toString().split(".")[1].length || 0;
      };

      let numofDecimals = Number(klines[0][4]).countDecimals();
      console.log(numofDecimals);
      let candleData = [];
      let volumeData = [];
      klines.forEach(addChartData);
      // Add Candlestick chart
      var candleSeries = chart.addCandlestickSeries({
        priceLineWidth: 1,

        priceFormat: {
          type: "price",
          precision: numofDecimals,
          minMove: 1.0 / 10 ** numofDecimals,
        },

        borderVisible: true,
        upColor: upColor,
        downColor: downColor,
        borderUpColor: upColor,
        borderDownColor: downColor,
        wickUpColor: upColor,
        wickDownColor: downColor,
      });
      candleSeries.setData(candleData);
      volumeSeries.setData(volumeData);
      // Update Last Candle

      var socket = new WebSocket(
        "wss://stream.binance.com:9443/ws/" +
          symbol.toLowerCase() +
          "@kline_" +
          interval
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

        let newCandle = {
          time: time,
          open: Number(data.k.o),
          high: Number(data.k.h),
          low: Number(data.k.l),
          close: Number(data.k.c),
        };

        candleData.push(newCandle);
        candleSeries.update(newCandle);
        let color = obsidian_invert;
        if (candleData[candleData.length - 2] != null) {
          if (
            candleData[candleData.length - 2].close >
            candleData[candleData.length - 1].close
          ) {
            color = down;
          } else {
            color = up;
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
        candleData[candleData.length - 1].open = Number(data.k.o);
        candleData[candleData.length - 1].high = Number(data.k.h);
        candleData[candleData.length - 1].low = Number(data.k.l);
        candleData[candleData.length - 1].close = Number(data.k.c);
        candleSeries.update(candleData[candleData.length - 1]);
      }
    }

    main();
  }
}
