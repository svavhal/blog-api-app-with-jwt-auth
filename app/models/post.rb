class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: "user_id"
  has_many :comments, dependent: :destroy

  def user_is_author?(current_user_id)
    current_user_id == user_id
  end

end
