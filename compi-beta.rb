# -*- coding: utf-8 -*-
#
# COMPI: Transform linguistic rules subtitutions pseudocode to a real perl code
#


# Name of the out file with the generated code
$NAME_OUT_FILE = "parserFromDPG.perl"

################ AUXILIAR FUNCTIONS
# Clean white spaces (tabs and newlines) before and after last letters
def limpa_brancos(cadea)
	if cadea == nil
		return cadea
	end
	while cadea[0..0] == " " || cadea[0..0] == "\t"
		cadea = cadea[1..-1]
	end
	while cadea[-1..-1] == " " || cadea[-1..-1] == "\n" || cadea[-1..-1] == "\t"
		cadea = cadea[0..-2]
	end
	cadea
end	

# Give the tokens into an array from a regexp and a string (idea is catch expresion between two characters like this /(<[^>]+>)/ expresions beetween < and >)
def tokenizer(pattern,cadea)
	pieces = Array.new
	while (true)
		offset = pattern =~ cadea
		part = pattern.match(cadea)
		if (part.to_a[0] == nil)
			break
		end
		pieces << part.to_a[0]
		cadea = cadea[(offset + part.to_a[0].size)..-1]
	end 
	pieces
end

class String
	# From an array of strings and a string, split_pro do all the splits to the same array and the same level and return it
	def split_pro(strings)
		cadea = self
		parts = Array.new
		separators = Array.new
		begin
			first_separator = nil
			first_separator_position = cadea.size+1
			strings.each do |string|
				regexp = Regexp.compile(string.gsub(/(.)/,"[\\1]"))
				if (cadea =~ regexp) != nil && (cadea =~ regexp) < first_separator_position
					first_separator_position = (cadea =~ regexp)
					first_separator = string
				end
			end
			if first_separator != nil
				parts << cadea[0...first_separator_position]
				separators << cadea[first_separator_position...(first_separator_position+first_separator.size)]
				cadea = cadea[(first_separator_position+first_separator.size)..-1]
			end
		end until first_separator == nil
		if cadea.size > 0
			parts << cadea
		end

		$ssp = separators
		parts
	end
end

	# From two arrays return another array with the values that exists in both arrays
	def array_intersection(a,b)
		intersec = Array.new
		a.each do |aa|
			b.each do |bb|
				if aa == bb
					intersec << aa
				end
			end
		end		
		intersec
	end

# Read file src/name_function.conf to a gloval var named $name_function wich is a hash of strings
def name_function(deps)
	substitutions = Hash["HeadDep" => 1,"DepHead" => 2,"HeadRelDep" => 1,"DepRelHead" => 3,"HeadDep_lex" => 1,"DepHead_lex" => 2, "Head" => 1,"RelDepHead" => 3, "RelHeadDep" => 2, "DepHeadRel" => 2, "HeadDepRel" => 1, "RelDepHead_lex" => 3, "RelHeadDep_lex" => 2, "DepHeadRel_lex" => 2, "HeadDepRel_lex" => 1] # Counting since 1
	$name_function = Hash.new
	$name_function.default = "NOT_FOUND_NAME_FUNCTION"
	$name_substitution = Hash.new
	$name_substitution.default = -10
	
	file_nf = File.open(deps + "/dependencies.conf")
	file_nf.each do |line|
		if line[0..0] != "#"
			$name_function[line.split(" ")[0]] = line.split(" ")[1]
			$name_substitution[line.split(" ")[0]] = substitutions[line.split(" ")[1]]
		end
	end
	$rel_position = Hash["HeadRelDep" => 1,"DepRelHead" => 1,"RelDepHead" => 0, "RelHeadDep" => 0, "DepHeadRel" => 2, "HeadDepRel" => 2, "RelDepHead_lex" => 0, "RelHeadDep_lex" => 0, "DepHeadRel_lex" => 2, "HeadDepRel_lex" => 2] # Counting since 0
end

# Creates the initial code in a stringwith vars defined in tagset.conf and lexical_classes.conf
def initial_code(deps)
	$atalhos_r = Array.new  #Cria um array com super-atalhos que terminam em ${r} (Com ele resolvemos o BUG de ter super atalhos terminados em ${r} aos que se lhe adire um $a)
	out = ""
	# postag.conf
	out << " POS TAGS ".center(90,"#") + "\n"
	file_ts = File.open(deps + "/tagset.conf")
	file_ts.each do |line|
		if line[0..0] != "#" && line[0..-1] != "" && limpa_brancos(line.split(" ")[1]) != nil
			exp = limpa_brancos(line.split(" ")[1])
			exp = exp.gsub("|","_[0-9]+$a2|")
			exp = exp.gsub(">_[0-9]+$a2|","${r}|")
			exp = exp.gsub(">","${r}")
			exp = exp.gsub("<","_[0-9]+${l}")
			exp = exp.gsub("${r}_[0-9]+","${r}") # Parche para o BUG: deveria gerar: $NC = "NOUN_[0-9]+${l}type:C${r}"; e não: $NC = "NOUN_[0-9]+${l}type:C${r}_[0-9]+"; 
			if exp[-1..-1] != "}" # Nao engade o _[0-9]+ as cadeias que terminem em "}"
				exp << "_[0-9]+"
			end
			out << 'my $' + limpa_brancos(line.split(" ")[0]) + ' = "' + exp + '";#<string>' + "\n"
			# Engadimos os nomes dos tags que terminam em r
			if exp[-4..-1] == "${r}"
				$atalhos_r << limpa_brancos(line.split(" ")[0])
			end
		end
	end
	out << "\n\n\n" + " LEXICAL CLASSES ".center(90,"#") + "\n"
	# lexical_classes.conf
 	file_lc = File.open(deps + "/lexical_classes.conf")
	file_lc.each do |line|
		if line[0..0] != "#" && line[0..-1] != "" && limpa_brancos(line.split("=")[1]) != nil
			out << "my " + line.split("=")[0] + ' = "(?:' + limpa_brancos(line.split("=")[1]).gsub(" ",'\\\\|') + '\\|)";#<string>' + "\n"
		end
	end
	out
end

################ CLASS DEFINITION
class Definition
	#Constructor
	def initialize(instruction)
		# instruction sintax::     RuleName: (Adj|Noun)? [Verb] Adv -> 1 \n Recursivity: 2 \n agr: genre number \n Inherit type mode
		lines = instruction.split("\n")		

		# First line (obligatory)
		@name = lines[0].split(':')[0]
		@name = limpa_brancos(@name)
		@elements = lines[0].sub(/^[^:]+:\s/,"").split(" ")
		@elements.collect {|r| limpa_brancos(r)}

		# Second and rest lines (optional)
		@recursivity = 0 # int
		@agr = "" # string with the list of attributes with colon and no spaces insde the string, empty string by default because ist allways printed
		@agr_statement = false # Boolean only used in the block rules to put the statement in the las rule
		@inherit = nil # string with the list separated with colon and no spaces inside the string
		@add = nil # string with a lista of "pair:value" with colon and no spaces inside the string
		@nouniq = false # false by default, true if explicit
                @remove = false # false by default, true if explicit
		if lines[1] != nil
			lines = lines[1..-1]
			lines.each do |line|
				if (/[Rr]ecursivity/ =~ line) != nil && line.split(':')[1] != nil && limpa_brancos(line.split(':')[1]) != ""
					@recursivity = line.split(':')[1]
					@recursivity = limpa_brancos(@recursivity).to_i
				end
				if ((/[Aa]gr/ =~ line) != nil || (/[Aa]greement/ =~ line) != nil) && line.split(':')[1] != nil
					@agr = limpa_brancos(line.split(':')[1]).gsub(/,[\s]*/," ").gsub(" ",",").gsub("@",'\@') # @ subs its for two words relationship
					@agr.collect { |c| limpa_brancos(c)}
				end
				if (/[Ii]nherit/ =~ line) != nil && line.split(':')[1] != nil
					@inherit = limpa_brancos(line.split(':')[1]).gsub(/,[\s]*/," ").gsub(" ",",").gsub("@",'\@') # @ subs its for two words relationship
				end
				if (/[Aa]dd/ =~ line) != nil && line.split(':')[1] != nil
					@add = limpa_brancos(line.gsub(/^[^:]+:/,"")).gsub(", "," ").gsub(","," ").gsub(" ",",").gsub("@",'\@') # @ subs its for two words relationship
				end
				if (/[Cc]orr/ =~ line) != nil && line.split(':')[1] != nil
					@corr = limpa_brancos(line.gsub(/^[^:]+:/,"")).gsub(", "," ").gsub(","," ").gsub(" ",",").gsub("@",'\@') # @ subs its for two words relationship
				end
				if (/[Nn]o[Uu]niq(ue)?/ =~ line) != nil
					@nouniq = true
				end
                                if (/[Re]move/ =~ line) != nil
					@remove = true
				end
			end
		end
		
		# Other attributes
		@exists_lex = ($name_function[@name][-3..-1] == "lex") # Creates a boolean var for lex (reason is about blocks)
		@negative_context_l = ""
		@negative_context_r = ""
		# Creates regular expressions used by another functions
		creates_regexp
	end

	# Return the piece of code of the pre optional code from the negative contexto --[] and -[] (nil if there aren't)
	def pre_code
		out_code = ""
		if @negative_context_l != ""
			out_code << "\t\t\t\t\tmy $CNTXL = negL($#{@negative_context_l});#<string>\n"
		end
		if @negative_context_r != ""
			out_code << "\t\t\t\t\tmy $CNTXR = negR($#{@negative_context_r});#<string>\n"
		end
		if out_code == ""
			return nil
		end
		out_code
                
	end
	
	# Return the piece of code from the definition without the substitution line
	def main_code
		# Creates the expresion's real code
		out_code = ""		
		out_code << "\t\t\t\t\t@temp = ($listTags =~ #{@regexp_dep}g);\n"
		out_code << "\t\t\t\t\t" + '$Rel =  "' + @name + '";' + "\n"
		out_code << "\t\t\t\t\t#{$name_function[@name]}" + '($Rel,"' + @agr + '",\@temp);' + "\n"		
		if $name_function[@name] == $name_function.default
			raise StandardError, "Warning. Function for the rule '" + @name + "' was not found. Try to add the function to the file dependencies.conf"
		end
		out_code
	end

	# Return the code for the substitution (type is a string, in case of bloc type = "block" in another case don't care)
	def subs_code
		# If we don't want to do the substitution @nouniq is true, else we put the numbers of substitution
               if @nouniq
                        # all_subs_elements contains a $1$2$3...$n being n=size of @elements because we want leave all the elements
                        all_subs_elements = ""
                        (@elements.size+1).times do |i|
                                if i == 0
                                        next
                                end
                                all_subs_elements << "$" + i.to_s
                        end
                        out_code = "\t\t\t\t\t$listTags =~ s#{@regexp_subs}" + all_subs_elements + "/g;\n"
                #end
                  # If we  want to do the substitution for all elements @uniq is true, else we remove the numbers of substitution
	       elsif @remove
                     	# all_subs_elements contains "" because we want to remove all the elements   
                       
                       
                        out_code = "\t\t\t\t\t$listTags =~ s#{@regexp_subs}" + "/g;\n"
                 
               else
                        out_code = "\t\t\t\t\t$listTags =~ s#{@regexp_subs}" + number_subs + "/g;\n"
               end
                # If there are agreements (it's placed here because it's only called after substitution line
               # if @agr != "" || @agr_statement
                 #       out_code << '$listTags =~ s/concord:[01]\|//g' + ";\n"
               # end
                out_code

                
                
               # # If there are agreements (it's placed here because it's only called after substitution line
                if @agr != "" || @agr_statement
                        out_code << "\t\t\t\t\t" + '$listTags =~ s/concord:[01]\|//g' + ";\n"
                end
                out_code
	

           
	end

	# Return the code of the options: LEX, add, inherit and agreement. Nil if there aren't changes
	def opt_code
		out_code = ""
		if @exists_lex
			out_code << "\t\t\t\t\t" + "LEX();\n"	
		end
		if @inherit != nil
			out_code << "\t\t\t\t\t" + 'Inherit("' + $name_function[@name] + '","' + @inherit + '",\@temp);' + "\n"
		end
		if @add != nil
			out_code << "\t\t\t\t\t" + 'Add("' + $name_function[@name] + '","' + @add + '",\@temp);' + "\n"
		end
		if @corr != nil
			out_code << "\t\t\t\t\t" + 'Corr("' + $name_function[@name] + '","' + @corr + '",\@temp);' + "\n"
		end
		if out_code != ""
			return out_code
		else
			return nil
		end
	end

	# Return the value of recursivity plus 1 (to use in an iterator)
	def recursivity
		@recursivity + 1 # we need to add 1 because this atributte begins in zero	
	end

	# Return the value of @regexp_subs
	def regexp_subs
		@regexp_subs
	end

	# Set function to put the value of the regexp_subs of the element of before (only used in blocks)
	def set_before_regexp_subs(value)
		@before_regexp_subs = value # In fact this update of the value is not necesary if the next is not true but it remains for more legible code (if don't understand forget)
		if @before_regexp_subs.include? "concord:1" 
			@regexp_subs = agr_generate_regexp_subs(@regexp_dep) # Update the var regexp_sub with the new data
		end
	end


	def pretty_print
		print "#{@name}: "
		@elements.each { |e| print e + " "}
		print "\nRecursivity: #{@recursivity}"
		if @agr != nil
			print "\nagr: "
			@agr.each { |c| print c + " "}
		end
		if @inherit != nil
			print "\nInherit: "
			@inherit.each { |i| print i + " "}
		end
			print "\nRegexp_subs: #{@regexp_subs}\n"
			print "Before_regexp_subs: #{@before_regexp_subs}\n"
	end

	# Function to know if instruction is lexical
	def lex?
		@exists_lex
	end
	
	# Function to know if instruction have an agreement
	def agr?
		(@agr != "")
	end
	
	# This function is only used by blocks, because there is a bug that no put the $listTags =~ s/concord:[01]\|//g; at the end of the expressions (if program grow up in this way maybe this need to be do it more elegantly)
	def set_exists_agr_statement
		@agr_statement = true
	end

	# Function to modify @exists_lex
	def set_exists_lex(entrada)
		@exists_lex = entrada
	end

	# Function that returns an array with the number of context of the instruction
	def number_contexts
		@subs_context
	end

	# Function that modifies the subs_context var (array with numbers of context items)
	def set_subs_context(entrada)
		@subs_context = entrada
	end

	# RPIVATE FUNCTIONS
	private

	# Creates the regular expressions used by the code and subs functions (ONLY EXECUTED AT CREATE THE OBJECT)
	def creates_regexp
		# Creates regular expressions for dependencies and for substitutions, save positions of context for substitution
		@regexp_dep = "" 
		@regexp_subs = nil
		@subs_context = Array.new # Array of int with the positions of the context
		@subs_offset = 0  # Offset off the substitution number (from the function) incremented when exist context and head is not before
		head_pos = $name_substitution[@name] # Position of the head in the no_context items
		no_context_items = 1 # Count the number of no_context items
		i = 1
		# Adapt each element to regular expression
		@elements.each do |item|
			# Transform context "[]" in real context "?:", normalize "()" and transform negative context "-[]" and "--[]" in real negative context "?!" and 
			if item[0..1] == "-[" && item[-2..-2] == "]"	# -[X]? -> (?!X)?
				@negative_context_r = item[2..-3]
				item[2..-3] = "CNTXR"
				@regexp_dep << "(#{item[2..-3]})#{item[-1..-1]}"
				@subs_context << i
				# Offset control
				if head_pos >= no_context_items
					@subs_offset = @subs_offset + 1
				end
			elsif item[0..2] == "--[" && item[-2..-2] == "]"	# --[X]? -> (?<X)?
				@negative_context_l = item[3..-3]
				item[3..-3] = "CNTXL"				
				@regexp_dep << "(?:#{item[3..-3]})#{item[-1..-1]}"
				@subs_context << i
				# Offset control
				if head_pos >= no_context_items
					@subs_offset = @subs_offset + 1
				end
			elsif item[0..0] == "[" && item[-2..-2] == "]"	# [X]? -> (?:X)?
				@regexp_dep << "(?:#{item[1..-3]})#{item[-1..-1]}"
				@subs_context << i
				# Offset control
				if head_pos >= no_context_items
					@subs_offset = @subs_offset + 1
				end
			elsif item[0..1] == "-[" && item[-1..-1] == "]"	# -[X] -> (?!X)
				@negative_context_r = item[2..-2]
				item[2..-2] = "CNTXR"
				@regexp_dep << "(#{item[2..-2]})"
				@subs_context << i
				# Offset control
				if head_pos >= no_context_items
					@subs_offset = @subs_offset + 1
				end
			elsif item[0..2] == "--[" && item[-1..-1] == "]"	# --[X] -> (?<X)
				@negative_context_l = item[3..-2]
				item[3..-2] = "CNTXL"
				@regexp_dep << "(?:#{item[3..-2]})"
				@subs_context << i
				# Offset control
				if head_pos >= no_context_items
					@subs_offset = @subs_offset + 1
				end
			elsif item[0..0] == "[" && item[-1..-1] == "]"	# [X] -> (?:X)
				@regexp_dep << "(?:#{item[1..-2]})"
				@subs_context << i
				# Offset control
				if head_pos >= no_context_items
					@subs_offset = @subs_offset + 1
				end
			elsif item[0..0] == "(" && (item[-1..-1] == ")" || (item[-2..-2] == ")" && item[-1..-1] == "?"))	# (X) -> (X) OR (X)? -> (X)?
				@regexp_dep << "#{item[1..-1]}"
				no_context_items = no_context_items + 1
			elsif item[-1..-1] == "?" 	# X?!< -> (X)?
				@regexp_dep << "(#{item[0..-2]})#{item[-1..-1]}"
				no_context_items = no_context_items + 1
			else
				@regexp_dep << "(#{item})"
				no_context_items = no_context_items + 1
			end
			i = i + 1
		end

		# Call the functions that modifies the initial regular expression depencie
		@regexp_dep = @regexp_dep.sub(/^[^:]+:\s/,"") # Delete the name of rule (all before first ":"). Next functions needs this change!
		@regexp_dep = canonical_form(@regexp_dep)
		@regexp_dep = subs_simbols(@regexp_dep)
		# Add / /
		@regexp_dep = "/" + @regexp_dep
		@regexp_dep << "/"

		# Creates substitution expression, if there are agreements we call the function and in all cases we delete the ?[:!<] of the regexp_dep
		@regexp_subs = @regexp_dep
		if @agr != ""
			@regexp_subs = agr_generate_regexp_subs(@regexp_subs)
		end
		@regexp_subs = @regexp_subs.gsub("?:$","$").gsub("?!","").gsub("?<","") # needed just before print

		# Creates veriable of the regexp_subs of the element of before that set with the function set_before_regexp_subs
		@before_regexp_subs = nil
	end

	# Transform a expresion in abstract code (expression must be complete) to the same code but in a canonical form more aproach to perl code: 
	# 1 - Convert an OR in the middle of two (or more) pairs of attribute-value (inside < >) to an OR between two (or more) elements (outside < >) with a pair each one (and delete all brackets ("(" and ")")
	# 2 - Order the & attributes by alphabetical order
	# 3 - Put brackets into the ORs between values
	def canonical_form(a1)
		tokens = tokenizer(/(\)\(|^\()[^<()]+(<[^>]+>)/,a1) # Get an array of elements with < >  #linha anterior com bug: tokenizer(/[(\|][^<]+(<[^>]+>)/,a1)
		tokens = tokens.collect { |t| t.gsub(/^\)\(/,"").gsub(/^\(/,"") } # Clean the beginning of the expressions
		tokens.each do |token|
			inside_token = token.split("<")[1].gsub(">","")
			outside_token = token.split("<")[0]
			pieces = inside_token.split(")|(")
			if pieces.size > 1 # If exist an OR inside the < > between attribute-value not into values (we know it because OR between attribute-value have "(" and ")" )
				pieces = pieces.collect { |p| p.gsub("(","").gsub(")","") }                              
				pre_post_string = a1.split(token)
				saida = pre_post_string[0] + "" ##CAMBIO DE PABLO: saida = pre_post_string[0] + " "
				pieces.each do |p|
					# Alphabtical order if there is &
					reorder = p.split("&")
					reorder = reorder.sort
					p=""
					reorder.each{ |r| p << r+"&"}
					p = p[0..-2]
					# Add to out
					saida << "#{limpa_brancos(outside_token)}<#{p}>|" 
				end
				saida = saida[0..-2]
				saida << pre_post_string[1]
				a1 = saida
			else
				# In this case we haven't ordered the & elements, and then we do it
				pieces = inside_token.split("&")
				if pieces.size > 1
					pre_post_string = a1.split(token)
					saida = pre_post_string[0] + "" ##CAMBIO DE PABLO...
					# Alphabtical order
					reorder = pieces.sort
					p=""
					reorder.each{ |r| p << r+"&"}
					p = p[0..-2]
					# Add to out
					saida << "#{limpa_brancos(outside_token)}<#{p}>|" 
					saida = saida[0..-2]
					saida << pre_post_string[1]
					a1 = saida
				end
			end
		end
		# Detect ORs into values and transform into (?:x|y)
		a1.gsub(/:([^<&]+)\|([^<&]+)([&>])/,':(?:\1|\2)\3') # Ha que geralizalo para qualquer numero de elementos e introduzir \| --CAMBIO DE PABLO
               
	end

	# Subs simbols to transform into a RegExp expression in Perl
	def subs_simbols(a1)
		# Put a $ before the items with < > Ex: ADJ<genre:f> -> $ADJ<genre:f>
		a1 = a1.gsub(/(\w+)(<[^>]+>)/,"$\\1\\2")
		# CAMBIOS DE PABLO: Put a $ before and a $a after the items without < > Ex: NOUN -> $NOUN$a  (NOUN|ADJ) -> ($NOUN$a|$ADJ$a)

            a1 = a1.gsub(/([^:]\(\?:|[(])([A-Z]\w*)/,"\\1$\\2$a2") ##colocar  $X$a depois de "(" ou depois de "(?:X", mas não depois de ":(?:X"
            a1 = a1.gsub(/(^\(\?:|[(])([A-Z]\w*)/,"\\1$\\2$a2") ## colocar  $X$a  depois de "(" ou depois de "(?:X" só em principio de linha. 
           a1 = a1.gsub(/([$a2>]\|)([A-Z]\w*)/,"\\1$\\2$a2").gsub(/([$a>]\|)([A-Z]\w*)/,"\\1$\\2$a2") # colocar recursivamente $X$a depois "$a|" ou depois de ">|"
          
#print a1
#print "\n"
		# Rest transformations
		a1 = a1.gsub(/([^?])</,"\\1${l}")
		a1 = a1.gsub(">",'\|${r}')
		a1 = a1.gsub("&",'\|${b2}')
                
                #a1 = a1.gsub('|(?:$CNTXL$a2)?', '|')  ###CAMBIO DE PABLO: parche contextos negativos optativos (nao tenhem sentido)
                a1 = a1.gsub('|(?:$CNTXL$a2)', '|')  ###CAMBIO DE PABLO: parche contextos negativos
                a1 = a1.gsub('|($', '|$')  ###CAMBIO DE PABLO: parche parentese a mais nas disjunçoes de atributos
                a1 = a1.gsub('${r}||', '${r}|')  ###CAMBIO DE PABLO: parche para eliminar dous traços verticais em disjunçoes de atributosi
                a1 = a1.gsub('(^)', '^')  ###CAMBIO DE PABLO: parche para mudar o (^) por ^ nas regras que começan por principio de frase
     
                a1 = a1.gsub("$a2$a2","$a2") # Corrige o duplo $a que poderia produzir-se com os super-atalhos
                a1 = a1.gsub("${r}${a}","${r}") #CAMBIO DE PABLO Corrige o duplo ${r}$a que poderia produzir-se com os super-atalhos
                #print a1 
                #print "\n"
=begin
TEMA NOM RESOLTO
		# @ is a delimitation character at the begin or the end of a string of a attribute that means there aren't more chars before (or after)
		a1 = a1.gsub(/([:|])@/,"\\1^")
		a1 = a1.gsub(/@([|>)])/,'\1\|')
=end

		# Clean $a if tag is in $atalhos_r (resolve o BUG das terminações em ${r})
		$atalhos_r.each do |atalho|
			a1 = a1.gsub(atalho+"$a2",atalho)
		end
		
		
		a1
	end

	# Generate regular expression for substitution (but still with :? that will be removed) from an agreement (or a block with an agreement that is called in cascade)
	# This piece is only executed when exists an agreement (and in blocks when exist an agreement before). It split by ")(" and add the agreement code (concord:1) in each expression only if the item is not context or not Rel position
	def agr_generate_regexp_subs(regexp_subs)
		nova = "" # New string with the new regexp
		pedacos = regexp_subs.split_pro([")(",")?(",")*("]) # Return the pieces divided by this two strings ##CAMBIO PABLO : engadim separador *
		separadores = $ssp	# The previos function creates an array in $ssp with the separators of the split (orderer and repeated by appearance)
		separadores << "" 
		if @before_regexp_subs != nil # (Only for blocks) If exist a previous regexp_subs we have to use to create the cascade effect with the other agreements 
			pedacos_before = @before_regexp_subs.split_pro([")(",")?(",")*("]) # Same as before  ##CAMBIO PABLO : engadim separador *
		end
		
		no_context = 0 # Count the no context vars to know when Rel appears (only when this var is 2 and expression have Rel)
		pedacos.each_with_index do |pedaco,index|
			if (/\?[:!<]/ =~ pedaco[0..1] ) != nil || (/\?[:!<]/ =~ pedaco[1..2] ) != nil || (/\?[:!<]/ =~ pedaco[2..3] ) != nil # Case of context. String cases:  ?[:!<] || (?[:!<] || /(?[:!<]
				if @before_regexp_subs != nil
					nova << pedacos_before[index]
				else
					nova << pedaco
				end
			else
				if ($rel_position[$name_function[@name]] == no_context) # Case of no_context and Rel position are equals
					if @before_regexp_subs != nil
						nova << pedacos_before[index]
					else
						nova << pedaco
					end
				else  # Another case, then no_context and no rel_position
					if @agr != "" # Needed because in blocks this function is called and it can exist a rule in block with no agreement
						if @before_regexp_subs != nil
                                                        
							nova << pedacos_before[index].gsub("${l}","${l}concord:1${b2}").gsub("$a2","${l}concord:1${r}") ##CAMBIO PABLO: o concord vai apos $l
						else
							nova << pedaco.gsub("${l}","${l}concord:1${b2}").gsub("$a2","${l}concord:1${r}") ##CAMBIO PABLO: o concord vai apos $l

						end
					else
						if @before_regexp_subs != nil
							nova << pedacos_before[index]
						else
							nova << pedaco
						end
					end
				end
				no_context = no_context + 1
			end
			nova << separadores[index]
		end
		nova.gsub("concord:1concord:1","concord:1").gsub("concord:1concord:1","concord:1")
	end	

	# Generate the substitutions numbers with $ orderer from the vars of the instance
	def number_subs
		if not @subs_context.empty?
			numbers = @subs_context
		else
			numbers = Array.new
		end
		numbers << $name_substitution[@name].to_i+@subs_offset
		cadea = ""
		numbers.uniq.sort.each do |n| # o uniq Ã© porque introduz duas vezes o elemento de sustituicao (em caso de erro com este ponto, desativar uniq)
			cadea << "$#{n}"
		end
		cadea
	end
end

################ CLASS RULE
class Rule
	# Constructor
	def initialize(instruction)
		instruction = instruction.gsub(/#.*$/," ").gsub(" \n","") # Clean sharp lines (coments)
		# If there are parts of a block divide and create an array of definitions
		parts = instruction.split("NEXT\n")
		@definitions = Array.new
		parts.each_with_index do |p,index|
			@definitions << Definition.new(p)
		end
		# If it is a block
		if @definitions.size > 0
			block_tasks # Call the private function
		end
	end

	# Return the main code (no substitution code)
	def code
		out_code = ""
		@definitions.each do |d|
			if d.pre_code
				out_code << d.pre_code
			end
			out_code << d.main_code
			# If the last element and the first are the the same (and actual), put subs_code
			if @definitions.last == d
				out_code << d.subs_code
			end
			if d.opt_code != nil
				out_code << d.opt_code
			end
		end
		# When the out_code is complete, it repeats this out code "recursivity" times (in blocks recursivity number must apear in the last part, if not, program will not do the repetition)

		out_code = out_code * @definitions.last.recursivity # Ruby allow multiply strings: "hello " * 2 = "hello hello "
		out_code << "\n"
	end


	def pretty_print
		@definitions.each do |d|
			print "#{d.pretty_print}\n"
		end
		print "\n\n"
	end

	private

	# Make some tasks to interconnect instructions in blocks
	def block_tasks 
		exists_lex = false
		exists_agreement = false
		no_repeated_numbers = @definitions[0].number_contexts
		@definitions.each_with_index do |d,index|
			# Handle agreements
			if index > 0
				@definitions[index].set_before_regexp_subs(@definitions[index-1].regexp_subs) # Set the var before_regexp_subs with the value of the element of before
			end
			# Handle LEX()
			if d.lex?
				exists_lex = true
				d.set_exists_lex(false)
			end
			# Hadle agreement (if one definition have an agreement we put in the end of the expressions the agreement statement)
			if d.agr?
				exists_agreement = true
			end
			# Handle 
			if index > 0
				no_repeated_numbers = array_intersection(no_repeated_numbers, d.number_contexts)
			end
		end
		# If exists lex in some instruction we ignore and memorize, finally modifies the last 
		if exists_lex
			@definitions[-1].set_exists_lex(true) 
		end
		# If exists agreement we set this funcion in the last definition to put the statement
		if exists_agreement
			@definitions[-1].set_exists_agr_statement
		end
		
		# Update the value of the subs_context of the last instruction
		no_repeated_numbers
		@definitions[-1].set_subs_context(no_repeated_numbers)
	end
end


################ MAIN 
wd = Dir.pwd
Dir.chdir File.dirname(__FILE__) do
	# SINTAX: ruby precompilerXX.rb filein.txt
	if ARGV.size < 3
		puts 'Error when calling compiler. CORRECT SINTAX: "ruby compiXX.rb <dependencies> <gramma.txt> [on|off] [name_parser]"'
	else
		dependencies = ARGV[0]#Dependency directory
		IT = ARGV[2].upcase
		# Crates constants from the files
		name_function(dependencies)
		# Execute pre-compi a script that makes previous modifications
		if File.file?("scripts/pre-compi.perl") and system "perl scripts/pre-compi.perl #{Dir.chdir wd do File.absolute_path(ARGV[1]) end} > log/grammar_not_compiled"
			file_in_name = File.absolute_path("log/grammar_not_compiled")
		else
			file_in_name = ARGV[1]
		end
		# Change name
		if ARGV[3] != nil
			if ARGV[3].end_with?(".perl")
				NAME_OUT_FILE = ARGV[3]
			else
				NAME_OUT_FILE = ARGV[3] + ".perl"
			end
		else
			NAME_OUT_FILE = $NAME_OUT_FILE
		end
		# Files operations
		file_in = nil
		file_out = nil
		Dir.chdir wd do
			file_in = File.open(file_in_name)
			file_out = File.new(NAME_OUT_FILE,"w") 
		end
		file_pre = File.open("src/iteration" + IT + "/pre_parsingCascataByRegularExpressions.perl","r")
		file_pre.each { |line| file_out.write line.sub("#__ICODE__", initial_code(dependencies)) }
		file_pre.close

		saida_aux = File.new("log/only_gramma.perl","w")
		
		# Analize the gramma file to create the object Rule
		instruction = ""
		count = 0
		file_out.write "\t\t\t\t{#<function>\n"
		file_in.each do |line|	
			# Build the expression (one or more lines). Separator = %
			if line[0..0] == "%"
				if limpa_brancos(instruction)[0..-1] != ""
					# Handle exceptions for Rule creation
					begin
						rule = Rule.new(instruction)
					rescue Exception => e
						#puts "Parsing error at line " + (file_in.lineno-1).to_s + '  with message: "' + $! + '"'
											#puts "Parsing error at line   #{file_in.lineno-1}  with message: \"  #{$!}  \""
						instruction = ""
						next
					end
					# Handle exceptions for Rule code creation
					begin
						if count != 0 and count % 60 == 0
							file_out.write "\t\t\t\t\t}\n{#<function>\n"
						end
						count = count + 1

						file_out.write "\t\t\t\t\t# " + instruction.gsub("\n","\n\t\t\t\t\t# ")[0..-8]
						file_out.write rule.code
						# Aux code to get a file with only the granma code
						saida_aux.write "# " + instruction.gsub("\n","\n# ")[0..-3]
						saida_aux.write rule.code
					rescue Exception => e
									  puts "Compile error with message:   #{$!} "
					end
					instruction = ""
				end
			elsif not (line[0..0] == "#" || limpa_brancos(line) == "")
				instruction << limpa_brancos(line) + "\n"
			end
		end
		file_out.write "\t\t\t\t}\n"
		file_post = File.open("src/iteration" + IT + "/post_parsingCascataByRegularExpressions.perl","r")
		file_post.each { |line| file_out.write line }
		file_out.close
	end
end