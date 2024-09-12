extends Node

const notif = preload("res://scenes/notification.tscn")

var player_pos : Vector2i

var selected = 0

var Plot = []

var Harvests = [{
	"Name": "tomato",
	"Count": 1,
	"Consumable": true,
}]

var coins = 100

var weather 
