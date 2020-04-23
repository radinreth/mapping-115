App.WelcomeIndex = () => {
  let map = null

  const init = () => {
    renderMap()
    renderMarkers()
  }

  const renderMap = () => {
    map = L.map("map", { zoom: 13 })
    map.fitBounds([
      [10.4865436874, 102.3480994],
      [14.5705838078, 107.614547968]
    ])
    map.addLayer(osm())
  }

  const renderMarkers = () => {
    console.log(gon.locations)
    gon.locations.forEach((loc) => {
      let marker = L.marker([loc.lat, loc.lng])
      marker.addTo(map)
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