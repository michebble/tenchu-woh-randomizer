require "pry"
Item = Struct.new(:name, :limit, :count)
SelectedItem = Struct.new(:name, :count)
NORMAL_ITEMS = [
  Item.new("shuriken", 15, 15),
  Item.new("healing potion", 15, 15),
  Item.new("caltrops", 15, 15),
  Item.new("coloured rice", 5, 5),
  Item.new("tetsubishi", 5, 5),
  Item.new("blow gun", 5, 5),
  Item.new("grenade", 15, 15),
  Item.new("mine", 15, 15),
  Item.new("poison antidote", 15, 15),
  Item.new("poison rice", 15, 15),
  Item.new("smoke bomb", 15, 15),
  Item.new("sticky bomb", 5, 5),
  Item.new("strength potion", 15, 15)
]
GM_ITEMS = [
  Item.new("binding spell", 1, 1),
  Item.new("chameleon spell", 3, 3),
  Item.new("decoy whistle", 1, 1),
  Item.new("dog bone", 5, 5),
  Item.new("exploding arrow", 3, 3),
  Item.new("fire spell", 2, 2),
  Item.new("fireworks", 3, 3),
  Item.new("invisbility spell", 2, 2),
  Item.new("ninja armor", 1, 1),
  Item.new("super shuriken", 5, 5)
]
RIKI_WEAPONS = [
  Item.new("fugaku", 1, 1),
  Item.new("muramasa", 1, 1)
]
AYAME_WEAPONS = [
  Item.new("dokuto", 1, 1),
  Item.new("kasumi and shizuku", 1, 1)
]
SPECIAL_ITEMS = [
  Item.new("ninja rebirth", 1, 1),
  Item.new("stone of power", 1, 1),
  Item.new("tiger trap", 3, 3)
]
MAX_SELECTED_ITEMS = 5
MAX_ITEM_COUNT = 15
def gen_item_choices(item_list)
  1.upto(MAX_SELECTED_ITEMS).reduce([]) do |a, _|
    selected_items = a.map(&:name)
    total_selected_count = a.sum(&:count)
    next a if total_selected_count >= MAX_ITEM_COUNT
    item_list.reject { |item| item.count.zero? || selected_items.include?(item.name) }
      .then { |possible_items| possible_items.sample }
      .then do |choosen_item|
        return a if choosen_item.nil?
        max_possible = [choosen_item.limit, choosen_item.count, MAX_ITEM_COUNT - total_selected_count].min
        [SelectedItem.new(choosen_item.name, rand(1..max_possible)), *a]
      end
  end
end

possible_items = [*NORMAL_ITEMS, *SPECIAL_ITEMS, *GM_ITEMS, RIKI_WEAPONS.sample]
p "Items for Riki"
p "grappling hook x 1"
gen_item_choices(possible_items).each do |selected_item|
  p "#{selected_item.name} x #{selected_item.count}"
end
