#!/usr/bin/env perl

###################################################################
# Script para facilitar o uso dos parser gerados polo compilador compi-beta.
#   - - A variábel DEPPATTERN_DIR estabelece o PATH dos programas.
#   - - O sistema inclui o PoS tagger CitiusTools
#
# Pablo Gamallo
# Grupo ProLNat@GE
###################################################################


use strict;
use warnings;
use File::Basename;
use lib ".";

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';
use utf8;
use lib dirname(__FILE__);

push @ARGV, "-h" if $#ARGV < 0;

#Linguakit dependencies
push(@INC, dirname(__FILE__)."/lib");
my $deps = 1;
if (!eval{require Getopt::ArgParse;}){
	warn "Please install Getopt::ArgParse module: cpan Getopt::ArgParse\n";
	$deps = 0;
}
if (!eval{require Storable;}){
	warn "Please install Storable module: cpan Storable\n";
	$deps = 0;
}
exit 1 if !$deps;


#Custom text
my $name = "deppattern";
my $shortDescription = "";
my $longDescription = "";
my $foot = "";
my $errorPrint = "$name: ";

my $parser = Getopt::ArgParse -> new_parser( prog => $name, help => $shortDescription, description => $longDescription, epilog => $foot, error_prefix  => $errorPrint);

#Arguments
$parser->add_argument('lang', type => 'Scalar', dest => 'lang', required => 1, metavar => "<lang>", help => "Choose the language", choices_i => ["en", "es", "gl", "pt", "fr"]);
$parser->add_argument('-c', type => 'Bool', dest => 'c', help => "Tagged text with syntactic information (for correction rules)");
$parser->add_argument('-fa', type => 'Bool', dest => 'fa', help => "Full dependency analysis");
$parser->add_argument('-conll', type => 'Bool', dest => 'conll', help => "Full dependency analysis with CoNLL format");
$parser->add_argument('-a', type => 'Bool', dest => 'a', help => "Simple dependency analysis");
$parser->add_argument('-f', '--file', type => 'Scalar',  dest => 'file', metavar => "<file>", help => "Path of the file input (default stdin)");
$parser->add_argument('-p', '--parser', type => 'Scalar',  dest => 'parser', metavar => "<parser>", help => "Path of the parser, or name of the parser generated from grammar (i.e. metaromance)");
$parser->add_argument('-ng', '--no-iteration-grammar', type => 'Scalar',  dest => 'ngrammar', metavar => "<grammar>", help => "Path of the file grammar (without iterations)");
$parser->add_argument('-g', '--grammar', type => 'Scalar',  dest => 'grammar', metavar => "<grammar>", help => "Path of the file grammar (with iterations)");
$parser->add_argument('-m', '--meta-romance', type => 'Bool', dest => 'meta', help => "MetaRomance Parser");

my $args = $parser->parse_args();


############################
# Config
############################

my $LING = $args->get_attr("lang");
my $FILE = $args->get_attr("file");
my $PARSER = $args->get_attr("parser");
my $GRAMMAR = $args->get_attr("grammar") // $args->get_attr("ngrammar");
my $ITERATIONS = $args->get_attr("grammar");
my $META = $args->get_attr("meta");

my $MAIN_DIR = dirname(__FILE__);

my $TOOLS = "$MAIN_DIR/CitiusTools";
my $PROGS = "$MAIN_DIR/scripts";
my $DIRPARSER="$MAIN_DIR/parsers";

unshift(@INC, $TOOLS);
unshift(@INC, $PROGS);


my $SENT   = "${LING}/sentences-${LING}_exe.perl"; 
my $TOK    = "${LING}/tokens-${LING}_exe.perl";
my $SPLIT  = "${LING}/splitter-${LING}_exe.perl";
my $NER    = "${LING}/ner-${LING}_exe.perl";
my $TAGGER = "${LING}/tagger-${LING}_exe.perl";

my $FILTER = "AdapterFreeling-${LING}.perl";
my $CONLL  = "saidaCoNLL-fa.perl";


#######################
#      EXECUTION      #
#######################
my $input;
if($FILE){
	open ($input, '<', $FILE) or die("'$FILE' not found.");
	binmode $input, ':utf8';
}else{
	$input = \*STDIN;
}


##Compilar si hay gramática
if ($GRAMMAR){
	use File::Spec;
	use Cwd 'abs_path';
	my $path_ruby = File::Spec->catfile(abs_path($MAIN_DIR), "compi-beta.rb");
	my $dependencies;
	my $it = $ITERATIONS ? "ON" : "OFF";
	$PARSER = $PARSER ? $PARSER : "parser.perl";

	if($META){
	    $dependencies = "grammars/MetaRomance";
	}else{
	     #$dependencies = "grammars/grammar-devel-".$LING;
	    ($dependencies) = ($GRAMMAR =~ /^(.+)\/.+$/);
	}

	system("ruby \"$path_ruby\" \"$dependencies\" \"$GRAMMAR\" $it \"$PARSER\"");
}
#Cogemos el parser correspondiente al idioma
elsif (!$PARSER && !$META){
	$PARSER = "$DIRPARSER/parserDefault-${LING}.perl";
}
elsif ($META){
    $PARSER = "$DIRPARSER/parserDefault-metaromance.perl";
}
$PARSER .= ".perl" if $PARSER !~ /\.perl$/;

my $mode = ($args->conll ? "-conll" : ($args->fa ? "-fa" : ($args->c ? "-c" : ($args->a ? "-a" : ""))));

if($mode){
	if(! -e $PARSER){
		die("'$PARSER' not found.")
	}

	do $SENT;
	do $TOK;
	do $SPLIT;
	do $NER;
	do $TAGGER;
	do $FILTER;
	do $PARSER;

	if ($mode ne "-conll") {
		while(my $line = <$input>){
			my $list = Parser::parse(AdapterFreeling::adapter(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$line])))))),  $mode);
			for my $result (@{$list}){
				print "$result\n";
			}
		}
	} else{
		do $CONLL;
		while(my $line = <$input>){
			my $list =  CONLL::conll(Parser::parse(AdapterFreeling::adapter(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$line])))))), "-fa"));
			for my $result (@{$list}){
				print "$result\n";
			}
		}
	}

}
