describe Fastlane::Actions::XcodebuildAnalyzeAndEnsureNoResultsAction do
  describe 'xcodebuild analyze ensure no results' do
    before(:each) do
      FileUtils.mkdir_p('fastlane/ExampleApp/analyze_results/StaticAnalyzer/ExampleApp')
      File.new("fastlane/ExampleApp/analyze_results/StaticAnalyzer/ExampleApp/report-57c09a.html", "w")
      expect(Fastlane::UI)
        .to receive(:user_error!)
        .with("Analyzer found vulnerabilities in 1 file(s)!")
    end

    after(:each) do
      FileUtils.rm_rf('fastlane/ExampleApp')
    end

    it 'should failed when html file created under results path in project directory' do
      expect(Fastlane::Actions::XcodebuildAction)
        .to receive(:run)
        .with(
          workspace: nil,
          project: "../ExampleApp/Meniga.xcodeproj",
          scheme: "Meniga",
          sdk: nil,
          analyze: true,
          xcargs: "CLANG_ANALYZER_OTHER_FLAGS= CLANG_ANALYZER_OUTPUT=html CLANG_ANALYZER_OUTPUT_DIR=analyze_results"
        )

      ActionRunner.xcodebuild_analyze_and_ensure_no_results("project: 'ExampleApp/Meniga.xcodeproj', scheme: 'Meniga'")
    end

    it 'should failed when html file created under results path in workspace directory' do
      expect(Fastlane::Actions::XcodebuildAction)
        .to receive(:run)
        .with(
          project: nil,
          workspace: "../ExampleApp/Meniga.xcworkspace",
          scheme: "Meniga",
          sdk: nil,
          analyze: true,
          xcargs: "CLANG_ANALYZER_OTHER_FLAGS= CLANG_ANALYZER_OUTPUT=html CLANG_ANALYZER_OUTPUT_DIR=analyze_results"
        )

      ActionRunner.xcodebuild_analyze_and_ensure_no_results("workspace: 'ExampleApp/Meniga.xcworkspace', scheme: 'Meniga'")
    end
  end
end
