desc 'Run iOS tests'
task :ios , :location do |t, args|
  location_helper args[:location]
  Dir.chdir 'iOS'
  exec 'rspec'
end

desc 'Run Android tests'
task :android, :location do |t, args|
  location_helper args[:location]
  Dir.chdir 'android'
  exec 'rspec'
end

def location_helper(location)
  if location != 'sauce'
    ENV['SAUCE_USERNAME'], ENV['SAUCE_ACCESS_KEY'] = nil, nil
  end
end
