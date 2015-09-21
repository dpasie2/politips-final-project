var DEFAULT_CANDIDATE_NAME = "sanders";
var pack, canvas;

function displayChart(data, candidateName) {
  candidateName = candidateName || DEFAULT_CANDIDATE_NAME;
  var nodes = pack.nodes(data[candidateName.toLowerCase()]);

  // binds data to the canvas
  var node = canvas.selectAll(".node")
    .data(nodes)
    .enter()
    .append("g")
      .attr("class", "node")
      .attr("transform", function (d) {
            return "translate(" + d.x + "," + d.y + ")";
      });

  node.append("circle")
    .attr("fill", function (d) { return d.children ? "#fff" : "steelblue"; })
    .attr("stroke", function (d) { return d.children ? "#fff" : "#ADADAD"; })
    .attr("r", function (d) { return d.value/2;})
    .transition().duration(2000)
    .attr("r", function (d) { return d.r; })
    .attr("opacity", .30)
    .attr("stroke-width", "2");

  node.append("text")
    .text(function (d) {
      return d.children ? "" : d.issue;
    });
}


$(document).ready(function() {
  var width = 800, height = 600;

  // sets width and height of the canvas
  canvas = d3.select(".d3").append("svg")
    .attr("width", width)
    .attr("height", height)
    .append("g")
      .attr("transform", "translate(50, 50)");

  // sets the layout to pack
  pack = d3.layout.pack()
    .size([width, height - 50])
    .padding(10);

  // passes json as data

  //important, need to swap data in and out on event clicks of candidates tabs
  // $(div????).on("click" function (event) {
  //   var candidate = this.last_name

  d3.json("fakedata.json", function (data) {
    // console.log(data);
    displayChart(data);
  });

  $()
});
