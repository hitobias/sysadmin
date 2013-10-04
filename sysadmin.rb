#!/usr/local/rvm/rubies/ruby-2.0.0-p195/bin/ruby

require_relative 'disk.rb'
# when main partition used more than 50%, delete the old backup files

df = DiskManager.new

if df.monitor_disk_used
	df.delete_old_backup_files
end