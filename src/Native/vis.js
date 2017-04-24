const vis = require("vis")

const defaultOptions =
{
  nodes: {
    borderWidth: 3,
    borderWidthSelected: 3,
    shape: 'dot',
    scaling: {
      min: 20,
      max: 30,
      label: { 
        min: 14, 
        max: 30, 
        drawThreshold: 9, 
        maxVisible: 20 }
      },
    font: {
      size: 12, 
      face: 'Arial'
    },
    borderWidth: 3,
    color: {
      border: "#1ed760",
      background: "#0a0a0a",
      highlight: {
        border: "#D3D71E",
        background: "#0a0a0a"
      },
      hover: {
        border: "#fff",
        background: "#0a0a0a"
      }
    },
  },
  interaction: {
    hover: true,
    hoverConnectedEdges: true,
    selectConnectedEdges: true,
  },
  edges: {
    color: {
      color: "rgba(31,33,32,1)",
      highlight: "#1ed760",
      inherit: false
    }
  },
}

module.exports = function(app) {
  let network
  let edges
  let nodes

  function init(data) {
    console.log(data)
    setTimeout(() => {
      const container = document.getElementById("VisContainer")
      edges = new vis.DataSet(data.edges),
      nodes = new vis.DataSet(data.nodes)

      const visData = {edges, nodes}

      network = new vis.Network(container, visData, {})

      network.on("click", function (params) {
        if(params.nodes[0] != undefined){
          app.ports.onNodeClick.send(params.nodes[0])
        }
      });

      // network.on("doubleClick", function (params) {
      //   $scope.playTopTrack(params.nodes[0]);
      // });

    }, 100)
  }

  function destroy() {
    if (network !== undefined)
      network.destroy()
  }

  function addSimilar(data) {
    data[0].forEach(node => nodes.add(node))
    data[1].forEach(edge => edges.add(edge))

    app.ports.updateNetwork.send(data)
  }

  app.ports.initVis.subscribe(init)
  app.ports.destroyVis.subscribe(destroy)
  app.ports.addSimilar.subscribe(addSimilar)
}
