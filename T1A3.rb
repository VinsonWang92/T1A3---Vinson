require_relative 'create_budget'
require_relative 'add_income'
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
        income = Income::add_income
    when 'Budget Surplus'
        budget_surplus = income-total_spending
        rows = []
        rows << ["Budget Surplus", budget_surplus]
        surplus_summary = Terminal::Table.new :title => "Net monthly savings", :rows=> rows
        puts surplus_summary
        if budget_surplus < 0 
            puts "Income has to increase or spending has to decrease, please amend income or budget"
        end
    when 'Invest'
        if budget_surplus > 0
            rows = []
            rows << ["Shares", "10% p.a."]
            rows << ["REIT (Real Estate Investment Trusts (property)", "7.8% p.a."]
            rows << ["Term deposits", "4.2% p.a."]
            rows << ["Bonds", "6.1% p.a."]
            invest_summary = Terminal::Table.new :title => "Types of investments", :headings => ["Type of Investment", "Average returns over last 15 years"], :rows=> rows
            puts invest_summary
            yields = TTY::Prompt.new
            yields = yields.select("What would you like to invest in?", ["Shares", "REIT", "Term_deposits", "Bonds"])
            case yields
                when "Shares"
                    yields = 0.10
                when "REIT" 
                    yields = 0.78
                when "Term_deposits" 
                    yields = 0.42
                when "Bonds"
                    yields = 0.61
            end
            puts "How long are you planning to invest for in years?"
            investment_time = gets.chomp.to_i
            savings = (budget_surplus)*((1+yields/12)**(investment_time*12)/(yields/12))
            puts "If you stick to your budget and invest all your money at #{yields*100}% p.a. you'll have $#{savings} after #{investment_time} years"
            puts "Would you like to see a chart of your savings over #{investment_time} years?"
            chart = gets.chomp
            if chart == "yes"
                puts AsciiCharts::Cartesian.new((0..investment_time).to_a.map{|x| [x, (budget_surplus*12)*((1+yields)**x/(yields))]}, :title => 'savings graph').draw
            end
        else puts "there's no budget surplus! Please create a another budget and add income to create a budget surplus"
        end
    when 'Save Profile'
       

    end  
end until ['Quit', 'q'].include? cmd 


