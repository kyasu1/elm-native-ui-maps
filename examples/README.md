## Create a new React Native app
Confirm your installation of React Native is working.
```
$ react-native init GoogleMapsExample
$ cd GoogleMapsExample
$ react-native run-ios
```
Stop the simulator if it is working ok. Next we need to install `react-native-maps` package. Its version on npm repository still is 0.12.4 but this package is using the latest 0.13.0 which fixed some weired callout display problems.
```
$ npm install react-native-maps@0.13.0 --save
```
We want to use the Google Maps on iOS, the setup described [here](https://github.com/airbnb/react-native-maps/blob/master/docs/installation.md#option-1-cocoapods---same-as-the-included-airmapsexplorer-example) is necessary. This is the hardest part of this installation, but if you create a new fresh project then follow the Option 1 exactly, it should work... After the successful installation, make sure again that your app is compiled and running.
```
# react-native run-ios
```
## Setup the example
In the React Native project directory, run elm-make to prepare basic Elm configurations.
```
$ elm-make
```
Since default elm-package does not allow packages with Native codes, you need to install [elm-install](https://github.com/gdotdesign/elm-github-install). When it is installed, copy `elm-package.json`, `index.ios.js` and `src/Main.elm` from `GoogleMapsExample` direcotry. Then you install necessary packages.
```
$ elm-install
```
After that compile Elm codes to Javascript. 
```
$ elm-make src/Main.elm --output elm.js
```
Finally start the app.
```
$ react-native run-ios
```

### Limitations
- `animateToCoordinate` does not work on iOS with Google Maps. Use `animateToRegion` instead.  Please see this [issue](https://github.com/airbnb/react-native-maps/issues/955) for more deatil.
- Only tested on iOS devices with Google Maps.
