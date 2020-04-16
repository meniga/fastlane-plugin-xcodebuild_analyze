require 'fastlane'
require_relative '../helper/xcodebuild_analyze_helper'

module Fastlane
  module Actions
    class XcodebuildAnalyzeAction < Action
      def self.run(params)
        configuration = Helper::XcodebuildAnalyzeHelper.parse_configuration(params)
        Helper::XcodebuildAnalyzeHelper.run_analyzer(configuration, other_action)
      end

      def self.category
        :building
      end

      def self.description
        "Run code analyzer using xcodebuild"
      end

      def self.authors
        ["Marcin Stepnowski"]
      end

      def self.example_code
        [
          "
          xcodebuild_analyze(project: 'Meniga.xcodeproj',
                            scheme: 'Release',
                            sdk: 'iphonesimulator'
                            output_dir: 'tmp',
                            output: 'html',
                            static_analyzer: true)
          "
        ]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :workspace,
            env_name: "XCODEBUILD_ANALYZE_WORKSPACE",
            description: "WORKSPACE Workspace (.xcworkspace) file to use to analyze app (automatically detected in current directory)",
            optional: true,
            type: String),
          FastlaneCore::ConfigItem.new(key: :project,
            env_name: "XCODEBUILD_ANALYZE_PROJECT",
            description: "Project (.xcodeproj) file to use to analyze app (overridden by --workspace option, if passed)",
            optional: true,
            type: String),
          FastlaneCore::ConfigItem.new(key: :configuration,
            env_name: "XCODEBUILD_ANALYZE_CONFIGURATION",
            description: "Configuration used to analyze",
            optional: true,
            type: String),
          FastlaneCore::ConfigItem.new(key: :scheme,
            env_name: "XCODEBUILD_ANALYZE_SCHEME",
            description: "Scheme used to analyze app",
            optional: false,
            type: String),
          FastlaneCore::ConfigItem.new(key: :sdk,
            env_name: "XCODEBUILD_ANALYZE_SDK",
            description: "Use SDK as the name or path of the base SDK when building the project",
            optional: true,
            type: String),
          FastlaneCore::ConfigItem.new(key: :static_analyzer,
            env_name: "XCODEBUILD_ANALYZE_STATIC_ANALYZER",
            description: "Run clang static analyzer if true",
            optional: true,
            type: Boolean),
          FastlaneCore::ConfigItem.new(key: :output,
            env_name: 'XCODEBUILD_ANALYZE_OUTPUT',
            description: 'List of file output formats separated by -',
            optional: true,
            type: String),
          FastlaneCore::ConfigItem.new(key: :output_dir,
            env_name: 'XCODEBUILD_ANALYZE_OUTPUT_DIR',
            description: 'Path to output dir',
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
