"use strict"

const urlParser = require("url-parser")

window.urlParser = urlParser

const audioPorts = require("./Native/audio")
const visPorts = require("./Native/vis")

require("./index.html")
require("./Stylesheets.elm")

const Elm = require("./Main.elm")
const mountNode = document.getElementById("main")

const code = urlParser.parse(window.location.href, true).query.code
const spotifyCode = code ? code : ""

const app = Elm.Main.embed(mountNode, {
  code: spotifyCode
})

audioPorts(app)
visPorts(app)
