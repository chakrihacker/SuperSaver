class Category < ApplicationRecord
  has_many :children, class_name: "Category", foreign_key: "parent_id", :dependent => :destroy
  belongs_to :parent, class_name: "Category", optional: true
  has_many :deals
  has_one_attached :icon
end
