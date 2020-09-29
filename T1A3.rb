begin
cmd = nil
        print 'Enter your command (create budget, add income, find budget surplus, quit): '
        cmd = gets.chomp.downcase.strip
        
        case cmd
        when 'create budget'
            puts "How much is your rent/mortgage/board"
            rent = gets.chomp.to_i
            puts "How much do you spend on groceries?"
            groceries = gets.chomp.to_i
            puts "How much do you spend eating out?"
            eating_out = gets.chomp.to_i
            total_spending = rent+groceries+eating_out
            puts "Your total monthly spending is $#{total_spending} per month"
        when 'add income'
            puts 'What is your net monthly income?'
            income = gets.chomp.to_i 
            puts "your net monthly income is $#{income}"
        when 'find budget surplus'
            budget_surplus = income-total_spending
            puts "your net monthly surplus is $#{budget_surplus}"
        end
    end until ['quit', 'q'].include? cmd 


