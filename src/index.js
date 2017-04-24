"use strict"

const audioPorts = require("./Native/audio")
const visPorts = require("./Native/vis")

require("./index.html")
require("./Stylesheets.elm")

const Elm = require("./Main.elm")
const mountNode = document.getElementById("main")

const app = Elm.Main.embed(mountNode)

audioPorts(app)
visPorts(app)
