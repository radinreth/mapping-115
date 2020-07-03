App.ListingsIndex = () => {
  let chart;

  init = () => {
    initTreeView();
    initBarChart();
    renderDatetimepicker();
    onClickBtnDownloadChart();
  }

  renderDatetimepicker = () => {
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
      console.log('click')
      $('.from').submit();
    })
  }

  initTreeView = () => {
    let options = `daterange=${$('.datepicker > input').val()}`;

    $('#tree').jstree({
      'core' : {
        'data' : {
          'url' : `/listings.json?${options}`,
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
    let labels = provinces.map(p => p.name_en);
    let data = provinces.map(p => p.callers_count);
    chart = new Chart(ctx, {
      type: 'bar',
      data: {
          labels: labels,
          datasets: [{
              label: '# of callers',
              backgroundColor: 'rgb(255, 99, 132)',
              borderColor: 'rgb(255, 99, 132)',
              data: data
          }]
      },
      options: {
      }
    });
  }

  onClickBtnDownloadChart = () => {
    $('#btn-download-chart').on('click', (e) => {
      let a = document.createElement("a");
      a.href = chart.toBase64Image()
      a.download = "chart.png";
      a.click();
    })
  }

  return { init }
}
