# Please note that this repository is not maintained anymore and will be made private to Meniga no later than on 31 december 2023. It is suggested that those using this repository will either fork it or find another tool that provides the same functionality

# xcodebuild_analyze plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-xcodebuild_analyze)
![Test](https://github.com/meniga/fastlane-plugin-xcodebuild_analyze/workflows/Test/badge.svg)
[![codecov](https://codecov.io/gh/meniga/fastlane-plugin-xcodebuild_analyze/branch/master/graph/badge.svg)](https://codecov.io/gh/meniga/fastlane-plugin-xcodebuild_analyze)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-xcodebuild_analyze`, add it to your project by running:

```bash
fastlane add_plugin xcodebuild_analyze
```

## About xcodebuild_analyze

Run code analyzer using xcodebuild

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and check available lanes in `Fastfile`.

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
