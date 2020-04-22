module ActionRunner
  def self.xcodebuild_analyze(string_params)
    run_action("xcodebuild_analyze", string_params)
  end

  def self.xcodebuild_analyze_and_ensure_no_results(string_params)
    run_action("xcodebuild_analyze_and_ensure_no_results", string_params)
  end

  def self.ensure_no_results_from_xcodebuild_analyze(string_params)
    run_action("ensure_no_results_from_xcodebuild_analyze", string_params)
  end

  def self.run_action(name, string_params)
    Fastlane::FastFile.new.parse("
      lane :test do
        #{name}(#{string_params})
      end
      ").runner.execute(:test)
  end
end
