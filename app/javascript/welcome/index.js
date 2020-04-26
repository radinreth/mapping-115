App.WelcomeIndex = () => {
  let map = null
  let defaultRadiusSize = 5
  let maxRadiusSize = 18
  let SW = [10.4865436874, 102.3480994]
  let NE = [14.5705838078, 107.614547968]

  const init = () => {
    renderMap()
    renderMarkers()
  }

  const renderMap = () => {
    map = L.map("map", { zoom: 13 })
    map.fitBounds([SW, NE])
    map.addLayer(osm())
  }

  const renderMarkers = () => {
    gon.locations.forEach((loc) => {
      callersCount = loc.nested_count
      increasedSize = defaultRadiusSize + callersCount

      let marker = L.circleMarker([loc.lat, loc.lng], {
        color: "red",
        fillColor: "#fc7a4e",
        fillOpacity: 0.8,
        weight: 1,
        opacity: 1,
        radius: (increasedSize > maxRadiusSize ? maxRadiusSize : increasedSize)
      }).addTo(map)

      marker.bindPopup(`Callers: ${callersCount}`)
    })
  }

  const osm = () => {
    let osmUrl = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
    let osmAttrib = "Map data © <a href='https://openstreetmap.org'>OpenStreetMap</a> contributors"
    let osm = new L.TileLayer(osmUrl, { minZoom: 5, maxZoom: 11, attribution: osmAttrib });
    return osm
  }

  return { init }
}