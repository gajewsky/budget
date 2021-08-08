class Yolo
  def self.confirm_expenses!(expenses:, contractor_id:)
    contractor = Contractor.find(contractor_id)

    expenses.each do |expense|
      expense.tag_list.remove('need-confirm')
      expense.subcategory = contractor.subcategory
      expense.save!
    end

    return unless contractor_id

    bill_ids = expenses.map(&:bill).pluck(:id)

    Bill.where(id: bill_ids).update_all(contractor_id: contractor_id)
  end

  def self.contractor_for_tag(tag:, contractor_id:)
    bill_ids = Expense.tagged_with(tag).map(&:bill).pluck(:id)

    Bill.where(id: bill_ids).update_all(contractor_id: contractor_id)
  end
end
