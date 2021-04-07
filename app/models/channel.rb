# frozen_string_literal: true

class Channel < ApplicationRecord
  has_many :channel_users
  has_many :users, through: :channel_users

  validates :name, presence: true

  def add_user(user)
    self.users << user unless self.has_user?(user)
  end

  def has_user?(user)
    self.channel_users.where(user_id: user.id).exists?
  end

  def to_h
    {
      "id": self.id,
      "name": self.name
    }
  end
end
