# frozen_string_literal: true

FactoryBot.define do
  factory :channel do
    name { Faker::FunnyName.name }
  end
end
