#!/usr/bin/perl
# - openfly irc bot

# use shit
use lib '/home/mjoyce/lib';

use Parse::IRCLog;
use Socket;
use strict;
use Net::Tor::Servers;

# version
my $version = "2.0-alpha";
print  " openfly $version - \"now with \033[31ms\033[34mp\033[33mr\033[32mi\033[31mn\033[34mk\033[33ml\033[32me\033[0m power!\"\n";

# help text
my $ARGC=@ARGV;
if ($ARGC <= 0 ) {
	print ":: Syntax: $0 <server> <port> <channel> <irc log> <number of bots>\n";
	print ":: Example: perl $0 irc.2600.net 6667 2600 irc-2600-04232004.log 20\n";
	exit;
}

# initialize
$0 = "openfly";
$| = 1;
my %nickchain    = ();
my $nickchainref = 0;
my $botcounter = 0;
my $nickcollision = 0;
my @SOCK;
my $nickin;     my $iaddr;
my $textin;     my $paddr;
my $timein;     my $proto;
my $botnum;
my $resnichk;
my $checkres;
my $lasttime = 0;
# read in cla
my $remote  = $ARGV[0];
my $port    = $ARGV[1];
my $channel = $ARGV[2];
my $irclog  = $ARGV[3];
my $botmax  = $ARGV[4];

###########################
# irclog parsing
print ":: Parsing irc log... \n";

my $result = Parse::IRCLog->parse($irclog) ;
my %reaped = ( msg => 1, action => 1 );

for ($result->events) {
  next unless $reaped{ $_->{type} };
  $nickin = $_->{nick} ;
  $textin = $_->{text} ;
  $timein = $_->{timestamp} ;
  my ($minutes , $seconds) = split(/:/,$timein);
  my $timestmp = ($minutes * 60) + $seconds;
  my $wait = $timestmp - $lasttime;
  $lasttime = $timestmp;
  $resnichk    = checkn($nickin);
  sleep($wait);
  my $smachk   = writetobot ($resnichk, $timein, $textin) ;
}

# check nick against nickchain and enter if not there
sub checkn($nickin) {
  my $nickcollision = 2;
  # check nick against hash for corresponding botnumber
  while ( my ($key, $value) = each(%nickchain) ) {
    if ($value eq $nickin) {
      $nickcollision = 1;
      $checkres = $key;
    }
  }
  # if there is no collision enter the nick into the hash 
  if ($nickcollision == 2) {     
    $nickchain {  $botcounter } = $nickin ; 
    $checkres = $botcounter;
    print ":: calling connect for bot-$checkres\n";
    irc_connect($checkres);
    $botcounter++;
  }
  return $checkres; 
}

#write to channel using bots...
sub writetobot ($resnichk, $timein, $textin, $nickin) {
  
  my $ircmsg = "PRIVMSG #$channel :$textin\n";
  send($SOCK[ $resnichk ], $ircmsg, 0)   

}

#############################
# connect to irc server
sub irc_connect($checkres) {
  my $botnum = $checkres;
  # initialize function
  my $msg;
  my $nick = $nickchain{ $botnum };

  print ":: bot-$botnum connecting to $remote:$port as $nick to server...\n";
  # initiate socket connect
  $iaddr = inet_aton($remote) ;
  $paddr = sockaddr_in($port, $iaddr) ;
  $proto = getprotobyname('tcp') ;
  # connect
  socket($SOCK[ $botnum ], PF_INET, SOCK_STREAM, $proto) || die "connect: $!" ;
  connect($SOCK[ $botnum ], $paddr) || die "connect: $!";

  # fork live irc parser
  if (my $pid = fork) { print ":: bot $botnum spun as pid ( $pid )\n"; }
  else { botspin($botnum); exit; }

  # negotiate with IRC server
  sleep(1);
  $msg = "USER $nick - - $nick\n";
  send($SOCK[ $botnum ], $msg, 0)  || die "send: $!";
  sleep(1);
  $msg = "NICK $nick\n";
  send($SOCK[ $botnum ], $msg, 0) || die "send: $!";
  sleep(1);
  $msg = "PONG $nick\n";
  send($SOCK[ $botnum ], $msg, 0) || die "send: $!";
  sleep(1);
  print ":: bot-$botnum ( $nick ) joining #$channel...\n";
  $msg = "JOIN #$channel\n";
  send($SOCK[ $botnum ], $msg, 0)  || die "send: $!";
  sleep(1);

  return 0;

}

############################
# bot specific code
sub botspin($botnum) {
  while(1) {
    $0 = "bot-$botnum";
    # begin read of irc stream
    my $SOCKIN = <$SOCK[ $botnum ]>;  
    chomp $SOCKIN;
  }
   
}
