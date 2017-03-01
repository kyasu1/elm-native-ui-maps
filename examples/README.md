## Create a new React Native app
Confirm your installation of React Native is working.
```
$ react-native init GoogleMapsExample
$ cd GoogleMapsExample
$ react-native run-ios
```
Stop the simulator once you confirm it is working. Next we need to install `react-native-maps` package.  Its version on npm repository still is 0.12.4 but this package is using the latest 0.13.0 which fixed some weired callout display problems.
```
$ npm install react-native-maps@0.13.0 --save
```
We want to use the Google Maps on iOS, the setup described [here](https://github.com/airbnb/react-native-maps/blob/master/docs/installation.md#option-1-cocoapods---same-as-the-included-airmapsexplorer-example) is necessary. This is the hardest part of this installation, but if you create a new fresh project then follow the Option 1 exactly, it should work... After the successful installation, make sure again that your app is compiled and running.
```
# react-native run-ios
```
## Setup the example
### Install non managed packages
Elm does not allow packages using Native modules as the part of `elm-package` repository. So we need to manage packages and their dependences manually. The method taken here is just clone the `elm-native-ui` related repositories in the subfolder called `elm-stuff-native`.
```
$ mkdir elm-stuff-native
$ cd elm-stuff-native
$ git clone git@github.com:ohanhi/elm-native-ui.git
$ git clone git@github.com:kyasu1/elm-native-ui-maps.git
```
###
Copy all files and directories in the `examples/GoolgeMapsExample` to the current project directory. Overwrite the `index.ios.js` and `package.json`.

### Compile and run
Install noraml Elm package then `elm-make` transpile all js related code to `elm.js` which is required from `index.ios.js`.
```
$ elm-package install
$ npm run build
$ react-native run-ios
```

## Details of Elm configurations
If you are starting a new Elm project in the React Native dreictory, please follow the next instructions.
### Elm installation
In the React Native project directory, run the following command.
```
$ elm-make
```
If your Elm code is using external packages something like `NoRedInk/elm-decode-pipeline`, you need to install them here. **You also need to install packages used in the `elm-native-ui` related packages.** This package needs [elm-decode-pipelien](https://github.com/NoRedInk/elm-decode-pipeline).
```
$ elm-package install NoRedInk/elm-decode-pipeline
```

### Install non managed packages
Elm does not allow packages using Native modules. So we need to manage packages and their dependences manually. The method taken here is just clone the elm-native-ui related repositories in the subfolder called `elm-stuff-native`.
```
$ mkdir elm-stuff-native
$ cd elm-stuff-native
$ git clone git@github.com:ohanhi/elm-native-ui.git
$ git clone git@github.com:kyasu1/elm-native-ui-maps.git
```

### Modify the package name
open `elm-package.json` then edit the repository name to be same as the `elm-native-ui` package.
```
"repository": "https://github.com/user/project.git",
```
to
```
"repository": "https://github.com/ohanhi/elm-native-ui.git",
```
Also make sure all the packages under the `elm-stuff-native` have same repository name.

### Change the source paths
We need to list all
```
"src",
"elm-stuff-native/elm-native-ui/src",
"elm-stuff-native/elm-native-ui-maps/src"
```

### Start writing your awesome Elm code!
Elm codes are reside in the `src` sub directory. You can write Elm codes as normal.

### Modify index file
If the starting point of you elm code is different from `Main`, change the key name accordingly.
```
const component = Elm.Main.start();
```
Also the first argument of `registerComponent` must be same as the React Native project name.
```
AppRegistry.registerComponent('GoogleMapsExample', () => component);
```
## Limitations
- `animateToCoordinate` does not work on iOS with Google Maps. Use `animateToRegion` instead.  Please see this [issue](https://github.com/airbnb/react-native-maps/issues/955) for more deatil.
- Only tested on iOS devices with Google Maps.
