const Vibrant = require("node-vibrant")

module.exports = function(app) {
  const body = document.getElementsByTagName('body')[0]

  function updateColor(imageUrl) {
    if (imageUrl.length > 0) {
      Vibrant.from(imageUrl)
        .getPalette((err, palette) => {
          const vibrant = palette.DarkVibrant._rgb
          const darkVibrant = vibrant.map(n => n - 45)

          body.style.background = "linear-gradient(rgb(" + vibrant.join(",") + "), rgb(" + darkVibrant.join(",") + ") 50%)"
        })
    }
  }

  app.ports.changeBgColor.subscribe(updateColor)
}
