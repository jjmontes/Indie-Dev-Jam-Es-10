extends Node2D

func _on_Level_exit():
	print("El jugador salio del nivel... cargando nivel 2")
	$Level.queue_free()
