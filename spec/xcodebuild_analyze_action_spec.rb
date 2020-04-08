describe Fastlane::Actions::XcodebuildAnalyzeAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The xcodebuild_analyze plugin is working!")

      Fastlane::Actions::XcodebuildAnalyzeAction.run(nil)
    end
  end
end
