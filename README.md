======
## Task 1:

Solved to utilize Ruby's object oriented nature.

Code can be run with `ruby task1.rb` from the `coding-exercises` directory in Terminal on Mac if ruby is installed || or via copy-pastying at https://repl.it/languages/Ruby

Class is initialized with the following variables by default:
* Original foobar price (here: $1) as integer or decimal
* % px increase of foobars as a decimal (here: 20%, input as 0.2)
* Starting amount to be spent (here: $200) as integer or decimal

Alternatively, class can be initialized with other variables that would need to be specified in an appropriate format. 

This code simulates conducting each transaction one at a time, and basing foobar n price on foobar n-1 at time of sale. There will be more money spent and less money received back in change in this scenario.

The answer, considering parameters above, will be output as:

> You started with $200.
Each subsequently bought foobar was 20% more expensive than a previous one.
You bought a total of 20 foobars at a total cost of $187.39.
You will get $12.61 in change.

Alternative solution with rounding cost at the end of purchasing history:

> You bought a total of 20 foobars at a total cost of $186.69.
You will get $13.31 in change.

This alternative solution would mean that line 41 should read `@initial_foobar_px = (@initial_foobar_px * (1+@percentage_px_increase))` instead of `@initial_foobar_px = (@initial_foobar_px * (1+@percentage_px_increase)).round(2)` as that is where rounding takes place.

As part of my normal workflow, I would supplement this code with the following: 

* Tests, including for code accuracy, speed, and for validating inputs when initializing the object.
  * I'd like to see appropriate error messages if one input value is missing, is unrealistic (such as negative starting amount) or is incorrectly formatted.
  * Ability to choose two different pricing scenarios and see their corresponding outputs.

======
## Task 2

Code can be run with `ruby task2.rb` from the `task2` directory in Terminal on Mac if ruby is installed || or via copy-pastying at https://repl.it/languages/Ruby

Coding commentary:
* Solved procedurally to provide contrast to Task 1.
* Commentary added to ease following the code.

Flow: 
* Code does not proceed if testdata file is blank. Clear temp testdata file or create a blank one.
* Initialize an empty nested array of correct size. Size is calculated based on number of unique IDs and dates. (In this case it is 10 rows by 5 columns.)
* Populate row headers and column headers with correctly sorted unique values from the csv file. (Both row and column headers are sorted in ascending order.)
* Populate the rest of the array with appropriately matched content. To look up coordinates, I created coordinate hashes with values and their respective coordinates for dates and IDs.
* Result is output in terminal and in CSV file (`solution_array.csv`)

Code re-factoring:
* I aimed to find a good balance between usilizing Ruby's explicit nature and keeping all methods as coherent units. 
* General suggestion for Ruby code is to keep all methods under five line of contents. I kept several methods longer than that for coherency's sake.

Directory contents:
* I placed the original `testdata.csv` file in the same directory as the solution file. The code will check to see if it's empty. 
  * If the file is empty, the code will alert about it on the terminal and clear out all other files in the directory.
  * This is basic safety check to avoid throwing errors if the downloaded file is empty.
* Two other files are created if testdata file is valid:
  * An intermediary `testdata_reworked.csv` that serves as a data reference for the solution. It allows for potential extra testing to see that this step is accomplished correctly before the solution is processed. It gets cleared out or created anew each time.before code runs.
  * A final solution as a `solution_array.csv` file.

As part of my normal workflow, I would supplement this code with the following:

* Tests:
  * Checking size of the generated matrix to make sure it is calculated correctly (as some expectations of that should be in place by the user before it comes in.)
  * Checking that input values on the  `testdata.csv` file don't appear to be out of place (e.g. alerting the user when neighboring elements have too much price discrepancy or that they are not zero when they are not meant to be).
  * Checking that input values are formatted correctly (and not, say, in Datatime because an Excel mistake has been made).
  * For all the checking procedures, I would add a separate validation layer in the code that would alert the user that checks have been completed and that x many potential errors have been found.

* Ability to choose two different pricing scenarios and see their corresponding outputs.

As a side note, the task specified leaving the value for which no match is found as '0' or 'nan'. Since the output is converted into csv, I would suggest leaving it as a blank value if the intention is to chart it in Excel as that way that value is not plotted.

======
## Task 3

"There is no more common error than to assume that because prolonged and accurate mathematical calculations have been made, the application of the result to some fact of nature is absolutely certain."

The task at hand is a basic quantitative times series forecasting method that assumes that patterns in the past data will continue into the future.

Should be accompanied by estimate of error.

The data has strong seasonality. Seasonality can change over time, but in this case we will assume a less apparent trend.

Let's de-seasonalize and identify the pattern.

Of course, this forecast assumes no other factors have come into play, such as flat price, HH premiums, new infrastructure (and change in residential demand base), etc.



