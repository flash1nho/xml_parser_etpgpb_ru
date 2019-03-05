class Asset < ApplicationRecord
  validates :file_name, :file_body, presence: true
  validates :file_name, uniqueness: true
end
