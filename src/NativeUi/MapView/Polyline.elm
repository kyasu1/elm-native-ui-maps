module NativeUi.MapView.Polyline
    exposing
        ( coordinates
        , strokeWidth
        , strokeColor
        , fillColor
        , lineCap
        , lineJoin
        , miterLimit
        , geodesic
        , lineDashPhase
        , lineDashPattern
          --Events
        , onPress
        )

{-|
@docs view
    , coordinates , strokeWidth , strokeColor , fillColor ,  lineCap
    , lineJoin , miterLimit , geodesic , lineDashPhase , lineDashPattern
    , onPress
-}

import Json.Decode as Decode
import Json.Encode as Encode exposing (Value, bool, int, list, object, string, float)
import NativeUi exposing (Node, Property, on, property, renderProperty, customNode)
import NativeUi.MapView.Common exposing (LatLng, encodeLatLng)


-- View


view : List (Property msg) -> List (Node msg) -> Node msg
view =
    customNode "MapView.Polyline" Native.NativeUi.MapView.polyline



-- Props


{-| -}
coordinates : List LatLng -> Property msg
coordinates list =
    property "coordinates" (Encode.list <| List.map encodeLatLng list)


strokeWidth : Int -> Property msg
strokeWidth =
    property "strokeWidth" << Encode.int


strokeColor : String -> Property msg
strokeColor =
    property "strokeColor" << Encode.string


fillColor : String -> Property msg
fillColor =
    property "fillColor" << Encode.string


lineCap : String -> Property msg
lineCap =
    property "lineCap" << Encode.string


lineJoin : List LatLng -> Property msg
lineJoin list =
    property "lineJoin" (Encode.list <| List.map encodeLatLng list)


miterLimit : Float -> Property msg
miterLimit =
    property "miterLimit" << Encode.float


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



-- Events


{-| -}
onPress : msg -> Property msg
onPress tagger =
    on "Pres" (Decode.succeed tagger)