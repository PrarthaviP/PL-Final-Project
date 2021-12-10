module analyseData

  using CSV
  using DataFrames
  using Statistics
  using Plots
  export calculateStatistics

  df = DataFrame(CSV.File("data_table_for_daily_case_trends__the_united_states.csv"; select=["New Cases"]))

  usaPopulation = 329500000

  function calculateStatistics()

      description = describe(df)

     mean = description[1, :"mean"]
     max = description[1, :"max"]
     dev = stdm(df[!,"New Cases"], mean)
     ans = "The average number of cases is:> $mean\n" *
           "The max number of cases in a day:> $max\n" *
           "The standard deviation of the number of cases is: $dev\n"
    return ans
  end

 function predictFutureCases()
   print("Enter how many days from today:> ")
   try
     days = parse(Int64,readline())
     cases = analyseData.calculateCases(days)
     println("Number of cases $days days later is :> $cases")
     print("Print plot(Y/N):> ")
     if(uppercase(readline()) == "Y")
       plotFutureCases(days)
     end
  catch
   println("Invalid Input")
  end
 end

  function calculateCases(t::Integer)
    growthRate = df[1,:"New Cases"] / df[2,:"New Cases"]
    ans = (growthRate ^ t) * df[1,:"New Cases"]
    return ans
  end

 function plotFutureCases(time::Integer)
   timeRange = 1:time
   cases = Vector{Float64}()
   for t in timeRange
     push!(cases,calculateCases(t))
   end
   plot(timeRange,cases)
 end

end
