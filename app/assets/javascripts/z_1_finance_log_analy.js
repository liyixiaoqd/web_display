
var randomScalingFactor = function () { return Math.round(Math.random() * 100) };//生成随机数字
var lineChartData = {
	labels: ["January", "February", "March", "April", "May", "June", "July"],//图上的各点（X坐标）
	datasets: [
	{
		label: "My First dataset",
		fillColor: "rgba(220,220,220,0.2)",
		strokeColor: "rgba(220,220,220,1)",
		pointColor: "rgba(220,220,220,1)",
		pointStrokeColor: "#fff",
		pointHighlightFill: "#fff",
		pointHighlightStroke: "rgba(220,220,220,1)",
		data: [40, 45, 50, 30, 20, 10, 0]//趋势图，线上各点的值（Y坐标）
	},
	{
		label: "My Second dataset",
		fillColor: "rgba(151,187,205,0.2)",
		strokeColor: "rgba(151,187,205,1)",
		pointColor: "rgba(151,187,205,1)",
		pointStrokeColor: "#fff",
		pointHighlightFill: "#fff",
		pointHighlightStroke: "rgba(151,187,205,1)",
		data: [25, 30, 35, 50, 65, 68, 80]//趋势图，线上各点的值（Y坐标）
	}
	]
}
//画趋势图
var chart1 = function () {
	var ctx = document.getElementById("line_chart_sample").getContext("2d");
	window.myLine = new Chart(ctx).Line(lineChartData, {
		responsive: true
	});
}

//百分比分布（环形）图数据
var doughnutData = [
	{
		value: 300,
		color: "#F7464A",
		highlight: "#FF5A5E",
		label: "Red"
	},
	{
		value: 50,
		color: "#46BFBD",
		highlight: "#5AD3D1",
		label: "Green"
	},
	{
		value: 100,
		color: "#FDB45C",
		highlight: "#FFC870",
		label: "Yellow"
	},
	{
		value: 40,
		color: "#949FB1",
		highlight: "#A8B3C5",
		label: "Grey"
	},
	{
		value: 120,
		color: "#4D5360",
		highlight: "#616774",
		label: "Dark Grey"
	}
];

//画百分比分布（环形）图
var chart2 = function () {
	var ctx = document.getElementById("doughnut_chart_sample").getContext("2d");
	window.myDoughnut = new Chart(ctx).Doughnut(doughnutData, { responsive: true });
};


//柱状图数据
var barChartData = {
	labels: ["January", "February", "March", "April", "May", "June", "July"],
	datasets: [
		{
			fillColor: "rgba(220,220,220,0.5)",
			strokeColor: "rgba(220,220,220,0.8)",
			highlightFill: "rgba(220,220,220,0.75)",
			highlightStroke: "rgba(220,220,220,1)",
			data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()]
		},
		{
			fillColor: "rgba(151,187,205,0.5)",
			strokeColor: "rgba(151,187,205,0.8)",
			highlightFill: "rgba(151,187,205,0.75)",
			highlightStroke: "rgba(151,187,205,1)",
			data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()]
		}
	]
}
//画柱状图
var chart3 = function () {
	var ctx = document.getElementById("bar_chart_sample").getContext("2d");
	window.myBar = new Chart(ctx).Bar(barChartData, {
		responsive: true
	});
};


//百分比分布图数据(饼状)

var pieData = [
	{
		value: 300,
		color: "#F7464A",
		highlight: "#FF5A5E",
		label: "Red"
	},
	{
		value: 50,
		color: "#46BFBD",
		highlight: "#5AD3D1",
		label: "Green"
	},
	{
		value: 100,
		color: "#FDB45C",
		highlight: "#FFC870",
		label: "Yellow"
	},
	{
		value: 40,
		color: "#949FB1",
		highlight: "#A8B3C5",
		label: "Grey"
	},
	{
		value: 120,
		color: "#4D5360",
		highlight: "#616774",
		label: "Dark Grey"
	}
];
//画百分比分布图(饼状)
var chart4 = function () {
	var ctx = document.getElementById("pie_chart_sample").getContext("2d");
	window.myPie = new Chart(ctx).Pie(pieData);
};


//扇形图数据
var polarData = [
	{
		value: 300,
		color: "#F7464A",
		highlight: "#FF5A5E",
		label: "Red"
	},
	{
		value: 50,
		color: "#46BFBD",
		highlight: "#5AD3D1",
		label: "Green"
	},
	{
		value: 100,
		color: "#FDB45C",
		highlight: "#FFC870",
		label: "Yellow"
	},
	{
		value: 40,
		color: "#949FB1",
		highlight: "#A8B3C5",
		label: "Grey"
	},
	{
		value: 120,
		color: "#4D5360",
		highlight: "#616774",
		label: "Dark Grey"
	}
];
//画扇形图
var chart5 = function () {
	var ctx = document.getElementById("polar_chart_sample").getContext("2d");
	window.myPolarArea = new Chart(ctx).PolarArea(polarData, {
		responsive: true
	});
};


//多边形数据对比图数据
var radarChartData = {
	labels: ["Eating", "Drinking", "Sleeping", "Designing", "Coding", "Cycling", "Running"],
	datasets: [
	{
		label: "My First dataset",
		fillColor: "rgba(220,220,220,0.2)",
		strokeColor: "rgba(220,220,220,1)",
		pointColor: "rgba(220,220,220,1)",
		pointStrokeColor: "#fff",
		pointHighlightFill: "#fff",
		pointHighlightStroke: "rgba(220,220,220,1)",
		data: [65, 59, 90, 81, 56, 55, 40]
	},
	{
		label: "My Second dataset",
		fillColor: "rgba(151,187,205,0.2)",
		strokeColor: "rgba(151,187,205,1)",
		pointColor: "rgba(151,187,205,1)",
		pointStrokeColor: "#fff",
		pointHighlightFill: "#fff",
		pointHighlightStroke: "rgba(151,187,205,1)",
		data: [28, 48, 40, 19, 96, 27, 100]
	}
	]
};
//画多边形数据对比图
var chart6 = function () {
	window.myRadar = new Chart(document.getElementById("radar_chart_sample").getContext("2d")).Radar(radarChartData, {
	responsive: true
	});
};

var pie_chart_data = [
	{
		color: "#F7464A",
		highlight: "#FF5A5E"
	},
	{
		color: "#46BFBD",
		highlight: "#5AD3D1"
	},
	{
		color: "#FDB45C",
		highlight: "#FFC870"
	},
	{
		color: "#949FB1",
		highlight: "#A8B3C5"
	},
	{
		color: "#4D5360",
		highlight: "#616774"
	},
	{
		color: "#6DF360",
		highlight: "#66FF33"
	}
];

var pie_chart = function(){
	var objTable=document.getElementById("pie_chart_table");
	if(objTable)
	{
		for(var i=1;i<objTable.rows.length;i++)
		{
			pie_chart_data[i-1].label=objTable.rows[i].cells[1].innerHTML;
			pie_chart_data[i-1].value=objTable.rows[i].cells[2].innerHTML;
		}
	}
	var ctx = document.getElementById("pie_chart").getContext("2d");
	window.myPie = new Chart(ctx).Pie(pie_chart_data);
}


var line_chart_table = {
	labels: [],//图上的各点（X坐标）
	datasets: [
		{
			label: "finance action dataset",
			fillColor: "rgba(220,220,220,0.2)",
			strokeColor: "rgba(220,120,220,1)",
			pointColor: "rgba(120,220,220,1)",
			pointStrokeColor: "#fff",
			pointHighlightFill: "#fff",
			pointHighlightStroke: "rgba(220,220,220,1)",
			data: []//趋势图，线上各点的值（Y坐标）
		}
	]
}

var line_chart=function(){
	var ctx = document.getElementById("line_chart").getContext("2d");
	var objTable=document.getElementById("line_chart_table");
	if(objTable)
	{
		for(var i=1;i<objTable.rows.length;i++)
		{
			line_chart_table.labels[i-1]=objTable.rows[i].cells[0].innerHTML;
			line_chart_table.datasets[0].data[i-1]=objTable.rows[i].cells[1].innerHTML;
		}
	}

	window.myLine = new Chart(ctx).Line(line_chart_table, {
		responsive: true
	});
}

//柱状图数据_count
var bar_chart_table_count = {
	labels: [],
	datasets: [
		{
			fillColor: "rgba(220,220,220,0.5)",
			strokeColor: "rgba(220,220,220,0.8)",
			highlightFill: "rgba(220,220,220,0.75)",
			highlightStroke: "rgba(220,220,220,1)",
			data: []
		}
	]
}
//柱状图数据_amount
var bar_chart_table_amount = {
	labels: [],
	datasets: [
		{
			fillColor: "rgba(151,187,205,0.5)",
			strokeColor: "rgba(151,187,205,0.8)",
			highlightFill: "rgba(151,187,205,0.75)",
			highlightStroke: "rgba(151,187,205,1)",
			data: []
		}
	]
}
//画柱状图
var bar_chart_all = function () {
	var objTable=document.getElementById("bar_chart_table");
	if(objTable)
	{
		for(var i=1;i<objTable.rows.length;i++)
		{
			bar_chart_table_count.labels[i-1]=objTable.rows[i].cells[0].innerHTML;
			bar_chart_table_count.datasets[0].data[i-1]=objTable.rows[i].cells[1].innerHTML;
			bar_chart_table_amount.labels[i-1]=objTable.rows[i].cells[0].innerHTML;
			bar_chart_table_amount.datasets[0].data[i-1]=objTable.rows[i].cells[2].innerHTML;
		}
	}
	var ctx = document.getElementById("bar_chart_count").getContext("2d");
	window.myBar = new Chart(ctx).Bar(bar_chart_table_count, {
		responsive: true
	});

	var ctx = document.getElementById("bar_chart_amount").getContext("2d");
	window.myBar = new Chart(ctx).Bar(bar_chart_table_amount, {
		responsive: true
	});
};

$(document).ready(function(){
	if (window.location.pathname=="/finance_log_analy/index_general_chart"){
		pie_chart();

		$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
			if (e.target.innerHTML=="CHART SAMPLE") {
				document.getElementById("search_chart_well").style.display="none";
				chart1()
				chart2()
				chart3()
				chart4()
				chart5()
				chart6()
			}
			else{
				if (e.target.innerHTML=="LINE CHART") {
					line_chart();
				}
				document.getElementById("search_chart_well").style.display="";
			}
		})
	}
	else if(window.location.pathname=="/finance_log_analy/index_submit_action_chart"){
		bar_chart_all()
	}
})