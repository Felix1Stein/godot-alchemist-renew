extends Resource
class_name PotionCardData

@export_multiline var name : String = "POTION NAME"
@export_multiline var description : String = "POTION DESCRIPTION"

@export var essence_requirement : EssenceBundleData
@export var potion_effect : PotionData
