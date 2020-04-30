App.WelcomeIndex = () => {
  let map = null
  let defaultRadiusSize = 5
  let maxRadiusSize = 18
  let SW = [10.4865436874, 102.3480994]
  let NE = [14.5705838078, 107.614547968]

  const init = () => {
    renderMap()
    renderMarkers()
    renderDatetimepicker()
  }

  const renderDatetimepicker = () => {
    $('.datepicker > input').daterangepicker({
      locale: { format: 'YYYY/MM/DD'},
      cancelLabel: 'Clear',
      alwaysShowCalendars: true,
      showCustomRangeLabel: true,
      ranges: {
        'Today': [moment(), moment()],
        'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
        'Last 7 Days': [moment().subtract(6, 'days'), moment()],
        'Last 30 Days': [moment().subtract(29, 'days'), moment()],
        'This Month': [moment().startOf('month'), moment().endOf('month')],
        'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
     },
     opens: 'left'
    })
    .on('apply.daterangepicker', function(ev, picker) {
      $(".btn-search > a")[0].click()
    })
  }

  $(".options button").click(function() {
    $(".options button").removeClass("active")
    $(this).addClass("active")
  })

  $(".btn-search a").click(function(e){
    let area = $('.options .btn.active').text().toLowerCase()
    let dateRange = $('input').val()
    $(this).attr('href', `?daterange=${dateRange}&kind=${area}`)
  })

  const renderMap = () => {
    map = L.map("map", { zoom: 13 })
    map.fitBounds([SW, NE])
    map.addLayer(osm())
  }

  const renderMarkers = () => {
    gon.locations.forEach((loc) => {
      callersCount = loc.callers_count
      increasedSize = defaultRadiusSize + callersCount

      let marker = L.circleMarker([loc.lat, loc.lng], {
        color: (callersCount == 0 ?"#004e98" : "red"),
        fillColor: (callersCount == 0 ?"#3a6ea5" : "#d62828"),
        fillOpacity: 0.8,
        weight: 1,
        opacity: 1,
        radius: (increasedSize > maxRadiusSize ? maxRadiusSize : increasedSize)
      }).addTo(map)

      marker.bindPopup(`ចំនួនតេចូល:${callersCount}`)
    })
  }

  const osm = () => {
    let osmUrl = 'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png'
    let osmAttrib = "Map data © <a href='https://openstreetmap.org'>OpenStreetMap</a> contributors"
    let osm = new L.TileLayer(osmUrl, { minZoom: 5, maxZoom: 11, attribution: osmAttrib });
    return osm
  }

  return { init }
}