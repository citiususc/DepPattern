# Single: VERB
# Add: nomin:no
					@temp = ($listTags =~ /($VERB$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)/$1/g;
					Add("Head","nomin:no",\@temp);

# Single: CONJ<lemma:pero|porque|mas|mais>
# Add: type:S
					@temp = ($listTags =~ /($CONJ${l}lemma:(?:pero|porque|mas|mais)\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($CONJ${l}lemma:(?:pero|porque|mas|mais)\|${r})/$1/g;
					Add("Head","type:S",\@temp);

# fixedR: X<token:sen|sin> X<token:embargo>
# Add: tag:CONJ, type:S
					@temp = ($listTags =~ /($X${l}token:(?:sen|sin)\|${r})($X${l}token:embargo\|${r})/g);
					$Rel =  "fixedR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($X${l}token:(?:sen|sin)\|${r})($X${l}token:embargo\|${r})/$1/g;
					Add("HeadDep","tag:CONJ,type:S",\@temp);

# fixedR: X<token:assim|asÃ­> X<token:como>
					@temp = ($listTags =~ /($X${l}token:(?:assim|asÃ­)\|${r})($X${l}token:como\|${r})/g);
					$Rel =  "fixedR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($X${l}token:(?:assim|asÃ­)\|${r})($X${l}token:como\|${r})/$1/g;

# fixedR: ADV<lemma:$AdvDe> PRP<lemma:de>
					@temp = ($listTags =~ /($ADV${l}lemma:$AdvDe\|${r})($PRP${l}lemma:de\|${r})/g);
					$Rel =  "fixedR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}lemma:$AdvDe\|${r})($PRP${l}lemma:de\|${r})/$1/g;

# punctR:  [Fz|Fe] X Fz|Fe
# NEXT
# punctL: Fz|Fe X [Fz|Fe]
					@temp = ($listTags =~ /(?:$Fz$a2|$Fe$a2)($X$a2)($Fz$a2|$Fe$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($Fz$a2|$Fe$a2)($X$a2)(?:$Fz$a2|$Fe$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fz$a2|$Fe$a2)($X$a2)($Fz$a2|$Fe$a2)/$2/g;

# cc: [ADV] [Fc] [ADV] [Fc] [ADV] CONJ<lemma:$CCoord> ADV
# NEXT
# conj: ADV [Fc] [ADV] [Fc] [ADV]  [CONJ<lemma:$CCoord>] ADV
# NEXT
# punctL: [ADV] [Fc] [ADV] Fc ADV  [CONJ<lemma:$CCoord>] [ADV]
# NEXT
# conj: ADV [Fc] [ADV] [Fc] ADV  [CONJ<lemma:$CCoord>] [ADV]
# NEXT
# punctL: [ADV] Fc ADV [Fc] [ADV]  [CONJ<lemma:$CCoord>] [ADV]
# NEXT
# conj: ADV [Fc] ADV [Fc] [ADV]  [CONJ<lemma:$CCoord>] [ADV]
					@temp = ($listTags =~ /(?:$ADV$a2)(?:$Fc$a2)(?:$ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)(?:$Fc$a2)(?:$ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($Fc$a2)($ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADV$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)(?:$Fc$a2)($ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADV$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)($Fc$a2)($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADV$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADV$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($Fc$a2)($ADV$a2)($Fc$a2)($ADV$a2)($CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/$1/g;

# cc: [ADV] [Fc] [ADV] CONJ<lemma:$CCoord> ADV
# NEXT
# conj: ADV [Fc] [ADV]  [CONJ<lemma:$CCoord>] ADV
# NEXT
# punctL: [ADV] Fc ADV  [CONJ<lemma:$CCoord>] [ADV]
# NEXT
# conj: ADV [Fc] ADV  [CONJ<lemma:$CCoord>] [ADV]
					@temp = ($listTags =~ /(?:$ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)($Fc$a2)($ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADV$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)($ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADV$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($Fc$a2)($ADV$a2)($CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/$1/g;

# cc: [ADV] CONJ<lemma:$CCoord> ADV
# NEXT
# conj: ADV [CONJ<lemma:$CCoord>] ADV
					@temp = ($listTags =~ /(?:$ADV$a2)($CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/$1/g;

# cc: [ADJ] [Fc] [ADJ] [Fc] [ADJ] CONJ<lemma:$CCoord> ADJ
# NEXT
# conj: ADJ [Fc] [ADJ] [Fc] [ADJ]  [CONJ<lemma:$CCoord>] ADJ
# NEXT
# punctL: [ADJ] [Fc] [ADJ] Fc ADJ  [CONJ<lemma:$CCoord>] [ADJ]
# NEXT
# conj: ADJ [Fc] [ADJ] [Fc] ADJ  [CONJ<lemma:$CCoord>] [ADJ]
# NEXT
# punctL: [ADJ] Fc ADJ [Fc] [ADJ]  [CONJ<lemma:$CCoord>] [ADJ]
# NEXT
# conj: ADJ [Fc] ADJ [Fc] [ADJ]  [CONJ<lemma:$CCoord>] [ADJ]
					@temp = ($listTags =~ /(?:$ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/$1/g;

# cc: [ADJ] [Fc] [ADJ] CONJ<lemma:$CCoord> ADJ
# NEXT
# conj: ADJ [Fc] [ADJ]  [CONJ<lemma:$CCoord>] ADJ
# NEXT
# punctL: [ADJ] Fc ADJ  [CONJ<lemma:$CCoord>] [ADJ]
# NEXT
# conj: ADJ [Fc] ADJ  [CONJ<lemma:$CCoord>] [ADJ]
					@temp = ($listTags =~ /(?:$ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/$1/g;

# cc: [ADJ] CONJ<lemma:$CCoord> ADJ
# NEXT
# conj: ADJ [CONJ<lemma:$CCoord>] ADJ
					@temp = ($listTags =~ /(?:$ADJ$a2)($CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/$1/g;

# advmodL: ADV<lemma:$Quant> ADV|ADJ
					@temp = ($listTags =~ /($ADV${l}lemma:$Quant\|${r})($ADV$a2|$ADJ$a2)/g);
					$Rel =  "advmodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}lemma:$Quant\|${r})($ADV$a2|$ADJ$a2)/$2/g;

# flatR:  NOUN<type:P> NOUN<type:P>
# Recursivity: 2
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/g);
					$Rel =  "flatR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/$1/g;
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/g);
					$Rel =  "flatR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/$1/g;
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/g);
					$Rel =  "flatR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/$1/g;

# amodL: ADV<lemma:no|nÃ£o|non> NOUN
					@temp = ($listTags =~ /($ADV${l}lemma:(?:no|nÃ£o|non)\|${r})($NOUN$a2)/g);
					$Rel =  "amodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}lemma:(?:no|nÃ£o|non)\|${r})($NOUN$a2)/$2/g;

# nmod2R:  NOUN<type:P> NOUN<type:P>
# Recursivity: 2
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/g);
					$Rel =  "nmod2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/$1/g;
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/g);
					$Rel =  "nmod2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/$1/g;
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/g);
					$Rel =  "nmod2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/$1/g;

# nmod2R:  NOUN NOUN
# Recursivity: 1
					@temp = ($listTags =~ /($NOUN$a2)($NOUN$a2)/g);
					$Rel =  "nmod2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($NOUN$a2)/$1/g;
					@temp = ($listTags =~ /($NOUN$a2)($NOUN$a2)/g);
					$Rel =  "nmod2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($NOUN$a2)/$1/g;

# nmodR: CARD PRP<lemma:de> NOUN<lemma:$Month>
# Add: date:yes
# NoUniq
					@temp = ($listTags =~ /($CARD$a2)($PRP${l}lemma:de\|${r})($NOUN${l}lemma:$Month\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($CARD$a2)($PRP${l}lemma:de\|${r})($NOUN${l}lemma:$Month\|${r})/$1$2$3/g;
					Add("HeadRelDep","date:yes",\@temp);

# amodL: ADJ NOUN
					@temp = ($listTags =~ /($ADJ$a2)($NOUN$a2)/g);
					$Rel =  "amodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($NOUN$a2)/$2/g;

# amodR: NOUN ADJ
					@temp = ($listTags =~ /($NOUN$a2)($ADJ$a2)/g);
					$Rel =  "amodR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($ADJ$a2)/$1/g;

# det: DT [DT|PRO<type:X>|PRO<token:lo>] NOUN
# NEXT
# det: [DT] DT|PRO<type:X>|PRO<token:lo> NOUN
					@temp = ($listTags =~ /($DT$a2)(?:$DT$a2|$PRO${l}type:X\|${r}|$PRO${l}token:lo\|${r})($NOUN$a2)/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$DT$a2)($DT$a2|$PRO${l}type:X\|${r}|$PRO${l}token:lo\|${r})($NOUN$a2)/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT$a2)($DT$a2|$PRO${l}type:X\|${r}|$PRO${l}token:lo\|${r})($NOUN$a2)/$3/g;

# det: DT [CARD] NOUN
# NEXT
# nummodL: [DT] CARD NOUN
					@temp = ($listTags =~ /($DT$a2)(?:$CARD$a2)($NOUN$a2)/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$DT$a2)($CARD$a2)($NOUN$a2)/g);
					$Rel =  "nummodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT$a2)($CARD$a2)($NOUN$a2)/$3/g;

# det: DT<type:I> [DT<type:A>] PRO<type:R>
# NEXT
# det: [DT<type:I>] DT<type:A> PRO<type:R>
					@temp = ($listTags =~ /($DT${l}type:I\|${r})(?:$DT${l}type:A\|${r})($PRO${l}type:R\|${r})/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$DT${l}type:I\|${r})($DT${l}type:A\|${r})($PRO${l}type:R\|${r})/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT${l}type:I\|${r})($DT${l}type:A\|${r})($PRO${l}type:R\|${r})/$3/g;

# amodL: [DT] VERB<mode:P> NOUN
# NEXT
# det: DT [VERB<mode:P>] NOUN
					@temp = ($listTags =~ /(?:$DT$a2)($VERB${l}mode:P\|${r})($NOUN$a2)/g);
					$Rel =  "amodL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($DT$a2)(?:$VERB${l}mode:P\|${r})($NOUN$a2)/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT$a2)($VERB${l}mode:P\|${r})($NOUN$a2)/$3/g;

# nummodL: CARD NOUN
					@temp = ($listTags =~ /($CARD$a2)($NOUN$a2)/g);
					$Rel =  "nummodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($CARD$a2)($NOUN$a2)/$2/g;

# det: DT NOUN
					@temp = ($listTags =~ /($DT$a2)($NOUN$a2)/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT$a2)($NOUN$a2)/$2/g;

# det: DT PRO<type:D|P|I|X>|ADJ|CARD
					@temp = ($listTags =~ /($DT$a2)($PRO${l}type:(?:D|P|I|X)\|${r}|$ADJ$a2|CARD)/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT$a2)($PRO${l}type:(?:D|P|I|X)\|${r}|$ADJ$a2|CARD)/$2/g;

# det: DT|PRO<type:D> PRO<type:[RW]>
# Add: sust:yes
# Inherit: number, person
					@temp = ($listTags =~ /($DT$a2|$PRO${l}type:D\|${r})($PRO${l}type:[RW]\|${r})/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT$a2|$PRO${l}type:D\|${r})($PRO${l}type:[RW]\|${r})/$2/g;
					Inherit("DepHead","number,person",\@temp);
					Add("DepHead","sust:yes",\@temp);

# det: DT<type:[AD]>|PRO<type:D> PRP<lemma:de> [NOUNS|PRO<type:D|P|I|X>]
# Add: nomin:yes
# Inherit: number, person
					@temp = ($listTags =~ /($DT${l}type:[AD]\|${r}|$PRO${l}type:D\|${r})($PRP${l}lemma:de\|${r})(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT${l}type:[AD]\|${r}|$PRO${l}type:D\|${r})($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$2$3/g;
					Inherit("DepHead","number,person",\@temp);
					Add("DepHead","nomin:yes",\@temp);

# det: DT [ADV<lemma:$AdvDe>] [PRP<lemma:de>] NOUN
					@temp = ($listTags =~ /($DT$a2)(?:$ADV${l}lemma:$AdvDe\|${r})(?:$PRP${l}lemma:de\|${r})($NOUN$a2)/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT$a2)($ADV${l}lemma:$AdvDe\|${r})($PRP${l}lemma:de\|${r})($NOUN$a2)/$2$3$4/g;

# explL: PRO<token:se> VERB
# Add: se:yes
					@temp = ($listTags =~ /($PRO${l}token:se\|${r})($VERB$a2)/g);
					$Rel =  "explL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}token:se\|${r})($VERB$a2)/$2/g;
					Add("DepHead","se:yes",\@temp);

# explR: VERB PRO<token:se>
# Add: se:yes
					@temp = ($listTags =~ /($VERB$a2)($PRO${l}token:se\|${r})/g);
					$Rel =  "explR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRO${l}token:se\|${r})/$1/g;
					Add("HeadDep","se:yes",\@temp);

# explL: PRO<lemma:$cliticoInd>  [PRO<lemma:$cliticoDir>]? VERB [ADV]? [NOUNS|PRO<type:D|P|I|X>]? [PRP<lemma:a>] [NOUN]
# NEXT
# iobjR: [PRO<lemma:$cliticoInd>]  [PRO<lemma:$cliticoDir>]? VERB [ADV]? [NOUNS|PRO<type:D|P|I|X>]? PRP<lemma:a> NOUN
					@temp = ($listTags =~ /($PRO${l}lemma:$cliticoInd\|${r})(?:$PRO${l}lemma:$cliticoDir\|${r})?($VERB$a2)(?:$ADV$a2)?(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?(?:$PRP${l}lemma:a\|${r})(?:$NOUN$a2)/g);
					$Rel =  "explL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRO${l}lemma:$cliticoInd\|${r})(?:$PRO${l}lemma:$cliticoDir\|${r})?($VERB$a2)(?:$ADV$a2)?(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUN$a2)/g);
					$Rel =  "iobjR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}lemma:$cliticoInd\|${r})($PRO${l}lemma:$cliticoDir\|${r})?($VERB$a2)($ADV$a2)?($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUN$a2)/$2$3$4$5/g;

# explR: VERB PRO<lemma:$cliticoInd>  [PRO<lemma:$cliticoDir>]? [ADV]? [NOUNS|PRO<type:D|P|I|X>]? [PRP<lemma:a>] [NOUN]
# NEXT
# iobjR: VERB [PRO<lemma:$cliticoInd>]  [PRO<lemma:$cliticoDir>]? [ADV]? [NOUNS|PRO<type:D|P|I|X>]? PRP<lemma:a> NOUN
					@temp = ($listTags =~ /($VERB$a2)($PRO${l}lemma:$cliticoInd\|${r})(?:$PRO${l}lemma:$cliticoDir\|${r})?(?:$ADV$a2)?(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?(?:$PRP${l}lemma:a\|${r})(?:$NOUN$a2)/g);
					$Rel =  "explR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$PRO${l}lemma:$cliticoInd\|${r})(?:$PRO${l}lemma:$cliticoDir\|${r})?(?:$ADV$a2)?(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUN$a2)/g);
					$Rel =  "iobjR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRO${l}lemma:$cliticoInd\|${r})($PRO${l}lemma:$cliticoDir\|${r})?($ADV$a2)?($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUN$a2)/$1$3$4$5/g;

# iobj2L: PRO<lemma:$cliticoInd> [PRO<lemma:$cliticoDir>]? VERB
# Add: ind:yes
					@temp = ($listTags =~ /($PRO${l}lemma:$cliticoInd\|${r})(?:$PRO${l}lemma:$cliticoDir\|${r})?($VERB$a2)/g);
					$Rel =  "iobj2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}lemma:$cliticoInd\|${r})($PRO${l}lemma:$cliticoDir\|${r})?($VERB$a2)/$2$3/g;
					Add("DepHead","ind:yes",\@temp);

# iobj2L: PRO<lemma:se> [PRO<lemma:$cliticoDir>] VERB
					@temp = ($listTags =~ /($PRO${l}lemma:se\|${r})(?:$PRO${l}lemma:$cliticoDir\|${r})($VERB$a2)/g);
					$Rel =  "iobj2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}lemma:se\|${r})($PRO${l}lemma:$cliticoDir\|${r})($VERB$a2)/$2$3/g;

# objL: PRO<lemma:$cliticoDir> VERB
					@temp = ($listTags =~ /($PRO${l}lemma:$cliticoDir\|${r})($VERB$a2)/g);
					$Rel =  "objL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}lemma:$cliticoDir\|${r})($VERB$a2)/$2/g;

# iobj2R: VERB PRO<lemma:$cliticoInd>
# Add: ind:yes
					@temp = ($listTags =~ /($VERB$a2)($PRO${l}lemma:$cliticoInd\|${r})/g);
					$Rel =  "iobj2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRO${l}lemma:$cliticoInd\|${r})/$1/g;
					Add("HeadDep","ind:yes",\@temp);

# objR: VERB PRO<lemma:$cliticoDir>
					@temp = ($listTags =~ /($VERB$a2)($PRO${l}lemma:$cliticoDir\|${r})/g);
					$Rel =  "objR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRO${l}lemma:$cliticoDir\|${r})/$1/g;

# auxL: VERB<type:S> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:P>
# Add: voice:passive
# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}type:S\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:P\|${r})/g);
					$Rel =  "auxL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}type:S\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB${l}mode:P\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);
					Add("DepHead","voice:passive",\@temp);

# auxL: VERB<(type:A)|(lemma:ter|haver|haber|avoir|have)> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:P>
# Add: type:perfect
# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}type:A\|${r}|$VERB${l}lemma:(?:ter|haver|haber|avoir|have)\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:P\|${r})/g);
					$Rel =  "auxL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}type:A\|${r}|$VERB${l}lemma:(?:ter|haver|haber|avoir|have)\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB${l}mode:P\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);
					Add("DepHead","type:perfect",\@temp);

# auxL: VERB<lemma:estar> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:G>
# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}lemma:estar\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:G\|${r})/g);
					$Rel =  "auxL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:estar\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB${l}mode:G\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

# auxL: VERB<lemma:$VModal> [ADV]? VERB<mode:N>
# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}lemma:$VModal\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "auxL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VModal\|${r})($ADV$a2)?($VERB${l}mode:N\|${r})/$2$3/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

# markL: [VERB<lemma:tener|ter|haber>] [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? CONJ<lemma:que&type:S>|PRP<lemma:de> [ADV]? VERB<mode:N>
# NEXT
# auxL: VERB<lemma:tener|haber> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [CONJ<lemma:que&type:S>|PRP<lemma:de>] [ADV]? VERB<mode:N>
# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /(?:$VERB${l}lemma:(?:tener|ter|haber)\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($CONJ${l}lemma:que\|${b2}type:S\|${r}|$PRP${l}lemma:de\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}lemma:(?:tener|haber)\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$CONJ${l}lemma:que\|${b2}type:S\|${r}|$PRP${l}lemma:de\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "auxL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:tener|haber)\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($CONJ${l}lemma:que\|${b2}type:S\|${r}|$PRP${l}lemma:de\|${r})($ADV$a2)?($VERB${l}mode:N\|${r})/$2$3$4$5$6$7$8$9$10$11$13$14/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

# markL: [VERB]? [ADV]? [PRP<lemma:$PrepLocs>]? [ADV]? [VERB<mode:N>] [ADV|PRO<type:P>]? PRP<lemma:$PrepLocs>  VERB<mode:N>
# NEXT
# xcomp2R: [VERB]? [ADV]? [PRP<lemma:$PrepLocs>]? [ADV]? VERB<mode:N>  [ADV|PRO<type:P>]? [PRP<lemma:$PrepLocs>]  VERB<mode:N>
# NEXT
# markL: [VERB] [ADV]? PRP<lemma:$PrepLocs> [ADV]? VERB<mode:N>  [ADV|PRO<type:P>]? [PRP<lemma:$PrepLocs>]  [VERB<mode:N>]
# NEXT
# xcomp2R: VERB [ADV]? [PRP<lemma:$PrepLocs>] [ADV]? VERB<mode:N>  [ADV|PRO<type:P>]? [PRP<lemma:$PrepLocs>]  [VERB<mode:N>]
# NoUniq
					@temp = ($listTags =~ /(?:$VERB$a2)?(?:$ADV$a2)?(?:$PRP${l}lemma:$PrepLocs\|${r})?(?:$ADV$a2)?(?:$VERB${l}mode:N\|${r})(?:$ADV$a2|$PRO${l}type:P\|${r})?($PRP${l}lemma:$PrepLocs\|${r})($VERB${l}mode:N\|${r})/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)?(?:$ADV$a2)?(?:$PRP${l}lemma:$PrepLocs\|${r})?(?:$ADV$a2)?($VERB${l}mode:N\|${r})(?:$ADV$a2|$PRO${l}type:P\|${r})?(?:$PRP${l}lemma:$PrepLocs\|${r})($VERB${l}mode:N\|${r})/g);
					$Rel =  "xcomp2R";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})(?:$ADV$a2|$PRO${l}type:P\|${r})?(?:$PRP${l}lemma:$PrepLocs\|${r})(?:$VERB${l}mode:N\|${r})/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$ADV$a2)?(?:$PRP${l}lemma:$PrepLocs\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})(?:$ADV$a2|$PRO${l}type:P\|${r})?(?:$PRP${l}lemma:$PrepLocs\|${r})(?:$VERB${l}mode:N\|${r})/g);
					$Rel =  "xcomp2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r})($ADV$a2)?($VERB${l}mode:N\|${r})($ADV$a2|$PRO${l}type:P\|${r})?($PRP${l}lemma:$PrepLocs\|${r})($VERB${l}mode:N\|${r})/$1$2$3$4$5$6$7$8/g;

# caseL: [VERB] ADV<lemma:$AdvDe> NOUNS
# NEXT
# advmodR: VERB [ADV<lemma:$AdvDe>] NOUNS
					@temp = ($listTags =~ /(?:$VERB$a2)($ADV${l}lemma:$AdvDe\|${r})($NOUNS$a2)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$ADV${l}lemma:$AdvDe\|${r})($NOUNS$a2)/g);
					$Rel =  "advmodR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($ADV${l}lemma:$AdvDe\|${r})($NOUNS$a2)/$1/g;

# punctL: [ADV<pos:0>] Fc VERB
# NEXT
# advmodL: ADV<pos:0> [Fc] VERB
					@temp = ($listTags =~ /(?:$ADV${l}pos:0\|${r})($Fc$a2)($VERB$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV${l}pos:0\|${r})(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "advmodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}pos:0\|${r})($Fc$a2)($VERB$a2)/$3/g;

# punctR:  VERB [Fc]? [ADV] Fc
# NEXT
# punctR: VERB Fc [ADV] [Fc]
# NEXT
# advmodR: VERB [Fc]? ADV [Fc]
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?(?:$ADV$a2)($Fc$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$ADV$a2)(?:$Fc$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?($ADV$a2)(?:$Fc$a2)/g);
					$Rel =  "advmodR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)?($ADV$a2)($Fc$a2)/$1/g;

# punctL: Fc [ADV] [Fc]? VERB
# NEXT
# punctL: [Fc] [ADV] Fc VERB
# NEXT
# advmodL: [Fc] ADV [Fc]? VERB
					@temp = ($listTags =~ /($Fc$a2)(?:$ADV$a2)(?:$Fc$a2)?($VERB$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$ADV$a2)($Fc$a2)($VERB$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)($ADV$a2)(?:$Fc$a2)?($VERB$a2)/g);
					$Rel =  "advmodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($ADV$a2)($Fc$a2)?($VERB$a2)/$4/g;

# advmodR: VERB [NOUN|PRO<type:D|P|I|X>]? ADV
# Recursivity: 1
					@temp = ($listTags =~ /($VERB$a2)(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2)/g);
					$Rel =  "advmodR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2)/$1$2/g;
					@temp = ($listTags =~ /($VERB$a2)(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2)/g);
					$Rel =  "advmodR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2)/$1$2/g;

# advmodL:  ADV  VERB
# Recursivity: 1
					@temp = ($listTags =~ /($ADV$a2)($VERB$a2)/g);
					$Rel =  "advmodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($VERB$a2)/$2/g;
					@temp = ($listTags =~ /($ADV$a2)($VERB$a2)/g);
					$Rel =  "advmodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($VERB$a2)/$2/g;

# cc: [PRP] [NOUNS] [Fc] [PRP] [NOUNS] CONJ<lemma:$CCoord> [PRP] NOUNS
# NEXT
# caseL: [PRP] [NOUNS] [Fc] [PRP] [NOUNS] [CONJ<lemma:$CCoord>] PRP NOUNS
# NEXT
# conj: [PRP] NOUNS [Fc] [PRP] [NOUNS] [CONJ<lemma:$CCoord>] [PRP] NOUNS
# NEXT
# caseL: [PRP] [NOUNS] [Fc] PRP NOUNS [CONJ<lemma:$CCoord>] [PRP] [NOUNS]
# NEXT
# punctR: [PRP] NOUNS Fc [PRP] [NOUNS] [CONJ<lemma:$CCoord>] [PRP] [NOUNS]
# NEXT
# conj: [PRP] NOUNS [Fc] [PRP] NOUNS [CONJ<lemma:$CCoord>] [PRP] [NOUNS]
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUNS$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2)($CONJ${l}lemma:$CCoord\|${r})(?:$PRP$a2)($NOUNS$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUNS$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($PRP$a2)($NOUNS$a2)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)($NOUNS$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$PRP$a2)($NOUNS$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUNS$a2)(?:$Fc$a2)($PRP$a2)($NOUNS$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$PRP$a2)(?:$NOUNS$a2)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)($NOUNS$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$PRP$a2)(?:$NOUNS$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)($NOUNS$a2)(?:$Fc$a2)(?:$PRP$a2)($NOUNS$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$PRP$a2)(?:$NOUNS$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUNS$a2)($Fc$a2)($PRP$a2)($NOUNS$a2)($CONJ${l}lemma:$CCoord\|${r})($PRP$a2)($NOUNS$a2)/$1$2/g;

# cc: [PRP] [NOUNS] CONJ<lemma:$CCoord> [PRP] NOUNS
# NEXT
# caseL: [PRP] [NOUNS] [CONJ<lemma:$CCoord>] PRP NOUNS
# NEXT
# conj: [PRP] NOUNS [CONJ<lemma:$CCoord>] [PRP] NOUNS
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUNS$a2)($CONJ${l}lemma:$CCoord\|${r})(?:$PRP$a2)($NOUNS$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUNS$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($PRP$a2)($NOUNS$a2)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)($NOUNS$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$PRP$a2)($NOUNS$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUNS$a2)($CONJ${l}lemma:$CCoord\|${r})($PRP$a2)($NOUNS$a2)/$1$2/g;

# nmodR: [NOUNS] [PRP] [NOUNS] [PRP] [NOUNS] [PRP] [NOUNS] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7$8$9/g;

# nmodR: [NOUNS] [PRP] [NOUNS] [PRP] [NOUNS] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7/g;

# nmodR: [NOUNS] [PRP] [NOUNS] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;

# nmodR: [NOUNS] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3/g;

# nmodR: NOUN<type:C> PRP<lemma:$PrepRA> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# nmodR: [NOUNS] [PRP] [NOUNS] [PRP] [NOUNS] [PRP] [NOUNS] [PRP] NOUNS PRP<lemma:de> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7$8$9/g;

# nmodR: [NOUNS] [PRP] [NOUNS] [PRP] [NOUNS] [PRP] NOUNS PRP<lemma:de> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7/g;

# nmodR: [NOUNS] [PRP] [NOUNS] [PRP] NOUNS PRP<lemma:de> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;

# nmodR: [NOUNS] [PRP] NOUNS PRP<lemma:de> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3/g;

# nmodR: NOUNS PRP<lemma:de> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# caseL: [NOUNS] ADV<lemma:$AdvDe> NOUNS
# NEXT
# nmodR: NOUNS [ADV<lemma:$AdvDe>] NOUNS
					@temp = ($listTags =~ /(?:$NOUNS$a2)($ADV${l}lemma:$AdvDe\|${r})($NOUNS$a2)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2)(?:$ADV${l}lemma:$AdvDe\|${r})($NOUNS$a2)/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($ADV${l}lemma:$AdvDe\|${r})($NOUNS$a2)/$1/g;

# nmodR: X<lemma:uno>|PRO<type:[DI]> PRP NOUNS|PRO<type:D|P|I|X>
# Add: tag:PRO, nomin:yes
					@temp = ($listTags =~ /($X${l}lemma:uno\|${r}|$PRO${l}type:[DI]\|${r})($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($X${l}lemma:uno\|${r}|$PRO${l}type:[DI]\|${r})($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
					Add("HeadRelDep","tag:PRO,nomin:yes",\@temp);

# caseL: PRP<nomin:yes> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($PRP${l}nomin:yes\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP${l}nomin:yes\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$2/g;

# nmodR: NOUN<pos:1&type:C> PRP NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($NOUN${l}pos:1\|${b2}type:C\|${r})($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}pos:1\|${b2}type:C\|${r})($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# nmodR: [Fc] NOUN<type:C> PRP NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$Fc$a2)($NOUN${l}type:C\|${r})($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($NOUN${l}type:C\|${r})($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2/g;

# cc: [NP] [Fc] [NP] [Fc] [NP] CONJ<lemma:$CCoord> NP
# NEXT
# conj: NP [Fc] [NP] [Fc] [NP]  [CONJ<lemma:$CCoord>] NP
# NEXT
# punctL: [NP] [Fc] [NP] Fc NP  [CONJ<lemma:$CCoord>] [NP]
# NEXT
# conj: NP [Fc] [NP] [Fc] NP  [CONJ<lemma:$CCoord>] [NP]
# NEXT
# punctL: [NP] Fc NP [Fc] [NP]  [CONJ<lemma:$CCoord>] [NP]
# NEXT
# conj: NP [Fc] NP [Fc] [NP]  [CONJ<lemma:$CCoord>] [NP]
					@temp = ($listTags =~ /(?:$NP)(?:$Fc$a2)(?:$NP)(?:$Fc$a2)(?:$NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)(?:$Fc$a2)(?:$NP)($Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)(?:$Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)($NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)($NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($Fc$a2)($NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/$1/g;

# cc: [NP] [Fc] [NP] CONJ<lemma:$CCoord> NP
# NEXT
# conj: NP [Fc] [NP]  [CONJ<lemma:$CCoord>] NP
# NEXT
# punctL: [NP] Fc NP  [CONJ<lemma:$CCoord>] [NP]
# NEXT
# conj: NP [Fc] NP  [CONJ<lemma:$CCoord>] [NP]
					@temp = ($listTags =~ /(?:$NP)(?:$Fc$a2)(?:$NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/$1/g;

# cc: [NP] CONJ<lemma:$CCoord> NP
# NEXT
# conj: NP [CONJ<lemma:$CCoord>] NP
					@temp = ($listTags =~ /(?:$NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/$1/g;

# punctL: [NOUNS|PRO<type:D|P|I|X>] Fc|Fpa|Fca NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
# NEXT
# punctR: [NOUNS|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] NOUNS|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
# NEXT
# apposR: NOUNS|PRO<type:D|P|I|X> [Fc|Fpa|Fca] NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "apposR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/$1/g;

# punctL: [NOUNS|PRO<type:D|P|I|X>] Fc|Fpa|Fca [PRP] NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
# NEXT
# punctR: [NOUNS|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] [PRP] NOUNS|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
# NEXT
# caseL: [NOUNS|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] PRP NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
# NEXT
# apposR: NOUNS|PRO<type:D|P|I|X> [Fc|Fpa|Fca] PRP NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)(?:$PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)(?:$PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "apposR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/$1/g;

# punctL: [NOUNS|PRO<type:D|P|I|X>] Fd NOUNS|PRO<type:D|P|I|X>|CARD
# NEXT
# apposR: NOUNS|PRO<type:D|P|I|X> [Fd] NOUNS|PRO<type:D|P|I|X>|CARD
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fd$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fd$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)/g);
					$Rel =  "apposR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fd$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)/$1/g;

# aclR: NOUNS|PRO<type:D|P|I|X> [Fc|Fpa|Fca] VERB<mode:P> [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [Fc|Fpt|Fct]
# NoUniq
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($VERB${l}mode:P\|${r})(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($VERB${l}mode:P\|${r})($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($Fc$a2|$Fpt$a2|Fct)/$1$2$3$4$5$6$7$8$9$10$11$12$13$14/g;

# nmodR: CARD PRP<lemma:de|entre|sobre|of|about|between> NOUNS|PRO
					@temp = ($listTags =~ /($CARD$a2)($PRP${l}lemma:(?:de|entre|sobre|of|about|between)\|${r})($NOUNS$a2|$PRO$a2)/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($CARD$a2)($PRP${l}lemma:(?:de|entre|sobre|of|about|between)\|${r})($NOUNS$a2|$PRO$a2)/$1/g;

# nmodR: PRO<type:P> PRP<lemma:de|of> NOUNS|PRO
					@temp = ($listTags =~ /($PRO${l}type:P\|${r})($PRP${l}lemma:(?:de|of)\|${r})($NOUNS$a2|$PRO$a2)/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}type:P\|${r})($PRP${l}lemma:(?:de|of)\|${r})($NOUNS$a2|$PRO$a2)/$1/g;

# nmodR: NOUNS [PRP] [PRO<type:D|P|I|X>] PRP NOUNS|ADV
# NEXT
# nmodR: NOUNS PRP PRO<type:D|P|I|X> [PRP] [NOUNS|ADV]
					@temp = ($listTags =~ /($NOUNS$a2)(?:$PRP$a2)(?:$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($NOUNS$a2|$ADV$a2)/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2)($PRP$a2)($PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP$a2)(?:$NOUNS$a2|$ADV$a2)/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($NOUNS$a2|$ADV$a2)/$1/g;

# nsubjL: [NOUN] PRO<type:R|W> VERB
# NEXT
# aclR: NOUN [PRO<type:R|W>] VERB
# NoUniq
					@temp = ($listTags =~ /(?:$NOUN$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2)/g);
					$Rel =  "nsubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2)/$1$2$3/g;

# objL: [NOUN] PRO<type:R|W> [NOUNS|PRO<type:D|P|I|X>] VERB
# NEXT
# aclR: NOUN [PRO<type:R|W>] [NOUNS|PRO<type:D|P|I|X>] VERB
# NoUniq
					@temp = ($listTags =~ /(?:$NOUN$a2)($PRO${l}type:(?:R|W)\|${r})(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/g);
					$Rel =  "objL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$PRO${l}type:(?:R|W)\|${r})(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($PRO${l}type:(?:R|W)\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/$1$2$3$4/g;

# obl2L: [NOUNS|PRO<type:D|P|I|X>]  [PRP] PRO<type:R|W> VERB
# NEXT
# caseL: [NOUNS|PRO<type:D|P|I|X>]  PRP PRO<type:R|W> [VERB]
# NEXT
# aclR: NOUNS|PRO<type:D|P|I|X> [PRP] [PRO<type:R|W>] VERB
# NoUniq
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2)/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($PRO${l}type:(?:R|W)\|${r})(?:$VERB$a2)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2)/$1$2$3$4/g;

# aclR: NOUN|PRO<type:D|P|I|X>  VERB<mode:[GP]>
# NoUniq
					@temp = ($listTags =~ /($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[GP]\|${r})/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[GP]\|${r})/$1$2/g;

# nsubjL: PRO<sust:yes>  VERB
# Add: nomin:yes
# Inherit: number, person
					@temp = ($listTags =~ /($PRO${l}sust:yes\|${r})($VERB$a2)/g);
					$Rel =  "nsubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}sust:yes\|${r})($VERB$a2)/$2/g;
					Inherit("DepHead","number,person",\@temp);
					Add("DepHead","nomin:yes",\@temp);

# nsubjL: [PRO<sust:yes>] NOUNCOORD|PRO<type:D|P|I|X> VERB
# NEXT
# objL: PRO<sust:yes> [NOUNCOORD|PRO<type:D|P|I|X>] VERB
# Add: nomin:yes
# Inherit: number, person
					@temp = ($listTags =~ /(?:$PRO${l}sust:yes\|${r})($NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/g);
					$Rel =  "nsubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRO${l}sust:yes\|${r})(?:$NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/g);
					$Rel =  "objL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}sust:yes\|${r})($NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/$3/g;
					Inherit("DepHead","number,person",\@temp);
					Add("DepHead","nomin:yes",\@temp);

# oblR: VERB<mode:P> [NOUNS|PRO<type:D|P|I|X>] PRP<lemma:por|by> NOUNCOORD|PRO<type:D|P|I|X>|ADV
					@temp = ($listTags =~ /($VERB${l}mode:P\|${r})(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:(?:por|by)\|${r})($NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$ADV$a2)/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}mode:P\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:(?:por|by)\|${r})($NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$ADV$a2)/$1$2/g;

# punctR: VERB Fc  [PRP]? [NOUNS|PRO<type:D|P|I|X>] [PRP<lemma:$PrepMA>] [CARD|DATE]
# NEXT
# oblR: VERB [Fc]?  [PRP]? [NOUNS|PRO<type:D|P|I|X>] PRP<lemma:$PrepMA> CARD|DATE
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)?(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP${l}lemma:$PrepMA\|${r})(?:$CARD$a2|$DATE$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?(?:$PRP$a2)?(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:$PrepMA\|${r})($CARD$a2|$DATE$a2)/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)?($PRP$a2)?($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:$PrepMA\|${r})($CARD$a2|$DATE$a2)/$1$3$4/g;

# nsubjR: NOUN<number:S> [VERB<number:P&lemma:ser|estar>] NOUN<number:P>
# NEXT
# cop2R: NOUN<number:S> VERB<number:P&lemma:ser|estar> [NOUN<number:P>]
# Inherit: person, number, tense, mode
					@temp = ($listTags =~ /($NOUN${l}number:S\|${r})(?:$VERB${l}lemma:(?:ser|estar)\|${b2}number:P\|${r})($NOUN${l}number:P\|${r})/g);
					$Rel =  "nsubjR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUN${l}number:S\|${r})($VERB${l}lemma:(?:ser|estar)\|${b2}number:P\|${r})(?:$NOUN${l}number:P\|${r})/g);
					$Rel =  "cop2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}number:S\|${r})($VERB${l}lemma:(?:ser|estar)\|${b2}number:P\|${r})($NOUN${l}number:P\|${r})/$1/g;
					Inherit("HeadDep","person,number,tense,mode",\@temp);

# cop2L: VERB<lemma:ser> VERB<nomin:yes>
# Add: cop:yes
# Inherit: person, number, tense, mode
					@temp = ($listTags =~ /($VERB${l}lemma:ser\|${r})($VERB${l}nomin:yes\|${r})/g);
					$Rel =  "cop2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:ser\|${r})($VERB${l}nomin:yes\|${r})/$2/g;
					Inherit("DepHead","person,number,tense,mode",\@temp);
					Add("DepHead","cop:yes",\@temp);

# cop2L: VERB<lemma:ser|estar> NOUNS|ADJ|ADV|VERB<mode:P>|PRO<type:D|P|I|X>
# Add: cop:yes
# Inherit: person, number, tense, mode
					@temp = ($listTags =~ /($VERB${l}lemma:(?:ser|estar)\|${r})($NOUNS$a2|$ADJ$a2|ADV|$VERB${l}mode:P\|${r}|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "cop2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:ser|estar)\|${r})($NOUNS$a2|$ADJ$a2|ADV|$VERB${l}mode:P\|${r}|$PRO${l}type:(?:D|P|I|X)\|${r})/$2/g;
					Inherit("DepHead","person,number,tense,mode",\@temp);
					Add("DepHead","cop:yes",\@temp);

# copL: VERB<lemma:ser|estar> PRP NOUNS|ADJ|ADV|VERB<mode:P>|PRO<type:D|P|I|X>
# Add: cop:yes
# Inherit: person, number, tense, mode
					@temp = ($listTags =~ /($VERB${l}lemma:(?:ser|estar)\|${r})($PRP$a2)($NOUNS$a2|$ADJ$a2|ADV|$VERB${l}mode:P\|${r}|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "copL";
					DepRelHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:ser|estar)\|${r})($PRP$a2)($NOUNS$a2|$ADJ$a2|ADV|$VERB${l}mode:P\|${r}|$PRO${l}type:(?:D|P|I|X)\|${r})/$3/g;
					Inherit("DepRelHead","person,number,tense,mode",\@temp);
					Add("DepRelHead","cop:yes",\@temp);

# obl2R:  VERB CARD<date:yes>|NOUN<lemma:$Day>
					@temp = ($listTags =~ /($VERB$a2)($CARD${l}date:yes\|${r}|$NOUN${l}lemma:$Day\|${r})/g);
					$Rel =  "obl2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CARD${l}date:yes\|${r}|$NOUN${l}lemma:$Day\|${r})/$1/g;

# punctL: Fc [CARD<date:yes>|NOUN<lemma:$Day>] VERB
# NEXT
# obl2L:  [Fc]? CARD<date:yes>|NOUN<lemma:$Day> VERB
					@temp = ($listTags =~ /($Fc$a2)(?:$CARD${l}date:yes\|${r}|$NOUN${l}lemma:$Day\|${r})($VERB$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?($CARD${l}date:yes\|${r}|$NOUN${l}lemma:$Day\|${r})($VERB$a2)/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($CARD${l}date:yes\|${r}|$NOUN${l}lemma:$Day\|${r})($VERB$a2)/$3/g;

# objR: VERB  NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($VERB$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "objR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# cc: [VERB<nomin:no>] [Fc] [VERB<nomin:no>] [Fc] [VERB<nomin:no>] CONJ<lemma:$CCoord> VERB<nomin:no>
# NEXT
# conj: VERB<nomin:no> [Fc] [VERB<nomin:no>] [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] VERB<nomin:no>
# NEXT
# punctL: [VERB<nomin:no>] [Fc] [VERB<nomin:no>] Fc VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
# NEXT
# conj: VERB<nomin:no> [Fc] [VERB<nomin:no>] [Fc] VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
# NEXT
# punctL: [VERB<nomin:no>] Fc VERB<nomin:no> [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
# NEXT
# conj: VERB<nomin:no> [Fc] VERB<nomin:no> [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/$1/g;

# cc: [VERB<nomin:no>] [Fc] [VERB<nomin:no>] CONJ<lemma:$CCoord> VERB<nomin:no>
# NEXT
# conj: VERB<nomin:no> [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] VERB<nomin:no>
# NEXT
# punctL: [VERB<nomin:no>] Fc VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
# NEXT
# conj: VERB<nomin:no> [Fc] VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/$1/g;

# cc: [VERB<nomin:no>] CONJ<lemma:$CCoord> VERB<nomin:no>
# NEXT
# conj: VERB<nomin:no> [CONJ<lemma:$CCoord>] VERB<nomin:no>
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/$1/g;

# oblR: VERB PRP NOUNS|PRO<type:D|P|I|X>
# Recursivity: 3
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# punctR: VERB Fc [PRP] [NOUNS|PRO<type:D|P|I|X>] [Fc]?
# NEXT
# punctR: VERB [Fc] [PRP] [NOUNS|PRO<type:D|P|I|X>] Fc
# NEXT
# oblR: VERB [Fc] PRP NOUNS|PRO<type:D|P|I|X> [Fc]?
# Recursivity:1
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?/$1/g;
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?/$1/g;

# punctL: [PRP<pos:1>] [NOUNS|PRO<type:D|P|I|X>] Fc  VERB<mode:[^PNG]>
# NEXT
# caseL: PRP<pos:1> NOUNS|PRO<type:D|P|I|X> [Fc]?  [VERB<mode:[^PNG]>]
# NEXT
# obl2L: [PRP<pos:1>] NOUNS|PRO<type:D|P|I|X> [Fc]?  VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$PRP${l}pos:1\|${r})(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP${l}pos:1\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP${l}pos:1\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP${l}pos:1\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/$4/g;

# punctL: [Fc] [PRP] [NOUNS|PRO<type:D|P|I|X>] Fc  VERB<mode:[^PNG]>
# NEXT
# punctL: Fc [PRP] [NOUNS|PRO<type:D|P|I|X>] [Fc]?  VERB<mode:[^PNG]>
# NEXT
# caseL: [Fc] PRP NOUNS|PRO<type:D|P|I|X> [Fc]?  [VERB<mode:[^PNG]>]
# NEXT
# obl2L: [Fc] [PRP] NOUNS|PRO<type:D|P|I|X> [Fc]?  VERB<mode:[^PNG]>
# Recursivity:1
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/$5/g;
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/$5/g;

# caseL: [CONJ] PRP NOUNS|PRO<type:D|P|I|X> [Fc]?  [VERB<mode:[^PNG]>]
# NEXT
# obl2L: [CONJ] [PRP] NOUNS|PRO<type:D|P|I|X> [Fc]?  VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$CONJ$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$CONJ$a2)(?:$PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($CONJ$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/$1$4$5/g;

# caseL: [NOUN] PRP<lemma:de> [CONJ<lemma:que>] VERB
# NEXT
# markL: [NOUN] [PRP<lemma:de>] CONJ<lemma:que> VERB
# NEXT
# obl2L: NOUN [PRP<lemma:de>] [CONJ<lemma:que>] VERB
					@temp = ($listTags =~ /(?:$NOUN$a2)($PRP${l}lemma:de\|${r})(?:$CONJ${l}lemma:que\|${r})($VERB$a2)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)(?:$PRP${l}lemma:de\|${r})($CONJ${l}lemma:que\|${r})($VERB$a2)/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$PRP${l}lemma:de\|${r})(?:$CONJ${l}lemma:que\|${r})($VERB$a2)/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($PRP${l}lemma:de\|${r})($CONJ${l}lemma:que\|${r})($VERB$a2)/$4/g;

# objR: VERB  NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($VERB$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "objR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# xcomp2R: VERB  VERB<mode:[PNG]>|ADJ
					@temp = ($listTags =~ /($VERB$a2)($VERB${l}mode:[PNG]\|${r}|$ADJ$a2)/g);
					$Rel =  "xcomp2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($VERB${l}mode:[PNG]\|${r}|$ADJ$a2)/$1/g;

# xcompR: VERB PRP VERB
# Recursivity:1
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)($VERB$a2)/g);
					$Rel =  "xcompR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($VERB$a2)/$1/g;
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)($VERB$a2)/g);
					$Rel =  "xcompR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($VERB$a2)/$1/g;

# markL: [VERB] [PRP] CONJ<lemma:que> VERB<mode:[^PNG]>
# NEXT
# xcompR: VERB PRP [CONJ<lemma:que>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$PRP$a2)($CONJ${l}lemma:que\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)(?:$CONJ${l}lemma:que\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "xcompR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($CONJ${l}lemma:que\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

# nmodR: NOUNS PRP NOUNS
					@temp = ($listTags =~ /($NOUNS$a2)($PRP$a2)($NOUNS$a2)/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)/$1/g;

# markL: [VERB] CONJ<lemma:que|si|that> VERB<mode:[^PNG]>
# NEXT
# ccompR: VERB  [CONJ<lemma:que|si|that>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)($CONJ${l}lemma:(?:que|si|that)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$CONJ${l}lemma:(?:que|si|that)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "ccompR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}lemma:(?:que|si|that)\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

# markL: [VERB]  CONJ<lemma:que|si|that>  [NOUNS|PRO<type:D|P|I|X>] VERB<mode:[^PNG]>
# NEXT
# nsubjL:  [VERB]  [CONJ<lemma:que|si|that>]  NOUNS|PRO<type:D|P|I|X> VERB<mode:[^PNG]>
# NEXT
# ccompR: VERB [CONJ<lemma:que|si|that>] [NOUNS|PRO<type:D|P|I|X>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)($CONJ${l}lemma:(?:que|si|that)\|${r})(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$CONJ${l}lemma:(?:que|si|that)\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "nsubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$CONJ${l}lemma:(?:que|si|that)\|${r})(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "ccompR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}lemma:(?:que|si|that)\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

# ccompR: VERB VERB<nomin:yes>
					@temp = ($listTags =~ /($VERB$a2)($VERB${l}nomin:yes\|${r})/g);
					$Rel =  "ccompR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($VERB${l}nomin:yes\|${r})/$1/g;

# punctL: [NOUNS|PRO<type:D|P|I|X>] Fc|Fpa|Fca NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
# NEXT
# punctR: [NOUNS|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] NOUNS|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
# NEXT
# apposR: NOUNS|PRO<type:D|P|I|X> [Fc|Fpa|Fca] NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "apposR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/$1/g;

# punctL: [NOUNS|PRO<type:D|P|I|X>] Fc|Fpa|Fca [PRP] NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
# NEXT
# punctR: [NOUNS|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] [PRP] NOUNS|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
# NEXT
# caseL: [NOUNS|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] PRP NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
# NEXT
# apposR: NOUNS|PRO<type:D|P|I|X> [Fc|Fpa|Fca] PRP NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)(?:$PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)(?:$PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "apposR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/$1/g;

# punctL: [NOUNS|PRO<type:D|P|I|X>] Fd NOUNS|PRO<type:D|P|I|X>|CARD
# NEXT
# apposR: NOUNS|PRO<type:D|P|I|X> [Fd] NOUNS|PRO<type:D|P|I|X>|CARD
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fd$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fd$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)/g);
					$Rel =  "apposR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fd$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)/$1/g;

# punctR: NOUNS|PRO<type:D|P|I|X> Fc|Fpa|Fca [VERB<mode:P>]  [Fc|Fpt|Fct]
# NEXT
# punctR: NOUNS|PRO<type:D|P|I|X> [Fc|Fpa|Fca] [VERB<mode:P>]  Fc|Fpt|Fct
# NEXT
# aclR: NOUNS|PRO<type:D|P|I|X> [Fc|Fpa|Fca] VERB<mode:P>  [Fc|Fpt|Fct]
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)(?:$VERB${l}mode:P\|${r})(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)(?:$VERB${l}mode:P\|${r})($Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($VERB${l}mode:P\|${r})(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($VERB${l}mode:P\|${r})($Fc$a2|$Fpt$a2|Fct)/$1/g;

# advclL: [Fc] VERB<mode:P> [Fc] VERB
# NEXT
# punctL: Fc [VERB<mode:P>] [Fc] VERB
# NEXT
# punctL: [Fc] [VERB<mode:P>] Fc VERB
					@temp = ($listTags =~ /(?:$Fc$a2)($VERB${l}mode:P\|${r})(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "advclL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($Fc$a2)(?:$VERB${l}mode:P\|${r})(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$VERB${l}mode:P\|${r})($Fc$a2)($VERB$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($VERB${l}mode:P\|${r})($Fc$a2)($VERB$a2)/$4/g;

# cc: [NP] [Fc] [NP] [Fc] [NP] CONJ<lemma:$CCoord> NP
# NEXT
# conj: NP [Fc] [NP] [Fc] [NP]  [CONJ<lemma:$CCoord>] NP
# NEXT
# punctL: [NP] [Fc] [NP] Fc NP  [CONJ<lemma:$CCoord>] [NP]
# NEXT
# conj: NP [Fc] [NP] [Fc] NP  [CONJ<lemma:$CCoord>] [NP]
# NEXT
# punctL: [NP] Fc NP [Fc] [NP]  [CONJ<lemma:$CCoord>] [NP]
# NEXT
# conj: NP [Fc] NP [Fc] [NP]  [CONJ<lemma:$CCoord>] [NP]
					@temp = ($listTags =~ /(?:$NP)(?:$Fc$a2)(?:$NP)(?:$Fc$a2)(?:$NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)(?:$Fc$a2)(?:$NP)($Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)(?:$Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)($NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)($NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($Fc$a2)($NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/$1/g;

# cc: [NP] [Fc] [NP] CONJ<lemma:$CCoord> NP
# NEXT
# conj: NP [Fc] [NP]  [CONJ<lemma:$CCoord>] NP
# NEXT
# punctL: [NP] Fc NP  [CONJ<lemma:$CCoord>] [NP]
# NEXT
# conj: NP [Fc] NP  [CONJ<lemma:$CCoord>] [NP]
					@temp = ($listTags =~ /(?:$NP)(?:$Fc$a2)(?:$NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/$1/g;

# cc: [NP] CONJ<lemma:$CCoord> NP
# NEXT
# conj: NP [CONJ<lemma:$CCoord>] NP
					@temp = ($listTags =~ /(?:$NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/$1/g;

# cc: [VERB<nomin:no>] [Fc] [VERB<nomin:no>] [Fc] [VERB<nomin:no>] CONJ<lemma:$CCoord> VERB<nomin:no>
# NEXT
# conj: VERB<nomin:no> [Fc] [VERB<nomin:no>] [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] VERB<nomin:no>
# NEXT
# punctL: [VERB<nomin:no>] [Fc] [VERB<nomin:no>] Fc VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
# NEXT
# conj: VERB<nomin:no> [Fc] [VERB<nomin:no>] [Fc] VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
# NEXT
# punctL: [VERB<nomin:no>] Fc VERB<nomin:no> [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
# NEXT
# conj: VERB<nomin:no> [Fc] VERB<nomin:no> [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/$1/g;

# cc: [VERB<nomin:no>] [Fc] [VERB<nomin:no>] CONJ<lemma:$CCoord> VERB<nomin:no>
# NEXT
# conj: VERB<nomin:no> [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] VERB<nomin:no>
# NEXT
# punctL: [VERB<nomin:no>] Fc VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
# NEXT
# conj: VERB<nomin:no> [Fc] VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/$1/g;

# cc: [VERB<nomin:no>] CONJ<lemma:$CCoord> VERB<nomin:no>
# NEXT
# conj: VERB<nomin:no> [CONJ<lemma:$CCoord>] VERB<nomin:no>
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/$1/g;

# markL: [VERB] [ADV]? PRP<lemma:$PrepLocs> [ADV]? VERB<mode:N>
# NEXT
# xcompR: VERB [ADV]? [PRP<lemma:$PrepLocs>]? [ADV]? VERB<mode:N>
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$ADV$a2)?(?:$PRP${l}lemma:$PrepLocs\|${r})?(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "xcompR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r})?($ADV$a2)?($VERB${l}mode:N\|${r})/$1$2$4/g;

# nsubjL: NOUN<type:P> VERB<mode:[^PG]>
# Add: subj:yes
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($VERB${l}mode:[^PG]\|${r})/g);
					$Rel =  "nsubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($VERB${l}mode:[^PG]\|${r})/$2/g;
					Add("DepHead","subj:yes",\@temp);

# nsubjL: NOUNS|PRO<type:D|P|I|X> VERB<mode:[^PG]>
# Add: subj:yes
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PG]\|${r})/g);
					$Rel =  "nsubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PG]\|${r})/$2/g;
					Add("DepHead","subj:yes",\@temp);

# csubjL: VERB<nomin:yes> VERB<mode:[^PG]>
# Add: subj:yes
					@temp = ($listTags =~ /($VERB${l}nomin:yes\|${r})($VERB${l}mode:[^PG]\|${r})/g);
					$Rel =  "csubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:yes\|${r})($VERB${l}mode:[^PG]\|${r})/$2/g;
					Add("DepHead","subj:yes",\@temp);

# punctL: [NOUN|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>] VERB<subj:yes>   [Fc]?
# NEXT
# punctR: [NOUN|PRO<type:D|P|I|X>] [Fc] [PRO<type:R|W>] VERB<subj:yes>  Fc
# NEXT
# objL: [NOUN|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W> VERB<subj:yes>   [Fc]?
# NEXT
# aclR: NOUN|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>] VERB<subj:yes>    [Fc]?
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r})(?:$Fc$a2)?/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r})($Fc$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r})(?:$Fc$a2)?/g);
					$Rel =  "objL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r})(?:$Fc$a2)?/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r})($Fc$a2)?/$1/g;

# punctL: [NOUN|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>] VERB   [Fc]?
# NEXT
# punctR: [NOUN|PRO<type:D|P|I|X>] [Fc]? [PRO<type:R|W>] VERB Fc
# NEXT
# nsubjL: [NOUN|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W> VERB  [Fc]?
# NEXT
# aclR: NOUN|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>] VERB [Fc]?
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)(?:$Fc$a2)?/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)($Fc$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r})($VERB$a2)(?:$Fc$a2)?/g);
					$Rel =  "nsubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)(?:$Fc$a2)?/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r})($VERB$a2)($Fc$a2)?/$1/g;

# punctL: [NOUN|PRO<type:D|P|I|X>] Fc [PRP] [PRO<type:R|W>] VERB   [Fc]?
# NEXT
# punctR: [NOUN|PRO<type:D|P|I|X>] [Fc]?  [PRP] [PRO<type:R|W>] VERB Fc
# NEXT
# obl2L: [NOUN|PRO<type:D|P|I|X>] [Fc]? [PRP] PRO<type:R|W> VERB  [Fc]?
# NEXT
# caseL: [NOUN|PRO<type:D|P|I|X>] [Fc]? PRP PRO<type:R|W> [VERB]  [Fc]?
# NEXT
# aclR: NOUN|PRO<type:D|P|I|X> [Fc]? [PRP] [PRO<type:R|W>] VERB [Fc]?
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)(?:$Fc$a2)?/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)($Fc$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2)(?:$Fc$a2)?/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r})(?:$VERB$a2)(?:$Fc$a2)?/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)(?:$Fc$a2)?/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2)($Fc$a2)?/$1/g;

# punctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc VERB<mode:[GP]>
# NEXT
# aclR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? VERB<mode:[GP]>
					@temp = ($listTags =~ /(?:$NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB${l}mode:[GP]\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[GP]\|${r})/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[GP]\|${r})/$1/g;

# markR: VERB [Fc]? CONJ<type:S> [VERB]
# NEXT
# punctR: VERB Fc [CONJ<type:S>] [VERB]
# NEXT
# advclR: VERB [Fc]? [CONJ<type:S>] VERB
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?($CONJ${l}type:S\|${r})(?:$VERB$a2)/g);
					$Rel =  "markR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$CONJ${l}type:S\|${r})(?:$VERB$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?(?:$CONJ${l}type:S\|${r})($VERB$a2)/g);
					$Rel =  "advclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)?($CONJ${l}type:S\|${r})($VERB$a2)/$1/g;

# markL:  CONJ<type:S> VERB [Fc]? [VERB]
# NEXT
# punctR:  [CONJ<type:S>] VERB Fc [VERB]
# NEXT
# advclR: [CONJ<type:S>] VERB [Fc]? VERB
					@temp = ($listTags =~ /($CONJ${l}type:S\|${r})($VERB$a2)(?:$Fc$a2)?(?:$VERB$a2)/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$CONJ${l}type:S\|${r})($VERB$a2)($Fc$a2)(?:$VERB$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$CONJ${l}type:S\|${r})($VERB$a2)(?:$Fc$a2)?($VERB$a2)/g);
					$Rel =  "advclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($CONJ${l}type:S\|${r})($VERB$a2)($Fc$a2)?($VERB$a2)/$2/g;

# punctR: X Fz|Fe
					@temp = ($listTags =~ /($X$a2)($Fz$a2|$Fe$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($X$a2)($Fz$a2|$Fe$a2)/$1/g;

# punctL: Fz|Fe X
					@temp = ($listTags =~ /($Fz$a2|$Fe$a2)($X$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fz$a2|$Fe$a2)($X$a2)/$2/g;

# caseL: PRP NOUNS|VERB|ADJ|ADV
					@temp = ($listTags =~ /($PRP$a2)($NOUNS$a2|$VERB$a2|ADJ|ADV)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUNS$a2|$VERB$a2|ADJ|ADV)/$2/g;

# punctR: X PUNCT|SENT|SYM
# Recursivity: 1
					@temp = ($listTags =~ /($X$a2)($PUNCT$a2|$SENT$a2|SYM)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($X$a2)($PUNCT$a2|$SENT$a2|SYM)/$1/g;
					@temp = ($listTags =~ /($X$a2)($PUNCT$a2|$SENT$a2|SYM)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($X$a2)($PUNCT$a2|$SENT$a2|SYM)/$1/g;

# punctL: PUNCT|SENT|SYM X
# Recursivity: 1
					@temp = ($listTags =~ /($PUNCT$a2|$SENT$a2|SYM)($X$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PUNCT$a2|$SENT$a2|SYM)($X$a2)/$2/g;
					@temp = ($listTags =~ /($PUNCT$a2|$SENT$a2|SYM)($X$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PUNCT$a2|$SENT$a2|SYM)($X$a2)/$2/g;

