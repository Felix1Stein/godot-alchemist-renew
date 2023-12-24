extends Resource
class_name EssenceBundleData

@export var essences : Array[EssenceData]

signal essence_bundle_changed()


# Constructor
func _init(essences : Array[EssenceData] = [EssenceData.new(EssenceData.ESSENCE_TYPE.DARKNESS, 0)]):
	self.essences = essences
	essence_bundle_changed.emit()


# Sorts essences array by each essence type
func sort_essences_by_type() -> void:
	essences.sort_custom(func(a, b): return a.type <= b.type)


# Sorts essences array by each essence amount in descending order with the highest amount at the beginning
func sort_essences_by_amount() -> void:
	essences.sort_custom(func(a, b): return a.amount >= b.amount)


# Returns the sum of all indvidiual essence types and their amount
func get_total_essence_amount() -> int:
	var amount : int = 0
	for essence in essences:
		amount += essence.amount
	
	return amount


# Returns a singular random essence from the bundle
func get_random_single_essence_in_essence_bundle() -> EssenceBundleData:
	var total_essence_amount : int = get_total_essence_amount()
	
	if total_essence_amount == 0:
		return null
	
	var random_index : int = randi_range(0, total_essence_amount - 1)
	
	var running_sum : int = random_index
	for essence in essences:
		running_sum -= essence.amount
		if running_sum < 0:
			return EssenceBundleData.new([EssenceData.new(essence.type, 1)])
	
	push_error("EssenceBundleData: Failed to get random essence!")
	return null


# Prints the essence bundle in repeated glyphs
func get_essence_bundle_string() -> String:
	sort_essences_by_type()
	
	var s : String = ""
	for essence in essences:
		s += essence.get_essence_string()
	
	return s


# Destorys all essences in bundle
func empty_essence_bundle() -> void:
	_init()


# Cleanes essence bundle array by removing all essences with amount = 0
func cull_essence_bundle() -> void:
	sort_essences_by_amount()
	
	var first_index_with_amount_zero = essences.size()
	for i in range(0, essences.size()):
		if essences[i].amount == 0:
			first_index_with_amount_zero = i
			break
	
	if first_index_with_amount_zero < essences.size():
		essences.resize(first_index_with_amount_zero)


# Creates new essence and appends to essence array
func add_new_essence_to_bundle(other_essence : EssenceData) -> void:
	essences.append(EssenceData.new(other_essence.type, other_essence.amount))


# Finds essence object with type = essence_type in essences array and returns index, otherwise -1
func get_index_of_essence_in_bundle(essence_type : EssenceData.ESSENCE_TYPE) -> int:
	for i in range(0, essences.size()):
		if essences[i].type == essence_type:
			return i
	return -1


# checks if essence bundle has sufficent essences to subtract other_essence_bundle from this essence bundle and returns true, otherwise false
func can_subtract(other_essence_bundle : EssenceBundleData) -> bool:
	for other_essence in other_essence_bundle.essences:
		var essence_index : int = get_index_of_essence_in_bundle(other_essence.type)
		
		if essence_index == -1:
			# Essence was not found
			return false
		if essences[essence_index].can_subtract(other_essence) == false:
			# Essence was found, but can not be subtracted / amount is not enough
			return false
	
	return true


# Adds other_essence_bundle to this essence_bundle if both are of the same essence type
func add(other_essence_bundle : EssenceBundleData) -> void:
	for other_essence in other_essence_bundle.essences:
		var essence_index : int = get_index_of_essence_in_bundle(other_essence.type)
		
		if essence_index == -1:
			# Create new Essence if not existing
			add_new_essence_to_bundle(other_essence)
		else:
			# Add other essence amount to existing essence
			essences[essence_index].add(other_essence)
	
	essence_bundle_changed.emit()


# Subtracts other_essence_bundle from this essence_bundle
func subtract(other_essence_bundle : EssenceBundleData) -> void:
	if can_subtract(other_essence_bundle) == false:
		push_error("EssenceBundleData: Failed subtracting essence bundles!")
		return
		
	for other_essence in other_essence_bundle.essences:
		var essence_index : int = get_index_of_essence_in_bundle(other_essence.type)
		
		if essence_index == -1:
			# Essence is missing, this should be catched by can_subtract() above
			push_error("EssenceBundleData: Failed subtracting essence bundles, can_subtract() failed!")
			return
		
		# Subtract amount from existing essence
		essences[essence_index].subtract(other_essence)
	
	# Remove all essences with amount 0 from array
	cull_essence_bundle()
	
	essence_bundle_changed.emit()
