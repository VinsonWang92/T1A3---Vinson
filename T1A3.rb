require_relative 'create_budget'

begin
cmd = nil
    print 'Enter your command (create budget, add income, find budget surplus, quit): '
    cmd = gets.chomp.downcase.strip
    
    case cmd
    when 'create budget'
       Budget::create_budget
    when 'add income'
        puts 'What is your net monthly income?'
        income = gets.chomp.to_i 
        puts "your net monthly income is $#{income}"
    when 'find budget surplus'
        budget_surplus = income-$total_spending
        puts "your net monthly surplus is $#{budget_surplus}"
    end
end until ['quit', 'q'].include? cmd 


