-- Selezionare tutte le nazioni il cui nome inizia con la P e la cui
-- area è maggiore di 1000 kmq
select * from countries where name like 'p%' and area > 1000;



-- 2. Selezionare le nazioni il cui national day è avvenuto più di
-- 100 anni fa

select * from countries  where timestampdiff(year,national_day ,curdate()) >100;


-- 3 Selezionare il nome delle regioni del continente europeo, in
-- ordine alfabetico

select r.name 
from regions r 
inner join continents c 
on r.continent_id = c.continent_id 
where c.continent_id = 4
order by r.name 

-- 4 Contare quante lingue sono parlate in Italia (107)
select count(*) 
from country_languages cl 
where country_id  = 107


-- 5. Selezionare quali nazioni non hanno un national day
select *
from countries c 
where national_day is null

-- 6. Per ogni nazione selezionare il nome, la regione e il continente

select c.name , r.name , c2.name 
from countries c
inner join regions r 
on c.region_id = r.region_id 
inner join continents c2 
on r.continent_id = c2.continent_id 


-- 7. Modificare la nazione Italy, inserendo come national day il 2
-- giugno 1946

update countries set national_day = '1946-06-02' where  name = 'italy'


-- 8. Per ogni regione mostrare il valore dell'area totale

select sum(c.area) as area_totale , r.name 
from regions r
inner join  countries c
on r.region_id = c.region_id 
group by r.name 
order by area_totale

-- 9. Selezionare le lingue ufficiali dell'Albania

select  c.name, l.`language`,cl.official
from languages l 
inner join country_languages cl 
on cl.language_id = l.language_id 
inner join countries c 
on cl.country_id = c.country_id
where c.name = 'Albania' and official = 1;


-- 10. Selezionare il Gross domestic product (GDP) medio dello
-- United Kingdom tra il 2000 e il 2010

select c.name as nazione ,  avg(cs.gdp) as media_gdp 
from countries c 
inner join country_stats cs 
on c.country_id = cs.country_id 
WHERE c.name LIKE 'United Kingdom' AND cs.`year` >= 2000 and cs.`year` <= 2010
GROUP BY nazione;


-- 11. Selezionare tutte le nazioni in cui si parla hindi, ordinate
-- dalla più estesa alla meno estesa

select *
from countries c
inner join country_languages cl 
on c.country_id = cl.country_id 
inner join languages l 
on cl.language_id = l.language_id 
where l.`language` like 'hindi'


-- 12  Per ogni continente, selezionare il numero di nazioni con
-- area superiore ai 10.000 kmq ordinando i risultati a partire dal
-- continente che ne ha di piu

SELECT c.name, COUNT(c2.country_id) as 'Nazioni_con_area_superiore_a_10000'
FROM continents c
INNER JOIN regions r 
ON c.continent_id  = r.continent_id  
INNER JOIN countries c2 
ON c2.region_id  = r.region_id 
WHERE c2.area > 10000
GROUP BY c.name 
ORDER BY Nazioni_con_area_superiore_a_10000 DESC;