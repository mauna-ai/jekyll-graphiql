# Jekyll Youtube

This is a jekyll port of [sphinx-graphql](https://github.com/hasura/sphinx-graphiql):

> a GraphiQL plugin for Sphinx that lets you make GraphQL queries from your docs.

https://github.com/hasura/sphinx-graphiql

## Installation

Add this line to your Gemfile:

```ruby
group :jekyll_plugins do
  gem "jekyll-graphiql"
end
```

And then execute:

    $ bundle

Alternatively install the gem yourself as:

    $ gem install jekyll-graphiql

and put this in your `_config.yml`

```yaml
plugins:
  [jekyll-graphiql]
  # This will require each of these gems automatically.
```

**Important**: You also need to add the following html tags at the bottom of the `<head>` tag in your layout.html file:

```html
<!-- GraphiQL -->
<script src="//cdn.jsdelivr.net/react/15.4.2/react.min.js"></script>
<script src="//cdn.jsdelivr.net/react/15.4.2/react-dom.min.js"></script>
<script src="https://rawgit.com/hasura/sphinx_graphiql/master/static/graphiql/graphiql.min.js"></script>
<link
  href="https://rawgit.com/hasura/sphinx_graphiql/master/static/graphiql/graphiql.css"
  rel="stylesheet"
/>
<link
  href="https://rawgit.com/hasura/sphinx_graphiql/master/static/styles.css"
  rel="stylesheet"
/>
<script type="text/javascript">
  // graphql query fetcher
  const graphQLFetcher = function (endpoint) {
    endpoint = endpoint || "{{ GRAPHIQL_DEFAULT_ENDPOINT }}";
    return function (graphQLParams) {
      const params = {
        method: "post",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
        },
        body: JSON.stringify(graphQLParams),
        credentials: "include",
      };
      return fetch(endpoint, params)
        .then(function (response) {
          return response.text();
        })
        .then(function (responseBody) {
          try {
            return JSON.parse(responseBody);
          } catch (error) {
            return responseBody;
          }
        });
    };
  };

  // create GraphiQL components and embed into HTML
  const setupGraphiQL = function () {
    if (
      typeof React === "undefined" ||
      typeof ReactDOM === "undefined" ||
      typeof GraphiQL === "undefined"
    ) {
      return;
    }

    const targets = document.getElementsByClassName("graphiql");
    for (let i = 0; i < targets.length; i++) {
      const target = targets[i];
      const endpoint = target
        .getElementsByClassName("endpoint")[0]
        .innerHTML.trim();
      const query = target.getElementsByClassName("query")[0].innerHTML.trim();
      const response = target
        .getElementsByClassName("response")[0]
        .innerHTML.trim();
      const graphiQLElement = React.createElement(GraphiQL, {
        fetcher: graphQLFetcher(endpoint),
        schema: null, // TODO: Pass undefined to fetch schema via introspection
        query: query,
        response: response,
      });
      ReactDOM.render(graphiQLElement, target);
    }
  };

  // if graphiql elements present, setup graphiql
  if (document.getElementsByClassName("graphiql").length > 0) {
    setupGraphiQL();
  }
</script>
```

## Usage

The tag name is `graphiql`. You can pass the options as a yaml-formatter string.

Options:

- `view_only`
- `query`
- `response`
- `endpoint`

```
 {% graphiql
    view_only: false
    query: |
      query {
         author {
            id
            name
         }
      }

    response: |
      {
          "data": {
             "author": [
                {
                   "id": 1
                   "name": "Justin",
                },
                {
                   "id": 2
                   "name": "Beltran",
                },
                {
                   "id": 3
                   "name": "Sidney",
                }
            ]
         }
      }

    endpoint: http://localhost:8080/v1/graphql
 %}
```
