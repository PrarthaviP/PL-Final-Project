using HTTP
using JSON3
using CSV
using DataFrames
using Statistics

include("DataStatistics.jl")

out_file_name = "us_data.csv"
url = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv"
function get_data_from_csv(url, out_file_name)
    f = open(out_file_name, "w")
    r = HTTP.request("GET", url)
    write(f, r.body)
    close(f)
    f = open(out_file_name, "r")
    csv = CSV.read(f, DataFrame)
    sort!(csv, (:date), rev=true)
    new_cases = [0]
    for i in 2:nrow(csv)
        push!(new_cases, csv.cases[i-1] - csv.cases[i])
    end 
    insertcols!(csv, 3, :new_cases => new_cases)
    CSV.write(out_file_name, csv)
    close(f)
end

function bulk_transform(filename)
    f = open(filename, "r")
    csv = CSV.read(f, DataFrame)
    initial_num_cols = ncol(csv)
    means = []
    std_devs = []
    for i in 2:initial_num_cols
        push!(means, Statistics.mean(csv[:,i]))
        push!(std_devs, stdm(csv[:,i], means[end]))
    end
    append!(means, repeat([-1], (nrow(csv) - length(means))))
    append!(std_devs, repeat([-1], (nrow(csv) - length(std_devs))))
    insertcols!(csv, initial_num_cols+1, :col_index => 2:nrow(csv)+1)
    insertcols!(csv, initial_num_cols+2, :means => means)
    insertcols!(csv, initial_num_cols+3, :std_devs => std_devs)
    CSV.write(filename, csv)
    close(f)
end
get_data_from_csv(url, out_file_name)