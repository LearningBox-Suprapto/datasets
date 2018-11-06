This dataset is a CSV export of the [MySQL
Employees](https://github.com/datacharmer/test_db) sample dataset.

<center>
![](https://dev.mysql.com/doc/employee/en/images/employees-schema.png)
</center>
Data Dictionary
---------------

### departments

    departments <- readr::read_csv(
      file = "departments.csv", 
      col_types = readr::cols(), 
      col_names = c("dept_no", "dept_name")
    )
    str(departments)

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    9 obs. of  2 variables:
    ##  $ dept_no  : chr  "d009" "d005" "d002" "d003" ...
    ##  $ dept_name: chr  "Customer Service" "Development" "Finance" "Human Resources" ...
    ##  - attr(*, "spec")=List of 2
    ##   ..$ cols   :List of 2
    ##   .. ..$ dept_no  : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ dept_name: list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   ..$ default: list()
    ##   .. ..- attr(*, "class")= chr  "collector_guess" "collector"
    ##   ..- attr(*, "class")= chr "col_spec"

    tibble::glimpse(departments)

    ## Observations: 9
    ## Variables: 2
    ## $ dept_no   <chr> "d009", "d005", "d002", "d003", "d001", "d004", "d00...
    ## $ dept_name <chr> "Customer Service", "Development", "Finance", "Human...

#### Notes

-   `dept_no`
    -   Values are alphanumberic (“A000”)
-   `dept_name`
    -   Values are title-case

### dept\_emp

    dept_emp <- readr::read_csv(
      file = "dept_emp.csv", 
      col_types = readr::cols(), 
      col_names = c("emp_no", "dept_no", "from_date", "to_date")
    )
    str(dept_emp)

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    331603 obs. of  4 variables:
    ##  $ emp_no   : int  10001 10002 10003 10004 10005 10006 10007 10008 10009 10010 ...
    ##  $ dept_no  : chr  "d005" "d007" "d004" "d004" ...
    ##  $ from_date: Date, format: "1986-06-26" "1996-08-03" ...
    ##  $ to_date  : Date, format: "9999-01-01" "9999-01-01" ...
    ##  - attr(*, "spec")=List of 2
    ##   ..$ cols   :List of 4
    ##   .. ..$ emp_no   : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ dept_no  : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ from_date:List of 1
    ##   .. .. ..$ format: chr ""
    ##   .. .. ..- attr(*, "class")= chr  "collector_date" "collector"
    ##   .. ..$ to_date  :List of 1
    ##   .. .. ..$ format: chr ""
    ##   .. .. ..- attr(*, "class")= chr  "collector_date" "collector"
    ##   ..$ default: list()
    ##   .. ..- attr(*, "class")= chr  "collector_guess" "collector"
    ##   ..- attr(*, "class")= chr "col_spec"

    tibble::glimpse(dept_emp)

    ## Observations: 331,603
    ## Variables: 4
    ## $ emp_no    <int> 10001, 10002, 10003, 10004, 10005, 10006, 10007, 100...
    ## $ dept_no   <chr> "d005", "d007", "d004", "d004", "d003", "d005", "d00...
    ## $ from_date <date> 1986-06-26, 1996-08-03, 1995-12-03, 1986-12-01, 198...
    ## $ to_date   <date> 9999-01-01, 9999-01-01, 9999-01-01, 9999-01-01, 999...

#### Notes

-   `emp_no`
    -   Key to `employees`.`emp_no`
-   `dept_no`
    -   Key to `departments`.`dept_no`
-   `from_date`
    -   Date in YYYY-MM-DD format
    -   Some values == `to_date`; could indicate employee in same
        department?
-   `to_date`
    -   Date in YYYY-MM-DD format
    -   Many dates such as “9999-01-01”; could indicate employee in same
        department?
    -   Some values == `from_date`; could indicate employee in same
        department?

### dept\_manager

    dept_manager <- readr::read_csv(
      file = "dept_manager.csv", 
      col_types = readr::cols(), 
      col_names = c("dept_no", "emp_no", "from_date", "to_date")
    )
    str(dept_manager)

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    24 obs. of  4 variables:
    ##  $ dept_no  : int  110022 110039 110085 110114 110183 110228 110303 110344 110386 110420 ...
    ##  $ emp_no   : chr  "d001" "d001" "d002" "d002" ...
    ##  $ from_date: Date, format: "1985-01-01" "1991-10-01" ...
    ##  $ to_date  : Date, format: "1991-10-01" "9999-01-01" ...
    ##  - attr(*, "spec")=List of 2
    ##   ..$ cols   :List of 4
    ##   .. ..$ dept_no  : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ emp_no   : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ from_date:List of 1
    ##   .. .. ..$ format: chr ""
    ##   .. .. ..- attr(*, "class")= chr  "collector_date" "collector"
    ##   .. ..$ to_date  :List of 1
    ##   .. .. ..$ format: chr ""
    ##   .. .. ..- attr(*, "class")= chr  "collector_date" "collector"
    ##   ..$ default: list()
    ##   .. ..- attr(*, "class")= chr  "collector_guess" "collector"
    ##   ..- attr(*, "class")= chr "col_spec"

    tibble::glimpse(dept_manager)

    ## Observations: 24
    ## Variables: 4
    ## $ dept_no   <int> 110022, 110039, 110085, 110114, 110183, 110228, 1103...
    ## $ emp_no    <chr> "d001", "d001", "d002", "d002", "d003", "d003", "d00...
    ## $ from_date <date> 1985-01-01, 1991-10-01, 1985-01-01, 1989-12-17, 198...
    ## $ to_date   <date> 1991-10-01, 9999-01-01, 1989-12-17, 9999-01-01, 199...

-   `dept_no`
    -   Key to `departments`.`dept_no`
-   `emp_no`
    -   Key to `employees`.`emp_no`
-   `from_date`
-   `to_date`
    -   Many dates such as “9999-01-01”; could indicate employee still
        department manager?

#### Notes

### employees

    employees <- readr::read_csv(
      file = "employees.csv", 
      col_types = readr::cols(), 
      col_names = c(
        "emp_no", "birth_date", "first_name", "last_name", "gender", "hire_date"
      )
    )
    str(employees)

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    300024 obs. of  6 variables:
    ##  $ emp_no    : int  10001 10002 10003 10004 10005 10006 10007 10008 10009 10010 ...
    ##  $ birth_date: Date, format: "1953-09-02" "1964-06-02" ...
    ##  $ first_name: chr  "Georgi" "Bezalel" "Parto" "Chirstian" ...
    ##  $ last_name : chr  "Facello" "Simmel" "Bamford" "Koblick" ...
    ##  $ gender    : chr  "M" "F" "M" "M" ...
    ##  $ hire_date : Date, format: "1986-06-26" "1985-11-21" ...
    ##  - attr(*, "spec")=List of 2
    ##   ..$ cols   :List of 6
    ##   .. ..$ emp_no    : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ birth_date:List of 1
    ##   .. .. ..$ format: chr ""
    ##   .. .. ..- attr(*, "class")= chr  "collector_date" "collector"
    ##   .. ..$ first_name: list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ last_name : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ gender    : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ hire_date :List of 1
    ##   .. .. ..$ format: chr ""
    ##   .. .. ..- attr(*, "class")= chr  "collector_date" "collector"
    ##   ..$ default: list()
    ##   .. ..- attr(*, "class")= chr  "collector_guess" "collector"
    ##   ..- attr(*, "class")= chr "col_spec"

    tibble::glimpse(employees)

    ## Observations: 300,024
    ## Variables: 6
    ## $ emp_no     <int> 10001, 10002, 10003, 10004, 10005, 10006, 10007, 10...
    ## $ birth_date <date> 1953-09-02, 1964-06-02, 1959-12-03, 1954-05-01, 19...
    ## $ first_name <chr> "Georgi", "Bezalel", "Parto", "Chirstian", "Kyoichi...
    ## $ last_name  <chr> "Facello", "Simmel", "Bamford", "Koblick", "Malinia...
    ## $ gender     <chr> "M", "F", "M", "M", "M", "F", "F", "M", "F", "F", "...
    ## $ hire_date  <date> 1986-06-26, 1985-11-21, 1986-08-28, 1986-12-01, 19...

#### Notes

-   `emp_no`
    -   Key to `employees`.`emp_no`
-   `birth_date`
    -   Date in YYYY-MM-DD format
-   `first_name`
-   `last_name`
-   `gender`
    -   “M” or “F”
-   `hire_date`
    -   Date in YYYY-MM-DD format

### salaries

    salaries <- readr::read_csv(
      file = "salaries.csv", 
      col_types = readr::cols(), 
      col_names = c("emp_no", "salary", "from_date", "to_date")
    )
    str(salaries)

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    2844047 obs. of  4 variables:
    ##  $ emp_no   : int  10001 10001 10001 10001 10001 10001 10001 10001 10001 10001 ...
    ##  $ salary   : int  60117 62102 66074 66596 66961 71046 74333 75286 75994 76884 ...
    ##  $ from_date: Date, format: "1986-06-26" "1987-06-26" ...
    ##  $ to_date  : Date, format: "1987-06-26" "1988-06-25" ...
    ##  - attr(*, "spec")=List of 2
    ##   ..$ cols   :List of 4
    ##   .. ..$ emp_no   : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ salary   : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ from_date:List of 1
    ##   .. .. ..$ format: chr ""
    ##   .. .. ..- attr(*, "class")= chr  "collector_date" "collector"
    ##   .. ..$ to_date  :List of 1
    ##   .. .. ..$ format: chr ""
    ##   .. .. ..- attr(*, "class")= chr  "collector_date" "collector"
    ##   ..$ default: list()
    ##   .. ..- attr(*, "class")= chr  "collector_guess" "collector"
    ##   ..- attr(*, "class")= chr "col_spec"

    tibble::glimpse(salaries)

    ## Observations: 2,844,047
    ## Variables: 4
    ## $ emp_no    <int> 10001, 10001, 10001, 10001, 10001, 10001, 10001, 100...
    ## $ salary    <int> 60117, 62102, 66074, 66596, 66961, 71046, 74333, 752...
    ## $ from_date <date> 1986-06-26, 1987-06-26, 1988-06-25, 1989-06-25, 199...
    ## $ to_date   <date> 1987-06-26, 1988-06-25, 1989-06-25, 1990-06-25, 199...

#### Notes

-   `emp_no`
    -   digits, length 5 to 6
-   `salary`
    -   digits, 5 to 6 in length
-   `from_date`
    -   Date in YYYY-MM-DD format
    -   Cases where `from_date` == `to_date`; could indicate current
        salary
-   `to_date`
    -   Date in YYYY-MM-DD format
    -   Cases where `from_date` == `to_date`; could indicate current
        salary
    -   Many dates such as “9999-01-01”; could indicate current salary

### titles

    titles <- readr::read_csv(
      file = "titles.csv", 
      col_types = readr::cols(), 
      col_names = c("emp_no", "title", "from_date", "to_date")
    )
    str(titles)

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    443308 obs. of  4 variables:
    ##  $ emp_no   : int  10001 10002 10003 10004 10004 10005 10005 10006 10007 10007 ...
    ##  $ title    : chr  "Senior Engineer" "Staff" "Senior Engineer" "Engineer" ...
    ##  $ from_date: Date, format: "1986-06-26" "1996-08-03" ...
    ##  $ to_date  : Date, format: "9999-01-01" "9999-01-01" ...
    ##  - attr(*, "spec")=List of 2
    ##   ..$ cols   :List of 4
    ##   .. ..$ emp_no   : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ title    : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ from_date:List of 1
    ##   .. .. ..$ format: chr ""
    ##   .. .. ..- attr(*, "class")= chr  "collector_date" "collector"
    ##   .. ..$ to_date  :List of 1
    ##   .. .. ..$ format: chr ""
    ##   .. .. ..- attr(*, "class")= chr  "collector_date" "collector"
    ##   ..$ default: list()
    ##   .. ..- attr(*, "class")= chr  "collector_guess" "collector"
    ##   ..- attr(*, "class")= chr "col_spec"

    tibble::glimpse(titles)

    ## Observations: 443,308
    ## Variables: 4
    ## $ emp_no    <int> 10001, 10002, 10003, 10004, 10004, 10005, 10005, 100...
    ## $ title     <chr> "Senior Engineer", "Staff", "Senior Engineer", "Engi...
    ## $ from_date <date> 1986-06-26, 1996-08-03, 1995-12-03, 1986-12-01, 199...
    ## $ to_date   <date> 9999-01-01, 9999-01-01, 9999-01-01, 1995-12-01, 999...

#### Notes

-   `emp_no`
    -   Key to `employees`.`emp_no`
-   `title`
    -   Title-case string
-   `from_date`
    -   Date in YYYY-MM-DD format
    -   Cases where `from_date` == `to_date`; could indicate current
        title
-   `to_date`
    -   Date in YYYY-MM-DD format
    -   Cases where `from_date` == `to_date`; could indicate current
        title
    -   Many dates such as “9999-01-01”; could indicate current title
