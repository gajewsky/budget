module Import
  class RevolutAdapter
    extend ServiceObject

    def initialize(content:)
      @content = content
    end

    def call
      content.map { |row| ParseRow.new(row).call }.compact
    end

    private

    attr_reader :content

    class ParseRow
      def initialize(row)
        @row = row
      end

      def call
        return if not_valid_row?

        {
          bill_attrs: bill_attrs,
          expenses_attrs: [expense_attrs]
        }
      end

      private

      attr_reader :row

      IGNORED_CONTRACTORS = [
        'Top-Up',
        'To CB PAYMENTS',
        'To Crypto',
        'Cash at',
        'Exchange',
        'To Base'
      ].freeze

      def not_valid_row?
        row[:"paid_out_(pln)"].nil? || row[:description].start_with?(*IGNORED_CONTRACTORS)
      end

      def bill_attrs
        {
          operation_date: operation_date,
          contractor_id: contractor&.id
        }
      end

      def expense_attrs
        {
          description: description,
          value: row[:"paid_out_(pln)"],
          subcategory_id: subcategory_id,
          tag_list: ['revolut']
        }
      end

      def operation_date
        @operation_date ||= Date.parse(row[:completed_date]).to_s
      end

      def contractor
        @contractor ||= Contractor.find_by(revolut_id: row[:description])
      end

      def subcategory_id
        @subcategory_id ||=
          contractor&.subcategory_id || Subcategory.find_by!(title: 'Revolut').id
      end

      def description
        "#{row[:description]} - #{row[:category]} - #{row[:notes]}"
      end
    end
  end
end
