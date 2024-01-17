 select *
 from health_data

 ---clean and sort out the data first

 ---dropping F1 column

 Alter table health_data
 drop column F1

 ---convert age from days to years

 select age, ROUND((age/365),0) as Age
 from health_data

UPDATE health_data
set age = ROUND((age/365),0)

---separating age into categorical groups (thirties, forties, fifties, sixties)

ALTER TABLE health_data
ALTER COLUMN age nvarchar(255)

select age, 
CASE WHEN age between 30 and 39 THEN 'thirties'
	 WHEN age between 40 and 49 THEN 'forties'
	 WHEN age between 50 and 59 THEN 'fifties'
	 WHEN age between 60 and 69 THEN 'sixties'
	 ELSE age
	 END 
from health_data

ALTER TABLE health_data
add AgeGroups nvarchar(255);

Update health_data
set AgeGroups = CASE WHEN age between 30 and 39 THEN 'thirties'
	 WHEN age between 40 and 49 THEN 'forties'
	 WHEN age between 50 and 59 THEN 'fifties'
	 WHEN age between 60 and 69 THEN 'sixties'
	 ELSE age
	 END 

---change gender column to male/female, 0 -> 'Male', 1 -> 'Female'

ALTER TABLE health_data
ALTER COLUMN gender nvarchar(255)

Select gender,
CASE WHEN gender = 0 THEN 'Male'
	 WHEN gender = 1 THEN 'Female'
	 ELSE gender
	 END
from health_data

UPDATE health_data
set gender = CASE WHEN gender = 0 THEN 'Male'
	 WHEN gender = 1 THEN 'Female'
	 ELSE gender
	 END

---calculating BMI with weight(kg) and height(cm), then placing each BMI in their respective weight category(underweight, normal weight, overweight, obese)

select height, weight, ROUND((weight/(POWER((height/100),2))),0) as BMI
from health_data

ALTER TABLE health_data
add BMI float;

UPDATE health_data
set BMI = ROUND((weight/(POWER((height/100),2))),0)

ALTER TABLE health_data
ALTER COLUMN BMI nvarchar(255)

Select BMI, 
CASE WHEN BMI <= 19 THEN 'underweight'
     WHEN BMI BETWEEN 19 AND 25 THEN 'normal'
     WHEN BMI BETWEEN 26 AND 30 THEN 'overweight'
     WHEN BMI >= 31 THEN 'obese'
     ELSE BMI
     END as BMIgroups
from health_data

ALTER TABLE health_data
add BMIgroups nvarchar(255)

UPDATE health_data
set BMIgroups = CASE WHEN BMI <= 19 THEN 'underweight'
     WHEN BMI BETWEEN 19 AND 25 THEN 'normal'
     WHEN BMI BETWEEN 26 AND 30 THEN 'overweight'
     WHEN BMI >= 31 THEN 'obese'
     ELSE BMI
     END

---grouping ap_hi(systolic blood pressure) and ap_lo(diastolic blood pressure) into each category(normal, elevated, hypertension1, hypertension2, hyperextensive)

ALTER TABLE health_data
ALTER COLUMN ap_hi nvarchar(255)

ALTER TABLE health_data
ALTER COLUMN ap_lo nvarchar(255)

select ap_hi, ap_lo,
CASE WHEN ap_hi < 120 AND ap_lo < 80 THEN 'normal' 
	 WHEN ap_hi BETWEEN 120 AND 129 AND ap_lo < 80 THEN 'elevated'
	 WHEN ap_hi BETWEEN 130 AND 139 OR ap_lo BETWEEN 80 AND 89 THEN 'hypertension1'
	 WHEN ap_hi BETWEEN 140 AND 179 OR ap_lo BETWEEN 90 AND 119 THEN 'hypertension2'
	 WHEN ap_hi >= 180 OR ap_lo >= 120 THEN 'hyperextensive'
	 ELSE ap_hi
	 END as BPcategories
from health_data

ALTER TABLE health_data
add BPcategories nvarchar(255)

UPDATE health_data
set BPcategories = CASE WHEN ap_hi < 120 AND ap_lo < 80 THEN 'normal' 
	 WHEN ap_hi BETWEEN 120 AND 129 AND ap_lo < 80 THEN 'elevated'
	 WHEN ap_hi BETWEEN 130 AND 139 OR ap_lo BETWEEN 80 AND 89 THEN 'hypertension1'
	 WHEN ap_hi BETWEEN 140 AND 179 OR ap_lo BETWEEN 90 AND 119 THEN 'hypertension2'
	 WHEN ap_hi >= 180 OR ap_lo >= 120 THEN 'hyperextensive'
	 ELSE ap_hi
	 END

---change cholesterol to 0 -> normal, 1 -> high, 2 -> extreme, indicating levels of cholesterol

ALTER TABLE health_data
ALTER COLUMN cholesterol nvarchar(255)

Select cholesterol,
CASE WHEN cholesterol = 0 THEN 'Normal'
	 WHEN cholesterol = 1 THEN 'High'
	 WHEN cholesterol = 2 THEN 'Extreme'
	 ELSE cholesterol
	 END
from health_data

UPDATE health_data
set cholesterol = CASE WHEN cholesterol = 0 THEN 'Normal'
	 WHEN cholesterol = 1 THEN 'High'
	 WHEN cholesterol = 2 THEN 'Extreme'
	 ELSE cholesterol
	 END

---change glucose from 0 -> normal, 1 -> high, 2 -> extreme, indicating levels of glucose

ALTER TABLE health_data
ALTER COLUMN gluc nvarchar(255)

Select gluc,
CASE WHEN gluc = 0 THEN 'Normal'
	 WHEN gluc = 1 THEN 'High'
	 WHEN gluc = 2 THEN 'Extreme'
	 ELSE gluc
	 END
from health_data

UPDATE health_data
set gluc = CASE WHEN gluc = 0 THEN 'Normal'
	 WHEN gluc = 1 THEN 'High'
	 WHEN gluc = 2 THEN 'Extreme'
	 ELSE gluc
	 END

---change smoke 0 -> No, 1 -> Yes, indicating if person is a smoker or not

ALTER TABLE health_data
ALTER COLUMN smoke nvarchar(255)

Select smoke,
CASE WHEN smoke = 0 THEN 'No'
	 WHEN smoke = 1 THEN 'Yes'
	 ELSE smoke
	 END
from health_data

UPDATE health_data
set smoke = CASE WHEN smoke = 0 THEN 'No'
	 WHEN smoke = 1 THEN 'Yes'
	 ELSE smoke
	 END

---change alco 0 -> No, 1 -> Yes, indicating if person drinks alcohol or not

ALTER TABLE health_data
ALTER COLUMN alco nvarchar(255)

Select alco,
CASE WHEN alco = 0 THEN 'No'
	 WHEN alco = 1 THEN 'Yes'
	 ELSE alco
	 END
from health_data

UPDATE health_data
set alco = CASE WHEN alco = 0 THEN 'No'
	 WHEN alco = 1 THEN 'Yes'
	 ELSE alco
	 END

---change active 0 -> No, 1 -> Yes, indicating if person does any physical activity

ALTER TABLE health_data
ALTER COLUMN active nvarchar(255)

Select active,
CASE WHEN active = 0 THEN 'No'
	 WHEN active = 1 THEN 'Yes'
	 ELSE active
	 END
from health_data

UPDATE health_data
set active = CASE WHEN active = 0 THEN 'No'
	 WHEN active = 1 THEN 'Yes'
	 ELSE active
	 END

---change cardio 0 -> No, 1 -> Yes, indicating if person has cardiovascular disease or not

ALTER TABLE health_data
ALTER COLUMN cardio nvarchar(255)

Select cardio,
CASE WHEN cardio = 0 THEN 'No'
	 WHEN cardio = 1 THEN 'Yes'
	 ELSE cardio
	 END
from health_data

UPDATE health_data
set cardio = CASE WHEN cardio = 0 THEN 'No'
	 WHEN cardio = 1 THEN 'Yes'
	 ELSE cardio
	 END

---EDA

select *
from health_data

---count of people who has CVD (34,979) by each age

select age, COUNT(age) as AgeCVD
from health_data
where cardio = 'Yes' 
group by age
order by age

---count of each age group that has CVD

select agegroups, count(agegroups) as AgegroupsCVD
from health_data
where cardio = 'Yes'
group by agegroups
order by 2

---count of people who has CVD (34,979) by gender

select gender, count(gender) as GenderCVD
from health_data
where cardio = 'Yes' 
group by gender

---count of people who has CVD by BMI categories

select BMIgroups, COUNT(BMIgroups) BMIgroupsCVD
from health_data
where cardio = 'Yes'
group by BMIgroups
order by 2 desc

---count of people who has CVD by Blood Pressure categories

select BPcategories, COUNT(BPcategories) BPcategoriesCVD
from health_data
where cardio = 'Yes'
group by BPcategories
order by 2 desc

---count of people who has CVD separated by each level(normal, high, extreme) of cholesterol

select cholesterol, count(cholesterol) as CholesterolCVD
from health_data
where cardio = 'Yes'
group by cholesterol
Order By 1

---count of people who has CVD separated by each level(normal, high, extreme) of glucose

select gluc, count(gluc) as GlucoseCVD
from health_data
where cardio = 'Yes'
group by gluc
Order By 1

---count of people who has CVD and are smokers

select smoke, count(smoke) as SmokeCVD
from health_data
where cardio = 'Yes' and smoke = 'Yes'
group by smoke

---count of people who has CVD and drinks alcohol 

select alco, count(alco) as AlcoCVD
from health_data
where cardio = 'Yes' and alco = 'Yes'
group by alco

---count of people who has CVD and is physically active

select active, count(active) as ActiveCVD
from health_data
where cardio = 'Yes' 
group by active

select *
from health_data