module NativeUi.MapView.Callout exposing (view, tooltip, onPress)

{-|
@docs view, tooltip, onPress
-}

import Json.Decode as Decode
import Json.Encode as Encode exposing (Value, bool, int, list, object, string, float)
import NativeUi exposing (Node, Property, on, property, renderProperty, customNode)


-- View


{-| -}
view : List (Property msg) -> List (Node msg) -> Node msg
view =
    customNode "MapView.Callout" Native.NativeUi.MapView.callout



-- Props


{-| -}
tooltip : Bool -> Property msg
tooltip val =
    property "tooltip" (Encode.bool val)



-- Events


{-| -}
onPress : msg -> Property msg
onPress tagger =
    on "Press" (Decode.succeed tagger)
