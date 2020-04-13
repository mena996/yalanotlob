class UserOrder < ApplicationRecord
    
    belongs_to :user 
    belongs_to :order  

    validates :item_name, :amount, :price, presence: true
    validates :item_name, format: {  with: /\A[a-zA-Z0-9]+\z/,message: "please enter available order" }
    validates :amount, numericality: { only_integer: true , greater_than: 0 }
    validates :price, :amount, numericality: { greater_than: 0 }
end
