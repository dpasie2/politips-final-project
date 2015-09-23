var currentCandidate = "Sanders";
var pack, canvas, nodes, node;

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
      .attr("fill", function(d) { return d.children ? "#fff" : "steelblue"; })
      .attr("stroke", function(d) { return d.children ? "#fff" : "#ADADAD"; })
      .attr("r", function(d) { return d.value/2;})
      .transition().duration(2000)
      .attr("r", function(d) { return d.r; })
      .attr("opacity", .30)
      .attr("stroke-width", "2");

  node.append("text")
      .text(function(d) {
        return d.children ? "" : d.issue;
      });
}

$(document).ready(function() {

	$(".d3").on("click", ".node", function(event) {
		console.log($(this).find("text").text());
		var category = $(this).find("text").text();

		var request = $.ajax({
			method: "get",
			url: "/candidates/" + currentCandidate + "/tweets",
			data: { category: "Taxes" }
		});
		request.done(function(tweet_ids) {
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

  var candidateData;

  d3.json("fakedata.json", function(data) {
    candidateData = data;
    displayChart(candidateData);

    $(".link a").on("click", function(event) {
      event.preventDefault();
      $(".node").remove();
			currentCandidate = this.id;
      displayChart(candidateData);
    });
  });
});
