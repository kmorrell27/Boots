/// @description Activate event
event_inherited();
if (!instance_exists(o_player)) {
	exit;
}
image_index = 0;
InventoryAddItem(o_sword_item);
SetPlayerFoundItem(s_sword_item);
activatable_ = false;
AddToDestroyedList(id);