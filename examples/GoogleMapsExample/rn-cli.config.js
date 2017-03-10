// http://stackoverflow.com/questions/41813211/how-to-make-react-native-packager-ignore-certain-directories
const blacklist = require('react-native/packager/blacklist');

module.exports = {
  getBlacklistRE: function() {
    return blacklist([/elm-stuff\/.*/]);
  }
};
