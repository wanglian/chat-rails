# frozen_string_literal: true

require 'rails_helper'

describe Api::ChannelsController, type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let(:user)          { FactoryBot.create(:user) }

  before do
    sign_in(user)
    @auth_params = get_auth_params(response)
  end

  describe "#index" do
    it "returns error if not signed in" do
      get '/api/v1/channels', params: {}

      expect(response.status).to eq(401)
    end

    it "renders a collection of channels" do
      FactoryBot.create_list(:channel, 5)

      get '/api/v1/channels', params: {}, headers: @auth_params

      expect(response.status).to eq(200)
      expect(response_body.length).to eq(Channel.count)
    end
  end

  describe "#join" do
    let(:channel) { FactoryBot.create(:channel) }

    it "joins a channel" do
      expect {
        post "/api/v1/channels/#{channel.id}/join", headers: @auth_params
      }.to change(ChannelUser, :count).by(1)
    end

    it "does nothing if already joined" do
      FactoryBot.create(:channel_user, channel: channel, user: user)

      expect {
        post "/api/v1/channels/#{channel.id}/join", headers: @auth_params
      }.to change(ChannelUser, :count).by(0)
    end

    it "retuns error if channel not exists" do
      post "/api/v1/channels/#{channel.id + 1}/join", headers: @auth_params

      expect(response.message).to eq("Unprocessable Entity")
    end
  end
end
