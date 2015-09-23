$(document).ready( function () {
  var margin = {top: 20, right: 20, bottom: 30, left: 400};
  var width = 900 - margin.left - margin.right;
  var height = 400 - margin.top - margin.bottom;

  var x = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1);

  var y = d3.scale.linear()
    .range([height, 0]);

  var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

  var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .tickFormat( function (d) { return d + "%"; });

  var chart = d3.select(".d3-charts")
    .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  d3.json("2016-president-dem-primary.json", function(error, data) {
    console.log(data)
    x.domain(data.map(function(d) { return d.choice; }))
    y.domain([0, d3.max(data, function(d) { return d.value; })
    ])

    chart.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);

    chart.append("g")
      .attr("class", "y axis")
      .call(yAxis)
      .append("text")
      .attr("y",6)
      .attr("dy", ".71em")
      .style("text-anchor", "end");

    chart.selectAll(".bar")
      .data(data)
      .enter()
      .append("rect")
      .attr("class", "bar")
      .attr("x", function(d) { return x(d.choice); })
      .attr("width", x.rangeBand())
      .attr("y", "0" )
      .attr("height", "0")
      .transition().duration(2000)
      .attr("y", function(d) { return y(d.value); })
      .attr("height", function(d) { return height - y(d.value); })
      .attr("fill", function(d) { return "rgb( 0, 0," + (d.value * 10) + ")"; });
 });
});

