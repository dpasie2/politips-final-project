var COLORS = {
  "unemployment": "#D13F31",
  "taxes": "#A6A6A6",
  "health care": "#4D94FF",
  "corporate corruption": "#FF5050",
  "terrorism": "#525564",
  "foreign policy": "#E93829",
  "immigration":"#3366CC",
  "climate change":"#DBD1C8",
  "education":"#21409A",
  "race relations":"#FFABAB",
  "marriage equality":"#ADC2EB"
};

var DEFAULT_CANDIDATE_NAME = "bush";
var pack, canvas, nodes, node;

function displayChart(data, candidateName) {
  candidateName = candidateName || DEFAULT_CANDIDATE_NAME
  nodes = pack.nodes(data[candidateName.toLowerCase()]);

  // binds data to the canvas
  node = canvas.selectAll(".node")
   .data(nodes)
   .enter()
   .append("g")
   .attr("class", "node")
   .attr("transform", function (d) {
     return "translate(" + d.x + "," + d.y + ")";
   });

  node.append("circle")
    .attr("fill", function(d) { return d.children ? "#fff" : COLORS[d.issue]; })
    .attr("stroke", function(d) { return d.children ? "#fff" : "black"; })
    .attr("r", function(d) { return d.value/2;})
    .transition().duration(2000)
    .attr("r", function(d) { return d.r + 20; })
    // .attr("opacity", .90)
    .attr("stroke-width", "3");

  node.append("text")
    .attr("text-anchor", "middle")
    .style("font-family", "open sans")
    .text(function(d) {
      return d.children ? "" : d.issue === "marriage equality" ? "LGBT rights": d.issue === "corporate corruption" ? "corporate crime" : d.issue;
    })
    .style("font-size", function(d) { return d.value <= 2 ? "10px" : Math.min(1.3 * d.r, (1.3 * d.r - 8) / this.getComputedTextLength() * 25) + "px"; })
    .attr("dy", ".35em");
}

$(document).ready(function() {
  var width = 900, height = 700;

  // sets width and height of the canvas
  canvas = d3.select(".d3").append("svg")
           .attr("width", width)
           .attr("height", height)
           .attr("id", "category-chart")
           .append("g")
           .attr("transform", "translate(50, 50)");

  // sets the layout to pack
  pack = d3.layout.pack()
         .size([width, height])
         .padding(60);

  var candidateData;

  d3.json("categories_data.json", function(data) {
    candidateData = data;
    displayChart(candidateData);

    $(".link a").on("click", function(event) {
      event.preventDefault();
      $(".node").remove();
      displayChart(candidateData, this.id)
    });
  });
});
