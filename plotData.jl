module plotData

using CSV
using DataFrames
using Plots
using Statistics

function svgScatter(x, y, data)
    f = open("scatter.svg", "w")

    #description = desribe(data)
    #max = description[1, :"max"]
    v = 1500/49505304
    w = 50/689

    str = "<svg version=\"1.2\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" class=\"graph\" aria-labelledby=\"title\" role=\"img\">" *
    "\n  <title id=\"title\">A line chart showing some information</title>" *
    "\n<g class=\"grid x-grid\" id=\"xGrid\">" *
    "\n  <line x1=\"50\" x2=\"50\" y1=\"50\" y2=\"699\"></line>" *
    "\n</g>\n<g class=\"grid y-grid\" id=\"yGrid\">" *
    "\n  <line x1=\"50\" x2=\"1500\" y1=\"700\" y2=\"700\"></line>" *
    "\n</g>\n<g class=\"data\" data-setname=\"Our first data set\">\n"

    write(f, str)

    for i in 1:length(y)
        outstr = "  <circle cx=\"" * string(y[i]) * "\" cy=\"" * string(i) * "\" data-value=\"7.2\" r=\"4\"></circle>\n"
        write(f, outstr)
    end
    write(f, "\n</g>\n</svg>")
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
            display(plot(x, y))
        elseif(ch == "2")
            svgScatter(x, y, data)
        elseif(ch == "3")
            display(histogram(x, y))
        else
            println("Invalid option")
        end
    catch e
         showerror(stdout, e)
    end
end
end
