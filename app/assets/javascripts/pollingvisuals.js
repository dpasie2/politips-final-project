$(document).ready( function () {

margin = {top: 20, right: 20, bottom: 30, left: 300};
width = 1200 - margin.left - margin.right;
height = 400 - margin.top - margin.bottom;
dems = "2016-president-dem-primary.json"
polling_chart(dems);

$("#republican-chart-button").on("click", function(event) {
    event.preventDefault();
    $(".d3-charts").empty()
    var repubs = "2016-president-gop-primary.json"
    margin = {top: 20, right: 20, bottom: 30, left: 100};
    width = 1400 - margin.left - margin.right;
    polling_chart(repubs);
  });

$("#democratic-chart-button").on("click", function(event) {
  event.preventDefault();
  $(".d3-charts").empty()
  margin = {top: 20, right: 20, bottom: 30, left: 70};
  width = 1200 - margin.left - margin.right;
  height = 400 - margin.top - margin.bottom;
  polling_chart(dems);

  });
});

var polling_chart = function(data){

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
    .attr("id", "polls-chart")
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  d3.json(data, function(error, data) {
    console.log(data)
    x.domain(data.map(function(d) { return d.choice; }))
    y.domain([0, d3.max(data, function(d) { return d.value; })
    ])

    self.data = data

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
      .attr("fill", function(d) {
        console.log("getting here!")
        console.log(self.data)
        if (self.data[0]["party"] === "Dem") {
          return "rgb( 0, 0," + (d.value * 20) + ")";
        } else if (self.data[0]["party"] === "Rep") {
          return "rgb( " + (d.value * 20) + ", 0, 0 )";
        }
      });
 });
};
