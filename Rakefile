$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
Bundler.require

require 'bubble-wrap/ui'
require 'bubble-wrap/http'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Sugart Tweets'

  app.files += Dir.glob(File.join(app.project_dir, 'styles/**/*.rb'))
  app.files += Dir.glob(File.join(app.project_dir, 'lib/**/*.rb'))
end
