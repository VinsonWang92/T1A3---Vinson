module Budget
    def create_budget
        puts "How much is your rent/mortgage/board per month"
        rent = gets.chomp.to_i
        puts "How much do you spend on groceries per month?"
        groceries = gets.chomp.to_i
        puts "How much do you spend eating out per month?"
        eating_out = gets.chomp.to_i
        puts "How much do you spend on clothing on average per month?"
        clothing = gets.chomp.to_i
        puts "How much do you spend on medical and health per month including private health insurance?"
        health = gets.chomp.to_i
        puts "How much do you spend on recreation and entertainment on average per month"
        entertainment = gets.chomp.to_i
        puts "How much do you budget per month for holidays?"
        holidays = gets.chomp.to_i
        puts "How much are your loan repayments per month? (credit card, personal loans, car loans etc)"
        loans = gets.chomp.to_i
        puts "Please enter how much other miscellaneous spending you think you may have per month, if 0, put 0"
        miscellaneous = gets.chomp.to_i
        total_spending = rent+groceries+eating_out+clothing+health+entertainment+holidays+loans+miscellaneous
        rows = []
        rows << ["Rent", rent]
        rows << ["Grocercies", groceries]
        rows << ["Eating Out", eating_out]
        rows << ["Clothing", clothing]
        rows << ["Health", health]
        rows << ["Entertainment", entertainment]
        rows << ["Holidays", holidays]
        rows << ["Loan repayments", loans]
        rows << ["Miscellaneous", miscellaneous]
        rows << ["Total Monthly Spending", total_spending]
        budget_summary = Terminal::Table.new :title => "Budget Summary", :headings => ["Category", "Monthly Expense($)"], :rows=> rows
        puts budget_summary
        confirm = TTY::Prompt.new
        confirm = confirm.yes?("Is this correct")
        puts confirm
        if confirm
            puts "Move onto adding income"
        else
            puts "Please recreate budget with correct figures"
        end
        return total_spending
    end
    module_function :create_budget 
end
