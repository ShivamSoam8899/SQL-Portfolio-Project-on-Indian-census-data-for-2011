select * from Project.dbo.Data1;

select * from Project.dbo.Data2;

-- Number of rows in both datasets.
select count(*) from Project..Data1;
select count(*) from Project..Data2;

-- Dataset for Uttar Pradesh and Delhi;

select * from project..data1 where state in ('Delhi','Uttar Pradesh')
select * from project..data2 where state in ('Delhi','Uttar Pradesh')

--Total Population of India

select sum(Population) as Population from project..Data2 

--Avg growth in India
select avg(Growth)*100 as Average_Growth from project..Data1

----Avg growth per State
select State ,avg(Growth)*100 as Average_Growth from project..Data1 group by State 

----Avg growth per State and order by Avg growth
select State ,avg(Growth)*100 as Average_Growth from project..Data1 group by State order by Average_Growth

----Avg growth per District and order by Avg growth
select District ,avg(Growth)*100 as Average_Growth from project..Data1 group by District order by Average_Growth

----Avg growth per District 
select District ,avg(Growth)*100 as Average_Growth from project..Data1  group by District 

---Avg Sex Ratio Per state
select State ,round(avg(Sex_Ratio),0) as Average_SexRatio from project..Data1  group by State order by Average_SexRatio desc

---Avg Literacy Per state
select State ,round(avg(Literacy),0) as Average_Literacy from project..Data1  group by State order by Average_Literacy

---Avg Literacy Per state (>90)
select State ,round(avg(Literacy),0) as Average_Literacy from project..Data1  group by State 
having round(avg(Literacy),0) >90 order by Average_Literacy


---Avg Literacy Per state (<70)
select State ,round(avg(Literacy),0) as Average_Literacy from project..Data1  group by State 
having round(avg(Literacy),0) <70 order by Average_Literacy

--Top 3 states with highest growth rate 
select top 3 State ,avg(Growth)*100 as Average_Growth from project..Data1 group by State order by Average_Growth desc

--Top 3 states with lowest growth rate
select top 3 State ,avg(Growth)*100 as Average_Growth from project..Data1 group by State order by Average_Growth asc

--top and bottom 3 states in literacy rate..
drop table if exists #topstates

create table #topstates
(state varchar(255) ,
topstates float )

insert into #topstates 
select State ,round(avg(Literacy),0) as Average_Literacy from project..Data1  group by State order by Average_Literacy

--top 3 states
select top 3 * from #topstates order by topstates desc 

drop table if exists #bottomstates

create table #bottomstates
(state varchar(255) ,
bottomstates float )

insert into #bottomstates
select State ,round(avg(Literacy),0) as Average_Literacy from project..Data1  group by State order by Average_Literacy

--bottom3  states
select top 3 * from #bottomstates order by bottomstates 


--union operator
--top3 and bottom3 literacy rate

select * from (select top 3 * from #topstates order by topstates desc) a union 
select * from (select top 3 * from #bottomstates order by bottomstates )  b order by topstates ;

--states starting with letter A

select distinct state from project..Data1 where lower(state) like 'a%'