const vis = require("vis")

const defaultOptions = {
  nodes: {
    borderWidth: 3,
    borderWidthSelected: 3,
    shape: 'dot',
    scaling: {
      min: 20,
      max: 30,
    },
    font: "14px arial #FFF",
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
      color: "rgba(255, 255, 255, 0.5)",
      highlight: "#1ed760",
      inherit: false
    }
  },
  layout: {
    hierarchical: {
      direction: 'UD'
    }
  }
}

module.exports = function(app) {
  let network
  let edges
  let nodes

  function init(data) {
    if (data.nodes[0].id !== "") {
      setTimeout(() => {
        const container = document.getElementById("VisContainer")
        edges = new vis.DataSet(data.edges)
        nodes = new vis.DataSet(data.nodes)

        const visData = {edges, nodes}

        network = new vis.Network(container, visData, defaultOptions)

        network.on("click", function (params) {
          if(params.nodes[0] != undefined){
            app.ports.onNodeClick.send(params.nodes[0])
          }
        })

        network.on("doubleClick", function (params) {
          app.ports.onDoubleClick.send(params.nodes[0])
        })

      }, 100)
    }
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
