class_name GameController
extends Node

static var currentLevel: int = 1
static var maxTry: int = 3

static var levels = {
	1: "res://Levels/level1.tscn",
	2: "res://Levels/level2.tscn",
	3: "res://Levels/level3.tscn",
	4: "res://Levels/level4.tscn",
	5: "res://Levels/level5.tscn",
}

static var dispatchEvent = true
# PRIVATE METHODS
############################################


# PUBLIC METHODS

static func go_next_level() -> void:
	print(get_current_level())
	if dispatchEvent == true:
		dispatchEvent = false
		currentLevel += 1
		dispatchEvent = true
	
static func go_back_level() -> void:
	currentLevel -= 1

static func get_current_level() -> String:
	return levels[currentLevel]

static func get_play_again_count() -> int:
	return maxTry
	
static func decrease_play_again() -> void:
	maxTry -= 1
	
static func increase_play_again() -> void:
	maxTry += 1


static func reset_play_again() -> void:
	maxTry = 3
