require('dotenv').config();

const webpack = require('webpack');
const path = require('path');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const UglifyJSPlugin = require('uglifyjs-webpack-plugin');

const prodPlugins =
  [ new webpack.EnvironmentPlugin(['CLIENT_ID', 'CLIENT_SECRET', 'REDIRECT_URI']),
    new webpack.optimize.OccurrenceOrderPlugin(),
    new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false,
        sequences: true,
        dead_code: true,
        conditionals: true,
        booleans: true,
        unused: true,
        if_return: true,
        join_vars: true,
        drop_console: true
      },
      mangle: true
    }),
    new CopyWebpackPlugin([
      { from: 'src/auth.html', to: 'auth.html' },
      { from: 'src/style.css', to: 'dist/style.css' },
      { from: 'vendor/', to: 'dist/vendor/'}
    ])
  ]

const devPlugins = [
  new webpack.EnvironmentPlugin(['CLIENT_ID', 'CLIENT_SECRET', 'REDIRECT_URI']),
  new CopyWebpackPlugin([
    { from: 'src/auth.html', to: 'auth.html' },
    { from: 'src/style.css', to: 'dist/style.css' },
    { from: 'vendor/', to: 'dist/vendor/'}
  ])
]

const plugins =
  process.env.BUILD_TO === 'production'
  ? prodPlugins
  : devPlugins

const elmLoaderProdConfig = 'elm-webpack-loader'
const elmLoaderDevConfig = 'elm-webpack-loader?verbose=true&warn=true&debug=true'

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
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015']
        }
      },
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/, /Stylesheets\.elm$/],
        loader: process.env.BUILD_TO === 'production' ? elmLoaderProdConfig : elmLoaderDevConfig
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

  plugins: plugins,

  devServer: {
    inline: true,
    stats: { colors: true },
  },
}
