///@arg0 string
//Right now just line break. Tomorrow, the world!
//Golly I'm proud of this.
var str = argument0;

if (string_length(str) <= 31) {
	return str;
}

for (var i = 32; i < string_length(str); i += 32) {
	while (string_char_at(str, i) != " ") {
		i--;
		
		if (i < 1) {
			// We fucked up. Bail
			return str;
		}
	}
	str = string_delete(str, i, 1);
	str = string_insert("\n", str, i);
}
return str;