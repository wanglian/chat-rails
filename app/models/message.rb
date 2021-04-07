# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :channel
  belongs_to :user

  validates :content, presence: true

  def to_h
    {
      "id": self.id,
      "channel_id": self.channel_id,
      "user_id": self.user_id,
      "content": self.content
    }
  end
end
