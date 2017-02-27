module NativeUi.MapView.Common
    exposing
        ( id
        , LatLng
        , decodeLatLng
        , encodeLatLng
        , Point
        , decodePoint
        , encodePoint
        , Marker
        , decodeMarker
        , trace
        )

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Json.Encode as Encode exposing (Value, bool, int, list, object, string, float)
import NativeUi exposing (Node, Property, on, property, renderProperty, customNode)


{-| id
-}
id : String -> Property msg
id val =
    property "id" (Encode.string val)


{-| LatLng Model, decoder and encoder
-}
type alias LatLng =
    { latitude : Float
    , longitude : Float
    }


decodeLatLng : Decode.Decoder LatLng
decodeLatLng =
    decode LatLng
        |> required "latitude" Decode.float
        |> required "longitude" Decode.float


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


decodePoint : Decode.Decoder Point
decodePoint =
    decode Point
        |> required "x" Decode.float
        |> required "y" Decode.float


encodePoint : Point -> Encode.Value
encodePoint point =
    Encode.object
        [ ( "x", Encode.float point.x )
        , ( "y", Encode.float point.y )
        ]


{-| Marker
-}
type alias Marker =
    { target : String
    , coordinate : LatLng
    , position : Point
    , action : String
    }


decodeMarker : Decode.Decoder Marker
decodeMarker =
    Decode.field "nativeEvent" <|
        (decode Marker
            |> required "target" Decode.string
            |> optional "coordinate" decodeLatLng (LatLng 0 0)
            |> optional "position" decodePoint (Point 0 0)
            |> optional "action" Decode.string ""
        )


{-| Util
-}
trace : String -> Decode.Decoder msg -> Decode.Decoder msg
trace message decoder =
    Decode.value
        |> Decode.andThen
            (\value ->
                case Decode.decodeValue decoder value of
                    Ok decoded ->
                        Decode.succeed decoded

                    Err err ->
                        Decode.fail <| Debug.log message <| err
            )
