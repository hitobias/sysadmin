#!/usr/local/rvm/rubies/ruby-2.0.0-p195/bin/ruby

# when main partition used more than 50%, delete the old backup files

class DiskManager
	@@MAX_USED = 40
	attr_accessor :disk_used

	def initialize
		dfstr = `df -alh`
		@disk_used = dfstr.split("\n")[1].split(/\s+/)[4].split("%")[0].to_i
	end

	def monitor_disk_used
		if @disk_used > @@MAX_USED
			true
		else
			false
		end
	end

	def delete_old_backup_files
		month_now = Time.new.month
		month_str = (month_now - 2) < 10 ? "0" + (month_now - 2).to_s : (month_now - 2).to_s
		delete_files = Array.new
		delete_files.push("\/home\/backup\/www.luke54.org\/website\/www.luke54.org_" + month_str + "*")
		delete_files.push("\/home\/backup\/www.luke54.org\/db\/luke54org_db_backup_" + month_str + "*")
		delete_files.push("\/home\/backup\/www.fttt-dt.org\/website\/fttt-dt.org_backup_" + month_str + "*")
		delete_files.push("\/home\/backup\/www.fttt-dt.org\/db\/ftttdt_db_backup_" + month_str + "*")
		delete_files.push("\/home\/backup\/www.fttt-dt.org\/db\/moodle_db_backup_" + month_str + "*")
#		`rm -rf #{delete_files}`
#		p delete_files
		delete_files.each { |f| `rm -f #{f}`}
	end
end

df = DiskManager.new

if df.monitor_disk_used
	df.delete_old_backup_files
end