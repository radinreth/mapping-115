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
              '/listings/provinces' :
              '/listings/child_locations';
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
    // console.log(provinces)
    let labels = provinces.map(p => p.name_km);
    let data = provinces.map(p => p.callers_count);
    var chart = new Chart(ctx, {
        // The type of chart we want to create
        type: 'bar',

        // The data for our dataset
        data: {
            labels: labels,
            datasets: [{
                label: 'ចំនួនអ្នកតេចូល',
                backgroundColor: 'rgb(255, 99, 132)',
                borderColor: 'rgb(255, 99, 132)',
                data: data
            }]
        },

        // Configuration options go here
        options: {}
    });
  }

  return { init }
}
