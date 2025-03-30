extends Node
var blocked_actions = {}

func block_action(action_name):
	blocked_actions[action_name] = true

func unblock_action(action_name):
	blocked_actions.erase(action_name)

func is_action_just_pressed(action_name):
	if blocked_actions.has(action_name):
		return false
	return Input.is_action_just_pressed(action_name)

func is_action_pressed(action_name):
	if blocked_actions.has(action_name):
		return false
	return Input.is_action_pressed(action_name) 
