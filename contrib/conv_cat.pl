#!/usr/bin/perl

print "// WARNING: this is an autogenerated file. Any change might be overwritten!\n";
use strict;
my %grps, my %secs;
$grps{"ANY"} = '';

for(<>)
{
	chomp;
	(my $sec, my $pred) = split(/,/);
	next if $sec eq "GTK" or $sec eq "Qt" or $sec eq "GNOME" or $sec eq "KDE" or $sec eq "XFCE" or $sec eq "Java" or $sec eq "ConsoleOnly";
	my $key = $pred;
	$key=~ s/\W//g;
	$key = "ANY" if(!$key);
	$secs{$sec}=$key;
	if($key && !defined($grps{$key}))
	{
		$pred=~s/ or /", "|", "/g;
		$pred=~s/;/", "/g;
		$grps{$key}=$pred;
	}

}

print "LPCSTR $_\[\] = { \"$grps{$_}\", \"|\", NULL };\n" for(sort keys %grps);
# start of the list, the end of the list are 
print <<LSTART

namespace spec {

tListMeta menuinfo[] =
{
    { N_("Accessibility"),"Accessibility", NULL, NULL},
    { N_("Settings"),"Settings", NULL, NULL},
    { N_("Screensavers"),"Screensavers", NULL, NULL},
    { N_("Accessories"),"Accessories", NULL, NULL},
    { N_("Development"),"Development", NULL, NULL},
    { N_("Education"),"Education", NULL, NULL},
    { N_("Game"),"Game", NULL, NULL},
    { N_("Graphics"),"Graphics", NULL, NULL},
    { N_("Multimedia"),"Multimedia", NULL, NULL},
    { N_("Audio"),"Audio", NULL, NULL},
    { N_("Video"),"Video", NULL, NULL},
    { N_("AudioVideo"),"AudioVideo", NULL, NULL},
    { N_("Network"),"Network", NULL, NULL},
    { N_("Office"),"Office", NULL, NULL},
    { N_("Science"),"Science", NULL, NULL},
    { N_("System"),"System", NULL, NULL},
    { N_("WINE"),"WINE", NULL, NULL},
    { N_("Editors"),"Editors", NULL, NULL},
    { N_("Utility"),"Utility", NULL, NULL},
    { N_("Other"), "Other", NULL, NULL },
LSTART
;

my @cats = sort(keys %secs);
for(@cats)
{
	my $ptr = "(char**) &$secs{$_}";
	print "// TRANSLATORS: This is a menu category name, please add spaces as needed but no quotes or double-quotes.\n";
	print "    { N_(\"$_\"), \"$_\", NULL, $ptr}";
	print $_ eq $cats[-1] ? "\n" : ",\n";
}
print "};
}
";