module.exports = function(app) {
  const audio = new Audio()

  let topTracks = []
  let currentIndex = 0

  audio.onended = function() {
    currentIndex++
    const currentTrack = topTracks[currentIndex]

    if (currentTrack !== undefined) {
      play(currentTrack.preview_url)
      app.ports.updateCurrentTrack.send(currentTrack)
    } else {
      app.ports.audioEnded.send("")
    }
  }

  function getSeconds(time) {
    return Number((String(time)).split(".")[0])
  }

  setInterval(() => {
    if (!audio.paused) {
      app.ports.updateAudioStatus.send({
        currentTime: Math.floor(audio.currentTime) + 1,
        duration: Math.floor(audio.duration),
        volume: audio.volume ? audio.volume : 0
      })
    }
  }, 1000)

  function play(src) {
    if (src !== audio.src) {
      audio.pause()
      audio.src = src
    }

    audio.play()
    currentIndex = updateCurrentIndex(src)
  }

  function pause() {
    audio.pause()
  }

  function stop() {
    audio.pause()
    audio.currentTime = 0
  }

  function next() {
    currentIndex++
    const currentTrack = topTracks[currentIndex]

    if (currentTrack !== undefined) {
      play(currentTrack.preview_url)
      app.ports.updateCurrentTrack.send(currentTrack)
    } else {
      currentIndex = 0
      const newCurrent = topTracks[currentIndex]
      play(newCurrent.preview_url)
      app.ports.updateCurrentTrack.send(newCurrent)
    }
  }

  function previous() {
    currentIndex--
    const currentTrack = topTracks[currentIndex]

    if (currentTrack !== undefined) {
      play(currentTrack.preview_url)
      app.ports.updateCurrentTrack.send(currentTrack)
    } else {
      currentIndex = topTracks.length - 1
      const newCurrent = topTracks[currentIndex]
      play(newCurrent.preview_url)
      app.ports.updateCurrentTrack.send(newCurrent)
    }
  }

  function setTopTracks(tracks) {
    topTracks = tracks.tracks
  }

  function updateCurrentIndex(currentTrack) {
    const item = topTracks.filter(track => track.preview_url === currentTrack)[0]

    return topTracks.indexOf(item)
  }

  app.ports.playAudio.subscribe(play)
  app.ports.pauseAudio.subscribe(pause)
  app.ports.provideTracks.subscribe(setTopTracks)
  app.ports.nextTrack.subscribe(next)
  app.ports.previousTrack.subscribe(previous)
}
