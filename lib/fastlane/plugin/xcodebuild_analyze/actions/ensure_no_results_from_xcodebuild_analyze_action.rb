require 'fastlane'
require_relative '../helper/ensure_no_results_from_xcodebuild_analyze_helper'

module Fastlane
  module Actions
    class EnsureNoResultsFromXcodebuildAnalyzeAction < Action
      def self.run(params)
        Helper::EnsureNoResultsFromXcodebuildAnalyzeHelper.ensure_no_results(
          params[:path],
          params[:prune]
        )
      end

      def self.category
        :building
      end

      def self.description
        "Check if the are any vulnerabilities under provided analyzer output path"
      end

      def self.authors
        ["Marcin Stepnowski"]
      end

      def self.example_code
        [
          "ensure_no_results(path: 'Meniga/analyzer_output', prune: true)"
        ]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :path,
            env_name: "ENSURE_NO_RESULTS_FROM_XCODEBUILD_ANALYZE_PATH",
            description: "Path to analyzer output directory",
            optional: false,
            type: String),
          FastlaneCore::ConfigItem.new(key: :prune,
            env_name: "ENSURE_NO_RESULTS_FROM_XCODEBUILD_ANALYZE_PRUNE",
            description: "Remove directory afterwards if true",
            optional: false,
            type: Boolean,
            default_value: false)
        ]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end
    end
  end
end
