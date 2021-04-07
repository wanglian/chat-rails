# frozen_string_literal: true

class ChannelUser < ApplicationRecord
  belongs_to :channel
  belongs_to :user

  validates :user_id,    presence: true
  validates :channel_id, presence: true
  validates :user_id,    uniqueness: { scope: :channel_id }
end
