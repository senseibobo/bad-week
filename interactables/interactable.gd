class_name Interactable
extends Node3D

signal interacted


func on_interact(player: Player):
	interacted.emit()
