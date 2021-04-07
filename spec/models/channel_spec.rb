# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Channel, type: :model do
  context 'associations' do
    it { should have_many(:channel_users)}
    it { should have_many(:users)}
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
  end

  context '#add_user' do
    let(:channel) { FactoryBot.create(:channel) }
    let(:user)    { FactoryBot.create(:user) }

    it 'adds user to a channel' do
      expect {
        channel.add_user user
      }.to change(ChannelUser, :count).by(1)
    end

    it 'should only add once' do
      FactoryBot.create(:channel_user, channel: channel, user: user)

      expect {
        channel.add_user user
      }.to change(ChannelUser, :count).by(0)
    end
  end

  context '#has_user?' do
    let(:channel) { FactoryBot.create(:channel) }
    let(:user)    { FactoryBot.create(:user) }

    it 'return false if user not joined' do
      expect(channel.has_user?(user)).to eq(false)
    end

    it 'returns true if user joined' do
      FactoryBot.create(:channel_user, channel: channel, user: user)

      expect(channel.has_user?(user)).to eq(true)
    end
  end
end
