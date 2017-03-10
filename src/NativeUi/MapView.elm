module NativeUi.MapView
    exposing
        ( view
          -- Basic types and props
        , Region
        , decodeRegion
        , LatLng
        , decodeLatLng
        , encodeLatLng
        , Point
        , decodePoint
        , encodePoint
          -- Properties
        , provider
        , Provider(..)
        , region
        , initialRegion
        , liteMode
        , MapType(..)
        , mapType
        , showsUserLocation
        , followsUserLocation
        , showsMyLocationButton
        , showsPointsOfInterest
        , showsCompass
        , showsScale
        , showsBuildings
        , showsTraffic
        , showsIndoors
        , zoomEnabled
        , rotateEnabled
        , scrollEnabled
        , pitchEnabled
        , toolbarEnabled
        , cacheEnabled
        , loadingEnabled
        , loadingIndicatorColor
        , loadingBackgroundColor
        , moveOnMarkerPress
        , EdgeInsets
        , legalLabelInsets
          -- Events
        , NativeEvent
        , decodeNativeEvent
        , onRegionChange
        , onRegionChangeComplete
        , onPress
        , onPanDrag
        , onLongPress
        , onMarkerPress
        , onMarkerSelect
        , onMarkerDeselect
        , onCalloutPress
        , onMarkerDragStart
        , onMarkerDrag
        , onMarkerDragEnd
          -- Methods
        , ref
        , mapId
        , animateToRegion
        , animateToCoordinate
        , fitToElements
        , fitToSuppliedMarkers
        , fitToCoordinates
        , EdgePadding
        )

{-|
# Elements
@docs view

# Basic types and props
@docs Region, decodeRegion,
      LatLng, decodeLatLng, encodeLatLng,
      Point, decodePoint, encodePoint

# Properties
@docs provider, Provider, region, initialRegion, liteMode, MapType, mapType,
      showsUserLocation, followsUserLocation, showsMyLocationButton,
      showsPointsOfInterest, showsCompass, showsScale, showsBuildings,
      showsTraffic, showsIndoors, zoomEnabled, rotateEnabled, scrollEnabled,
      pitchEnabled, toolbarEnabled, cacheEnabled, loadingEnabled,
      loadingIndicatorColor, loadingBackgroundColor, moveOnMarkerPress,
      EdgeInsets, legalLabelInsets

# Events
@docs NativeEvent, decodeNativeEvent, onRegionChange, onRegionChangeComplete,
      onPress, onPanDrag, onLongPress, onMarkerPress, onMarkerSelect,
      onMarkerDeselect, onCalloutPress, onMarkerDragStart, onMarkerDrag,
      onMarkerDragEnd

# Methods
@docs ref, mapId, animateToRegion, animateToCoordinate, fitToElements,
      fitToSuppliedMarkers, fitToCoordinates, EdgePadding
-}

import Task exposing (Task)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Json.Encode as Encode exposing (Value, bool, int, list, object, string, float)
import Native.NativeUi.MapView
import NativeUi exposing (Node, Property, on, property, renderProperty, customNode)


{-| -}
view : List (Property msg) -> List (Node msg) -> Node msg
view =
    customNode "MapView" Native.NativeUi.MapView.map



-- Props


{-| -}
type Provider
    = Default
    | Google


{-| -}
provider : Provider -> Property msg
provider val =
    let
        stringProvider =
            case val of
                Default ->
                    ""

                Google ->
                    "google"
    in
        property "provider" (Encode.string stringProvider)


{-| Region Model, decoder and encoder
-}
type alias Region =
    { latitude : Float
    , longitude : Float
    , latitudeDelta : Float
    , longitudeDelta : Float
    }


{-| -}
encodeRegion : Region -> Encode.Value
encodeRegion region =
    Encode.object
        [ ( "latitude", float region.latitude )
        , ( "longitude", float region.longitude )
        , ( "latitudeDelta", float region.latitudeDelta )
        , ( "longitudeDelta", float region.longitudeDelta )
        ]


{-| -}
decodeRegion : Decode.Decoder Region
decodeRegion =
    Decode.map4 Region
        (Decode.field "latitude" Decode.float)
        (Decode.field "longitude" Decode.float)
        (Decode.field "latitudeDelta" Decode.float)
        (Decode.field "longitudeDelta" Decode.float)


{-| -}
region : Region -> Property msg
region =
    property "region" << encodeRegion


{-| -}
initialRegion : Region -> Property msg
initialRegion =
    property "initialRegion" << encodeRegion


{-| LatLng Model, decoder and encoder
-}
type alias LatLng =
    { latitude : Float
    , longitude : Float
    }


{-| -}
decodeLatLng : Decode.Decoder LatLng
decodeLatLng =
    decode LatLng
        |> required "latitude" Decode.float
        |> required "longitude" Decode.float


{-| -}
encodeLatLng : LatLng -> Encode.Value
encodeLatLng latLng =
    Encode.object
        [ ( "latitude", Encode.float latLng.latitude )
        , ( "longitude", Encode.float latLng.longitude )
        ]


{-| Point Model, decoder and encoder
-}
type alias Point =
    { x : Float
    , y : Float
    }


{-| -}
decodePoint : Decode.Decoder Point
decodePoint =
    decode Point
        |> required "x" Decode.float
        |> required "y" Decode.float


{-| -}
encodePoint : Point -> Encode.Value
encodePoint point =
    Encode.object
        [ ( "x", Encode.float point.x )
        , ( "y", Encode.float point.y )
        ]


{-| -}
liteMode : Bool -> Property msg
liteMode =
    property "liteMode" << Encode.bool


{-| MapType Union type, Terrain is only available on Android
-}
type MapType
    = Standard
    | Satellite
    | Hybrid
    | Terrain


mapTypeToString : MapType -> String
mapTypeToString mapType =
    case mapType of
        Standard ->
            "standard"

        Satellite ->
            "satellite"

        Hybrid ->
            "hybrid"

        Terrain ->
            "terrain"


{-| -}
mapType : MapType -> Property msg
mapType =
    property "mapType" << Encode.string << mapTypeToString


{-| -}
showsUserLocation : Bool -> Property msg
showsUserLocation =
    property "showsUserLocation" << Encode.bool


{-| -}
followsUserLocation : Bool -> Property msg
followsUserLocation =
    property "followsUserLocation" << Encode.bool


{-| -}
showsMyLocationButton : Bool -> Property msg
showsMyLocationButton =
    property "showsMyLocationButton" << Encode.bool


{-| -}
showsPointsOfInterest : Bool -> Property msg
showsPointsOfInterest =
    property "showsPointsOfInterest" << Encode.bool


{-| -}
showsCompass : Bool -> Property msg
showsCompass =
    property "showsCompass" << Encode.bool


{-| -}
showsScale : Bool -> Property msg
showsScale =
    property "showsScale" << Encode.bool


{-| -}
showsBuildings : Bool -> Property msg
showsBuildings =
    property "showsBuildings" << Encode.bool


{-| -}
showsTraffic : Bool -> Property msg
showsTraffic =
    property "showsTraffic" << Encode.bool


{-| -}
showsIndoors : Bool -> Property msg
showsIndoors =
    property "showsIndoors" << Encode.bool


{-| -}
zoomEnabled : Bool -> Property msg
zoomEnabled =
    property "zoomEnabled" << Encode.bool


{-| -}
rotateEnabled : Bool -> Property msg
rotateEnabled =
    property "rotateEnabled" << Encode.bool


{-| -}
scrollEnabled : Bool -> Property msg
scrollEnabled =
    property "scrollEnabled" << Encode.bool


{-| -}
pitchEnabled : Bool -> Property msg
pitchEnabled =
    property "pitchEnabled" << Encode.bool


{-| -}
toolbarEnabled : Bool -> Property msg
toolbarEnabled =
    property "toolbarEnabled" << Encode.bool


{-| -}
cacheEnabled : Bool -> Property msg
cacheEnabled =
    property "cacheEnabled" << Encode.bool


{-| -}
loadingEnabled : Bool -> Property msg
loadingEnabled =
    property "loadingEnabled" << Encode.bool


{-| -}
loadingIndicatorColor : String -> Property msg
loadingIndicatorColor =
    property "loadingIndicatorColor" << Encode.string


{-| -}
loadingBackgroundColor : String -> Property msg
loadingBackgroundColor =
    property "loadingBackgroundColor" << Encode.string


{-| -}
moveOnMarkerPress : Bool -> Property msg
moveOnMarkerPress =
    property "moveOnMarkerPress" << Encode.bool


{-| NOTE NOT TESTED
-}
type alias EdgeInsets =
    { top : Float
    , left : Float
    , bottom : Float
    , right : Float
    }


encodeEdgeInsets : EdgeInsets -> Encode.Value
encodeEdgeInsets edgeInsets =
    Encode.object
        [ ( "top", float edgeInsets.top )
        , ( "left", float edgeInsets.left )
        , ( "bottom", float edgeInsets.bottom )
        , ( "right", float edgeInsets.right )
        ]


{-| -}
legalLabelInsets : EdgeInsets -> Property msg
legalLabelInsets =
    property "legalLabelInsets" << encodeEdgeInsets


{-| -}
type alias EdgePadding =
    { top : Float
    , right : Float
    , bottom : Float
    , left : Float
    }


encodeEdgePadding : EdgePadding -> Encode.Value
encodeEdgePadding edgePadding =
    Encode.object
        [ ( "top", float edgePadding.top )
        , ( "right", float edgePadding.right )
        , ( "bottom", float edgePadding.bottom )
        , ( "left", float edgePadding.left )
        ]



-- Events


{-| -}
type alias NativeEvent =
    { target : Int
    , coordinate : LatLng
    , point : Point
    , action : String
    }


{-| -}
decodeNativeEvent : Decode.Decoder NativeEvent
decodeNativeEvent =
    decode NativeEvent
        |> optional "target" Decode.int 0
        |> optional "coordinate" decodeLatLng (LatLng 0 0)
        |> optional "point" decodePoint (Point 0 0)
        |> optional "action" Decode.string ""


{-| -}
onRegionChange : (Region -> msg) -> Property msg
onRegionChange tagger =
    on "RegionChange" (Decode.map tagger decodeRegion)


{-| -}
onRegionChangeComplete : (Region -> msg) -> Property msg
onRegionChangeComplete tagger =
    on "RegionChangeComplete" (Decode.map tagger decodeRegion)


{-| -}
onPress : (NativeEvent -> msg) -> Property msg
onPress tagger =
    on "Press" (Decode.map tagger (Decode.field "nativeEvent" decodeNativeEvent))


{-| -}
onPanDrag : (NativeEvent -> msg) -> Property msg
onPanDrag tagger =
    on "PanDrag" (Decode.map tagger (Decode.field "nativeEvent" decodeNativeEvent))


{-| -}
onLongPress : (NativeEvent -> msg) -> Property msg
onLongPress tagger =
    on "LongPress" (Decode.map tagger (Decode.field "nativeEvent" decodeNativeEvent))


{-| -}
onMarkerPress : msg -> Property msg
onMarkerPress tagger =
    on "MarkerPress" (Decode.succeed tagger)


{-| -}
onMarkerSelect : msg -> Property msg
onMarkerSelect tagger =
    on "MarkerSelect" (Decode.succeed tagger)


{-| -}
onMarkerDeselect : msg -> Property msg
onMarkerDeselect tagger =
    on "MarkerDeselect" (Decode.succeed tagger)


{-| -}
onCalloutPress : msg -> Property msg
onCalloutPress tagger =
    on "CalloutPress" (Decode.succeed tagger)


{-| -}
onMarkerDragStart : (NativeEvent -> msg) -> Property msg
onMarkerDragStart tagger =
    on "MarkerDragStart" (Decode.map tagger (Decode.field "nativeEvent" decodeNativeEvent))


{-| -}
onMarkerDrag : (NativeEvent -> msg) -> Property msg
onMarkerDrag tagger =
    on "MarkerDrag" (Decode.map tagger (Decode.field "nativeEvent" decodeNativeEvent))


{-| -}
onMarkerDragEnd : (NativeEvent -> msg) -> Property msg
onMarkerDragEnd tagger =
    on "MarkerDragEnd" (Decode.map tagger (Decode.field "nativeEvent" decodeNativeEvent))



-- Methods


{-| -}
ref : Property msg
ref =
    NativeUi.ref Native.NativeUi.MapView.refMap


{-| -}
mapId : String -> Property msg
mapId =
    property "mapId" << Encode.string


{-| -}
animateToRegion : String -> Region -> Float -> Task Never Region
animateToRegion id region duration =
    Native.NativeUi.MapView.animateToRegion (Encode.string id) (encodeRegion region) (Encode.float duration)


{-| This is not working on iOS with google maps
-}
animateToCoordinate : String -> LatLng -> Float -> Task Never LatLng
animateToCoordinate id latLng duration =
    Native.NativeUi.MapView.animateToCoordinate (Encode.string id) (encodeLatLng latLng) (Encode.float duration)


{-| Compute a boundary including all elements then resize the map to fit to contain them.
-}
fitToElements : String -> Bool -> Task Never String
fitToElements mapId animated =
    Native.NativeUi.MapView.fitToElements (Encode.string mapId) (Encode.bool animated)


{-| The markerID used here is set by the Marker.identifier property
-}
fitToSuppliedMarkers : String -> List String -> Bool -> Task Never String
fitToSuppliedMarkers mapId markerIDs animated =
    Native.NativeUi.MapView.fitToSuppliedMarkers (Encode.string mapId) (markerIDs |> List.map Encode.string |> Encode.list) (Encode.bool animated)


{-| -}
fitToCoordinates : String -> List LatLng -> EdgePadding -> Bool -> Task Never String
fitToCoordinates mapId coordinates edgePadding animated =
    Native.NativeUi.MapView.fitToCoordinates
        (Encode.string mapId)
        (coordinates |> List.map encodeLatLng |> Encode.list)
        (Encode.object
            [ ( "edgePadding", encodeEdgePadding edgePadding )
            , ( "animated", Encode.bool animated )
            ]
        )
