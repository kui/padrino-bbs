class Topic < ActiveRecord::Base
  belongs_to :account
  has_many :comments

  def updated_once?
    created_at != updated_at
  end
end
