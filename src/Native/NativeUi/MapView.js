const _ohanhi$elm_native_ui$Native_NativeUi_MapView = function () {
  const map = require('react-native-maps');
  const unit = { ctor: "_Tuple0" };

  const markers = {};
  const maps = {};

  /**
   * The imperaive methods must be called on an instance.
   * By calling the refMap and refMarker function through ref property,
   * the reference to the component will be stored here.
   * To distinguish them each other wee supply an `id` property to the node.
   *
   * There is no concern about garbage collection things.
   * What if an app try to repeat adding and removing 1000 markers ?
   * Probably need to add a removing functionality.
   */

  /**
   * functions for  MapView
   */
  function refMap(el) {
    maps[el.props.id] = el;
  }

  function animateToRegion(id, region, duration) {
    return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
      maps[id].animateToRegion(region, duration);
      return callback(_elm_lang$core$Native_Scheduler.succeed(unit));
    });
  }

  function animateToCoordinate(id, coordinate, duration) {
    return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
      maps[id].animateToCoordinate(coordinate, duration);
      return callback(_elm_lang$core$Native_Scheduler.succeed(unit));
    });
  }

  function fitToElements(id, animated) {
    return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
      maps[id].fitToElements(animated);
      return callback(_elm_lang$core$Native_Scheduler.succeed(unit));
    });
  }

  function fitToSuppliedMarkers(id, markerIDs, animated) {
    return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
      maps[id].fitToSuppliedMarkers(markerIDs, animated);
      return callback(_elm_lang$core$Native_Scheduler.succeed(unit));
    });
  }

  function fitToCoordinates(id, coordinates, options) {
    return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
      maps[id].fitToCoordinates(coordinates, options);
      return callback(_elm_lang$core$Native_Scheduler.succeed(unit));
    });
  }

  /**
   * functions for MapView.Marker
   */
  function refMarker(el) {
    markers[el.props.id] = el;
  }

  function showCallout(id) {
    return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
      markers[id].showCallout();
      return callback(_elm_lang$core$Native_Scheduler.succeed(unit));
    });
  }

  function hideCallout(id) {
    return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
      markers[id].hideCallout();
      return callback(_elm_lang$core$Native_Scheduler.succeed(unit));
    });
  }

  return {
    map: map,
    marker: map.Marker,
    polyline: map.Polyline,
    polygon: map.Polygon,
    circle: map.Circle,
    urlTile : map.UrlTile,
    callout: map.Callout,
    refMap: refMap,
    animateToRegion: F3(animateToRegion),
    animateToCoordinate : F3(animateToCoordinate),
    fitToElements: F2(fitToElements),
    fitToSuppliedMarkers: F3(fitToSuppliedMarkers),
    fitToCoordinates: F3(fitToCoordinates),
    refMarker: refMarker,
    showCallout: showCallout,
    hideCallout: hideCallout,
  };
}();
