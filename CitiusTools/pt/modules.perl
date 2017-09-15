
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;


do "sentences-pt_exe.perl";
do "splitter-pt_exe.perl";
do "tagger-pt_exe.perl";
do "tokens-pt_exe.perl";
do "ner-pt_exe.perl";
do "nec-pt_exe.perl";
do "lemma-pt_exe.perl";

while(my $line = <STDIN>){
	my $list = [$line];
	$list = Sentences::sentences($list);
	$list = Tokens::tokens($list);
	$list = Splitter::splitter($list);
	#$list = Ner::ner($list);
	$list = Lemma::lemma($list);
	#$list = Tagger::tagger($list);
	#$list = Nec::nec($list);

	for my $line (@{$list}){
		print "$line\n";
	}
}