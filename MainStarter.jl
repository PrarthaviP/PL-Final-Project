include("AnalyseData.jl")


function main()
     menu = "\n1) Import data from CDC\n" *
          "2) Plot the data\n" *
           "3) Get statistics the data\n" *
           "0) Exit\n" *
           "Enter option:> "

    println("COVID-19 Data Analyser\n")

    option = "-1"
    while(option != "0" )
        print(menu)
        option = readline()
        #try
            if(option == "1")
                println("TODO")
            elseif(option == "2")
                println("TODO")
            elseif(option == "3")
                print(analyseData.calculateStatistics())
                print("Predict number of cases in the future(Y/N):> ")
                if(uppercase(readline()) == "Y")
                    analyseData.predictFutureCases()
                end
            else
                println("Invalid option")
            end
    #    catch e
    #         showerror(stdout, e)
    #     end
     end
end