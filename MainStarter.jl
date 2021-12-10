include("AnalyseData.jl")
include("DataStatistics.jl")
include("get_data.jl")

function main()
     menu = "\n1) Import data from website to CSV file\n" *
          "2) Save mean and standard deviation to file\n"  *
          "3) Plot data from file\n" *
           "4) Get statistics for the data\n" *
           "5) Predict number of cases in the future \n" *
           "0) Exit\n" *
           "Enter option:> "

    println("COVID-19 Data Analyser\n")

    option = "-1"
    while(option != "0" )
        print(menu)
        option = readline()
        fileName = "us_data.csv"
        try
            if(option == "1")
                print("Enter url of the website:> ")
                url = readline()
                print("Enter file name:> ")
                fileName = readline()
                get_data.getDataFromCsv(url, fileName)
            elseif(option == "2")
                println("TODO")
            elseif(option == "3")
                print(DataStatistics.getData(fileName))
            elseif(option == "4")
                    analyseData.predictFutureCases(fileName)
            elseif(option != "0")
                println("Invalid option")
            end
        catch e
             showerror(stdout, e)
         end
     end
end

main()
