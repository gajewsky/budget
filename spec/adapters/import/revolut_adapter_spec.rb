require 'rails_helper'

RSpec.describe Import::RevolutAdapter do
  subject do
    described_class.call(content: content)
  end

  let(:user) { create :user }
  let(:description) { 'Description' }
  let(:type) { 'CARD_PAYMENT' }

  let!(:revolut_subcategory) { create :subcategory, title: 'Revolut' }
  let(:content) do
    [
      {
        type: type,
        product: 'Current',
        started_date: '2021-09-25 13:49:44',
        completed_date: '2021-09-27 11:52:14',
        description: description,
        amount: -85.76,
        fee: 0.0,
        currency: 'PLN',
        state: 'COMPLETED',
        balance: 3153.56,
        notes: 'some notes'
      }
    ]
  end

  let(:expected_result) do
    [
      {
        bill_attrs: {
          contractor_id: expected_contractor_id,
          operation_date: '2021-09-25 13:49:44 +0200'.to_time
        },

        expenses_attrs: [
          {
            description: "#{description}\n          \n          some notes",
            subcategory_id: expected_subcategory_id,
            tag_list: ['revolut'],
            value: 85.76
          }
        ]
      }
    ]
  end


  context 'when type is not accepted' do
    let(:type) { 'Cash at' }

    it 'omits expense' do
      expect(subject).to eq []
    end
  end

  context 'when it has known contractor existing in db' do
    let(:description) { 'Contractor Name' }
    let(:expected_contractor_id) { contractor.id }

    context 'and contractor has associated default category' do
      let!(:contractor) { create :contractor, revolut_id: 'Contractor Name', subcategory_id: 13 }
      let(:expected_subcategory_id) { 13 }

      it 'omits expense when contractor is on ignored list' do
        expect(subject).to eq expected_result
      end
    end

    context 'and description has part of revolut_id' do
      let!(:contractor) { create :contractor, revolut_id: 'digitalocean', subcategory_id: 13 }
      let(:expected_subcategory_id) { 13 }
      let(:description) { "Digitalocean FX Rate zł 1 = $0.2411" }

      it 'finds contractor using regexp' do
        expect(subject).to eq expected_result
      end
    end

    context 'and contractor has not associated default category' do
      let!(:contractor) { create :contractor, revolut_id: 'Contractor Name' }

      let(:expected_subcategory_id) { revolut_subcategory.id }

      it 'omits expense when contractor is on ignored list' do
        expect(subject).to eq expected_result
      end
    end
  end

  context 'when it has unknown contractor not existing in db' do
    let(:expected_contractor_id) { nil }
    let(:expected_subcategory_id) { revolut_subcategory.id }

    it 'omits expense when contractor is on ignored list' do
      expect(subject).to eq expected_result
    end
  end
end

