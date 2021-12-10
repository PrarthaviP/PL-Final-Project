using HTTP
using JSON3
using CSV
using DataFrames

out_file_name = "us_data.csv"
url = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv"
function get_data_from_csv(url, out_file_name)
    f = open(out_file_name, "w")
    r = HTTP.request("GET", url)
    write(f, r.body)
    close(f)
    f = open(out_file_name, "r")
    println(filesize(out_file_name))
    csv = CSV.read(f, DataFrame)
    sort!(csv, (:date), rev=true)
    old = 0
    new_cases = []
    for num_cases in csv.cases
        global old
        push!(new_cases, old - num_cases)
        old = num_cases
    end 
    insertcols!(csv, 3, :new_cases => new_cases)
    CSV.write(out_file_name, csv) 
end

# json = JSON3.read(r.body)
