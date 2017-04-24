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
  let network;

  function init(artist) {
    setTimeout(() => {
      const container = document.getElementById("VisContainer")
      const node = { id: "aslkdja", label: "Test", value: 20 }
      const data = { nodes: new vis.DataSet([node]), edges: new vis.DataSet([]) }
      try {
        network = new vis.Network(container, data, defaultOptions)

        app.ports.getVisStatus.send(true)
      } catch (err) {
        app.ports.getVisStatus.send(false)
      }

    }, 100)
  }

  function destroy() {
    if (network !== undefined)
      network.destroy()
  }

  function addSimilar() {
    // verificar se o artista já existe
  }

  app.ports.initVis.subscribe(init)
  app.ports.destroyVis.subscribe(destroy)
}
