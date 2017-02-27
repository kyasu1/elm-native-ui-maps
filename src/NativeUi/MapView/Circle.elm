module NativeUi.MapView.Circle
    exposing
        ( view
        , center
        , radius
        , strokeWidth
        , strokeColor
        , fillColor
        , zIndex
        , lineCap
        , lineJoin
        , miterLimit
        , geodesic
        , lineDashPhase
        , lineDashPattern
        )

{-|
@docs view
    , center , radius , strokeWidth , strokeColor , fillColor , zIndex , lineCap
    , lineJoin , miterLimit , geodesic , lineDashPhase , lineDashPattern
-}

import Json.Encode as Encode exposing (Value, bool, int, list, object, string, float)
import NativeUi exposing (Node, Property, on, property, renderProperty, customNode)
import NativeUi.MapView.Common exposing (LatLng, encodeLatLng)


-- View


{-| -}
view : List (Property msg) -> List (Node msg) -> Node msg
view =
    customNode "MapView.Circle" Native.NativeUi.MapView.circle


{-| -}
center : LatLng -> Property msg
center latlng =
    property "center"
        (Encode.object
            [ ( "latitude", float latlng.latitude )
            , ( "longitude", float latlng.longitude )
            ]
        )


{-| -}
radius : Float -> Property msg
radius =
    property "radius" << Encode.float


{-| -}
strokeWidth : Int -> Property msg
strokeWidth =
    property "strokeWidth" << Encode.int


{-| -}
strokeColor : String -> Property msg
strokeColor =
    property "strokeColor" << Encode.string


{-| -}
fillColor : String -> Property msg
fillColor =
    property "fillColor" << Encode.string


{-| -}
zIndex : Float -> Property msg
zIndex =
    property "zIndex" << Encode.float


{-| -}
lineCap : String -> Property msg
lineCap =
    property "lineCap" << Encode.string


{-| -}
lineJoin : List LatLng -> Property msg
lineJoin list =
    property "lineJoin" (Encode.list <| List.map encodeLatLng list)


{-| -}
miterLimit : Float -> Property msg
miterLimit =
    property "miterLimit" << Encode.float


{-| -}
geodesic : Bool -> Property msg
geodesic =
    property "geodesic" << Encode.bool


{-| -}
lineDashPhase : Int -> Property msg
lineDashPhase =
    property "lineDashPhase" << Encode.int


{-| -}
lineDashPattern : List Int -> Property msg
lineDashPattern list =
    property "lineDashPattern" (Encode.list <| List.map Encode.int list)
