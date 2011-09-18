I'm always using the "Hold for Developer Release" method for my apps. Sadly, this is the one case where Apple won't send me an email to let me know :( So I had to be creative.

How to use this?
===============
First of all, you'll need "mechanize". Install with "gem install mechanize".

At the same level as itc.rb, you should have a file called "itc-pwd.rb" (or whatever, wherever, but then change the first "require") containing those lines: 

USERNAME = "foo"        ==> Your iTunes Connect Username
PASSWORD = "bar"        ==> Your iTunes Connect Password
APP      = "Disk Alarm" ==> This is the App we should check

You shouldn't -- in most case -- have to modify itc.rb

Now go in the Terminal, where itc.rb is and type

chmod u+x itc.rb

Now type "./itc.rb" which will launch the script in an endless loop. To quit the app, use "Ctrl C" twice.

The first time, the app will create a "YOUR APP.txt" file with the status ("Waiting for Review" for ex.)

As soon as this status changes, the app will display a message, make beeps, and speak the message.

It will *repeat* this in a loop ;-) until you break and restart the script. This is to ensure the "It's okay, I'll do something" factor! You basically start the script once per Status change.

PS: Obviously, this is a *very* basic solution, but for now, it's enough for me ;) Feel free to fork me!