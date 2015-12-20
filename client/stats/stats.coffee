random = ->
  Math.floor Math.random() * 100 + 1

Template.statsTemplate.onRendered ->
  # Get the context of the canvas element we want to select
  ctx = document.getElementById('myChart').getContext('2d')
  ctx2 = document.getElementById('myChart2').getContext('2d')
  ctx3 = document.getElementById('myChart3').getContext('2d')

  options = {
    legendTemplate: "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].strokeColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>"
  }

  data1 = [
    {
      value: random()
      color: '#F7464A'
      highlight: '#FF5A5E'
      label: 'Red'
    }
    {
      value: random()
      color: '#46BFBD'
      highlight: '#5AD3D1'
      label: 'Green'
    }
  ]
  
  data2 = [
    {
      value: random()
      color: '#F7464A'
      highlight: '#FF5A5E'
      label: 'Red'
    }
    {
      value: random()
      color: '#46BFBD'
      highlight: '#5AD3D1'
      label: 'Green'
    }
  ]

  data3 = [
    {
      value: random()
      color: '#F7464A'
      highlight: '#FF5A5E'
      label: 'Red'
    }
    {
      value: random()
      color: '#46BFBD'
      highlight: '#5AD3D1'
      label: 'Green'
    }
  ]
  
  myLineChart = new Chart(ctx).Doughnut(data1, options)
  myRadarChart = new Chart(ctx2).Doughnut(data2, options)
  myPolarArea = new Chart(ctx3).Doughnut(data3, options)
  