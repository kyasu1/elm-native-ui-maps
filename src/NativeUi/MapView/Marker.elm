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
@docs view,
      title, description, image, pinColor, coordinate, centerOffset, calloutOffset, anchor, calloutAnchor, flat, identifier, rotation, draggable,
      onSelect, onDeselect, onCalloutPress, onDragStart, onDrag, onDragEnd,
      ref, showCallout, hideCallout
-}

import Task exposing (Task)
import Json.Decode as Decode
import Json.Encode as Encode exposing (Value, bool, int, list, object, string, float)
import Native.NativeUi
import NativeUi exposing (Node, Property, on, property, renderProperty, customNode)
import NativeUi.MapView.Common exposing (LatLng, Point, Marker, encodeLatLng, encodePoint, decodeMarker)


-- View


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
onPress : (Marker -> msg) -> Property msg
onPress tagger =
    on "Press" (Decode.map tagger decodeMarker)


{-| -}
onSelect : (Marker -> msg) -> Property msg
onSelect tagger =
    on "Select" (Decode.map tagger decodeMarker)


{-| -}
onDeselect : (Marker -> msg) -> Property msg
onDeselect tagger =
    on "Deselect" (Decode.map tagger decodeMarker)


{-| -}
onCalloutPress : msg -> Property msg
onCalloutPress tagger =
    on "CalloutPress" (Decode.succeed tagger)


{-| -}
onDragStart : (Marker -> msg) -> Property msg
onDragStart tagger =
    on "DragStart" (Decode.map tagger decodeMarker)


{-| -}
onDrag : (Marker -> msg) -> Property msg
onDrag tagger =
    on "Drag" (Decode.map tagger decodeMarker)


{-| -}
onDragEnd : (Marker -> msg) -> Property msg
onDragEnd tagger =
    on "DragEnd" (Decode.map tagger decodeMarker)



-- Methods


{-| -}
ref : Property msg
ref =
    (Native.NativeUi.ref Native.NativeUi.MapView.refMarker)


{-| -}
showCallout : String -> Task Never String
showCallout id =
    Native.NativeUi.MapView.showCallout (Encode.string id)


{-| -}
hideCallout : String -> Task Never String
hideCallout id =
    Native.NativeUi.MapView.hideCallout (Encode.string id)
