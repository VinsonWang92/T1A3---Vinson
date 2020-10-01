module Budget
    def create_budget
        puts "How much is your rent/mortgage/board"
        rent = gets.chomp.to_i
        puts "How much do you spend on groceries?"
        groceries = gets.chomp.to_i
        puts "How much do you spend eating out?"
        eating_out = gets.chomp.to_i
        total_spending = rent+groceries+eating_out
        puts "Your total monthly spending is $#{total_spending} per month"
        return total_spending
    end
    module_function :create_budget 
end
