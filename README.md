# device_image_selector plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-device_image_selector)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-device_image_selector`, add it to your project by running:

```bash
fastlane add_plugin device_image_selector
```

## About device_image_selector

After creating hundreds of screenshots for the AppStore you probably want to use only a few of them with device frames, i.e. to put them on your website. Instead of running 'frameit' on the whole screenshots directory this plugin selects only the screenshots you want to use and puts them into the output directory. Running 'frameit' on that directory produces the device images. After that, the screenshot files can automatically be deleted by running the cleanup action. So the Fastfile may look like this:

    
    desc "Generate device images"
    lane :device_images do
      device_image_selector(name_prefixes: ["iPhone X","iPad Pro (12.9-inch)"])
      frame_screenshots(path: "fastlane/screenshots/device_images")
      device_image_selector_cleanup
    end

## Actions
### device_image_selector
Selects only the screenshot files which matches the specified name prefixes and copys them into the output directory.

    # iPhone X screenshots only
    device_image_selector(name_prefixes: "iPhone X")   

    # iPhone 8 Plus and iPad Pro (9.7-inch) screenshots
    device_image_selector(name_prefixes: ["iPhone 8 Plus","iPad Pro (9.7-inch)"])

    # specify the screenshots directory (default: ./fastlane/screenshots)
    device_image_selector(screenshot_directory: "path/to/screenshots",  name_prefixes: "iPhone X")   

    # specify the output directory (default: ./fastlane/screenshots/device_images)
    device_image_selector(output_directory: "~/device_images",  name_prefixes: "iPhone X")       



### device_image_selector_cleanup
Cleans up the output directory by deleting the previously selected screenshot files. This leaves only the generated device images in the output directory.

    # cleanup after the device images are created
    device_image_selector_cleanup


## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
