class String
  def self.colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def cyan
    self.class.colorize(self, 36)
  end

  def green
    self.class.colorize(self, 32)
  end
end

desc 'CocoaPod related'
task :pod_install do
  puts 'Installing pods...'.cyan
  `pod install`
end

desc 'Setup with example files'
task :setup => :pod_install do
  # Copy examples defines
  puts 'Copying example PXDefines into place...'.cyan
  `cp Pixnetr/PXDefinesExample.h Pixnetr/PXDefines.h`
  `cp Pixnetr/PXDefinesExample.m Pixnetr/PXDefines.m`

  # Done!
  puts 'Done! You\'re ready to get started!'.green
end

# Run setup by default
task :default => :setup
