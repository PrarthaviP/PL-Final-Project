module analyseData

  using CSV
  using DataFrames
  using Statistics
  using Plots

  function predictFutureCases(fileName)
    df = DataFrame(CSV.File(fileName; select=["new_cases"]))
    print("Enter how many days from today:> ")
    try
      days = parse(Int64,readline())
      cases = analyseData.calculateCases(df,days)
      println("Number of cases $days days later is :> $cases")
      print("Print plot(Y/N):> ")
      if(uppercase(readline()) == "Y")
        analyseData.plotFutureCases(df,days)
      end
   catch
    println("Invalid Input")
   end
  end

   function calculateCases(df, t::Integer)
     growthRate = df[2,:"new_cases"] / df[3,:"new_cases"]
     ans = (growthRate ^ t) * df[2,:"new_cases"]
     return ans
   end

  function plotFutureCases(df,time::Integer)
    timeRange = 1:time
    cases = Vector{Float64}()
    for t in timeRange
      push!(cases,calculateCases(df, t))
    end
    display(plot(timeRange,cases))
  end
end
