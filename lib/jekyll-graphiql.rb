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
    endpoint  = @params[:endpoint]
    
    %Q{
    <div class="graphiql #{ view_only ? "view-only" : ""}">
    Loading...
      <div class="endpoint">
      #{ endpoint }
      </div>
      <div class="query">
      #{ query }
      </div>
      <div class="response">
      #{ response }
      </div>
    </div>
    }
  end

  Liquid::Template.register_tag "graphiql", self
end
