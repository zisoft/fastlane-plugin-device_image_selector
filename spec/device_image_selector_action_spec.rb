describe Fastlane::Actions::DeviceImageSelectorAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The device_image_selector plugin is working!")

      Fastlane::Actions::DeviceImageSelectorAction.run(nil)
    end
  end
end
