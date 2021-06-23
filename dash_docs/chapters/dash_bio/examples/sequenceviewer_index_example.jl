using Dash, DashBio
using StringEncodings, HTTP, JSON

req = HTTP.request("GET", "https://raw.githubusercontent.com/plotly/dash-bio-docs-files/master/sequence_viewer_P01308.fasta")
data = decode(req.body, "UTF-8")

mdata = JSON.parse(data)


app = dash()


app.layout = dashbio_needleplot(
  id="my-dashbio-needleplot",
  mutationData=mdata
)

run_server(app, "0.0.0.0", debug=true)