using CSV
using DataFrames
using Plots

include("filterData.jl")
include("plotData.jl")

function menu()
    f = open("us_data.csv", "r")
    data = CSV.read(f, DataFrame)

    mainmenu = "\n1) Plot data\n" *
          "2) Display data\n" *
           "0) Exit\n" *
           "Enter option:> "

    option = "-1"
    while(option != "0")
        print(mainmenu)
        option = readline()
        try
            if(option == "1")
                plotData.plotMenu(data)
            elseif(option == "2")
                filterData.filterMenu(data)
            elseif(option == "0")
                println("\nExiting")
            else
                println("Invalid option")
            end
        catch e
             showerror(stdout, e)
         end
     end

end
