App.WelcomeIndex = () => {
  let map = null
  let defaultRadiusSize = 5
  let minRadiusSize = 1
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
    let color = {
      red: { name: 'red', fill: '#d62828' },
      green: { name: 'green', fill: '#02c39a' },
      orange: { name: 'orange', fill: '#fb5607' }
    }

    gon.locations.forEach((loc) => {
      callersCount = loc.callers_count
      increasedSize = defaultRadiusSize + callersCount

      let key = 'red'
      if( callersCount <= gon.indicator.max1 ) key = 'green'
      else if (callersCount <= gon.indicator.max2 ) key = 'orange'

      let marker = L.circleMarker([loc.lat, loc.lng], {
        color: color[key].name,
        fillColor: color[key].fill,
        fillOpacity: 0.8,
        weight: 1,
        opacity: 1,
        radius: minRadiusSize + callersCount * 10 / gon.indicator.max
      }).addTo(map)

      marker.bindPopup(`
        <strong class="location-title">${loc.name || loc.name_km}</strong>
        <p class="m-0">ចំនួនតេចូល:${callersCount}</p>
      `)
      marker.on('mouseover', function() { this.openPopup() })
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