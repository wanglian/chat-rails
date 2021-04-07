# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    channel
    user
    content { Faker::Lorem.paragraph }
  end
end
