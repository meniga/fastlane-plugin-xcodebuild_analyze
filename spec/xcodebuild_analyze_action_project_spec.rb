describe Fastlane::Actions::XcodebuildAnalyzeAction do
  describe 'xcodebuild analyze should run xcodebuild with -project' do
    before(:each) do
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("xcodebuild -project Meniga.xcodeproj -scheme Meniga analyze")
    end

    it 'when project provided and workspace not provided' do
      Fastlane::FastFile.new.parse("lane :test do
        xcodebuild_analyze(project: 'Meniga.xcodeproj', scheme: 'Meniga')
      end").runner.execute(:test)
    end

    it 'when project provided and xcodeproj is in current directory' do
      xcodeproj = "fastlane/Wrapp.xcodeproj"
      File.new(xcodeproj, "w")

      Fastlane::FastFile.new.parse("lane :test do
          xcodebuild_analyze(project: 'Meniga.xcodeproj', scheme: 'Meniga')
      end").runner.execute(:test)

      File.delete(xcodeproj)
    end

    it 'when project not provided and xcodeproj is in current directory' do
      xcodeproj = "fastlane/Meniga.xcodeproj"
      File.new(xcodeproj, "w")

      Fastlane::FastFile.new.parse("lane :test do
        xcodebuild_analyze(scheme: 'Meniga')
      end").runner.execute(:test)

      File.delete(xcodeproj)
    end

    it 'when project provided and xcworkspace is in current directory' do
      xcworkspace = "fastlane/Meniga.xcworkspace"
      File.new(xcworkspace, "w")

      Fastlane::FastFile.new.parse("lane :test do
          xcodebuild_analyze(project: 'Meniga.xcodeproj', scheme: 'Meniga')
      end").runner.execute(:test)

      File.delete(xcworkspace)
    end
  end
end
