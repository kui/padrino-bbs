class Comment < ActiveRecord::Base
  belongs_to :account
  belongs_to :topic

  def auther? a
    a.class == Account and a.id == account.id
  end
end
