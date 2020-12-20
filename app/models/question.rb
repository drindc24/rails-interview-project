class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user

  default_scope { where.not(private: true) }
end
