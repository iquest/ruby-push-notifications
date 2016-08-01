
module RubyPushNotifications
  module MPNS
    describe MPNSNotification do

      let(:device_urls) { %w(a b c) }
      let(:raw_notification) { build :mpns_notification }
      let(:toast_data) { { :title => 'Title', :message => 'Hello MPNS World!', :type => :toast } }
      let(:toast_notification) { build :mpns_notification, :device_urls => device_urls, :data => toast_data }
      let(:tile_data) { { :count => 1, :title => 'Hello MPNS World!', :type => :tile } }
      let(:tile_notification) { build :mpns_notification, :device_urls => device_urls, :data => tile_data }

      it 'builds the right mpns raw xml' do
        xml = '<?xml version="1.0" encoding="UTF-8"?>'
        xml << '<root><value1>hello</value1></root>'
        expect(raw_notification.as_mpns_xml).to eq xml
      end

      it 'builds the right mpns toast xml' do
        xml = '<?xml version="1.0" encoding="UTF-8"?>'
        xml << '<wp:Notification xmlns:wp="WPNotification"><wp:Toast>'
        xml << '<wp:Text1>Title</wp:Text1>'
        xml << '<wp:Text2>Hello MPNS World!</wp:Text2>'
        xml << '</wp:Toast></wp:Notification>'
        expect(toast_notification.as_mpns_xml).to eq xml
      end

      it 'builds the right mpns tile xml' do
        xml = '<?xml version="1.0" encoding="UTF-8"?>'
        xml << '<wp:Notification xmlns:wp="WPNotification"><wp:Tile>'
        xml << '<wp:Count>1</wp:Count>'
        xml << '<wp:Title>Hello MPNS World!</wp:Title>'
        xml << '</wp:Tile></wp:Notification>'
        expect(tile_notification.as_mpns_xml).to eq xml
      end

      it 'validates the mpns format'

      it 'validates the data'

      it_behaves_like 'a proper results manager' do
        let(:notification) { build :mpns_notification }
        let(:success_count) { 1 }
        let(:failures_count) { 0 }
        let(:device_url) { generate :mpns_device_url }
        let(:individual_results) { [MPNSResultOK.new(device_url, {})] }
        let(:results) do
          MPNSResponse.new [{ :code => 200, :device_url => device_url, :headers => {} }]
        end
      end
    end
  end
end
