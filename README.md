Coded using ruby 2.2.0, also backward compatible.

======
## Task 1:

### Running code: 

To run code:
* `ruby task1.rb` from the `task1` directory in Terminal on Mac if Ruby is installed 
* copy-paste at https://repl.it/languages/Ruby

Solved in an object-oriented fashion.

Class is initialized with the following variables by default:
* Original foobar price (here: $1) as integer or decimal
* % px increase of foobars as a decimal (here: 20%, input as 0.2)
* Starting amount to be spent (here: $200) as integer or decimal

Class can be initialized with variables specified when code is run that should be in the same format.

### Solution 1:

This code simulates conducting each transaction one at a time, and basing foobar n price on foobar n-1 at time of sale. There will be more money spent and less money received back in change in this scenario.

Output:

> You started with $200.
Each subsequently bought foobar was 20% more expensive than a previous one.
You bought a total of 20 foobars at a total cost of $187.39.
You will get $12.61 in change.

### Solution 2:

Alternative solution with rounding each price after calculating to arbitrary decimal places.

Line 41 should then read `@initial_foobar_px = (@initial_foobar_px * (1+@percentage_px_increase))` instead of `@initial_foobar_px = (@initial_foobar_px * (1+@percentage_px_increase)).round(2)`.

Output: 
> You bought a total of 20 foobars at a total cost of $186.69.
You will get $13.31 in change.

### Other things to consider:

* Tests, including for code accuracy, speed, and for validating inputs when initializing the object.
* Check for and display appropriate error messages if one input value is missing, is unrealistic (such as negative starting amount) or is incorrectly formatted.
* Ability to choose two different pricing scenarios (see above) and see their corresponding outputs.

======
## Task 2

### Running code: 

* `ruby task2.rb` from the `task2` directory in Terminal on Mac if ruby is installed 
* copy-paste at https://repl.it/languages/Ruby

Coding commentary:
* Solved procedurally to provide contrast to Task 1.
* Added commented out output of several methods to provide an immediate visual explanation.

### Flow: 
* Check if `testdata.csv` file is blank. If it has content, proceed. If it's blank, clear temp testdata file of any exiting content or create a blank one if no tempdata file is present. 
* Create an empty nested array. Calculates dimenstions from number of unique IDs and dates in `testdata.csv`. (Here: 10 rows by 5 columns.)
* Populate row headers and column headers with correctly sorted unique values from the csv file. (Here: both sorted ascending.)
* Populate the rest of the array with matched content. 
  * To look up coordinates, use created hashes with values and their respective coordinates for dates and IDs.
* Output result in Terminal and in CSV file (`solution_array.csv`)

### Directory contents:
* The originally provided `testdata.csv` file is in the same directory as the solution file. The code will check to see if it's empty. 
  * If the file is empty, the Terminal will print an alert; content of all other files in the directory will be cleared.
    * This is basic safety check to avoid throwing errors if the downloaded file is empty.
* Two other files are created if `testdata.csv` file is not blank:
  * An intermediary `testdata_reworked.csv` that serves as a data reference for the solution. It allows for potential extra testing to see that this step is accomplished correctly before the solution is processed. It gets cleared out or created anew each time.before code runs.
  * A final solution as a `solution_array.csv` file (solution will be also output in Terminal).

### Other things to consider:
* Tests:
  * Checking size of the generated matrix to make sure it is calculated correctly (as some expectations of that should be in place by the user before it comes in.)
  * Checking that input values on the  `testdata.csv` file don't appear to be out of place (e.g. alerting the user when neighboring elements have too much price discrepancy or that they are not zero when they are not meant to be).
  * Checking that input values are formatted correctly (and not, say, in Datatime because an Excel mistake has been made).
  * For all the checking procedures, I would add a separate validation layer in the code that would alert the user that checks have been completed and that x many potential errors have been found.
* Ability to choose two different pricing scenarios and see their corresponding outputs.

* Minor point: 
  * The task was to leave the value for which no match is found as '0' or 'nan', which I did do. Since the output is converted into `csv`, I would suggest leaving it as a blank value instead if the intention is to chart it in Excel.
  * I converted data points that are not dates or IDs to floats to preserve initial format. Should be fine for charting.

### Answer (below is copied from `solution_array.csv`, also available as a nested array):

 ,102231711,103244134,103285344,103293593
734638,300234299.0,371.912648,291.8402341,308504322.0
734639,375297743.0,465.33212,383.1187303,367987076.0
734640,347131139.0,nan,346.7884983,367304087.0
734641,324073368.0,444.012499,329.5651221,366744696.0
734642,314528399.0,450.494763,331.4411184,371354477.0
734643,292151202.0,422.621704,279.583651,382348434.0
734644,229731991.0,357.184776,213.6075258,332998895.0
734645,220363995.0,332.40686,234.7429863,305312443.0
734646,298911020.0,418.780372,264.043354,380569199.0

======
## Task 3

Assume that patterns in the past data will continue into the future.

* Step 1: Extract HDD, CDD
  * Calculate for specific months, building up from days. 
    * This is because our demand data (dependent variable) is only on monthly basis. 
    * Preferential to do weekly, especially since many residential buildings run on a weekly schedule.
  * Basis 65F.

* Step 2: Regress HDD, CDD vs. Demand
  * 2-variable regression gives best fit, using CDD + HDD. 
  * Result outputs variables (L8,M8,N8) that can be used to forecast demand on monthly basis.

* Step 3: Forecast per month
  * Develop average view of 2015 MONTHLY HDD, CDD.
  * Use the formula derived in step 2.
  * First forecast ready.

* Step 4: Forecast per days - same idea, more complicated.
  * Similar approach as step 3 -- need to establish a historical pattern on daily basis that will inform forecasts. To do this, we use our only daily time series - temperature - and leverage daily degree days. What we want to do is leverage this temperature data to identify how much "share" of the total demand in a month a given day generates, on average. This fluctuates hugely though and is not likely very accurate without more timely data (e.g., near-term forecasts).
  * We would ideally then regress a daily equation on its own (if this wasn't so noisy). As a shortcut, I took each day's CDD / HDD and multiplied by 31 to get the formula to work correctly - ie, pretending each day is a month.
  * This can be used basically to then give a "share of demand per month" per "day." Again, we only have a few years of datapoints, so some risks in this. To judge "share of demand per day", we just look at Jan 1 2015 and say, the 1st of January had on average 3% of January's demand, therefore take Jan 2015 forecast demand, *3%, gives us the value.
  * However, due to leap years and other factors, this "general demand factor" requires some smoothing, which is done to ensure that the "daily forecasted demand" adds up to our "monthly forecasted demand." 

* Value of executing in Excel:
  * Testing theories and manipulating data is often faster, especially for a small-scale project.
  * More user-friendly if sharing broadly, and faster to change inputs and assumptions (if calibrated as a complete model).
  * If statistical relationships are established and held constant, stats heavy lifting is less important than analytical flexibility in many cases.
  * Faster for sharing outputs broadly in terms of display and presentation.

* Other things to consider:
  * Changes from historical record - reasons to think 2015 patterns would behave differently:
    * Different weather, or different distribution of weather (major global warning impact, El Nino / La Nina, etc.)
    * Different demand (more investments in efficiency -- maybe Nest becomes more popular; economy; etc.)
    * Different 'comfort elasticity' (people wanting to save money or be green at expense of comfort)
    * Infrastructure changes (new pipelines or pipelines issues, new processing plants, etc.)
    * Population changes (massive migration in / out of state)
    * Etc.

* Minor notes:
  * Accounting should be better for leap years but we don't take into account yet.  
  * Assume temperatures are averages of max and min temperatures for the day; looking at those maxes and mins individually could produce a more accurate result.

* Key general point:
  * Predicting fuel deliveries after the fact is easy, but in advance of time getting weather forecasts accurate has a much lower statistical fit with reality, leading to challenges in forecast. Other factors that help *predict* may be useful in addition to weather, i.e. other things ultimately correlated with heating demand if any.



