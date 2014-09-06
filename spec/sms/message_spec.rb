require 'spec_helper'
require 'nokogiri'
require 'sms/message'

describe Sms::Message do
  let(:node) { Nokogiri::XML('<sms protocol="0" address="7705557200" date="1409536051255" type="2" subject="null" body="Aight. I\'ll probably chill at the pulse loft " toa="0" sc_toa="0" service_center="null" read="1" status="-1" locked="0" date_sent="0" readable_date="Aug 31, 2014 9:47:31 PM" contact_name="George Burdell" />').child }
  let(:message) { Sms::Message.new(node) }

  describe '#body' do
    it "returns the message body" do
      expect(message.body).to eq("Aight. I'll probably chill at the pulse loft ")
    end
  end

  describe '#date' do
    it "returns the date the message was sent" do
      expect(message.date.asctime).to eq("Sun Aug 31 21:47:31 2014")
    end
  end

  describe '#type' do
    it "is :sent for outgoing" do
      expect(message.type).to eq(:sent)
    end

    context "when incoming" do
      let(:node) { Nokogiri::XML('<sms protocol="0" address="+7705557200" date="1409535915637" type="1" subject="null" body="We\'re outside" toa="0" sc_toa="0" service_center="null" read="1" status="-1" locked="0" date_sent="0" readable_date="Aug 31, 2014 9:45:15 PM" contact_name="George Burdell" />').child }

      it "is :received" do
        expect(message.type).to eq(:received)
      end
    end
  end

  describe '#phone_number' do
    it "is the other parties phone number" do
      expect(message.phone_number).to eq("7705557200")
    end
  end

  describe '#name' do
    it "is the other parties name" do
      expect(message.name).to eq("George Burdell")
    end
  end

  describe '#locked?' do
    it "is true if the message is marked locked" do
      expect(message).not_to be_locked
    end
  end

  describe '#delete!' do
    it "deletes the message from the xml" do
      doc = node.parent
      expect {
        message.delete!
      }.to change { doc.children.count }.to(0)
    end
  end
end
