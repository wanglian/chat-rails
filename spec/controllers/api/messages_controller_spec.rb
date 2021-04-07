# frozen_string_literal: true

require 'rails_helper'

describe Api::MessagesController, type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let(:user)          { FactoryBot.create(:user) }
  let(:channel)       { FactoryBot.create(:channel) }

  before do
    sign_in(user)
    @auth_params = get_auth_params(response)
  end

  describe "#index" do
    it "renders a collection of messages" do
      FactoryBot.create(:channel_user, channel: channel, user: user)
      FactoryBot.create_list(:message, 5, channel_id: channel.id)

      get "/api/v1/channels/#{channel.id}/messages", headers: @auth_params

      expect(response.status).to eq(200)
      expect(response_body.length).to eq(Message.count)
    end

    it "retuns error if channel not exists" do
      get "/api/v1/channels/#{channel.id + 1}/messages", headers: @auth_params

      expect(response.message).to eq("Unprocessable Entity")
    end

    it "retuns error if channel not joined" do
      get "/api/v1/channels/#{channel.id}/messages", headers: @auth_params

      expect(response.message).to eq("Unprocessable Entity")
    end
  end

  describe "#create" do
    it "creates a message on a channel" do
      FactoryBot.create(:channel_user, channel: channel, user: user)

      expect {
        post "/api/v1/channels/#{channel.id}/messages", params: { content: 'test' }, headers: @auth_params
      }.to change(Message, :count).by(1)
    end
  end
end
