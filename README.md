7he-Alan-P4rs0ns-Project
========================

Sharks with friggin lazers! This is the repo we will use to collaborate on creating the Metasploit module for the applicaiton whitelisting bypassing.

I would like to keep this in line with the Veil Project Teams solution. There could be possible integartion at some level someday. that would probably make it easier. 

https://github.com/Veil-Framework/


The date goal will be in time to submit the release talk at Derbycon 2014 and/or SecTor 2014.

As a note to any public viewers of this repository, we will not be sharing the code/details with the public until proper disclosure happens fullly. We are shooting for the end of April or early May. If you look at the features below, you may notice some new items on the list that werent discussed. Some of those we forgot about or didn't have time to fully test and some are new ideas that look succesful in some testing so far!

The feature goals will include items from the last talk and this talk and any new items possibly found before then. here is a list (I may be missing some). Feel free to start. I'm adding the module I created for last time to this repo as the first plugin. 


-OS verion configuartion

-Whitelisting Vendor choice and version

-Maybe a hail mary option autopwn style!

-Windows File Protection Tricks

-Java Exploits

-Java Payloads

-Iexpress check

-Adobe Flash and PDF

-Javascript

-VBA 

-Shellcode

-MITM with ARP poision, and a valid SSL CERT (maybe a choice to spawn Burp if they want)

-DLL Highjacking

-Watering hole attack ala SET integration

-Executable File Type Modifications

-Dynamic Annotation Tricks

-Microoft WinHTTP (WinRM)

-Service and file SUID modification tricks

-EXE in jpg after the footer. or out of bounds for RFC standard file types (New idea)

-ROP

-create a user spawn a memory module then remove the user to see if Bit9 respects the actual SID or bails if it's generic (new Idea)
-kick off new rundll32.exe with NULL Security ID (S-1-0-0) this should give full access to the system (new idea)

-Mac client (Hopefully if we can find a trail version of 7.4.1 somewhere)

-HTML5 voice control to execute entrusted binary - possible speech to text and other HTML5 goodies

-HASH collisions (new idea)

-Trused directory abuse (trying %netlogon%, SCCM/SMS directories, BigFix Directories, pull trusted publishers and trusted directory with MITM module and try to masquerade as another cert or find other possible directorys that are trusted.

-Chris John Riley's PYC fork (Thanks Chris!)

And maybe more!


