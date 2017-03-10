module Main exposing (..)

import Task exposing (Task)
import NativeUi as Ui exposing (Node)
import NativeUi.Style as Style
import NativeUi.Elements as Elements exposing (..)
import NativeUi.Properties exposing (..)
import NativeUi.Events as Events
import NativeUi.MapView as MapView
import NativeUi.MapView.Common exposing (LatLng)
import NativeUi.MapView.Marker as Marker
import NativeUi.Animatable as Animatable
import Native.Images


-- Program


main : Program Never Model Msg
main =
    Ui.program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- Model


type alias Station =
    { id : String
    , name : String
    , latLng : LatLng
    }


type alias Model =
    { stations : List Station
    , current : Maybe Station
    , region : MapView.Region
    }


initialStation : List Station
initialStation =
    [ Station "1" "大崎" (LatLng 35.6197 139.728553)
    , Station "2" "五反田" (LatLng 35.626446 139.723444)
    , Station "3" "目黒" (LatLng 35.633998 139.715828)
    , Station "4" "恵比寿" (LatLng 35.64669 139.710106)
    , Station "5" "Shibuya" (LatLng 35.658517 139.701334)
    , Station "6" "原宿" (LatLng 35.670168 139.702687)
    , Station "7" "代々木" (LatLng 35.683061 139.702042)
    , Station "8" "Shinjuku" (LatLng 35.690921 139.700258)
    , Station "9" "新大久保" (LatLng 35.701306 139.700044)
    , Station "10" "高田馬場" (LatLng 35.712285 139.703782)
    , Station "11" "目白" (LatLng 35.721204 139.706587)
    , Station "12" "Ikebukuro" (LatLng 35.728926 139.71038)
    , Station "13" "大塚" (LatLng 35.73159 139.729329)
    , Station "14" "巣鴨" (LatLng 35.733492 139.739345)
    , Station "15" "駒込" (LatLng 35.736489 139.746875)
    , Station "16" "田端" (LatLng 35.738062 139.76086)
    , Station "17" "西日暮里" (LatLng 35.732135 139.766787)
    , Station "18" "日暮里" (LatLng 35.727772 139.770987)
    , Station "19" "鶯谷" (LatLng 35.720495 139.778837)
    , Station "20" "上野" (LatLng 35.713768 139.777254)
    , Station "21" "御徒町" (LatLng 35.707893 139.774332)
    , Station "22" "Akihabara" (LatLng 35.698683 139.774219)
    , Station "23" "神田" (LatLng 35.69169 139.770883)
    , Station "24" "Tokyo" (LatLng 35.681382 139.766084)
    , Station "25" "有楽町" (LatLng 35.675069 139.763328)
    , Station "26" "新橋" (LatLng 35.665498 139.75964)
    , Station "27" "浜松町" (LatLng 35.655646 139.756749)
    , Station "28" "田町" (LatLng 35.645736 139.747575)
    , Station "29" "品川" (LatLng 35.630152 139.74044)
    , Station "30" "大崎" (LatLng 35.6197 139.728553)
    ]


initialModel : Model
initialModel =
    Model initialStation Nothing initialRegion


initialRegion : MapView.Region
initialRegion =
    MapView.Region 35.713768 139.777254 0.15 0.08


mapId : String
mapId =
    "1"



-- Update


type Msg
    = ListPress Station
    | MarkerPress Station
    | MoveTo String
    | ShowCallout String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "update" msg of
        ListPress station ->
            let
                region =
                    model.region

                newRegion =
                    { region
                        | latitude = station.latLng.latitude
                        , longitude = station.latLng.longitude
                    }
            in
                { model
                    | current =
                        Just station
                    , region = newRegion
                }
                    ! [ Cmd.batch
                            [ moveTo newRegion
                            , showCallout station.id
                            ]
                      ]

        MarkerPress station ->
            let
                region =
                    model.region

                newRegion =
                    { region
                        | latitude = station.latLng.latitude
                        , longitude = station.latLng.longitude
                    }
            in
                { model | region = newRegion } ! [ moveTo newRegion ]

        MoveTo _ ->
            model ! []

        ShowCallout _ ->
            model ! []


moveTo : MapView.Region -> Cmd Msg
moveTo region =
    Task.perform MoveTo (MapView.animateToRegion mapId region 500)


showCallout : String -> Cmd Msg
showCallout markerId =
    Task.perform ShowCallout (Marker.showCallout markerId)



-- View


view : Model -> Node Msg
view model =
    Elements.view
        [ Ui.style cssAbsoluteFillObject ]
        [ MapView.view
            [ Ui.style cssMap
            , MapView.ref
            , MapView.mapId mapId
            , MapView.provider MapView.Google
            , MapView.showsUserLocation True
            , MapView.region model.region
            ]
            (List.map (markerView model.current) model.stations)
        , Elements.scrollView [ Ui.style cssList ] (List.map listView model.stations)
        ]


markerView : Maybe Station -> Station -> Node Msg
markerView current station =
    let
        ( icon, zIndex ) =
            if stationSelected current station == True then
                ( Animatable.image
                    [ Ui.style cssMarkerImage
                    , source Native.Images.iconJr
                    , Animatable.animation Animatable.Swing
                    , Animatable.easing Animatable.EaseOut
                    , Animatable.iterationCount (Animatable.Finite 5)
                    , Animatable.direction Animatable.Alternate
                    ]
                    []
                , 100
                )
            else
                ( Elements.image
                    [ Ui.style cssMarkerImage
                    , source Native.Images.iconJr
                    ]
                    []
                , 5
                )
    in
        Marker.view
            [ Marker.coordinate station.latLng
            , Marker.ref
            , Marker.identifier station.id
            , Marker.markerId station.id
            , Events.onPress (MarkerPress station)
            , Marker.title station.name
            , Marker.description (toString station.latLng)
            , Ui.style (cssMarker zIndex)
            ]
            [ icon ]


stationSelected : Maybe Station -> Station -> Bool
stationSelected current station =
    case current of
        Just station_ ->
            if station_.id == station.id then
                True
            else
                False

        Nothing ->
            False


listView : Station -> Node Msg
listView station =
    Elements.touchableOpacity
        [ Events.onPress (ListPress station) ]
        [ Elements.text [] [ Ui.string station.name ]
        ]



-- Css


cssAbsoluteFillObject : List Style.Style
cssAbsoluteFillObject =
    [ Style.position "absolute"
    , Style.left 0
    , Style.right 0
    , Style.top 0
    , Style.bottom 0
    ]


cssMap : List Style.Style
cssMap =
    [ Style.flex 1 ]


cssList : List Style.Style
cssList =
    [ Style.height 300
    , Style.padding 10
    ]


cssMarker : Float -> List Style.Style
cssMarker zIndex =
    [ Style.zIndex zIndex
    ]


cssMarkerImage : List Style.Style
cssMarkerImage =
    [ Style.height 40
    , Style.width 40
    , Style.resizeMode "contain"
    ]
