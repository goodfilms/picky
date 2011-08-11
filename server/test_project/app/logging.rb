# Standard logging.
#
# require 'logger'
# Picky.logger = Logger.new(File.expand_path('log/search.log', PICKY_ROOT))

# Example with using the syslog logger.
# Falling back to the standard log if it isn't available.
# (For example, because it is used locally and syslog is
# only available on the servers)
#
# begin
#   log_program_name = 'search/query'
#   Picky.logger    = SyslogLogger.new log_program_name
#   puts "Logging on syslog #{log_program_name}."
# rescue StandardError
#   warn "Could not connect to the syslog, using the normal log."
#   require 'logger'
#   Picky.logger = Logger.new(File.join(PICKY_ROOT, 'log/search.log'))
# end
