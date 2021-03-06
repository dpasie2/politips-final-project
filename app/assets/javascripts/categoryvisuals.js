var pack, canvas, nodes, node,
    currentCandidate = "Trump",
    COLORS = {
      "unemployment": "#D13F31",
      "economy": "#A6A6A6",
      "health care": "#4D94FF",
      "corporate crime": "#FF5050",
      "terrorism": "#525564",
      "foreign policy": "#E93829",
      "immigration":"#3366CC",
      "climate change":"#DBD1C8",
      "education":"#21409A",
      "race relations":"#FFABAB",
      "lgbt rights":"#ADC2EB"
    };

function displayChart(data) {
  nodes = pack.nodes(data[currentCandidate]);

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
  .attr("fill", function(d) { return d.children ? "transparent" : COLORS[d.issue]; })
  .attr("stroke", function(d) { return d.children ? "none" : "black"; })
  .attr("r", function(d) { return d.value/2;})
  .transition().duration(2000)
  .attr("r", function(d) { return d.r + 20; })
  // .attr("opacity", .90)
  .attr("stroke-width", "3");

  node.append("text")
    .attr("text-anchor", "middle")
    .style("font-family", "open sans")
    .text(function(d) {
      return d.children ? "" : d.issue === "lgbt rights" ? "LGBT rights" : d.issue;
    })
    .style("font-size", function(d) { return d.value <= 2 ? "10px" : Math.min(1.3 * d.r, (1.3 * d.r - 8) / this.getComputedTextLength() * 25) + "px"; })
    .attr("dy", ".35em");
}

$(document).ready(function() {
	$(".d3").on("click", ".node", function(event) {
		var category = $(this).find("text").text();

		var request = $.ajax({
			method: "get",
			url: "/candidates/" + currentCandidate + "/tweets",
			data: { category: category }
		});
		request.done(function(tweet_ids) {
      $("#sidebar-wrapper").hide();
			$("#twitter-overlay").show();
			$("#tweet-container").show();
			$("#tweet-box").show();
			tweet_ids.forEach(function(tweet_id) {
				twttr.widgets.createTweet(
					tweet_id,
					document.getElementById('tweet-box'),
					{
						theme: "dark"
					}
				)
				.then(function(element) {
					$("iframe").each(function() {
						$(this).width(500);
					});
				});
			});
		});
	});

  $("#close-button").on("click", function(event) {
    event.preventDefault();
    $("#sidebar-wrapper").show();
    $("#twitter-overlay").hide();
    $("#tweet-container").hide();
    $("#tweet-box").hide();
    $("iframe").remove();
  });

  var width = 800, height = 600;

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

    $("#candidate-header").text("Donald Trump")

    $(".link a").on("click", function(event) {
      event.preventDefault();
      $(".node").remove();
			currentCandidate = this.id;
      $("#candidate-header").text($(this).text());
      displayChart(candidateData);
    });
  });
});
