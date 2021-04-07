# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChannelUser, type: :model do
  context 'associations' do
    it { should belong_to(:channel)}
    it { should belong_to(:user)}
  end

  context 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:channel_id) }
    subject { FactoryBot.create(:channel_user) } # required to validate uniqueness
    it { should validate_uniqueness_of(:user_id).scoped_to(:channel_id) }
  end
end
