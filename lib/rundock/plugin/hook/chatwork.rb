require "rundock/plugin/hook/chatwork/version"
require 'faraday'

module Rundock
  module Hook
    class Chatwork < Base
      def hook(operation_attributes, log_buffer)

        conn = Faraday::Connection.new(url: 'https://api.chatwork.com') do |builder|
          builder.use Faraday::Request::UrlEncoded
          builder.use Faraday::Response::Logger
          builder.use Faraday::Adapter::NetHttp
        end

        response = conn.post do |request|
          request.url "/v1/rooms/#{@contents[:room_id]}/messages"
          request.headers = {'X-ChatWorkToken' => @contents[:token]}

          out_msg = ''
          log_buffer.each do |log|
            out_msg += log.formatted_message
          end

          request.params[:body] = out_msg
        end
      end
    end
  end
end
