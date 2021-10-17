module Import
  class Csv
    extend ServiceObject

    def initialize(user:, filepath: Rails.public_path.join('revolut.csv'))
      @user = user
      @filepath = filepath
    end

    def call
      attributes.map do |row|
        CreateBill.call(
          attrs: row[:bill_attrs],
          expenses_attrs: row[:expenses_attrs],
          user: user
        )
      end
    end

    private

    attr_reader :filepath, :user

    def attributes
      Import::RevolutAdapter.call(content: parsed_csv)
    end

    def parsed_csv
      @parsed_csv ||= SmarterCSV.process(filepath, col_sep: ',')
    end
  end
end
