require 'fastlane'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class EnsureNoResultsFromXcodebuildAnalyzeHelper
      def self.ensure_no_results(path, prune)
        results = Dir["#{path}/**/**.html"]
        FileUtils.rm_rf(path) if prune
        if results.empty?
          UI.success("Project is free of analyzer warnings, all good! 💪")
        else
          UI.user_error!("Analyzer found vulnerabilities in #{results.count} file(s)!")
        end
      end
    end
  end
end
