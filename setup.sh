#!/bin/bash
touch package.json
cat > package.json <<- "EOF"
{
  "name": "test_dev_setup",
  "version": "1.0.0",
  "description": "",
  "private": true,
  "scripts": {
    "test": "eslint --ext .js src/",
    "start": "webpack-dev-server --open",
    "build": "webpack"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/phlgr/test_dev_setup.git"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "bugs": {
    "url": "https://github.com/phlgr/test_dev_setup/issues"
  },
  "homepage": "https://github.com/phlgr/test_dev_setup#readme",
  "devDependencies": {
    "clean-webpack-plugin": "^3.0.0",
    "css-loader": "^3.4.2",
    "eslint": "^6.8.0",
    "eslint-config-prettier": "^6.10.0",
    "eslint-plugin-prettier": "^3.1.2",
    "file-loader": "^5.1.0",
    "html-webpack-plugin": "^3.2.0",
    "husky": "^4.2.3",
    "lint-staged": "^10.0.8",
    "prettier": "^1.19.1",
    "sass": "^1.26.2",
    "sass-loader": "^8.0.2",
    "style-loader": "^1.1.3",
    "webpack": "^4.42.0",
    "webpack-cli": "^3.3.11",
    "webpack-dev-server": "^3.10.3"
  },
  "husky": {
    "hooks": {
      "pre-commit": "lint-staged",
      "pre-push": "npm test"
    }
  },
  "lint-staged": {
    "_.{js}": "eslint --fix",
    "_.{js,css,scss,md,json}": "prettier --write",
    "*.js": "eslint --cache --fix"
  },
  "main": ".eslintrc.js",
  "dependencies": {}
}
EOF

npm i 

mkdir src/
touch src/index.js
touch src/index.scss

touch webpack.config.js
cat > webpack.config.js <<- "EOF"
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');

module.exports = {
  entry: './src/index.js',
  plugins: [
    new CleanWebpackPlugin(),
    new HtmlWebpackPlugin({
      title: 'test_dev_setup'
    })
  ],
  devServer: {
    contentBase: './dist'
  },

  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'dist')
  },
  module: {
    rules: [
      {
        test: /\.s[ac]ss$/i,
        use: [
          // Creates `style` nodes from JS strings
          'style-loader',
          // Translates CSS into CommonJS
          'css-loader',
          // Compiles Sass to CSS
          'sass-loader',
          // Compiles Sass to CSS
          {
            loader: 'sass-loader',
            options: {
              // Prefer `dart-sass`
              implementation: require('sass')
            }
          }
        ]
      },
      {
        test: /\.(png|svg|jpg|gif)$/,
        use: ['file-loader']
      }
    ]
  }
};
EOF

touch .prettierrc
cat > .prettierrc <<- "EOF"
{
"singleQuote": true
}
EOF

touch .eslintrc.js
cat > .eslintrc.js <<- "EOF"
module.exports = {
env: {
browser: true,
es6: true
},
plugins: ['prettier'],
extends: ['eslint:recommended', 'plugin:prettier/recommended'],
globals: {
Atomics: 'readonly',
SharedArrayBuffer: 'readonly'
},
parserOptions: {
ecmaVersion: 2018,
sourceType: 'module'
},
rules: {}
};
EOF

touch .prettierignore
cat > .prettierignore <<- "EOF"
dist/
node_modules/
EOF

touch .eslintignore
cat > .eslintignore <<- "EOF"
dist/
node_modules/
webpack.config.js
*.scss
EOF

echo '.DS_STORE' >> .gitignore
echo '.vscode' >> .gitignore

echo ">>> Change the title in webpack.config.js <<<"
echo ">>> Change the title in package.json <<<"