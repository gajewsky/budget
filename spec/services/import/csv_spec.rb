require 'rails_helper'

RSpec.describe Import::Csv do
  subject do
    described_class.call(
      user: user,
      filepath: file_fixture('import/revolut.csv')
    )
  end

  let(:user) { create :user }
  let!(:revolut_subcategory) { create :subcategory, title: 'Revolut' }

  it 'creates bill and associated expense for user' do
    expect { subject }
      .to change { user.bills.count }.from(0).to(4)
      .and change { user.expenses.count }.from(0).to(4)
  end
end

