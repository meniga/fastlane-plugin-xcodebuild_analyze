describe Fastlane::Actions::XcodebuildAnalyzeAction do
  describe 'xcodebuild analyze' do
    it 'should fail when workspace nor project provided and xcodeproj and xcworkspace are not in current directory' do
      expect(Fastlane::UI)
        .to receive(:user_error!)
        .with("Workspace or project not found, pass workspace or project path to action!")

      Fastlane::FastFile.new.parse("lane :test do
        xcodebuild_analyze(scheme: 'Meniga')
      end").runner.execute(:test)
    end

    it 'should run xcodebuild with proper -scheme when scheme providev' do
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("xcodebuild -project Meniga.xcodeproj -scheme Wrapp analyze")

      Fastlane::FastFile.new.parse("lane :test do
        xcodebuild_analyze(project: 'Meniga.xcodeproj', scheme: 'Wrapp')
      end").runner.execute(:test)
    end

    it 'should run xcodebuild with -sdk when sdk provided' do
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("xcodebuild -project Meniga.xcodeproj -scheme Meniga -sdk iphonesimulator analyze")

      Fastlane::FastFile.new.parse("lane :test do
        xcodebuild_analyze(project: 'Meniga.xcodeproj', scheme: 'Meniga', sdk: 'iphonesimulator')
      end").runner.execute(:test)
    end

    it 'should run xcodebuild with proper output when output provided' do
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("xcodebuild -project Meniga.xcodeproj -scheme Meniga CLANG_ANALYZER_OTHER_FLAGS= CLANG_ANALYZER_OUTPUT=html analyze")

      Fastlane::FastFile.new.parse("lane :test do
        xcodebuild_analyze(project: 'Meniga.xcodeproj', scheme: 'Meniga', output: 'html')
      end").runner.execute(:test)
    end

    it 'should run xcodebuild with output dir when output dir provided' do
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("xcodebuild -project Meniga.xcodeproj -scheme Meniga CLANG_ANALYZER_OTHER_FLAGS= CLANG_ANALYZER_OUTPUT_DIR=path/tmp analyze")

      Fastlane::FastFile.new.parse("lane :test do
        xcodebuild_analyze(project: 'Meniga.xcodeproj', scheme: 'Meniga', output_dir: 'path/tmp')
      end").runner.execute(:test)
    end

    it 'should run xcodebuild with static analyzer when static_analyzer is true' do
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("xcodebuild -project Meniga.xcodeproj -scheme Meniga CLANG_ANALYZER_OTHER_FLAGS= RUN_CLANG_STATIC_ANALYZER=YES analyze")

      Fastlane::FastFile.new.parse("lane :test do
        xcodebuild_analyze(project: 'Meniga.xcodeproj', scheme: 'Meniga', static_analyzer: true)
      end").runner.execute(:test)
    end

    it 'should run xcodebuild with static analyzer set to NO when static_analyzer is false' do
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("xcodebuild -project Meniga.xcodeproj -scheme Meniga CLANG_ANALYZER_OTHER_FLAGS= RUN_CLANG_STATIC_ANALYZER=NO analyze")

      Fastlane::FastFile.new.parse("lane :test do
        xcodebuild_analyze(project: 'Meniga.xcodeproj', scheme: 'Meniga', static_analyzer: false)
      end").runner.execute(:test)
    end
  end
end
