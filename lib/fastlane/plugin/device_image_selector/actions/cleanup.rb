require 'fastlane/action'
require_relative '../helper/device_image_selector_helper'

module Fastlane
  module Actions
    class DeviceImageSelectorCleanupAction < Action
      def self.run(params)
        UI.message("Cleaning up device images...")

        Actions.lane_context[SharedValues::DEVICE_IMAGE_SELECTOR_FILES].split(",").each do |file|
          File.delete(file)
        end
      end

      def self.description
        "Cleanup screenshot files after frameit"
      end

      def self.authors
        ["Mario Zimmermann"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Deletes the screenshot files in the output directory which were previously selected and processed by frameit"
      end

      def self.available_options
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
