extends Resource
class_name EssenceData


@export var type : ESSENCE_TYPE = ESSENCE_TYPE.DARKNESS
@export var amount : int = 0

enum ESSENCE_TYPE {DARKNESS, DEATH, EATHER, ENERGY, FLUIDITY, FRAGMENTATION, INFINITY, LIGHTNESS, NATURALITY, NULLIFICATION, STABILITY, SUBVERSION, TORRIDITY, TOXICITY, UNIFICATION, VITALITY, }
const ESSENCE_GLYPHS : Dictionary = {ESSENCE_TYPE.DARKNESS: "0", ESSENCE_TYPE.DEATH: "1", ESSENCE_TYPE.EATHER: "2", ESSENCE_TYPE.ENERGY: "3", ESSENCE_TYPE.FLUIDITY: "4", ESSENCE_TYPE.FRAGMENTATION: "5", ESSENCE_TYPE.INFINITY: "6", ESSENCE_TYPE.LIGHTNESS: "7", ESSENCE_TYPE.NATURALITY: "8", ESSENCE_TYPE.NULLIFICATION: "9", ESSENCE_TYPE.STABILITY: "A", ESSENCE_TYPE.SUBVERSION: "B", ESSENCE_TYPE.TORRIDITY: "C", ESSENCE_TYPE.TOXICITY: "D", ESSENCE_TYPE.UNIFICATION: "E", ESSENCE_TYPE.VITALITY: "F"}


# Constructor
func _init(type : ESSENCE_TYPE = ESSENCE_TYPE.DARKNESS, amount : int = 1):
	self.type = type
	self.amount = amount


# Returns flattened string of essence with repeated glyphs
func get_essence_string() -> String:
	return get_glyph().repeat(amount)


# Returns the glyph of the essence
func get_glyph() -> String:
	return ESSENCE_GLYPHS[type]


# compares this essence to another and returns true if both essences are of the same type, otherwise false
func are_types_matching(other_essence : EssenceData) -> bool:
	if other_essence.type != type:
		push_warning("EssenceData: Mismatching essence types!")
		return false
	
	return true


# checks matching types and if this essence.amount is sufficent to subtract other_essence.amount from this essence and returns true, otherwise false
func can_subtract(other_essence : EssenceData) -> bool:
	if are_types_matching(other_essence) == false:
		return false
	
	if amount < other_essence.amount:
		return false
	
	return true


# Adds other_essence.amount to this essence.amount if both are of the same essence type and returns the new amount
func add(other_essence : EssenceData) -> int:
	if are_types_matching(other_essence) == false:
		push_error("EssenceData: Failed adding essences!")
		return 0
	
	amount += other_essence.amount
	return amount


# Subtracts other_essence.amount from this essence.amount if both are of the same essence type and returns the new amount
func subtract(other_essence : EssenceData) -> int:
	if can_subtract(other_essence) == false:
		push_error("EssenceData: Failed subtracting essences!")
		return 0
	
	amount -= other_essence.amount
	return amount
