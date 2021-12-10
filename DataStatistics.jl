module DataStatistics

  using CSV
  using DataFrames
  using Statistics

  function getData(fileName)
    fileMenu = "Choose file to analyse \n" *
               "1) Default\n" *
               "2) Custom file\n" *
               "Enter option:> "
    colMenu = "Choose column to analyse \n" *
              "1) New cases\n" *
              "2) Total cases\n" *
              "3) Deaths\n" *
              "4) Custom column\n" *
              "Enter option:> "

    # fileName = "us_data.csv"
    colName = "new_cases"
    print(fileMenu)
    if(readline() == "2")
      print("Enter exact file name:> ")
      fileName = readline()
    end
    print(colMenu)
    option = readline()
      if(option == "2")
        colName = "cases"
      elseif(option == "3")
        colName = "deaths"
      elseif(option == "4")
        print("Enter exact column name:> ")
        colName = readline()
      end
      try
        df = df = DataFrame(CSV.File(fileName; select=[colName]))
        return calculateStatistics(df,colName)
      catch
       return print("Invalid file or column name:")
      end

  end

  function calculateStatistics(df,colName)

    println("")
      description = describe(df)

     mean = description[1, :"mean"]
     max = description[1, :"max"]
     dev = stdm(df[!,colName], mean)
     median = Statistics.median(df[!,colName])
     ans = "The average number of cases is:> $mean\n" *
           "The max number of cases in a day:> $max\n" *
           "The standard deviation of the number of cases is: $dev\n" *
           "The median of the data is $median\n"
    return ans
  end



end
