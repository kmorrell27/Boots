///@arg value
///@arg target_array

var _value = argument0;
var _array = argument1;
var _length = array_length_1d(_array);

var i = 0;
repeat (_length) {
	if (_value == _array[i]) {
		return true;
	}
	if (object_is_ancestor(_value, _array[i])) {
		return true;
	}
	i++;
}

return false;