App.ListingsIndex = () => {
  init = () => {
    initTreeView();
    initBarChart();
  }

  initTreeView = () => {
    $('#tree').jstree({
      'core' : {
        'data' : {
          'url' : function (node) {
            return node.id === '#' ?
              '/listings.json' :
              '/listings/locations';
          },
          'data' : function (node) {
            return { 'id' : node.id };
          }
        }
      }
    });
  }

  initBarChart = () => {
    var ctx = document.getElementById('myChart').getContext('2d');
    let provinces = $('#myChart').data('provinces');
    let labels = provinces.map(p => p.name_km);
    let data = provinces.map(p => p.callers_count);
    var chart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'ចំនួនអ្នកតេចូល',
                backgroundColor: 'rgb(255, 99, 132)',
                borderColor: 'rgb(255, 99, 132)',
                data: data
            }]
        },
        options: {}
    });
  }

  return { init }
}
