class AddVotesCountToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :votes_count, :integer, default: 0
    # добавляет колонку (с именем: :votes_count) в таблицу :items со значением по умолч. 0 
    # (кол-во голосов)
  end
end