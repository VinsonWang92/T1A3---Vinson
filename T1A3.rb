require_relative 'create_budget'
require 'ascii_charts'
require 'colorize'
require 'tty-prompt'
require 'terminal-table'

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

begin
    
    prompt = TTY::Prompt.new
    cmd = prompt.select("Which would you like to do?", ["Create budget", "Add Income", "Budget Surplus", "Invest", "Quit"])
    
    case cmd
    when 'Create budget' 
       total_spending = Budget::create_budget
    when 'Add Income'
        puts 'What is your net monthly income?'
        income = gets.chomp.to_i 
        # budget_surplus = income-total_spending
        rows = []
        rows << ["Net income", income]
        income_summary = Terminal::Table.new :title => "Net income", :rows=> rows
        puts income_summary
    when 'Budget Surplus'
        budget_surplus = income-total_spending
        puts "your net monthly surplus is $#{budget_surplus}"
        if budget_surplus < 0 
            puts "Income has to increase or spending has to decrease, please amend income or budget"
        end
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
end until ['Quit', 'q'].include? cmd 


