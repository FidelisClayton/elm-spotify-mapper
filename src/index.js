"use strict"

const urlParser = require("url-parser")

window.urlParser = urlParser

const audioPorts = require("./Native/audio")
const visPorts = require("./Native/vis")
const localStoragePorts = require("./Native/localStorage")

require("./index.html")
require("./Stylesheets.elm")

const Elm = require("./Main.elm")
const mountNode = document.getElementById("main")

const code = urlParser.parse(window.location.href, true).query.code
const spotifyCode = code ? code : ""

const authData = JSON.parse(localStorage.getItem('spotify-auth-data'))

const app = Elm.Main.embed(mountNode, {
  spotifyConfig: {
    clientId: process.env.CLIENT_ID,
    clientSecret: process.env.CLIENT_SECRET,
    redirectUri: process.env.REDIRECT_URI
  },
  auth: authData ? {
    accessToken: authData.access_token,
    expiresIn: Number(authData.expires_in),
    tokenType: authData.token_type
  } : null
})

audioPorts(app)
visPorts(app)
localStoragePorts(app)
