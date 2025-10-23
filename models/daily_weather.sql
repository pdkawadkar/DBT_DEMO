with daily_weather as(

select 
date(time) as daily_weather,
weather,
temp,
pressure,
humadity,
clouds
from
{{ source('demo','weather')}}
limit 10
),

daily_weather_agg as (

select 
daily_weather,
weather,
round(avg(temp),2) as avg_temp,
round(avg(pressure),2) as avg_presuure,
round(avg(humadity),2) as avg_humadity,
round(avg(clouds),2) as avg_clouds

from 
daily_weather
group by daily_weather, count(weather)
where row_number()(partition by daily_weather order by count(weather) desc = 1

)


select * from daily_weather_agg