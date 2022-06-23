class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def user_is_author?(current_user_id)
    current_user_id == user_id
  end
end
