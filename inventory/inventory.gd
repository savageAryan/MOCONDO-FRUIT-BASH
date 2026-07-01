extends Resource
class_name  Inventory
@export var slots: Array [InventorySlot]
@export var selected_index := 0
signal use_item
signal updated
func insert(item: InventoryItem):
	var itemSlots = slots.filter(func(slot):return slot.item == item && slot.amount < slot.item.maxAmountPrStack)
	if not itemSlots.is_empty():
		itemSlots[0].amount += 1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		emptySlots[0].item = item
		emptySlots[0].amount = 1
	updated.emit()
func removeSlot(inventorySlot: InventorySlot):
	var index = slots.find(inventorySlot)
	if index < 0: return
	
	remove_at_Index(index)
func remove_at_Index(index: int) -> void:
	slots[index] = InventorySlot.new()
	updated.emit()
	
func insertSlot(index: int, inventorySlot: InventorySlot):
	
	slots[index] = inventorySlot
	updated.emit()
	
func use_Item_at_Index(index: int) -> void:
	if index < 0 or index >= slots.size() or not slots[index].item: return
	var slot = slots[index]
	use_item.emit(slot.item)
	if slot.item.item_consumable:
		if slot.amount > 1:
			slot.amount -= 1
			updated.emit()
		else:
			remove_at_Index(index)

	
func remove_item(item: InventoryItem, amount_remove: int = 1):
	for slot in slots:
		if slot.item == item:
			if slot.amount >= amount_remove:
				slot.amount -= amount_remove
				if slot.amount <= 0:
					slot.item = null
				updated.emit()
				return true
			return false
