class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user

  default_scope { where.not(private: true) }

  def self.search(q)
    return page unless q.present?

    where(arel_table[:title].matches("%#{q}%"))
  end
end
