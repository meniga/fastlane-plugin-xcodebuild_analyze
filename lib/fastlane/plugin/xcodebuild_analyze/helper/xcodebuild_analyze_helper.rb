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

      def self.run_analyzer(configuration, other_action)
        workspace_path = "../#{configuration.workspace}" unless configuration.workspace.nil?
        project_path = "../#{configuration.project}" unless configuration.project.nil?

        xcargs = []
        output = configuration.output
        output_dir = configuration.output_dir
        static_analyzer = configuration.static_analyzer
        xcargs << "CLANG_ANALYZER_OTHER_FLAGS=" unless output.nil? && output_dir.nil? && static_analyzer.nil?
        xcargs << "CLANG_ANALYZER_OUTPUT=#{output}" unless output.nil?
        xcargs << "CLANG_ANALYZER_OUTPUT_DIR=#{output_dir}" unless output_dir.nil?
        xcargs << "RUN_CLANG_STATIC_ANALYZER=#{static_analyzer ? 'YES' : 'NO'}" unless static_analyzer.nil?

        other_action.xcodebuild(
          workspace: workspace_path,
          project: project_path,
          scheme: configuration.scheme,
          sdk: configuration.sdk,
          analyze: true,
          xcargs: xcargs.join(' ')
        )
      end
    end
  end
end
