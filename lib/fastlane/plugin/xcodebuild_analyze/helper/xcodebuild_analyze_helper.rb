require 'fastlane'

class XcodebuildAnalyzeConfiguration
  attr_accessor :workspace
  attr_accessor :project
  attr_accessor :scheme
  attr_accessor :sdk
  attr_accessor :output
  attr_accessor :output_dir
  attr_accessor :static_analyzer

  def initialize(dictionary)
    @workspace = dictionary[:workspace]
    @project = dictionary[:project]
    @scheme = dictionary[:scheme]
    @sdk = dictionary[:sdk]
    @output = dictionary[:output]
    @output_dir = dictionary[:output_dir]
    @static_analyzer = dictionary[:static_analyzer]
  end
end

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class XcodebuildAnalyzeHelper
      def self.parse_configuration(params)
        XcodebuildAnalyzeConfiguration.new(params.values)
      end

      def self.run_analyzer(configuration)
        workspace_path = configuration.workspace
        workspace_provided = !workspace_path.nil?
        workspace_path ||= Dir["*.xcworkspace"].first
        project_path = configuration.project
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

        if configuration.scheme
          cmd << "-scheme"
          cmd << configuration.scheme
        end

        if configuration.sdk
          cmd << "-sdk"
          cmd << configuration.sdk
        end

        output = configuration.output
        output_dir = configuration.output_dir
        static_analyzer = configuration.static_analyzer
        cmd << "CLANG_ANALYZER_OTHER_FLAGS=" unless output.nil? && output_dir.nil? && static_analyzer.nil?
        cmd << "CLANG_ANALYZER_OUTPUT=#{output}" unless output.nil?
        cmd << "CLANG_ANALYZER_OUTPUT_DIR=#{output_dir}" unless output_dir.nil?
        cmd << "RUN_CLANG_STATIC_ANALYZER=#{static_analyzer ? 'YES' : 'NO'}" unless static_analyzer.nil?

        cmd << "analyze"
        Actions.sh(cmd.join(' '))
      end
    end
  end
end
