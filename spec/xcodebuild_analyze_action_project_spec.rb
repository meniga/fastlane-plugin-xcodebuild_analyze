describe Fastlane::Actions::XcodebuildAnalyzeAction do
  describe 'xcodebuild analyze should run xcodebuild with -project' do
    before(:each) do
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("xcodebuild -project Meniga.xcodeproj -scheme Meniga analyze")
    end

    it 'when project provided and workspace not provided' do
      ActionRunner.xcodebuild_analyze("project: 'Meniga.xcodeproj', scheme: 'Meniga'")
    end

    it 'when project provided and xcodeproj is in current directory' do
      xcodeproj = "fastlane/Wrapp.xcodeproj"
      File.new(xcodeproj, "w")

      ActionRunner.xcodebuild_analyze("project: 'Meniga.xcodeproj', scheme: 'Meniga'")

      File.delete(xcodeproj)
    end

    it 'when project not provided and xcodeproj is in current directory' do
      xcodeproj = "fastlane/Meniga.xcodeproj"
      File.new(xcodeproj, "w")

      ActionRunner.xcodebuild_analyze("scheme: 'Meniga'")

      File.delete(xcodeproj)
    end

    it 'when project provided and xcworkspace is in current directory' do
      xcworkspace = "fastlane/Meniga.xcworkspace"
      File.new(xcworkspace, "w")

      ActionRunner.xcodebuild_analyze("project: 'Meniga.xcodeproj', scheme: 'Meniga'")

      File.delete(xcworkspace)
    end
  end
end
