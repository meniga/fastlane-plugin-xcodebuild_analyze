describe Fastlane::Actions::XcodebuildAnalyzeAction do
  describe 'xcodebuild analyze' do
    it 'should run xcodebuild with proper project when project provided' do
      expect(Fastlane::Actions::XcodebuildAction)
        .to receive(:run)
        .with(
          workspace: nil,
          project: "../Meniga.xcodeproj",
          scheme: "Meniga",
          sdk: nil,
          analyze: true,
          xcargs: ""
        )

      ActionRunner.xcodebuild_analyze("project: 'Meniga.xcodeproj', scheme: 'Meniga'")
    end

    it 'should run xcodebuild with proper workspace when project workspace provided' do
      expect(Fastlane::Actions::XcodebuildAction)
        .to receive(:run)
        .with(
          workspace: "../Meniga.xcworkspace",
          project: nil,
          scheme: "Meniga",
          sdk: nil,
          analyze: true,
          xcargs: ""
        )

      ActionRunner.xcodebuild_analyze("workspace: 'Meniga.xcworkspace', scheme: 'Meniga'")
    end

    it 'should run xcodebuild with proper scheme when scheme provided' do
      expect(Fastlane::Actions::XcodebuildAction)
        .to receive(:run)
        .with(
          workspace: nil,
          project: "../Meniga.xcodeproj",
          scheme: "Wrapp",
          sdk: nil,
          analyze: true,
          xcargs: ""
        )

      ActionRunner.xcodebuild_analyze("project: 'Meniga.xcodeproj', scheme: 'Wrapp'")
    end

    it 'should run xcodebuild with sdk when sdk provided' do
      expect(Fastlane::Actions::XcodebuildAction)
        .to receive(:run)
        .with(
          workspace: nil,
          project: "../Meniga.xcodeproj",
          scheme: "Meniga",
          sdk: "iphonesimulator",
          analyze: true,
          xcargs: ""
        )

      ActionRunner.xcodebuild_analyze("project: 'Meniga.xcodeproj', scheme: 'Meniga', sdk: 'iphonesimulator'")
    end

    it 'should run xcodebuild with proper output when output provided' do
      expect(Fastlane::Actions::XcodebuildAction)
        .to receive(:run)
        .with(
          workspace: nil,
          project: "../Meniga.xcodeproj",
          scheme: "Meniga",
          sdk: nil,
          analyze: true,
          xcargs: "CLANG_ANALYZER_OTHER_FLAGS= CLANG_ANALYZER_OUTPUT=html"
        )

      ActionRunner.xcodebuild_analyze("project: 'Meniga.xcodeproj', scheme: 'Meniga', output: 'html'")
    end

    it 'should run xcodebuild with output dir when output dir provided' do
      expect(Fastlane::Actions::XcodebuildAction)
        .to receive(:run)
        .with(
          workspace: nil,
          project: "../Meniga.xcodeproj",
          scheme: "Meniga",
          sdk: nil,
          analyze: true,
          xcargs: "CLANG_ANALYZER_OTHER_FLAGS= CLANG_ANALYZER_OUTPUT_DIR=path/tmp"
        )

      ActionRunner.xcodebuild_analyze("project: 'Meniga.xcodeproj', scheme: 'Meniga', output_dir: 'path/tmp'")
    end

    it 'should run xcodebuild with static analyzer when static_analyzer is true' do
      expect(Fastlane::Actions::XcodebuildAction)
        .to receive(:run)
        .with(
          workspace: nil,
          project: "../Meniga.xcodeproj",
          scheme: "Meniga",
          sdk: nil,
          analyze: true,
          xcargs: "CLANG_ANALYZER_OTHER_FLAGS= RUN_CLANG_STATIC_ANALYZER=YES"
        )

      ActionRunner.xcodebuild_analyze("project: 'Meniga.xcodeproj', scheme: 'Meniga', static_analyzer: true")
    end

    it 'should run xcodebuild with static analyzer set to NO when static_analyzer is false' do
      expect(Fastlane::Actions::XcodebuildAction)
        .to receive(:run)
        .with(
          workspace: nil,
          project: "../Meniga.xcodeproj",
          scheme: "Meniga",
          sdk: nil,
          analyze: true,
          xcargs: "CLANG_ANALYZER_OTHER_FLAGS= RUN_CLANG_STATIC_ANALYZER=NO"
        )

      ActionRunner.xcodebuild_analyze("project: 'Meniga.xcodeproj', scheme: 'Meniga', static_analyzer: false")
    end
  end
end
