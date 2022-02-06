class BillsFilter
  def initialize(search: nil, subcategory_id: nil, contractor_id: nil, user_id: nil)
    @search = search
    @subcategory_id = subcategory_id
    @contractor_id = contractor_id
    @user_id = user_id
  end

  def self.call(...)
    new(...).call
  end

  def call
    bills = bills_with_relations
    bills = bills.search_by_expense(search) if search.present?
    bills = bills.where(expenses: Subcategory.find(subcategory_id).expenses) if subcategory_id.present?
    bills = bills.where(contractor_id: contractor_id) if contractor_id.present?
    bills = bills.where(user_id: user_id) if user_id.present?

    bills.reorder 'operation_date DESC'
  end

  private

  attr_reader :search, :subcategory_id, :contractor_id, :user_id

  def bills_with_relations
    Bill.includes({ expenses: [{ subcategory: :category }] }, :user, :contractor)
  end
end