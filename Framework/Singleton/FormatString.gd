#FormatString.gd
#----------------------------------
# Helpful String Functions
#--------------------------

extends Node

func lower_case(input_val):
	#essentially an alias for to_lower()
	#I added this because "lower_case" seems easier to understand to me than "to_lower"
	return str(input_val).to_lower()

func comma_sep(number):
	# Places commas at the appropriate positions within numbers
	var string = str(number)
	var string2 = str(number)
	if (string2.find(".") != -1):
		string2 = string2.right(string2.find("."))
		string = string.left(string.find("."))
	else:
		string2 = ""
	var mod = string.length() % 3
	var res = ""
	for i in range(0, string.length()):
		if (i != 0 && i % 3 == mod):
			res += ","
		res += string[i]
	res += string2
	return res
	
	
func currency(number):
	#Formats the number as a currency
	var string = str("%.2f"%number)
	var string2 = str("%.2f"%number)
	if (string2.find(".") != -1):
		string2 = string2.right(string2.find("."))
		string = string.left(string.find("."))
	else:
		string2 = ""
	var mod = string.length() % 3
	var res = ""
	for i in range(0, string.length()):
		if (i != 0 && i % 3 == mod):
			res += ","
		res += string[i]
	res += string2
	return res
