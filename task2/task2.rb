# Task 2: Organizing Data
 
# Attached you find a file ‘testdata.csv’. This file contains three vectors: ID, date and value. These represent unsorted data points for four different time series. 
# ID gives the id of the time series to which the point belongs; date indicates the date for which the value is valid and value contains the data. 
# Please create a generic function that sorts the data into a matrix with a number of rows equal to the unique number of dates (sorted?!) and a number of columns equal to the number of curves, so that each column contains the data for one time series and each row contains the data for a given date. 
#  Please be aware that there is at least one data point missing. The matrix should contain a “nan” or a zero in place of the missing value. The function should be applicable to any list of data that has the given format. 

# If possible, avoid using a loop to solve the problem.
 
# Hint: In Matlab, this problem can for example be solved using the functions “unique” and “ismember”, which return the unique elements of a list and the location of elements from a list A in another list B. The function sub2ind helps you to convert the resulting subscripts to linear indices. Similar functions should be available in other languages, but this is certainly not the only way to solve the problem.

# require ruby csv library 
require 'csv'

###################### INITIALIZE AN EMPTY ARRAY OF CORRECT SIZE

# create an empty nested array of 5 columns by 10 rows -- this comes from the premise of the exercise
# this is the array we will be hydrating in this exercise
def create_empty_array
  @outcome_array = Array.new(10) { Array.new(5) }
end

###################### POPULATE ARRAY WITH ROW HEADERS (DATES)

# collect and sort unique dates // these will be row headers
def collect_row_headers
  @row_headers = []
  CSV.foreach('testdata.csv') {|row| @row_headers << row[1].to_i}
  @row_headers = @row_headers.uniq.sort[0..-1] # [0, 734638, 734639, 734640, 734641, 734642, 734643, 734644, 734645, 734646]
end

# creates hash of indexes and corresponding values that will serve as reference for coordinates lookup
def create_row_headers_index_hash
  collect_row_headers
  @row_hash = Hash[(0...@row_headers.size).zip(@row_headers)] # {0=>0, 1=>734638, 2=>734639, 3=>734640, 4=>734641, 5=>734642, 6=>734643, 7=>734644, 8=>734645, 9=>734646}
end

# populate empty array's row headers with collected unique dates
def populate_matrix_with_row_headers
  create_empty_array
  collect_row_headers
  replace_row_helpers
end

# helper method for populate_matrix_with_row_headers
def replace_row_helpers
  x = 0
  @outcome_array.each do |inner_array|
    inner_array[0] = @row_headers[x]
    x += 1
  end
end
# current @output_array ==> [[0, nil, nil, nil, nil], [734638, nil, nil, nil, nil], [734639, nil, nil, nil, nil], [734640, nil, nil, nil, nil], [734641, nil, nil, nil, nil], [734642, nil, nil, nil, nil], [734643, nil, nil, nil, nil], [734644, nil, nil, nil, nil], [734645, nil, nil, nil, nil], [734646, nil, nil, nil, nil]]

###################### POPULATE ARRAY WITH COLUMN HEADERS (IDs)

# collect unique column IDs // these will be column headers
def collect_column_headers
  @column_headers = []
  CSV.foreach('testdata.csv') {|row| @column_headers << row[0].to_i}
  @column_headers = @column_headers.uniq.sort[1..-1] # [102231711, 103244134, 103285344, 103293593]
end

# creates hash of indexes and corresponding values that will serve as reference for coordinates lookup
def create_column_headers_index_hash
  collect_column_headers
  @column_hash = Hash[(0...@column_headers.size).zip(@column_headers)] # {0=>102231711, 1=>103244134, 2=>103285344, 3=>103293593}
end

# populate column headers of an empty nested array; row headers have been populated already
def populate_matrix_with_column_headers
  populate_matrix_with_row_headers
  collect_column_headers
  @outcome_array[0] = @outcome_array[0].clear.push(" ").push(@column_headers).flatten! 
end
# at this point, our column and row headers have been populated and we need to hydrate the matrix with appropriate variables
# current @output_array ==> [[0, 102231711, 103244134, 103285344, 103293593], [734638, nil, nil, nil, nil], [734639, nil, nil, nil, nil], [734640, nil, nil, nil, nil], [734641, nil, nil, nil, nil], [734642, nil, nil, nil, nil], [734643, nil, nil, nil, nil], [734644, nil, nil, nil, nil], [734645, nil, nil, nil, nil], [734646, nil, nil, nil, nil]]

###################### HYDRATE ARRAY WITH APPROPRIATE DATA

# makes a new testdata_reworked.csv file with data that will be used in hydrating the matrix.
def make_testdata_reworked_csv_file
  create_column_headers_index_hash 
  create_row_headers_index_hash 
  CSV.open('testdata_reworked.csv', "wb") do |csv|
    CSV.foreach('testdata.csv', {headers: true}) do |row| 
      row[0] = @column_hash.key(row[0].to_i)
      row[1] = @row_hash.key(row[1].to_i)
      csv << row
    end
  end
end

# hydrates array with appropriately matched values
def hydrate_array
  populate_matrix_with_column_headers
  CSV.foreach('testdata_reworked.csv') { |row| @outcome_array[row[1].to_i][row[0].to_i+1] = row[2].to_f }
  @outcome_array
end

# replaces NilClass with "nan" string; outputs array to Terminal
def replace_nil_with_nan
  hydrate_array
  @outcome_array.each { |row| row[row.index(nil)] = "nan" if row.include?(nil) }
  print "#{@outcome_array} \n"
end

# saves solution to a solution_array.csv file
def solve_and_write_to_csv
  replace_nil_with_nan
  CSV.open('solution_array.csv', "wb", {converters: :numeric}) do |csv|
    @outcome_array.each { |array_row| csv << array_row }
  end
end

solve_and_write_to_csv

# # dates  ↓
# # ______|102231711|103244134 |103285344  |103293593
# # 734638|300234299|371.912648|291.8402341|308504322
# # 734639|375297743|465.33212 |383.1187303|367987076
# # 734640|347131139|_________ |346.7884983|367304087
# # 734641|324073368|444.012499|329.5651221|366744696
# # 734642|314528399|450.494763|331.4411184|371354477 
# # 734643|292151202|422.621704|279.583651 |382348434
# # 734644|229731991|357.184776|213.6075258|332998895
# # 734645|220363995|332.40686 |234.7429863|305312443
# # 734646|298911020|418.780372|264.043354 |380569199

