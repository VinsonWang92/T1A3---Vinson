module Income
    def add_income
        puts 'What is your net monthly income?'
        income = gets.chomp.to_i 
        # budget_surplus = income-total_spending
        rows = []
        rows << ["Net income", income]
        income_summary = Terminal::Table.new :title => "Net income", :rows=> rows
        puts income_summary
        return income
    end
    module_function :add_income
end 