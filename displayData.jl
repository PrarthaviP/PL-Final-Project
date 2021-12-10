using CSV
using DataFrames
using Plots

function svgtest(x, y)
    f = open("test.svg", "w")
    for i in 2:length(y)
        outstr = "<line x1=\""*string(x[i-1])*"\" y1=\""*string(y[i-1])*"\" x2=\""*string(x[i])*""\" y2=\""*string(y[i])*"\" stroke=\"blue\" stroke-width=\"4\" />"
        write(f, outstr)
    end
    
    close(f)
end

function plotdata(ch, data)
    menu = "\n1) Total Cases\n" *
           "2) New Cases\n" *
           "3) Deaths\n" *
           "Enter option:> "

    print("\nChoose data to plot:")
    print(menu)
    option = readline()
    x = data.date
    y = []

    try
        if(option == "1")
            y = data.cases
        elseif(option == "2")
            y = data.new_cases
        elseif(option == "3")
            y = data.deaths
        else
            println("Invalid option")
        end
    catch e
         showerror(stdout, e)
    end

    try
        if(ch == "1")
            #display(plot(x, y))
            svgtest(x, y)
        elseif(ch == "2")
            display(scatter(x, y))
        elseif(ch == "3")
            display(histogram(x, y))
        else
            println("Invalid option")
        end
    catch e
         showerror(stdout, e)
    end
end

function menu()
    f = open("us_data.csv", "r")
    data = CSV.read(f, DataFrame)

    menu = "\n1) Line\n" *
          "2) Scatter\n" *
           "3) Histogram\n" *
           "0) Exit\n" *
           "Enter option:> "

    print("\nPlots:")

    option = "-1"
    while(option != "0")
        print(menu)
        option = readline()
        try
            if(option == "1" || option == "2" || option == "3")
                plotdata(option, data)
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

menu()