begin
  require 'rubygems'
  # paths = `gemset debug ruby -e 'puts Gem.path'`.lines.collect(&:chop)
  # Gem.path.concat paths
  # Gem.refresh
  require "pry"
  Pry.start
  exit
rescue LoadError => e
  warn "=> Unable to load pry"
end
