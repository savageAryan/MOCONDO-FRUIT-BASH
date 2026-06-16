extends Resource
class_name  Inventory
@export var items: Array [InventoryItem]
signal updated
func insert(item: InventoryItem):
	for i in range(items.size()):
		if not items[i]:
			items[i] = item
			break
	updated.emit()
