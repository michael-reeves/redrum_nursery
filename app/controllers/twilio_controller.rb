require "twilio-ruby"

class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token

  def connect_customer
    # mocking a db of customers, connect to real db in production
    customers = {
      "123" => { "phone_number" => "7724183162" },
      "456" => { "phone_number" => "+15553333" }
    }
    # accessing mocked customers db
    customer = customers[params[:id]]
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Hello. Connecting you to the customer now.", :voice => "alice"
      r.Dial :callerId => "17723245092" do |d|
        d.Number customer["phone_number"]
      end
    end

    render_twiml response
  end
end
