module Import
  class RevolutAdapter
    extend ServiceObject

    def initialize(content:)
      @content = content
    end

    def call
      expense_rows.map { |row| ParseRow.new(row).call }.compact
    end

    private

    def expense_rows
      expense_types = %w[CARD_PAYMENT TRANSFER]

      content.keep_if do |row|
        expense_types.include?(row[:type]) && row[:state] == 'COMPLETED'
      end
    end

    attr_reader :content

    class ParseRow
      def initialize(row)
        @row = row
      end

      def call
        {
          bill_attrs: bill_attrs,
          expenses_attrs: [expense_attrs]
        }
      end

      private

      attr_reader :row

      def bill_attrs
        {
          operation_date: operation_date,
          contractor_id: contractor&.id
        }
      end

      def expense_attrs
        {
          description: description,
          value: row[:amount].abs,
          subcategory_id: subcategory_id,
          tag_list: ['revolut']
        }
      end

      def operation_date
        @operation_date ||= Time.parse(row[:started_date])
      end

      def contractor
        @contractor ||= Contractor.where.not(revolut_id: '').find do |contractor|
          pattern = /#{Regexp.quote(contractor.revolut_id)}/i

          pattern.match? row[:description]
        end
      end

      def subcategory_id
        @subcategory_id ||=
          contractor&.subcategory_id || Subcategory.find_by!(title: 'Revolut').id
      end

      def description
        %(#{row[:description]}
          #{row[:category]}
          #{row[:notes]}).strip
      end
    end
  end
end
