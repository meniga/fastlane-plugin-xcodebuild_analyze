require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class XcodebuildAnalyzeHelper
      # class methods that you define here become available in your action
      # as `Helper::XcodebuildAnalyzeHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the xcodebuild_analyze plugin helper!")
      end
    end
  end
end
