///@arg value
///@arg array

//Oooohh this is bad I think
var _value = argument0;
var _array = argument1;

for (var i = 0; i < array_length_1d(_array); i++) {
	if (_array[i] == _value) {
		return i;
	}
}
return -1;