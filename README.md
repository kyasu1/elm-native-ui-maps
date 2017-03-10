# elm-native-ui-maps
Elm bindings to [react-native-maps](https://github.com/airbnb/react-native-maps) which takes over original `MapView` component in the #react-native. As of the version 0.42, the reference to `MapView` is removed from React Native components.

# Dependencies
This package is tested on the following versions,
- react-native@41.1 and 42.0
- react-native-maps@0.13
- elm@0.18
- elm-native-ui@latest

# Running the example
I have created a simple exapmle showing a MapView and a ScrollView with a list of station names. By touching a station name, the map center move to the selected stations's coordinate, then shows the corresponding callout, the marker pop ups to front and animates slightly. Not sophisticated UI design, but it is working pretty well.

## React Native part
Create a new React Native app:

```bash
$ react-native init GoogleMapsExample
```

Install required npm packages:

```bash
$ cd GoogleMapsExample
$ npm install
```

Before going futher you need to setup `react-native-maps` by following their installation [instructions](https://github.com/airbnb/react-native-maps/blob/master/docs/installation.md). If you want to use Google Maps on iOS devices, you should apply ONLY [Option 1](https://github.com/airbnb/react-native-maps/blob/master/docs/installation.md#option-1-cocoapods---same-as-the-included-airmapsexplorer-example) exactly. For React Natie 0.42.0 support please refer [this](https://github.com/airbnb/react-native-maps/issues/1078).

## Elm part
Copy all files in the `examples/GoogleMapsExample` to the top level of the app directory.
```bash
$ cp examples/GoogleMapsExample/* .
```

Install Elm packages with [elm-install](https://github.com/gdotdesign/elm-github-install).
```bash
$ elm-install
```

Then compile as nomral Elm code.
```bash
$ npm run build
```

Start the app.
```bash
$ react-native run-ios
```

# Limitations
- Tested on iOS devices only, should work on Android devices too.
- Some features are supported only specific platform only, please consult with the original documentations and issues.
