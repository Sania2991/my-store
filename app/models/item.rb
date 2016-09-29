class Item < ApplicationRecord
  validates :price, { numericality: { greater_than: 0, allow_nil: true } }
  # валидация :имя_поля, (передаем ХЭШ, состоящий из цены { Больше чем 0, может быть true)
  validates :name, { presence: true }

end


