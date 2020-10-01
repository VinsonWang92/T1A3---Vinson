require_relative 'create_budget'
require 'ascii_charts'
require 'colorize'
require 'tty-prompt'
require 'terminal-table'

begin
    puts " 
     /$$$$$$$$                                   /$$                     /$$       /$$$$$$$                  /$$                       /$$    
    |__  $$__/                                  |__/                    | $$      | $$__  $$                | $$                      | $$    
       | $$     /$$$$$$   /$$$$$$  /$$$$$$/$$$$  /$$ /$$$$$$$   /$$$$$$ | $$      | $$  \\ $$ /$$   /$$  /$$$$$$$  /$$$$$$   /$$$$$$  /$$$$$$  
       | $$    /$$__  $$ /$$__  $$| $$_  $$_  $$| $$| $$__  $$ |____  $$| $$      | $$$$$$$ | $$  | $$ /$$__  $$ /$$__  $$ /$$__  $$|_  $$_/  
       | $$   | $$$$$$$$| $$  \\__/| $$ \\ $$ \\ $$| $$| $$  \\ $$  /$$$$$$$| $$      | $$__  $$| $$  | $$| $$  | $$| $$  \\ $$| $$$$$$$$  | $$    
       | $$   | $$_____/| $$      | $$ | $$ | $$| $$| $$  | $$ /$$__  $$| $$      | $$  \\ $$| $$  | $$| $$  | $$| $$  | $$| $$_____/  | $$ /$$
       | $$   |  $$$$$$$| $$      | $$ | $$ | $$| $$| $$  | $$|  $$$$$$$| $$      | $$$$$$$/|  $$$$$$/|  $$$$$$$|  $$$$$$$|  $$$$$$$  |  $$$$/
       |__/    \\_______/|__/      |__/ |__/ |__/|__/|__/  |__/ \\_______/|__/      |_______/  \\______/  \\_______/ \\____  $$ \\_______/   \\___/  
                                                                                                                 /$$  \\ $$                    
                                                                                                                |  $$$$$$/                    
                                                                                                                 \\______/                     "
    prompt = TTY::Prompt.new
    cmd = prompt.select("Which would you like to do?", ["Create budget", "Add Income", "Budget Surplus", "Invest", "Save Profile", "Load Profile", "quit"])
    
    case cmd
    when 'Create budget' 
       total_spending = Budget::create_budget
    when 'Add Income'
        puts 'What is your net monthly income?'
        income = gets.chomp.to_i 
        puts "your net monthly income is $#{income}"
    when 'Budget Surplus'
        budget_surplus = income-total_spending
        puts "your net monthly surplus is $#{budget_surplus}"
    when 'Invest'
        if budget_surplus > 0
            puts "What annual returns are you expecting from your investments?"
            yields = gets.chomp.to_f
            puts "How long are you planning to invest for in years?"
            investment_time = gets.chomp.to_i
            savings = (budget_surplus)*((1+yields/12/100)**(investment_time*12)/(yields/12/100))
            puts "If you stick to your budget and invest all your money at #{yields}% you'll have $#{savings} after #{investment_time} years"
            puts "Would you like to see a chart of your savings over #{investment_time} years?"
            chart = gets.chomp
            if chart == "yes"
                puts AsciiCharts::Cartesian.new((0..investment_time).to_a.map{|x| [x, (budget_surplus*12)*((1+yields/100)**x/(yields/100))]}, :title => 'savings graph').draw

            end
        else puts "there's no budget surplus!"
        end
    when 'Save Profile'
       

    end  
end until ['quit', 'q'].include? cmd 


