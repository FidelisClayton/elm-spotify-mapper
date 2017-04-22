module.exports = function(app) {
  const audio = new Audio()

  let topTracks = []
  let currentIndex = 0

  audio.onended = function() {
    next()
    const currentTrack = topTracks[currentIndex]

    if (currentTrack !== undefined) {
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
      const audioStatus = {
        currentTime: Math.floor(audio.currentTime) + 1,
        duration: !isNaN(Math.floor(audio.duration)) ? Math.floor(audio.duration) : 30 ,
        volume: !isNaN(audio.volume) ? audio.volume : 1
      }

      app.ports.updateAudioStatus.send(audioStatus)
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

  function updateCurrentTime(time) {
    audio.currentTime = time
  }

  function updateVolume(volume) {
    audio.volume = volume
  }

  app.ports.playAudio.subscribe(play)
  app.ports.pauseAudio.subscribe(pause)
  app.ports.provideTracks.subscribe(setTopTracks)
  app.ports.nextTrack.subscribe(next)
  app.ports.previousTrack.subscribe(previous)
  app.ports.updateCurrentTime.subscribe(updateCurrentTime)
  app.ports.updateVolume.subscribe(updateVolume)
}
