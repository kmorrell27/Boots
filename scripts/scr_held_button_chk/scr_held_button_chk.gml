return (
  (Item.SWORD == argument0 && keyboard_check(global.swordButton)) ||
  (Item.HAMMER == argument0 && keyboard_check(global.hammerButton)) ||
  (Item.BOW == argument0 && keyboard_check(global.bowButton)) ||
  (Item.BOMB == argument0 && keyboard_check(global.bombButton))
);