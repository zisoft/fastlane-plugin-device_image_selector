require 'fastlane/action'
require_relative '../helper/device_image_selector_helper'

module Fastlane
  module Actions
    module SharedValues
      DEVICE_IMAGE_SELECTOR_FILES = :DEVICE_IMAGE_SELECTOR_FILES
    end
    
    class DeviceImageSelectorAction < Action
      def self.run(params)
        Dir.mkdir(params[:output_directory]) unless Dir.exists?(params[:output_directory])
        
        files = []

        Dir.entries(params[:screenshot_directory]).each do |entry|
          next if entry == "." || entry == ".."
          input_dir = params[:screenshot_directory] + "/#{entry}"
          next unless File.directory?(input_dir)
          next if input_dir == params[:output_directory]

          output_dir = "#{params[:output_directory]}/#{entry}"
          Dir.mkdir(output_dir) unless Dir.exists?(output_dir)

          Dir.entries(input_dir).each do |filename|
            next if filename == "." || filename == ".."

            use_this = false
            params[:name_prefixes].each do |name_prefix|
              if filename.start_with?(name_prefix)
                use_this = true
                break
              end
            end
            next unless use_this

            FileUtils.copy("#{input_dir}/#{filename}","#{output_dir}/#{filename}")

            files << "#{output_dir}/#{filename}"
          end
        end

        Actions.lane_context[SharedValues::DEVICE_IMAGE_SELECTOR_FILES] = files.join(",")
      end

      def self.description
        "Selects screenshots with specified names for processing with frameit"
      end

      def self.authors
        ["Mario Zimmermann"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.output
        [
          ["DEVICE_IMAGE_SELECTOR_FILES", "Comma separated list of selected screenshot files"]
        ]
      end

      def self.details
        # Optional:
        "Takes the device screenshots which match the specified names and puts them in the output directory for frameit to process. The screenshot files can then be cleaned up after the device images are created."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :screenshot_directory,
                                  env_name: "DEVICE_IMAGE_SELECTOR_SCREENSHOT_DIRECTORY",
                               description: "Directory where the screenshots are located",
                                  optional: false,
                             default_value: "./fastlane/screenshots",
                                      type: String),

          FastlaneCore::ConfigItem.new(key: :output_directory,
                                  env_name: "DEVICE_IMAGE_SELECTOR_OUTPUT_DIRECTORY",
                               description: "Directory where to put the selected screenshots",
                                  optional: false,
                             default_value: "./fastlane/screenshots/device_images",
                                      type: String),

          FastlaneCore::ConfigItem.new(key: :name_prefixes,
                                  env_name: "DEVICE_IMAGE_SELECTOR_NAME_PREFIXES",
                               description: "Array of filename prefixes to select",
                                  optional: true,
                                      type: Array)
        ]
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
