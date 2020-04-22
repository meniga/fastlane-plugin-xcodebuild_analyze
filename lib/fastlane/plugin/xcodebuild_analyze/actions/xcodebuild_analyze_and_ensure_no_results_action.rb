require 'fastlane'
require_relative '../helper/xcodebuild_analyze_helper'
require_relative '../helper/ensure_no_results_from_xcodebuild_analyze_helper'

module Fastlane
  module Actions
    class XcodebuildAnalyzeAndEnsureNoResultsAction < Action
      def self.run(params)
        configuration = Helper::XcodebuildAnalyzeHelper.parse_configuration(params)
        configuration.output = "html"
        Helper::XcodebuildAnalyzeHelper.run_analyzer(configuration, other_action)
        input_path = configuration.workspace ? configuration.workspace : configuration.project
        path = "#{File.dirname(input_path)}/#{configuration.output_dir}"
        Helper::EnsureNoResultsFromXcodebuildAnalyzeHelper.ensure_no_results(
          path,
          params[:prune_output]
        )
      end

      def self.category
        :building
      end

      def self.description
        "Run code analyzer using xcodebuild and fail if any vulnerability is found"
      end

      def self.authors
        ["Marcin Stepnowski"]
      end

      def self.example_code
        [
          "
          xcodebuild_analyze_and_ensure_no_results(
              project: 'Meniga.xcodeproj',
              scheme: 'Release',
              sdk: 'iphonesimulator'
              output_dir: 'tmp',
              static_analyzer: true,
              prune_output: true)
          "
        ]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :workspace,
            env_name: "XCODEBUILD_ANALYZE_AND_ENSURE_NO_RESULTS_WORKSPACE",
            description: "WORKSPACE Workspace (.xcworkspace) file to use to analyze app (automatically detected in current directory)",
            optional: true,
            type: String),
          FastlaneCore::ConfigItem.new(key: :project,
            env_name: "XCODEBUILD_ANALYZE_AND_ENSURE_NO_RESULTS_PROJECT",
            description: "Project (.xcodeproj) file to use to analyze app (overridden by --workspace option, if passed)",
            optional: true,
            type: String),
          FastlaneCore::ConfigItem.new(key: :configuration,
            env_name: "XCODEBUILD_ANALYZE_AND_ENSURE_NO_RESULTS_CONFIGURATION",
            description: "Configuration used to analyze",
            optional: true,
            type: String),
          FastlaneCore::ConfigItem.new(key: :scheme,
            env_name: "XCODEBUILD_ANALYZE_AND_ENSURE_NO_RESULTS_SCHEME",
            description: "Scheme used to analyze app",
            optional: false,
            type: String),
          FastlaneCore::ConfigItem.new(key: :sdk,
            env_name: "XCODEBUILD_ANALYZE_AND_ENSURE_NO_RESULTS_SDK",
            description: "Use SDK as the name or path of the base SDK when building the project",
            optional: true,
            type: String),
          FastlaneCore::ConfigItem.new(key: :static_analyzer,
            env_name: "XCODEBUILD_ANALYZE_AND_ENSURE_NO_RESULTS_STATIC_ANALYZER",
            description: "Run clang static analyzer if true",
            optional: true,
            type: Boolean),
          FastlaneCore::ConfigItem.new(key: :prune_output,
            env_name: 'XCODEBUILD_ANALYZE_AND_ENSURE_NO_RESULTS_PRUNE_OUTPUT',
            description: 'If true remove output dir after analyze',
            optional: true,
            type: Boolean),
          FastlaneCore::ConfigItem.new(key: :output_dir,
            env_name: 'XCODEBUILD_ANALYZE_AND_ENSURE_NO_RESULTS_OUTPUT_DIR',
            description: 'Path to output dir',
            default_value: 'analyze_results',
            optional: true,
            type: String)
        ]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end
    end
  end
end
