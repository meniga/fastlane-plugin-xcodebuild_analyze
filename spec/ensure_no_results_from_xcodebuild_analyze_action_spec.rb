describe Fastlane::Actions::EnsureNoResultsFromXcodebuildAnalyzeAction do
  describe 'xcodebuild analyze ensure no results' do
    before(:each) do
      FileUtils.mkdir_p('fastlane/analyze_results/StaticAnalyzer/ExampleApp')
      expect(Fastlane::UI)
        .to receive(:success)
        .with("Driving the lane 'test' 🚀")
    end

    after(:each) do
      FileUtils.rm_rf('fastlane/analyze_results')
    end

    it 'should succedd when no html files under results path' do
      expect(Fastlane::UI)
        .to receive(:success)
        .with("Project is free of analyzer warnings, all good! 💪")

      ActionRunner.ensure_no_results_from_xcodebuild_analyze("path: 'analyze_results'")
    end

    it 'should failed when html file created under results path' do
      File.new("fastlane/analyze_results/StaticAnalyzer/ExampleApp/report-57c09a.html", "w")

      expect(Fastlane::UI)
        .to receive(:user_error!)
        .with("Analyzer found vulnerabilities in 1 file(s)!")

      ActionRunner.ensure_no_results_from_xcodebuild_analyze("path: 'analyze_results'")
    end

    it 'should failed with proper message when html files created under results path' do
      File.new("fastlane/analyze_results/StaticAnalyzer/ExampleApp/report-57c09a.html", "w")
      File.new("fastlane/analyze_results/StaticAnalyzer/ExampleApp/report-21c47a.html", "w")

      expect(Fastlane::UI)
        .to receive(:user_error!)
        .with("Analyzer found vulnerabilities in 2 file(s)!")

      ActionRunner.ensure_no_results_from_xcodebuild_analyze("path: 'analyze_results'")
    end

    it 'should remove output dir when prune is true' do
      File.new("fastlane/analyze_results/StaticAnalyzer/ExampleApp/report-57c09a.html", "w")

      expect(Fastlane::UI)
        .to receive(:user_error!)
        .with("Analyzer found vulnerabilities in 1 file(s)!")

      ActionRunner.ensure_no_results_from_xcodebuild_analyze("path: 'analyze_results', prune: true")

      expect(File.exist?("fastlane/analyze_results")).to be false
    end

    it 'should not remove output dir when prune is false' do
      File.new("fastlane/analyze_results/StaticAnalyzer/ExampleApp/report-57c09a.html", "w")

      expect(Fastlane::UI)
        .to receive(:user_error!)
        .with("Analyzer found vulnerabilities in 1 file(s)!")

      ActionRunner.ensure_no_results_from_xcodebuild_analyze("path: 'analyze_results', prune: false")

      expect(File.exist?("fastlane/analyze_results")).to be true
    end
  end
end
