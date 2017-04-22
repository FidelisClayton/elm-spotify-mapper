"use strict"

const audioPorts = require("./Native/audio")

require("./index.html")
require("./Stylesheets.elm")

const Elm = require("./Main.elm")
const mountNode = document.getElementById("main")

const app = Elm.Main.embed(mountNode)

audioPorts(app)
