describe Fastlane::Actions::XcodebuildAnalyzeAction do
  describe 'xcodebuild analyze should run with -workspace' do
    before(:each) do
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("xcodebuild -workspace Meniga.xcworkspace -scheme Meniga analyze")
    end

    it 'when workspace and project provided' do
      ActionRunner.xcodebuild_analyze("workspace: 'Meniga.xcworkspace', project: 'Meniga.xcodeproj', scheme: 'Meniga'")
    end

    it 'when workspace provided and project not provided' do
      ActionRunner.xcodebuild_analyze("workspace: 'Meniga.xcworkspace', scheme: 'Meniga'")
    end

    it 'when workspace not provided and xcworkspace is in current directory' do
      xcworkspace = "fastlane/Meniga.xcworkspace"
      File.new(xcworkspace, "w")

      ActionRunner.xcodebuild_analyze("scheme: 'Meniga'")

      File.delete(xcworkspace)
    end

    it 'when workspace provided and xcworkspace is in current directory' do
      xcworkspace = "fastlane/Wrapp.xcworkspace"
      File.new(xcworkspace, "w")

      ActionRunner.xcodebuild_analyze("workspace: 'Meniga.xcworkspace', scheme: 'Meniga'")

      File.delete(xcworkspace)
    end
  end
end
