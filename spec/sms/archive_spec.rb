require 'spec_helper'
require 'sms/archive'

describe Sms::Archive do
  let(:file) { File.read("spec/fixtures/tiny_archive.xml") }
  let(:archive) { Sms::Archive.new(file) }

  describe '#count' do
    it "returns the number of messages" do
      expect(archive.count).to eq(2)
    end
  end

  describe '#messages' do
    it "returns a list of all the messages in the archive" do
      expect(archive.messages.count).to eq(2)
      expect(archive.messages.first).to be_a(Sms::Message)
    end
  end

  describe '#update_count!' do
    it "updates the message count to match the number of messages" do
      archive.messages.first.delete!
      expect {
        archive.update_count!
      }.to change { archive.count }.by(-1)
    end
  end

  describe '#to_xml' do
    it "outputs the archive" do
      expect(archive.to_xml).to eq(file)
    end

    it "updates the count before saving" do
      archive.messages.first.delete!
      expect(archive.to_xml).to include('<smses count="1">')
    end

    it "reflects changes in the archive" do
      archive.messages.each(&:delete!)
      expect(archive.to_xml).not_to match(/<sms [^>]+\/>/)
    end
  end
end
