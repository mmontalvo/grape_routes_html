require "grape_routes_html/version"

module GrapeRoutesHtml
  
  def initialize
    
    grape_endpoints = ObjectSpace.each_object(Class).select { |klass| klass < Grape::API}
# [API::V1::XXX1, API::V1::XXX2, .. ]

    main_html = "<div id='grape_routes_info'>"
    
    grape_endpoints.each do |grape_endpoint|
      
# API::V1::XXX

      grape_endpoint_html = "<table class='grape_endpoint'>"
      grape_endpoint_html += "<thead><tr><th colspan='7'>#{grape_endpoint.to_s}</th></tr>"
      grape_endpoint_html += "<tr><th>Params</th><th>Description</th><th>Prefix</th><th>Version</th><th>Namespace</th><th>Method</th><th>Path</th></tr></thead><tbody>"
      routes_endpoint = grape_endpoint.routes
# routes
      routes_endpoint.each do |route_endpoint|
# route
        options_values = route_endpoint.instance_values['options']
        
# route options keys       
        grape_endpoint_html += "<tr>"
        [:params, :description, :prefix, :version, :namespace, :method, :path].each do |key|
          grape_endpoint_html += "<td>#{options_values[key]}</td>"
        end
        grape_endpoint_html += "</tr>"
      end

      grape_endpoint_html += "</tbody></table>"
      main_html += grape_endpoint_html
    end
    
    main_html += "</div>"
    
  end
  
end