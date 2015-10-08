# require "net/http"
# # Used to commmunicate with server and receive response
# require "uri"
# # Wrap url using uri
# require "json"
#
# ## republican request
# republican_uri = URI("http://elections.huffingtonpost.com/pollster/api/polls")
# params = {"topic" => "2016-president-gop-primary", "after" => "2015-09-20"}
# republican_uri.query = URI.encode_www_form(params)
#
# ##republican response
# Net::HTTP.get(republican_uri)
# republican_response = Net::HTTP.get_response(republican_uri)
# republican_body = JSON.parse(republican_response.body)
# finished_republican = republican_body[0]["questions"][0]["subpopulations"][0]["responses"].to_json
#
#
# # Write to file
#
# # open("../../public/2016-president-gop-primary.json", "w") do |f|
# #     f << finished_republican
# # end
#
# ## democrat request
# democrat_uri = URI("http://elections.huffingtonpost.com/pollster/api/polls")
# params = {"topic" => "2016-president-dem-primary", "after" => "2015-09-20"}
# democrat_uri.query = URI.encode_www_form(params)
#
# ## democrat response
# Net::HTTP.get(democrat_uri)
# democrat_response = Net::HTTP.get_response(democrat_uri)
# democrat_body = JSON.parse(democrat_response.body)
# finished_democrat = democrat_body[1]["questions"][1]["subpopulations"][0]["responses"].to_json
#
#
# # Write to file
#
# # open("../../public/2016-president-dem-primary.json", "w") do |f|
# #     f << finished_democrat
# # end
#
