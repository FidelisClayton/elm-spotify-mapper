require('dotenv').config();

const webpack = require('webpack');
const path = require('path');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
  entry: {
    app: [
      './src/index.js'
    ],
  },

  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: '[name].js',
  },

  module: {
    rules: [
      {
        test:    /\.html$/,
        exclude: /node_modules/,
        loader:  'file-loader?name=[name].[ext]',
      },
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/, /Stylesheets\.elm$/],
        loader:  'elm-webpack-loader?verbose=true&warn=true&debug=true',
      },
      {
        test: /Stylesheets\.elm$/,
        use: [
          'style-loader',
          'css-loader',
          'elm-css-webpack-loader'
        ]
      }
    ],
  },

  plugins: [
    new webpack.EnvironmentPlugin(['CLIENT_ID', 'CLIENT_SECRET', 'REDIRECT_URI']),
    new CopyWebpackPlugin([
      { from: 'src/auth.html', to: 'auth.html' },
      { from: 'src/style.css', to: 'dist/style.css' },
      { from: 'vendor/', to: 'dist/vendor/'}
    ])
  ],

  devServer: {
    inline: true,
    stats: { colors: true },
  },
}
