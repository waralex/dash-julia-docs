using Dash, DashHtmlComponents, DashCoreComponents

options = [
    (label = "New York City", value = "NYC"),
    (label = "Montreal", value = "MTL"),
    (label = "San Francisco", value = "SF")
]

app = dash()

app.layout = html_div(style = Dict("height" => "150px")) do

    html_label(["Single Dynamic Dropdown", dcc_dropdown(id="demo-dropdown-2") ]),

    html_label(["Multi Dynamic Dropdown", dcc_dropdown(id="demo-dropdown-3", multi=true) ])

end

callback!(
    app,
    Output("demo-dropdown-2", "options"),
    Input("demo-dropdown-2", "search_value"),
) do search_value
    isnothing(search_value) && throw(PreventUpdate())
    search_value == "" && throw(PreventUpdate())

    return [o for o in options if occursin(search_value, o.label)]
end

callback!(
    app,
    Output("demo-dropdown-3", "options"),
    Input("demo-dropdown-3", "search_value"),
    State("demo-dropdown-3", "value")
) do search_value, value
    isnothing(search_value) && throw(PreventUpdate())
    search_value == "" && throw(PreventUpdate())
    

    return [o for o in options if occursin(search_value, o.label) || in(o.value, something(value, []))]
end


run_server(app, "0.0.0.0", debug=true)
