module ChartsHelper
  def expense_for_chart(expenses)
    expenses.group_by_category.map do |array|
      subcategories = array.second
      expenses = subcat_exp_sums(subcategories)
      {
        expenses: expenses.reduce(:+),
        drilldown: {
          name: array.first.title,
          categories: subcategories.map { |sub| sub.first.title },
          data: expenses
        }
      }
    end.to_json
  end

  def categories_titles(expenses)
    expenses.group_by_category.keys.map(&:title)
  end

  def expenses_vs_incomes(expenses, incomes)
    [
      { name: 'Incomes', data: montly_summary(incomes) },
      { name: 'Expenses', data: montly_summary(expenses) }
    ]
  end

  def sums_by_month(savings)
    sum = 0
    savings.values.map { |e| sum += e }
  end

  private

  def montly_summary(summable)
    summable
      .to_a
      .group_by_month(&:operation_date)
      .map { |k, v| [k.strftime('%B %Y'), v.map(&:value).reduce(:+)] }
  end

  def subcat_exp_sums(subcategories)
    subcategories.map { |s| s.second.map { |e| e.value.to_f.round }.reduce(:+) }
  end
end
