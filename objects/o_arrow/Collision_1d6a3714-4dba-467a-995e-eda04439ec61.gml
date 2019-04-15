// Make an exception for the weird depth issue
if (image_angle == 0 || image_angle == 180) {
	if (y < other.bbox_top + 5) {
		should_draw_shadow_ = false;
		exit;
	}
}

var _arrow_hit = instance_create_layer(x, y - 7, "Instances", o_arrow_hit);
_arrow_hit.image_angle = image_angle;
var _x_dir = sign(lengthdir_x(1, _arrow_hit.image_angle));
var _y_dir = sign(lengthdir_y(1, _arrow_hit.image_angle));
while (!place_meeting(_arrow_hit.x + _x_dir, _arrow_hit.y + _y_dir, o_solid)) {
	_arrow_hit.x += _x_dir;
	_arrow_hit.y += _y_dir;
}
_arrow_hit.x += _x_dir;
_arrow_hit.y += _y_dir;
	
instance_destroy();