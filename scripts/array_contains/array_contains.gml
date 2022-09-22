/// @argument0 Array
/// @argument1 element
function array_contains() {
  var i, tempArray;
  tempArray = argument[0];
  for (i = 0; i < array_length(tempArray); i++) {
    if (tempArray[i] == argument[1]) return true;
  }
  return false;
}
