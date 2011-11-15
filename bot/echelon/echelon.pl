#!/usr/bin/perl
# - openfly irc bot
# mjoyce@malebolge.org

# Version Number
$version = "0.0.1";

# Print Software information
print "\033[31m echelon\033[0m - $version \nopenfly\@malebolge.org\n\n";

# If Command line Args not Specified.
$ARGC=@ARGV;
if ($ARGC <= 0 ) {
	print ":: Syntax: $0 <server> <port> <channel> <nick> <password> <server db name>\n";
	print ":: Example: perl $0 irc.2600.net 6667 2600 dufus kickme 2600net\n";
	exit;
}

# Hide Command lin Arguments from Process listing
$0 = "echelon";

# Modules to load
use Socket;
use Pg;

# Define IRC Shiznit
$remote  = $ARGV[0];
$port    = $ARGV[1];
$channel = $ARGV[2];
$nick    = $ARGV[3];
$pass 	 = $ARGV[4];
$dbnet   = $ARGV[5];
$process = $pid;


# Start Connection Process
print ":: Attempting to connect to - $remote.\n";
$iaddr = inet_aton($remote) or die "Error: $!";
$paddr = sockaddr_in($port, $iaddr) or die "Error: $!";
$proto = getprotobyname('tcp') or die "Error: $!";

socket(SOCK, PF_INET, SOCK_STREAM, $proto) or die "Error: $!";
connect(SOCK, $paddr) or die "Error: $!";

print ":: Connected. Authenticating with server.\n";

# fork off chatter evalutation process

if ($pid = fork) { print ":: IO Agent Launched PID = $pid\n"; }
  else { wangchung(); exit; }

  # Keep Alive Random Chatter
@haha = ( 
  "...",
);

$temper = $haha[ rand scalar @haha ];

# Random Delay Times

 @timer = (
  2000, 500, 6000, 3000, 4000, 700, 230, 4000, 10000, 4000, 
  9000, 7800, 1000 );

 $times = $timer[ rand scalar @timer ];

# Connection Routine for IRC
sleep(1);
$msg = "USER $nick - - $nick\n"; 
send(SOCK, $msg, 0) or die "Unable to send packet: $!";
sleep(1);
$msg = "NICK $nick\n";
send(SOCK, $msg, 0) or die "Unable to send packet: $!";
sleep(1);
$msg = "JOIN #$channel\n";
send(SOCK, $msg, 0) or die "Unable to send packet: $!";
sleep(1);
while (1) {
$temper = $haha[ rand scalar @haha ];
$msg = "PRIVMSG #$channel :$temper\n";
sleep(5);
for(0 .. $times) {
   $mesg = "JOIN #$nick\n";
   send(SOCK, $mesg, 0) or die "Unable to send packet: $!";
   sleep(30);
}  

# Send Random Chatter
send(SOCK, $msg, 0) or die "Unable to send packet: $!";
sleep(2);
}

# WANGCHUNG OWNS J00 !!!  
##############################
# Evaluating Channel Chatter #
##############################

sub wangchung() {
$spoke = 0;
# Name the Child
$0 = "Echelon - IO Agent";
$chan = $channel;

# Define SQL Shiznit
my $pghost    = "localhost";
my $pgport    = "5432";
my $pgoptions = "";
my $pgtty     = "";
my $dbname    = "echelon";
my $login     = "mjoyce";
my $pwd       = "televizzle";

# connect to database
my $borg = Pg::setdbLogin($pghost, $pgport, $pgoptions, $pgtty, $dbname, $login, $pwd) or die("DB CONNECTION FAILURE");
$borg = Pg::connectdb("dbname=$dbname user=$login") or die("DB CONNECTION FAILURE");
die $borg->errorMessage unless PGRES_CONNECTION_OK eq $borg->status;
	
while (1) {

$inny = <SOCK>;
   chomp $inny;
   ($inny0, $inny1, $inny3, $inny4, $inny5, $inny6, $inny7) = split(/\x20/, $inny);

# initialize variables
my $done = 0;
# print "CHANNEL :: \033[31m$chan\033[0m\n";
my $ignore = 0;
# nick parse... hell lets do nick host and username!
 ($trall0, $trall1) = split(/:/, $inny0);
 ($person, $hostess) = split(/!/, $trall1);
 ($usernome, $host) = split(/@/, $hostess);
 ($trall2, $trall3, $message, $trall5) = split(/:/, $inny);
  
# Fixing for SQL Injection
# quoted_string = $db->quote($unquoted_string);

# Get Current Time Information
	@ctime = localtime (time);
	$cmin = $ctime[1];
# Min
	if ($cmin < 10)
	{
		$pcmin = "0".$cmin;
	}
	else
	{
		$pcmin = $cmin;
	}
	$cmin_upper = $cmin + $trange;
	$cmin_lower = $cmin - $trange;
	$chour = $ctime[2];
# Hour
	if ($chour > 12)
	{
		$chour = $chour - 12;
	}
	$cday = $ctime[3];
# Day of the Month
	if ($cday < 10)
	{
		$cday = "0".$cday;
	}
	$cmonth = $ctime[4];
# Month
	$cmonth += 1;
	$cyear = $ctime[5];
# Year
	$cyear += 1900;
	$cdst = $ctime[8];
# Boolean of Daylight Savings Time
	$cdate = $cmonth."/".$cday."/".$cyear;
    $ctime = $chour.":".$cmin;
	
	$result =
		$borg->exec ("INSERT INTO \"chatter\" (\"date\", \"time\", \"server\", \"network\", \"channel\", \"user\", \"host\", \"message\") values ('$cdate', '$ctime', '$remote', '$dbnet', '$channel', '$person', '$host', '$message');");
        print "\033[31m Inserting -> \033[0m(\033[34m$person\033[0m) : $message\n";
### DEBUG INFORMATION ###
if ($ARGV[4] =~ "DEBUG") {
  print "inny :: \033[37m$inny\033[0m\n";
  print "person :: \033[31m$person\033[0m\n";
  print "pre-host :: \033[31m$hostess\033[0m\n";
  print "username :: \033[31m$usernome\033[0m\n";
  print "host :: \033[31m$host\033[0m\n";
  print "message :: \033[31m$message\033[0m\n";
  print "inny0 :: \033[31m$inny0\033[0m\n";
  print "inny1 :: \033[31m$inny1\033[0m\n";
  print "inny2 :: \033[31m$inny2\033[0m\n";
  print "inny3 :: \033[31m$inny3\033[0m\n";
  print "inny4 :: \033[31m$inny4\033[0m\n";
  print "inny5 :: \033[31m$inny5\033[0m\n";
  print "inny6 :: \033[31m$inny6\033[0m\n";
  print "inny7 :: \033[31m$inny7\033[0m\n";
  print "pass :: \033[31m$pass\033[0m\n";
}

# this is such a pain
if ($trall2 =~ "PING") {
   $mesc = "PONG $trall3\n";
   send(SOCK, $mesc, 0) or warn "Unable to send packet: $!";
   $done = 1;
   print "NYC2600 RFC HACK\n";
}
   
}
  print "SOCK is dead I am OUTTA HERE!\n\n";
}

############
# END CODE #
############
