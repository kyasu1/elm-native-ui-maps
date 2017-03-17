module NativeUi.MapView.Marker
    exposing
        ( view
        , title
        , description
        , image
        , pinColor
        , coordinate
        , centerOffset
        , calloutOffset
        , anchor
        , calloutAnchor
        , flat
        , identifier
        , rotation
        , draggable
        , onSelect
        , onDeselect
        , onCalloutPress
        , onDragStart
        , onDrag
        , onDragEnd
        , ref
        , showCallout
        , hideCallout
        )

{-|
# Elements
@docs view

# Properties
@docs title, description, image, pinColor, coordinate, centerOffset,
      calloutOffset, anchor, calloutAnchor, flat, identifier, rotation, draggable

# Events
@docs onSelect, onDeselect, onCalloutPress, onDragStart, onDrag, onDragEnd

# Methods
@docs ref, showCallout, hideCallout
-}

import Task exposing (Task)
import Json.Decode as Decode
import Json.Encode as Encode exposing (Value, bool, int, list, object, string, float)
import NativeUi exposing (Node, Property, on, property, renderProperty, customNode)
import NativeUi.MapView exposing (LatLng, Point, NativeEvent, encodeLatLng, encodePoint, decodeNativeEvent)


-- View


{-| -}
view : List (Property msg) -> List (Node msg) -> Node msg
view =
    customNode "MapView.Marker" Native.NativeUi.MapView.marker



-- Props


{-| -}
title : String -> Property msg
title val =
    property "title" (Encode.string val)


{-| -}
description : String -> Property msg
description val =
    property "description" (Encode.string val)


{-| -}
image : String -> Property msg
image uri =
    property "image" (Encode.object [ ( "uri", Encode.string uri ) ])


{-| -}
pinColor : String -> Property msg
pinColor color =
    property "pinColor" (Encode.string color)


{-| -}
coordinate : LatLng -> Property msg
coordinate latLng =
    property "coordinate" (encodeLatLng latLng)


{-| -}
centerOffset : Point -> Property msg
centerOffset point =
    property "centerOffset" (encodePoint point)


{-| -}
calloutOffset : Point -> Property msg
calloutOffset point =
    property "calloutOffset" (encodePoint point)


{-| -}
anchor : Point -> Property msg
anchor point =
    property "anchor" (encodePoint point)


{-| -}
calloutAnchor : Point -> Property msg
calloutAnchor point =
    property "calloutAnchor" (encodePoint point)


{-| -}
flat : Bool -> Property msg
flat value =
    property "flat" (Encode.bool value)


{-| -}
identifier : String -> Property msg
identifier value =
    property "identifier" (Encode.string value)


{-| -}
rotation : Float -> Property msg
rotation angle =
    property "rotation" (Encode.float angle)


{-| -}
draggable : Property msg
draggable =
    property "draggable" (Encode.bool True)



-- Events


{-| -}
onPress : (NativeEvent -> msg) -> Property msg
onPress tagger =
    on "Press" (Decode.map tagger decodeNativeEvent)


{-| -}
onSelect : (NativeEvent -> msg) -> Property msg
onSelect tagger =
    on "Select" (Decode.map tagger decodeNativeEvent)


{-| -}
onDeselect : (NativeEvent -> msg) -> Property msg
onDeselect tagger =
    on "Deselect" (Decode.map tagger decodeNativeEvent)


{-| -}
onCalloutPress : msg -> Property msg
onCalloutPress tagger =
    on "CalloutPress" (Decode.succeed tagger)


{-| -}
onDragStart : (NativeEvent -> msg) -> Property msg
onDragStart tagger =
    on "DragStart" (Decode.map tagger decodeNativeEvent)


{-| -}
onDrag : (NativeEvent -> msg) -> Property msg
onDrag tagger =
    on "Drag" (Decode.map tagger decodeNativeEvent)


{-| -}
onDragEnd : (NativeEvent -> msg) -> Property msg
onDragEnd tagger =
    on "DragEnd" (Decode.map tagger decodeNativeEvent)



-- Methods


{-| -}
ref : Property msg
ref =
    NativeUi.ref Native.NativeUi.MapView.refMarker


{-| -}
showCallout : String -> Task Never String
showCallout id =
    Native.NativeUi.MapView.showCallout (Encode.string id)


{-| -}
hideCallout : String -> Task Never String
hideCallout id =
    Native.NativeUi.MapView.hideCallout (Encode.string id)
