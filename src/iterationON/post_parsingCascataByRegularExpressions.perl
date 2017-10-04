############################## END GRAMMAR  ###############################

				if ($ListInit eq $listTags) {
					$STOP = 1;
				}
			}
			#print STDERR "Iterations: $iteration\n";

#########SAIDA CORRECTOR TAGGER
			if ($flag eq "-c") {    
				for($i=0;$i<=$#Token;$i++) {
					my $saida = "$Token[$i]\t";#<string>
					my %OrdTags=();#<map><string>
					$OrdTags{"tag"} = $Tag[$i]; 
					foreach my $feat (keys %{$ATTR[$i]}) {
						$OrdTags{$feat} = $ATTR[$i]{$feat};
					}
					foreach my $feat (sort keys %OrdTags) {
						$saida .= "$feat:$OrdTags{$feat}|";
					}
					if($pipe){#<ignore-line>
						print "$saida\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida,$saida);
					}#<ignore-line>
				}
				##Colocar a zero os vectores de cada oraçao
				@Token=();
				@Tag=();
				@Lemma=();
				@Attributes=();
				@ATTR=();   
			}
#########SAIDA STANDARD DO ANALISADOR 
			elsif ($flag eq "-a") {
				##Escrever a oraçao que vai ser analisada:
				if($pipe){#<ignore-line>
					print "SENT::$seq\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida,"SENT::$seq");
				}#<ignore-line>
				#print STDERR "LIST:: $listTags\n";
				####imprimir Hash de dependencias ordenado:
				foreach my $triplet (sort {$Ordenar{$a} <=> $Ordenar{$b} } keys %Ordenar ) {
					$triplet =~ s/^\(//;
					$triplet =~ s/\)$//;
					my ($re, $he, $de) =  split (";", $triplet);#<string>
					if ($re !~ /($DepLex)/) {
						($he , my $ta1, my $pos1) = split ("_", $he);#<string>
						$he = $Lemma[$pos1];
						($de ,my $ta2, my $pos2) = split ("_", $de);#<string>
						$de = $Lemma[$pos2];
						$triplet = "$re;$he\_$ta1\_$pos1;$de\_$ta2\_$pos2" ;
					}
					if($pipe){#<ignore-line>
						print "($triplet)\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida,"($triplet)");
					}#<ignore-line>
				}
				##final de analise de frase:
				if($pipe){#<ignore-line>
					print "---\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida,"---");
				}#<ignore-line>
			}
###SAIDA ANALISADOR COM ESTRUTURA ATRIBUTO-VALOR (full analysis)
			elsif ($flag eq "-fa") {
				##Escrever a oraçao que vai ser analisada:
				if($pipe){#<ignore-line>
					print "SENT::$seq\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida,"SENT::$seq");
				}#<ignore-line>
				#print STDERR "LIST:: $listTags\n";
				####imprimir Hash de dependencias ordenado:
				my $re="";#<string>
				foreach my $triplet (sort {$Ordenar{$a} <=>
					$Ordenar{$b} }
					keys %Ordenar ) {
					$triplet =~ s/^\(//;
					$triplet =~ s/\)$//;
					($re, my $he,my $de) =  split (";", $triplet);#<string>

					if ($re !~ /($DepLex)/) { ##se rel nao e lexical
						my ($he1, $ta1, $pos1) = split ("_", $he);#<string>
						$he1 = $Lemma[$pos1];
						my ($de2 ,$ta2, $pos2) = split ("_", $de);#<string>
						$de2 = $Lemma[$pos2];
						$triplet = "$re;$he1\_$ta1\_$pos1;$de2\_$ta2\_$pos2";
					}
					if($pipe){#<ignore-line>
						print "($triplet)\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida,"($triplet)");
					}#<ignore-line>

					($he, my $ta, my $pos) = split ("_", $he);#<string>
					my $saida = "HEAD::$he\_$ta\_$pos<";#<string>
					$ATTR[$pos]{"lemma"} = $Lemma[$pos];
					$ATTR[$pos]{"token"} = $Token[$pos];
					foreach my $feat (sort keys %{$ATTR[$pos]}) {
						$saida .= "$feat:$ATTR[$pos]{$feat}|";
					}
					if($pipe){#<ignore-line>
						print "$saida>\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida,"$saida>");
					}#<ignore-line>

					($de, $ta, $pos) = split ("_", $de);#<string>
					$saida = "DEP::$de\_$ta\_$pos<";
					$ATTR[$pos]{"lemma"} = $Lemma[$pos];
					$ATTR[$pos]{"token"} = $Token[$pos];
					foreach my $feat (sort keys %{$ATTR[$pos]}) {
						$saida .= "$feat:$ATTR[$pos]{$feat}|" ;
					}
					if($pipe){#<ignore-line>
						print "$saida>\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida,"$saida>");
					}#<ignore-line>

					if ($re =~ /\//) {
						my ($depName, $reUnit) = split ('\/', $re);#<string>
						(my $reLex, $ta, $pos) = split ("_", $reUnit);#<string>
						$saida =  "REL::$reLex\_$ta\_$pos<";
						$ATTR[$pos]{"lemma"} = $Lemma[$pos];
						$ATTR[$pos]{"token"} = $Token[$pos];
						foreach my $feat (sort keys %{$ATTR[$pos]}) {
							$saida .= "$feat:$ATTR[$pos]{$feat}|" ;
						}
						if($pipe){#<ignore-line>
							print "$saida>\n";#<ignore-line>
						}else{#<ignore-line>
							push (@saida,"$saida>");
						}#<ignore-line>
					}
				}
				##final de analise de frase:
				if($pipe){#<ignore-line>
					print "---\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida,"---");
				}#<ignore-line>
			}
    
			##Colocar numa lista vazia os strings com os tags (listTags) e a oraçao (seq)
			##Borrar hash ordenado de triplets

			$i=0;
			$j=0;
			$listTags="";
			$seq="";
			%Ordenar=();
			@Token=();
			@Tag=();
			@Lemma=();
			@Attributes=();
			@ATTR=();  
	   
		} ##fim do elsif

	}

	#print "\n";
	return \@saida;
}


sub HeadDep {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Head = $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Dep =~ /[\w]+_([0-9]+)/);


		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			my $Rel =  $y ;#<string>
			$Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && 
				($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) && ##a modificar: so no caso de que atr = number or genre (N = invariable or neutral)
				($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "") ) {

				$found=1;
				}
			}

			# print STDERR "Found: $found\n";
			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
				$found=0;

				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				my $Rel =  $y ;#<string>
				$Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;
			}
		}
	}
}


sub DepHead {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	# print STDERR "-$y-, -$z-, -@x-\n";

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Dep = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			my $Rel =  $y;#<string>
			$Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;

		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) &&
				 ($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "") ) {
				$found=1;
				}
			}

			#  print STDERR "Found: $found\n";
			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
				$found=0;
			} else  {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
				$found=0;
				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				my $Rel =  $y;#<string>
				$Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
				$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;
			}
		}
	}
}


sub DepRelHead {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Dep = $x->[$m];#<string>
		$m++;
		my $Rel = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3 ;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
					($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
					($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
					$found=1;
				}
			}

			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;


				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}";
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
			}
		}
	}
}


sub HeadRelDep {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Head = $x->[$m];#<string>
		$m++;
		my $Rel = $y . "_" . $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);


		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) && 
				 ($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
					$found=1;
				}
			}

			if ($found)  {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;

				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}";
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}";
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
			}
		}
	}
}


sub RelDepHead {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Rel = $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3 ;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
				 ($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
					$found=1;
				}
			}

			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;


				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
			}
		}
	}
}


sub RelHeadDep {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Rel = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
				($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
				($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
				$found = 1;
				}
			}

			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;

				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
			}
		}
	}
}


sub DepHeadRel {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Dep = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>
		$m++;
		my $Rel = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
					($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
					($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
					$found = 1;
				}
			}

			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;

				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}";
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
			}
		}
	}
}


sub HeadDepRel {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Head = $x->[$m];#<string>
		$m++;
		my $Rel = $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}";
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}";
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}";

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
					($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
					($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
					$found=1;
				}
			}

			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;

				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3 ;
			}
		}
	}
}


sub HeadDep_lex {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Head = $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			#$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Head = "$ATTR[$n1]{'lemma'}_$Tag[$n1]_${n1}" ;
			my $Rel =  $y;#<string>
			#$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$ATTR[$n2]{'lemma'}_$Tag[$n2]_${n2}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;
			#print STDERR "head::$Head -- dep:::$Dep\n";

			if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} . "\@$Lemma[$n2]" ;
				# $ATTR_token{$n1} = $ATTR[$n1]{"token"} .  "\@$Token[$n2]";
				$IDF{$n1}++;
			} elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} .  "\@$ATTR_lemma{$n2}" ;
				#$ATTR_token{$n1} = $ATTR[$n1]{"token"} .   "\@$ATTR_token{$n2}";
				$IDF{$n1}++;
			} elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} .=   "\@$Lemma[$n2]";
				#$ATTR_token{$n1} .=   "\@$Token[$n2]";
			} else {
				$ATTR_lemma{$n1} .=    "\@$ATTR_lemma{$n2}" ;
				#$ATTR_token{$n1} .=    "\@$ATTR_token{$n2}";
			}
			#print STDERR "$n1::: $ATTR_lemma{$n1} -- $ATTR_token{$n1} \n";
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) &&
				 ($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "") ) {
					$found = 1;
				}
			}

			# print STDERR "Found: $found\n";
			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
				$found=0;

				#$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Head = "$ATTR[$n1]{'lemma'}_$Tag[$n1]_${n1}";
				my $Rel =  $y;#<string>
				#$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
				$Dep =  "$ATTR[$n2]{'lemma'}_$Tag[$n2]_${n2}";

				$Ordenar{"($Rel;$Head;$Dep)"} = $n2;

				if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
					$ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} . "\@$Lemma[$n2]" ;
					# $ATTR_token{$n1} = $ATTR[$n1]{"token"} .  "\@$Token[$n2]";
					$IDF{$n1}++;
				} elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
					$ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} .  "\@$ATTR_lemma{$n2}" ;
					#$ATTR_token{$n1} = $ATTR[$n1]{"token"} .   "\@$ATTR_token{$n2}";
					$IDF{$n1}++;
				} elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
					$ATTR_lemma{$n1} .=   "\@$Lemma[$n2]" ;
					#$ATTR_token{$n1} .=   "\@$Token[$n2]";
				} else {
					$ATTR_lemma{$n1} .=    "\@$ATTR_lemma{$n2}";
					#$ATTR_token{$n1} .=    "\@$ATTR_token{$n2}";
				}
			}
		}
		$Lemma[$n1] = $ATTR_lemma{$n1};
		# $Token[$n1] = $ATTR_token{$n1};
	}
}


sub DepHead_lex {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Dep = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>

		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			#$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Head = "$ATTR[$n1]{'lemma'}_$Tag[$n1]_${n1}" ;
			my $Rel =  $y;#<string>
			#$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$ATTR[$n2]{'lemma'}_$Tag[$n2]_${n2}" ;
			$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;

			#print STDERR "OKKKK: #$Dep - $n2#\n";
			if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} = $ATTR[$n2]{"lemma"} . "\@$Lemma[$n1]" ;
				#$ATTR_token{$n1} = $ATTR[$n2]{"token"} .  "\@$Token[$n1]";
				$IDF{$n1}++;
			} elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} =   "$ATTR_lemma{$n2}\@"  . $ATTR[$n1]{"lemma"}  ;
				#$ATTR_token{$n1} =   "$ATTR_token{$n2}\@" .  $ATTR[$n1]{"token"};
				$IDF{$n1}++;
		} elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
			$ATTR_lemma{$n1} .=   "$Lemma[$n2]\@";
			#$ATTR_token{$n1} .=   "$Token[$n2]\@";
		} else {
			$ATTR_lemma{$n1} .=    "$ATTR_lemma{$n1}\@" ;
			#$ATTR_token{$n1} .=    "$ATTR_token{$n1}\@" ;
		}
	} else {
		foreach my $atr (@z) {
			if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) &&
			 ($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "")  ) {
				$found=1;
			}
		}
		# print STDERR "Found: $found\n";
		if ($found) {
			$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
			$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
			$found=0;
		} else {
			$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
			$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
			$found=0;
			#$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Head = "$ATTR[$n1]{'lemma'}_$Tag[$n1]_${n1}";
			my $Rel =  $y;#<string>
			#$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$ATTR[$n2]{'lemma'}_$Tag[$n2]_${n2}";
			$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;

			if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} = $ATTR[$n2]{"lemma"} . "\@$Lemma[$n1]" ;
				#$ATTR_token{$n1} = $ATTR[$n2]{"token"} .  "\@$Token[$n1]";
				$IDF{$n1}++;
			} elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} =   "$ATTR_lemma{$n2}\@"  . $ATTR[$n1]{"lemma"}  ;
				#$ATTR_token{$n1} =   "$ATTR_token{$n2}\@" .  $ATTR[$n1]{"token"};
				$IDF{$n1}++;
			} elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} .=   "$Lemma[$n2]\@";
				#$ATTR_token{$n1} .=   "$Token[$n2]\@";
			} else {
				$ATTR_lemma{$n1} .=    "$ATTR_lemma{$n1}\@";
				#$ATTR_token{$n1} .=    "$ATTR_token{$n1}\@";
			}
		}
	}
	$Lemma[$n1] = $ATTR_lemma{$n1} ;
	#$Token[$n1] = $ATTR_token{$n1} ;
	}
}



sub Head {
	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>

	return 1;
}


sub LEX {

	foreach my $idf (keys %IDF) {
		#print STDERR "idf = $idf";

		##parche para \2... \pi...:
		# $ATTR[$idf]{"lemma"}  =~ s/[\\]/\\\\/g ;
		# $ATTR[$idf]{"token"}  =~ s/[\\]/\\\\/g ;

		$listTags =~ s/($Tag[$idf]_${idf}${l})lemma:$ATTR[$idf]{'lemma'}/${1}lemma:$ATTR_lemma{$idf}/;
		# $listTags =~ s/($Tag[$idf]_${idf}${l})token:$ATTR[$idf]{"token"}/${1}token:$ATTR_token{$idf}/;

		delete $IDF{$idf};
		delete $ATTR_lemma{$idf};
		#delete $ATTR_token{$idf};
	}
}


##Operaçoes Corr, Inherit, Add, 
sub Corr {

	(my $z, my $y,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $atr="";#<string>
	my $value="";#<string>
	my $info="";#<string>
	my $attribute="";#<string>
	my $entry="";#<string>

	my @y = split (",", $y);#<array><string>


	if ($z eq "Head") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;

			foreach my $info (@y) {
				($atr, $value) = split (":", $info) ;

				##token:=lemma / lemma:=token
				if ($value =~ /^=/) {
					$value =~ s/^=//;
					$ATTR[$n1]{$atr} = $ATTR[$n1]{$value} ;
					if ($value eq "token") {
						$Lemma[$n1] = $ATTR[$n1]{$value} ;
					} elsif ($value eq "lemma") {
						$Token[$n1] = $ATTR[$n1]{$value} ;
					}
				} 
				##change the PoS tag:
				elsif ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$entry = "${value}_${n1}_<";
					if (activarTags($value,$n1)) {
						foreach my $attribute (sort keys %{$ATTR[$n1]}) {
							#print STDERR "--atribs: $attribute\n";      
							if (defined $TagStr{$attribute}) {
								$entry .= "$attribute:$ATTR[$n1]{$attribute}|" ;
								#print STDERR "atribute defined : $attribute --$entry\n";
							} else {
								#$entry .= "$attribute:$TagStr{$attribute}|" ;
								delete $ATTR[$n1]{$attribute} ;
								#print STDERR "++entry : $entry\n";
							} 
						}

						foreach my $attribute (sort keys %TagStr) {
							#print STDERR "++atribs: $attribute\n";      
							if (!defined $ATTR[$n1]{$attribute}) {
								$entry .= "$attribute:$ATTR[$n1]{$attribute}|" ;
								$ATTR[$n1]{$attribute} = $TagStr{$attribute};
								#print STDERR "++atribute defined : $attribute --$entry\n";
							}
						}
					}
					$entry .= ">";
					#print STDERR  "--$entry\n" ;
					$listTags =~ s/$Tag[$n1]_$n1$a2/$entry/;
					$Tag[$n1] = $value;
					desactivarTags($value);
				} elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};  
					}
				}
			}
		}
	}
}


sub Inherit {

	(my $z, my $y,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>

	my @y = split (",", $y);#<array><string>

	if ($z eq "DepHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "HeadDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "DepRelHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m +=2;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "HeadRelDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m +=2;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);
			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "RelDepHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			$m++;
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "RelHeadDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			$m++;
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "DepHeadRel") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};               
			}
		}
	} elsif ($z eq "HeadDepRel") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr}; 
			}
		}
	} elsif ($z eq "DepHead_lex") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/);
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
					$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr}; 
			}
		}
	} elsif ($z eq "HeadDep_lex") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr}; 
			}
		}
	}
}


sub Add {

	(my $z, my $y,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $atr="";#<string>
	my $value="";#<string>
	my $info="";#<string>

	my @y = split (",", $y);#<array><string>

 
	if ($z eq "Head") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			foreach my $info (@y) {
				($atr, $value) = split (":", $info) ;
				if ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
                                        my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					my $feat2 = $feat;
					$feat2 =~ s/\|/\\|/g;
					$listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					my @feat = split ('\|', $feat); 
					push (@feat,$info);
					@feat = sort (@feat); 
					$feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;    

					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
				}
			}
		}
	} elsif ($z eq "DepHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/);
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $info (@y) {
				($atr, $value) = split (":", $info);
				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
					#print STDERR "$atr - $value : #$l# - #$r#";
					} else {
					    my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					    #$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;

					     $ATTR[$n1]{$atr} = $value;
					     if ($atr eq "lemma") {
							$Lemma[$n1] = $ATTR[$n1]{"lemma"};
				}
				if ($atr eq "token") {
					$Token[$n1] = $ATTR[$n1]{"token"};
				}
				#print STDERR "$atr - $value ::: #$l# - #$r#";
				}
			}
		}
	} elsif ($z eq "HeadDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					    my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
					    $ATTR[$n1]{$atr} = $value; 
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
				            }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} elsif ($z eq "DepRelHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m+=2;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					 my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;

					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} elsif ($z eq "HeadRelDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m +=2;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
				$ATTR[$n1]{$atr} = $value;
				$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
				$Tag[$n1] = $value;
				} elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					 my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} elsif ($z eq "RelDepHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			$m++;
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					 my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					 
					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} elsif ($z eq "RelHeadDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			$m++;
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					 my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} elsif ($z eq "DepHeadRel") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags  =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
				            my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} elsif ($z eq "HeadDepRel") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
				if ($atr eq "lemma") {
					$Lemma[$n1] = $ATTR[$n1]{"lemma"};
				}
				if ($atr eq "token") {
					$Token[$n1] = $ATTR[$n1]{"token"};
				}
				$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
				            my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} elsif ($z eq "DepHead_lex") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
				            my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} 

	if ($z eq "HeadDep_lex") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
				        $listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}${info}\|/;
				} else {
				            my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
					#print STDERR "$atr - $value ::: #$l# - #$r#";
				}
			}
		}
	} 
}


sub negL {

	my ($x) = @_ ;#<string>
	my $expr="";#<string>
	my $ref="";#<string>
	my $CAT="";#<string>

	($CAT, $ref) = split ("_", $x);  
	$expr = "(?<!${CAT})\\_$ref";


	return $expr;
}


sub negR {

	my ($x) = @_ ;#<string>
	my $expr="";#<string>
	my $ref="";#<string>
	my $CAT="";#<string>

	($CAT, $ref) = split ("_", $x); 
	$expr = "?!${CAT}\\_$ref";

	return $expr;
}



sub activarTags {

	my ($x, #<string>
	$pos) = @_ ; #<integer>

	##shared attributes:
	# $TagStr{"tag"} = 0;
	$TagStr{"lemma"} = 0;
	$TagStr{"token"} = 0;

	if ($x =~ /^PRO/) {
		$TagStr{"type"} = 0;
		$TagStr{"person"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"number"} = 0;
		$TagStr{"case"} = 0;
		$TagStr{"possessor"} = 0;
		$TagStr{"politeness"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	##conjunctions:
	elsif ($x =~ /^C/) {
		$TagStr{"type"} =  0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	##interjections:
	elsif ($x =~ /^I/) {
		$TagStr{"type"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	##numbers
	elsif ($x =~  /^CARD/) {
		$TagStr{"number"} = "P";
		$TagStr{"person"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	##dates
	elsif ($x =~  /^DATE/) {
		$TagStr{"number"} = 0;
		$TagStr{"person"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	elsif ($x =~ /^ADJ/) {
		$TagStr{"type"} = 0;
		$TagStr{"degree"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"number"} = 0;
		$TagStr{"function"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	elsif ($x =~ /^ADV/) {
		$TagStr{"type"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	elsif ($x =~ /^PRP/) {
		$TagStr{"type"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
   elsif ($x =~ /^NOUN/) {    
		$TagStr{"type"} = 0 ;
		$TagStr{"gender"} = 0;
		$TagStr{"number"} = 0;
		$TagStr{"person"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
   }
   elsif ($x =~ /^DT/) {
		$TagStr{"type"} = 0;
		$TagStr{"person"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"number"} = 0;
		$TagStr{"possessor"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
   }
  ##mudar tags nos verbos:
   elsif ($x =~ /^VERB/) {
		$TagStr{"type"} = 0;
		$TagStr{"mode"} = 0;
		$TagStr{"tense"} = 0;
		$TagStr{"person"} = 0;
		$TagStr{"number"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;  
   }
   else {
		return 0;
   }
}


sub desactivarTags {

	my ($x) = @_ ; #<string>

	delete $TagStr{"type"} ;
	delete $TagStr{"person"};
	delete $TagStr{"gender"} ;
	delete $TagStr{"number"} ;
	delete $TagStr{"case"} ;
	delete $TagStr{"possessor"} ;
	delete $TagStr{"politeness"} ;
	delete $TagStr{"mode"} ;
	delete $TagStr{"tense"} ;
	delete $TagStr{"function"} ;
	delete $TagStr{"degree"} ;
	delete $TagStr{"pos"} ;     

	delete $TagStr{"lemma"} ;
	delete $TagStr{"token"} ;
	# delete $TagStr{"tag"} ;
	return 1;
}


sub ConvertChar {

	my ($x, $y) = @_ ;#<string>

	$info =~ s/lemma:$x/lemma:\*$y\*/g; 
	$info =~ s/token:$x/token:\*$y\*/g;

}

sub ReConvertChar {

	my ($x, $y, $z) = @_ ;#<string>

	$Attributes[$z] =~ s/lemma:\*$y\*/lemma:$x/g;
	$Attributes[$z] =~ s/token:\*$y\*/token:$x/g;
	$ATTR[$z]{"lemma"} =~ s/\*$y\*/$x/g;
	$ATTR[$z]{"token"} =~ s/\*$y\*/$x/g;
	$Token[$z] =~ s/\*$y\*/$x/g;
	$Lemma[$z] =~ s/\*$y\*/$x/g;
}

#<ignore-block>
if($pipe){
	my @lines=<STDIN>;
	parse(\@lines, shift(@ARGV));
}
#<ignore-block>
