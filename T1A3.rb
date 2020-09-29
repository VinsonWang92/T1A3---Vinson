require_relative 'create_budget'

begin
cmd = nil
    print 'Enter your command (create budget, add income, find budget surplus, invest, quit): '
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
    when 'invest'
        if budget_surplus > 0
            puts "What annual returns are you expecting from your investments?"
            yields = gets.chomp.to_f
            puts "How long are you planning to invest for in years?"
            investment_time = gets.chomp.to_i
            savings = budget_surplus*12*(1+yields/100)**investment_time
            puts "If you stick to your budget and invest all your money at #{yields}% you'll have $#{savings} after #{investment_time} years"
        else puts "there's no budget surplus!"
        end
    end
end until ['quit', 'q'].include? cmd 


