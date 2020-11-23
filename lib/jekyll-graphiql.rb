require "jekyll"
require "jekyll-graphiql/version"
require "yaml"

class GraphiqlEmbed < Liquid::Tag

  def initialize(tagName, content, tokens)
    super
    @params = YAML.load(content)
  end

  def render(context)

    view_only = @params[:view_only] || false
    query     = @params[:query]     || ""
    response  = @params[:response]  || ""
    endpoint  = @params[:endpoint]  || "/graphql"
    
    # Need to do this dance because multiline strings include indentation and
    # that messes up the output.
    # 
    # See: https://github.com/Shopify/liquid/issues/136#issuecomment-19178257
    output = ""

    output += "<div class=\"graphiql #{ view_only ? "view-only" : ""}\">"
    output += 'Loading...'
    output +=   '<div class="endpoint">'
    output +=   endpoint
    output +=   '</div>'
    output +=   '<div class="query">'
    output +=   query
    output +=   '</div>'
    output +=   '<div class="response">'
    output +=   response
    output +=   '</div>'
    output += '</div>'

    return output
  end

  Liquid::Template.register_tag "graphiql", self
end
