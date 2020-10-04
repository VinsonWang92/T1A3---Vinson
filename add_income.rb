module Income
    def add_income
        puts 'What is your net monthly income?'
        income = gets.chomp
        begin
            income = Integer(income)
          rescue ArgumentError, TypeError
            puts "Invalid input, please retry adding income and input integers only"
            return income = nil    
        end
        rows = []
        rows << ["Net income", income]
        income_summary = Terminal::Table.new :title => "Net income", :rows=> rows
        puts income_summary
        return income
    end
    module_function :add_income
end 