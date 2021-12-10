module analyseData

  using CSV
  using DataFrames
  using Statistics
  using Plots



  df = DataFrame(CSV.File("us_data.csv"; select=["new_cases"]))

  function predictFutureCases()
    print("Enter how many days from today:> ")
    try
      days = parse(Int64,readline())
      cases = analyseData.calculateCases(days)
      println("Number of cases $days days later is :> $cases")
      print("Print plot(Y/N):> ")
      if(uppercase(readline()) == "Y")
        analyseData.plotFutureCases(days)
      end
   catch
    println("Invalid Input")
   end
  end

   function calculateCases(t::Integer)
     growthRate = df[1,:"new_cases"] / df[2,:"new_cases"]
     ans = (growthRate ^ t) * df[1,:"new_cases"]
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
