# Spotify Mapper
App built with Elm to explore new artists using the Spotify api. [See online Demo](http://spotify-mapper.fidelisclayton.com/).

This app is a new version of my previous Spotify mapper built with Angular 1.x. I used this app to learn more about Elm and see how it works beyond the simplicity of TODO apps.

![Elm Spotify Mapper](https://media.giphy.com/media/3ohzdNH8xOeaxTp37W/giphy.gif)

## :package: Features
- :mag_right: Search Artists
- :microphone: Discover related artists
- :notes: Play song previews
- :musical_score: Generate Spotify playlists with the explored artists

## Installation
```sh
$ git clone https://github.com/FidelisClayton/elm-spotify-mapper
$ cd elm-spotify-mapper
$ npm install
```
After clone this repository run `npm install` inside the project folder to install and build the project dependencies.

## :runner: Getting started
First of all you will need to set the environment variables with your spotify developer credentials:
```sh
cp .env.sample .env
```
Open the `.env` file and set the `CLIENT_ID`, `CLIENT_SECRET` and `REDIRECT_URI`.
To run this project in your machine you just need to execute the `npm start`command, it will start a development server on port `3000`. Enjoy it!

## :memo: TODO
- [x] Create playlist with the artists on the node tree
- [x] Improve the fold structure and split the Update function
- [ ] Improve mobile experience (maybe it should seems like the spotify mobile.)
- [ ] Tests

## :heart: Contributing
Please use the [issue tracker](https://github.com/FidelisClayton/elm-spotify-mapper/issues) to report bugs or suggest new features and feel free to fix bugs or add new features on the project. Your contributions is always welcome!
