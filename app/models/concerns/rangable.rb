# frozen_string_literal: true

module Rangable
  extend ActiveSupport::Concern

  included do
    default_scope -> { order('created_at DESC') }
    scope :spent_between, ->(date_range) { where(operation_date: date_range) }
  end

  private

  def set_operation_date
    self.operation_date ||= Date.today
  end
end
