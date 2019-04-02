HTMLWidgets.widget({

  name: 'calmap',

  type: 'output',

  factory: function(el, width, height) {

    var instance = {};

    return {

      instance: instance,

      renderValue: function(x) {

        instance.x = x;
        instance.cal = [];

        var data = {};

        x.data.date.forEach(function(d,i) {
          var timestamp = d3.timeParse("%Y-%m-%d")(d).getTime() / 1000;
          data[timestamp] = x.data.count[i];
        });

        x.data = data;

        if(x.hasOwnProperty("start")) {
          x.start = d3.timeParse("%Y-%m-%d")(x.start).getTime();
        }

        if(x.facet) {
          var s = new Set();
          // get unique years
          d3.keys(x.data).forEach(function(d) {
            s.add(d3.timeFormat('%Y')(new Date(d*1000)));
          });
          var divs = d3.select(el).selectAll('div')
            .data(Array.from(s));
          divs = divs.merge(divs.enter().append('div'));
          divs.each(function(d) {
            var newx = JSON.parse(JSON.stringify(x));
            // set itemSelector to be el
            newx.itemSelector = this;
            // set start to beginning of the year
            newx.start = d3.timeParse("%Y-%m-%d")(d + "-01" + "-01").getTime() / 1000;
            // filter data for this year
            newx.data = {};
            d3.entries(x.data).filter(function(val) {
              return d3.timeFormat("%Y")(val.key * 1000) === d;
            }).forEach(function(val) {
              newx.data[val.key] = val.value;
            });
            var cal = new CalHeatMap();
            instance.cal.push(cal);
            cal.init(newx);
          });
        } else {
          // set itemSelector to be el
          x.itemSelector = el;
          var cal = new CalHeatMap();
          instance.cal.push(cal);
          cal.init(x);
        }

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
