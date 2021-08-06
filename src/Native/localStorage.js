module.exports = function (app) {
  window.addEventListener('storage', function (event) {
    if (event.key === 'spotify-auth-data') {
      const data = JSON.parse(event.newValue)
      const newData = {
        accessToken: data.access_token,
        expiresIn: Number(data.expires_in),
        tokenType: data.token_type,
      }

      app.ports.fromStorage.send(newData)
    }
  })

  function clearToken() {
    localStorage.removeItem('spotify-auth-data')
  }

  app.ports.clearToken.subscribe(clearToken)
}
