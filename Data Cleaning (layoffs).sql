-- Data Cleaning

select *
from layoffs;

#we will later do exploratory data analysis

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. NULL/ Blank values
-- 4. Remove rows or columns where necessary


CREATE TABLE layoffs_staging
LIKE layoffs;

select *
from layoffs_staging;

insert layoffs_staging
select *
from layoffs;

# this was a necessary measure
# since we will be changing 
# the layoffs staging database a lot

-- 1.

select *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) as row_num
from layoffs_staging;

# let's create a CTE for this^

WITH duplicate_cte as
(
select *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;

select *
from layoffs_staging
where company = 'Casper';

# we observed^ that two out of the 3 of these are duplicates

WITH duplicate_cte as
(
select *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
delete
from duplicate_cte
where row_num > 1;

# ^ it won't work. Deleting duplicates in MySQL isn't as easy as in MSSQL

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging2;

insert into layoffs_staging2
select *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;


select *
from layoffs_staging2
where row_num > 1;

delete
from layoffs_staging2
where row_num > 1;

select *
from layoffs_staging2;

-- Standardizing data

select distinct(TRIM(company))
FROM layoffs_staging2;

select company, TRIM(company)
from layoffs_staging2;

update layoffs_staging2
set company = TRIM(company);

select distinct industry
from layoffs_staging2
order by 1
;
select *
from layoffs_staging2
where industry like 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

select distinct industry
from layoffs_staging2
order by 1;

select *
from layoffs_staging2
where country like 'United States%'
;

select distinct country, trim(TRAILING '.'from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select `date`
from layoffs_staging2;

update layoffs_staging2
set date = STR_TO_DATE(`date`, '%m/%d/%Y');

#  NOW we can do this on a date column

alter table layoffs_staging2
modify column `date` date;

#definition changed to date succesfully! :D 🥳

select *
from layoffs_staging2;

-- NULL & Blank Values

select *
from layoffs_staging2
where total_laid_off IS NULL
AND percentage_laid_off IS NULL;

#make blanks into nulls
update layoffs_staging2
set industry = null
where industry ='';


select *
from layoffs_staging2
where industry is null
or industry = '';

select *
from layoffs_staging2
where company = 'Airbnb';

#populate

select t1.industry, t2.industry
from layoffs_staging2 as t1
join layoffs_staging2 as t2
	on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null
;

update layoffs_staging2 as t1
join layoffs_staging2 as t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

select *
from layoffs_staging2;

-- removal of columns/ rows

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2;

alter table layoffs_stagging2
drop column row_num;
