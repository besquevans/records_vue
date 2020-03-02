class Record < ApplicationRecord
  belongs_to :user

  vaildates :title, :year, presence: true
end
