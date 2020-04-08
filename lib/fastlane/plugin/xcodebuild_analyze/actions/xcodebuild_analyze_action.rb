require 'fastlane'
require_relative '../helper/xcodebuild_analyze_helper'

module Fastlane
  module Actions
    class XcodebuildAnalyzeAction < Action
      def self.run(params)
        workspace_path = params[:workspace]
        workspace_provided = !workspace_path.nil?
        workspace_path ||= Dir["*.xcworkspace"].first
        project_path = params[:project]
        project_provided = !project_path.nil?
        project_path ||= Dir["*.xcodeproj"].first

        cmd = []
        cmd << "xcodebuild"
        if workspace_path && (workspace_provided || (!workspace_provided && !project_provided))
          cmd << "-workspace"
          cmd << workspace_path
        elsif project_path
          cmd << "-project"
          cmd << project_path
        else
          UI.user_error!("Workspace or project not found, pass workspace or project path to action!")
        end

        scheme = params[:scheme]
        if scheme
          cmd << "-scheme"
          cmd << scheme
        end

        sdk = params[:sdk]
        if sdk
          cmd << "-sdk"
          cmd << sdk
        end

        output = params[:output]
        output_dir = params[:output_dir]
        static_analyzer = params[:static_analyzer]
        cmd << "CLANG_ANALYZER_OTHER_FLAGS=" unless output.nil? && output_dir.nil? && static_analyzer.nil?
        cmd << "CLANG_ANALYZER_OUTPUT=#{params[:output]}" unless output.nil?
        cmd << "CLANG_ANALYZER_OUTPUT_DIR=#{output_dir}" unless output_dir.nil?
        cmd << "RUN_CLANG_STATIC_ANALYZER=#{static_analyzer ? 'YES' : 'NO'}" unless static_analyzer.nil?

        cmd << "analyze"
        Actions.sh(cmd.join(' '))
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
            description: "Project (.xcodeproj) file to use to analyze app (automatically detected in current directory, overridden by --workspace option, if passed)",
            optional: true,
            type: String),
          FastlaneCore::ConfigItem.new(key: :configuration,
            env_name: "XCODEBUILD_ANALYZE_CONFIGURATION",
            description: "Configuration used to build",
            optional: true,
            type: String),
          FastlaneCore::ConfigItem.new(key: :scheme,
            env_name: "XCODEBUILD_ANALYZE_SCHEME",
            description: "Scheme used to build app",
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
            description: '- separated list of file output format (default: plist-html)',
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
