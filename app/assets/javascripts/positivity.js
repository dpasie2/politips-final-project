var categories = ["Ben Carson","Carly Fiorina","Jeb Bush","Hillary Clinton","Donald Trump","Bernie Sanders"];

var percents = [100, 92, 84, 68, 56, 36];

  var colors = ['#33CCCC','#33CCCC','#33CCCC','#33CCCC','#33CCCC'];

  var grid = d3.range(100).map(function(i) {
    return {
      'x1': 0,
      'y1': 0,
      'x2': 0,
      'y2': 460
    };
  });

  var tickVals = grid.map(function(d, i) {
    if (i > 0) {
      return i * 10;
    } else if (i === 0) {
      return "100";
    }
  });

  var xscale = d3.scale.linear()
    .domain([0, 100])
    .range([0, 772]);

  var yscale = d3.scale.linear()
    .domain([0, categories.length])
    .range([0, 480]);

  var colorScale = d3.scale.quantize()
    .domain([0, categories.length])
    .range(colors);

  var canvas = d3.select('#wrapper')
    .append('svg')
    .attr({
      'width': 900,
      'height': 550
    });

  var grids = canvas.append('g')
    .attr('id', 'grid')
    .attr('transform', 'translate(150,10)')
    .selectAll('line')
    .data(grid)
    .enter()
    .append('line')
    .attr({
      'x1': function(d, i) {
        return i * 30;
      },
      'y1': function(d) {
        return d.y1;
      },
      'x2': function(d, i) {
        return i * 30;
      },
      'y2': function(d) {
        return d.y2;
      },
    })
    .style({
      'stroke': '#adadad',
      'stroke-width': '1px'
    });

  var xAxis = d3.svg.axis();
  xAxis
    .orient('bottom')
    .scale(xscale)
    .tickValues(tickVals);

  var yAxis = d3.svg.axis();
  yAxis
    .orient('left')
    .scale(yscale)
    .tickSize(0.01)
    .tickFormat(function(d, i) {
      return categories[i];
    })
    .tickValues(d3.range(17));

  var y_xis = canvas.append('g')
    .attr("transform", "translate(150,50)")
    .attr('id', 'yaxis')
    .call(yAxis);

  var x_xis = canvas.append('g')
    .attr("transform", "translate(150,480)")
    .attr('id', 'xaxis')
    .call(xAxis);

  var chart = canvas.append('g')
    .attr("transform", "translate(150,0)")
    .attr('id', 'bars')
    .selectAll('rect')
    .data(percents)
    .enter()
    .append('rect')
    .attr('height', 59)
    .attr({
      'x': 0,
      'y': function(d, i) {
        return yscale(i) + 19;
      }
    })
    .style('fill', function(d, i) {
      return colorScale(i);
    })
    .attr('width', function(d) {
      return 0;
    });


  var transit = d3.select("svg").selectAll("rect")
    .data(percents)
    .transition()
    .duration(2000)
    .attr("width", function(d) {
      return xscale(d);
    });

  var transitext = d3.select('#bars')
    .selectAll('text')
    .data(percents)
    .enter()
    .append('text')
    .attr({
      'x': function(d) {
        if (d != 0){
        return xscale(d) -90;
      } else {
        return xscale(d) - 500;
      }
      },
      'y': function(d, i) {
        return yscale(i) + 55;
      }
    })
    .text(function(d) {
      return d + "%";
    }).style({
      'fill': '#fff',
      'font-size': '25px',
      'font-family':'Open Sans, sans-serif'
    });
