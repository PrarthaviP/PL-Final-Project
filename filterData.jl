module filterData

using DataFrames

function filterMenu(data)
    menu = "\n1) Total cases\n" *
          "2) New Cases\n" *
           "3) Deaths\n" *
           "4) 10 most recent entries\n" *
           "5) 10 most oldest entries\n" *
           "0) Exit\n" *
           "Enter option:> "

    print("\nDisplay:")

    option = "-1"
    while(option != "0")
        print(menu)
        option = readline()
        try
            if(option == "1")
                println(select(data, :cases))
            elseif(option == "2")
                println(select(data, :new_cases))
            elseif(option == "3")
                println(select(data, :deaths))
            elseif(option == "4")
                println(first(data, 10))
            elseif(option == "5")
                println(last(data, 10))
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
end
