describe Fastlane::Actions::XcodebuildAnalyzeEnsureNoResultsAction do
  describe 'xcodebuild analyze ensure no results' do
    before(:each) do
      FileUtils.mkdir_p('fastlane/analyze_results/StaticAnalyzer/ExampleApp')
      expect(Fastlane::UI)
        .to receive(:success)
        .with("Driving the lane 'test' 🚀")
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("xcodebuild -project Meniga.xcodeproj -scheme Meniga CLANG_ANALYZER_OTHER_FLAGS= CLANG_ANALYZER_OUTPUT=html CLANG_ANALYZER_OUTPUT_DIR=analyze_results analyze")
    end

    after(:each) do
      FileUtils.rm_rf('fastlane/analyze_results')
    end

    it 'should succedd when no html files under results path' do
      expect(Fastlane::UI)
        .to receive(:success)
        .with("Project is free of analyzer warnings, all good! 💪")

      ActionRunner.xcodebuild_analyze_ensure_no_results("project: 'Meniga.xcodeproj', scheme: 'Meniga'")
    end

    it 'should failed when html file created under results path' do
      File.new("fastlane/analyze_results/StaticAnalyzer/ExampleApp/report-57c09a.html", "w")

      expect(Fastlane::UI)
        .to receive(:user_error!)
        .with("Analyzer found vulnerabilities in 1 file(s)!")

      ActionRunner.xcodebuild_analyze_ensure_no_results("project: 'Meniga.xcodeproj', scheme: 'Meniga'")
    end

    it 'should failed with proper message when html files created under results path' do
      File.new("fastlane/analyze_results/StaticAnalyzer/ExampleApp/report-57c09a.html", "w")
      File.new("fastlane/analyze_results/StaticAnalyzer/ExampleApp/report-21c47a.html", "w")

      expect(Fastlane::UI)
        .to receive(:user_error!)
        .with("Analyzer found vulnerabilities in 2 file(s)!")

      ActionRunner.xcodebuild_analyze_ensure_no_results("project: 'Meniga.xcodeproj', scheme: 'Meniga'")
    end

    it 'should remove output dir when prune output is true' do
      File.new("fastlane/analyze_results/StaticAnalyzer/ExampleApp/report-57c09a.html", "w")

      expect(Fastlane::UI)
        .to receive(:user_error!)
        .with("Analyzer found vulnerabilities in 1 file(s)!")

      ActionRunner.xcodebuild_analyze_ensure_no_results("project: 'Meniga.xcodeproj', scheme: 'Meniga', prune_output: true")

      expect(File.exist?("fastlane/analyze_results")).to be false
    end

    it 'should not remove output dir when prune output is false' do
      File.new("fastlane/analyze_results/StaticAnalyzer/ExampleApp/report-57c09a.html", "w")

      expect(Fastlane::UI)
        .to receive(:user_error!)
        .with("Analyzer found vulnerabilities in 1 file(s)!")

      ActionRunner.xcodebuild_analyze_ensure_no_results("project: 'Meniga.xcodeproj', scheme: 'Meniga', prune_output: false")

      expect(File.exist?("fastlane/analyze_results")).to be true
    end
  end
end
