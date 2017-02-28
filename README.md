# elm-native-ui-maps
Elm bindings to [react-native-maps] which takes over original `MapView` component in the #react-native. As of the version 0.42, the reference to `MapView` is removed.

## Usage
This package is tested on the following versions,
- react-native 41.1
- react-native-maps 0.13
- elm 0.18
- elm-native-ui latest

#### Create a new Reac Native app
Confirm your installation of React Native is working.
```
$ react-native init GoogleMapsExample
$ cd GoogleMapsExample
$ react-native run-ios
```

#### Install Elm packages and elm-package.json
In the React Native project directory, run the following command.
```
$ elm-make
```
If your Elm code is using packages something like `NoRedInk/elm-decode-pipeline`, you need to install them here. *You also need to install packages used in `elm-native-ui` related packages*
```
$ elm-package install NoRedInk/elm-decode-pipeline
```

#### Install non managed packages
Elm does not allow packages using Native modules, we need :
```
$ mkdir elm-stuff-native
$ cd elm-stuff-native
$ git clone git@github.com:ohanhi/elm-native-ui.git
$ git clone git@github.com:kyasu1/elm-native-ui-maps.git
```

#### Modifying Elm confiurations
open `elm-package.json` then edit the repository name to be same as the `elm-native-ui` package.

```
"repository": "https://github.com/user/project.git",
"repository": "https://github.com/ohanhi/elm-native-ui.git",
```
```
"src",
"elm-stuff-native/elm-native-ui/src",
"elm-stuff-native/elm-native-ui-maps/src"
```

#### Start writing your awesome Elm code!
Elm codes are reside in the `src` sub directory. You can write Elm codes as normal.

