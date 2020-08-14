<!DOCTYPE html >
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="sat, 01 Dec 2001 00:00:00 GMT">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
<title>Virtusa  | Weather Forecast</title>
<link href="static/css/bootstrap.min.css" rel="stylesheet">
<link href="static/css/style.css" rel="stylesheet">
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body  style="background-color:white;font-family: 'Times New Roman', Times, serif;">
	<div role="navigation">
		<div class="navbar navbar-inverse">
			<a href="/welcome" class="navbar-brand">Virtusa  | Weather Forecast</a>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="/login">Login</a></li>
					<li><a href="/register">New Registration</a></li>
					<!-- <li><a href="/show-users">All Users</a></li>-->
				</ul>
			</div>
		</div>
	</div>

	<div class="container" id="homediv">
		<div class="jumbotron text-center">
			<h1>Virtusa | Weather Forecast </h1>
			
		</div>
	</div>

<div class="input"  >
      <input type="text" placeholder="Enter the city" class="input_text">
      <br><br>
      <select id="j" >
    <option value="metric">celsius</option>
    <option value="imperial">fharanhiet</option>
 </select><br><br>
      <input type="submit" value="Submit"  class="submit" >
    </div>
  

  <div class="container">
    <div class="card" STYLE="font-family: 'Times New Roman', Times, serif;">
      <h1 class="name" id="name"></h1>
      <p   id="icon"></p>
      <p class="air"></p>
      
      <p class="temp"></p>
      <p class="mintemp"></p>
      <p class="maxtemp"></p>
      <p class="clouds"></p>
      <p class="desc"></p>
      <p class="wind"></p>
      <p class="presure"></p>
      <p class="humidity"></p>
      
      
    </div>
    
  </div>
  <div class="container">
    <canvas id="myChart" width="400" height="200"></canvas>
  </div>
  

    <div class="day" >
        
    </div>
    
    
    
<div class="container" style=" text-align: center;">
<div class="card">
    <div id="towrite">
</div>
    </div>
    </div>
  
<script>
var input = document.querySelector('.input_text');

var main = document.querySelector('#name');
var unit=document.getElementById('j');
var temp = document.querySelector('.temp');
var desc = document.querySelector('.desc');
var clouds = document.querySelector('.clouds');
var button= document.querySelector('.submit');
var mint= document.querySelector('.mintemp');
var maxt= document.querySelector('.maxtemp');
var wind= document.querySelector('.wind');
var presure= document.querySelector('.presure');
var humidity= document.querySelector('.humidity');
var air=document.querySelector('.air');

button.addEventListener('click', function(name){
fetch('https://api.openweathermap.org/data/2.5/weather?q='+input.value+'&units='+unit.value+'&appid=f59dba5e3890a069738d437f1805fd6a')
.then(response => response.json())
.then(data => {
  var tempValue = data['main']['temp'];
  var nameValue = data['name'];
  var descValue = data['weather'][0]['description'];
  var mintt=data['main']['temp_min'];
  var maxtt=data['main']['temp_max'];
  var iconValue=data['weather'][0]['icon'];
  var wwind=data['wind']['speed'];
  var wpre=data['main']['pressure'];
  var whum=data['main']['humidity'];
	var latt=data['coord']['lat'];
	var lonn=data['coord']['lon'];

  main.innerHTML = nameValue;
  desc.innerHTML = "Description - "+descValue;
  temp.innerHTML = "Temperature - "+tempValue;
  document.getElementById('icon').innerHTML = '<img src="http://openweathermap.org/img/wn/' + iconValue + '@4x.png" id="imageBox"/>';
  mint.innerHTML="Minimum Temperature - "+mintt;
  maxt.innerHTML="Maximum Temperature - "+maxtt;
  wind.innerHTML="Wind Speed - "+wwind;
  presure.innerHTML="Pressure - "+wpre;
  humidity.innerHTML="Humidity - "+whum;
  fetchWeather (latt,lonn,unit.value);
})

.catch(err => alert(err));
})
button.addEventListener('click', function(name){
fetch('https://api.waqi.info/feed/'+input.value+'/?token=cb89e96065b2f6086869d78f7f37e3081e013532')
.then(response => response.json())
.then(dataa => {
	var airpp=dataa['data']['aqi'];
	air.innerHTML="Air Pollution - "+airpp;
})
.catch(err => alert("Wrong city name!"));
})
const date = new Date();
//console.log(date);
const dateUnix = date.getTime();
//console.log(dateUnix);

//latitude, longitude, and api key
//41.727002, -73.240131, 8e6631d1b0023b1022deee87d15d061d 

const openWeatherURL = 'api.openweathermap.org/data/2.5/weather?zip={06750},{country code}&appid={8e6631d1b0023b1022deee87d15d061d}';
//make api request to get next 7 day forecast
async function fetchWeather (latt,lonn,temperature) {
	//await charit(latt,lonn,temperature);
	
    const response = await fetch('https://api.openweathermap.org/data/2.5/onecall?lat='+latt+'&lon='+lonn+'&exclude=minute&appid=8e6631d1b0023b1022deee87d15d061d&units='+temperature);
    const json = await response.json();
    const weeklyForecast = json.daily;
    const dates = [];
    const temps = [];
    const rainChance = [];
    const windSpeed = [];


    const dailyWeather = [];

    // for (var i=0; i<weeklyForecast.length; i++){
    //     console.log(weeklyForecast[i].dt);
    //     console.log(weeklyForecast[i].temp.day);
    //     console.log(weeklyForecast[i].rain);
    //     console.log(weeklyForecast[i].wind_speed);
    // }
    const dateLocal = [];
    
    const div = document.getElementById('towrite');
    div.innerHTML="";

    for (var i=0; i<weeklyForecast.length; i++){
    	
        weeklyForecast[i].dt;
        dates.push(weeklyForecast[i].dt);
        temps.push(weeklyForecast[i].temp.day);
        rainChance.push(weeklyForecast[i].rain);
        windSpeed.push(weeklyForecast[i].wind_speed);
        var iValue=weeklyForecast[i].weather[0].icon;
        var maxt=weeklyForecast[i].temp.max;
        var mint=weeklyForecast[i].temp.min;
        var mor=weeklyForecast[i].temp.morn;
        var aft=weeklyForecast[i].temp.eve;
        var nig=weeklyForecast[i].temp.night;
        //convert times from unix time to local
        let utcSeconds = dates[i];
        let d = new Date(0);
        let localTime = d.setUTCSeconds(utcSeconds);
        let stringTime = d.toString();
        
        	
        
        //convert kelvins to fahrenheit
        //let toFahrenheit = ((temps[i] - 273.15) * (9 / 5) + 32); 
        //let finalFahrenheit = Math.floor(toFahrenheit);
        let finalFahrenheit=weeklyForecast[i].temp.day;
        
        
        
        //if precipatation is undefined show as 0% chance of rain
        let floatRain = Number(rainChance[i]);
        if (isNaN(floatRain)){
            floatRain = 0;
        }

        //if high chance of rain show raincloud
        if (floatRain < 0.30){
            div.innerHTML += '<img src="http://openweathermap.org/img/wn/' + iValue+ '@2x.png"/>';
        } 
        if (floatRain > 0.50){
            div.innerHTML += '<img src="http://openweathermap.org/img/wn/' + iValue+ '@2x.png"/>';
        }

        const ddd = new Date();
        const n = ddd.getHours();


        //display weekly forecast 
        div.innerHTML += "<h3>" + stringTime.slice(0,15) + "</h3>";
        div.innerHTML += "<p >" + "Temperature: " + finalFahrenheit  + "</p>";
        div.innerHTML += "<p >" + "Max Temp:" + maxt + "    Min Temp: " + mint+ "</p>";
        div.innerHTML += "<p>" + "Wind Speed: " + windSpeed[i] + " Miles/Hour" +"</p>";
        div.innerHTML += "<p>" + "Morning: " + mor + " Afternoon: "+aft+"Evening: "+nig  +"</p>";
        if (windSpeed[i] > 15){
            div.innerHTML += "<p>" + "High Wind Advisory, Bring In Patio Cushions" + "</p>";
        }
        
        div.innerHTML += "<hr>";
        
        //div.innerHTML="";
        //console.log(dates);
    }
    
    charit(latt,lonn,temperature);


    //console.log(dates, dailyTemps, rainChance, windSpeed);
    //console.log(dailyWeather);

    //const div = document.getElementById('towrite');
    //div.innerHTML += '<h1>' + dates[0] + '</h1>';
    //div.innerHTML += '<p>' + temps[0] + '</p>';
    //div.innerHTML += '<p>' +rainChance[0] + '</p>';
    //div.innerHTML += '<p>' + windSpeed[0] + '</p>';



    
    
    //const file = JSON.stringify(weeklyForecast);
    //console.log(weeklyForecast);
    //console.log(file);
}
const hd=[];
const ht=[];
//getData();

async function charit(lat,lon,temper){
await getData(lat,lon,temper);
let myChart = document.getElementById('myChart').getContext('2d');

    // Global Options
    Chart.defaults.global.defaultFontFamily = 'Lato';
    Chart.defaults.global.defaultFontSize = 18;
    Chart.defaults.global.defaultFontColor = '#777';

    let massPopChart = new Chart(myChart, {
      type:'line', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
      data:{
        labels:hd,
        datasets:[{
          label:'Temperature',
          data:ht,
          //backgroundColor:'green',
          //backgroundColor:'gray',

          borderWidth:1,
          borderColor:'#777',
          hoverBorderWidth:3,
          hoverBorderColor:'#000'
        }]
      },
	  
      
    });
}
async function getData(lat,lon,temper){
	const response=await fetch('https://api.openweathermap.org/data/2.5/onecall?lat='+lat+'&lon='+lon+'&exclude=minute&appid=8e6631d1b0023b1022deee87d15d061d&units='+temper+'')
	const json = await response.json();
    const aa = json.hourly;
	const ddt=[];
    for(var i=0;i<aa.length;i++){
		ddt.push(aa[i].dt);
    	let utcSeconds = ddt[i];
        let d = new Date(0);
        let localTime = d.setUTCSeconds(utcSeconds);
        let stringTime = d.toString();
		hd.push(stringTime.slice(15,21));

    	ht.push(aa[i].temp);
    	
    	
    }
    
    
    
}

// grab dates from json and convert dates from unix and display on webpage





	
</script>
 


	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="static/js/jquery-1.11.1.min.js"></script>
	<script src="static/js/bootstrap.min.js"></script>
</body>
</html>