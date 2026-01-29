Begin your adventure?

VAR ate_food = false

VAR with_guard = false

VAR has_guard_gun = false

VAR is_alone = true

VAR back_from_key_search = false

VAR ate_the_guard = false


+ [Yes]
  -> begin

== begin ==
You wake up in a 5x5-foot prison cell. Bright lights stream from the ceiling, and the cell smells like cheese. You vaguely remember running away from something before you woke up... and nothing before that.

An alien... guard walks by your cell, carrying a tray of green slime. They place it in front of you and gesture vaguely towards it before walking away.

The slime twitches a few times. You're not sure if you trust it, and you want to eat a gourmet meal instead.

+ [This is too disgusting, refuse] You refuse the prison food. Your stomach rumbles, but you don't want to eat food for poor people.
 ~ate_food = false
 -> stay_or_leave
+ [Eat it, you're hungry] You crunch through the slime and eat the meal. Suddenly, you feel energized!
 ~ate_food = true
 -> stay_or_leave

== stay_or_leave ==
Suddenly, the lights flicker in the cell. The entire building shakes several times, and then the lights turn off. The light on the door locks fade away. You think you might be able to force the door open now.

Do you stay in the cell block?

+ [Stay in the cell block] The cell shakes and you hear a hissing. 
All the oxygen leaves the room and you suffocate.
You died.
 -> prompt_restart
+ [Break out] You break out of the cell block! You hear a hissing sound, but find an oxygen mask on the wall and put it on.
 -> go_to_hangar

== go_to_hangar ==
You look out the window. It looks like you're on a space station! The only way out is to get on a shuttle. You think you can find one in the hangar bay.

Following the signs mounted on the wall, you make your way to the hangar. You hear screaming from a corridor to the left. Glancing that way, you notice a guard with his leg stuck in a door.

What do you do?

+ [Help the guard] You help the guard out of the door. His name is Bob, and he's heading to the hangar too. He agrees to help you out, and you head towards the hangar together.
 ~ with_guard = true
 ~ is_alone = false
 -> open_bay_doors
+ [Knock him out and take his gun] You kick him in the head and take a gun out of his pocket, leaving him to die.
 ~ has_guard_gun = true
 -> open_bay_doors
+ [Leave them alone] You ignore him and walk away.
 -> open_bay_doors

== open_bay_doors ==
{ 
 - ate_food == true:
	+ Try to force open the door manually [fails if you didn’t eat earlier] (Go to F)
 	-> obtain_escape_pod
 - else:
 	You can't open the door manually, you're hungry.

 }
+ Throw the guard at the door ***
 -> threw_guard
+ Look for the key
 -> look_for_key
{ 
 - back_from_key_search == true && with_guard == true:
	+ Eat the guard and open the door
	 ~ate_the_guard = true
	 -> obtain_escape_pod

 }

== obtain_escape_pod ==
potato

== threw_guard ==
Guard: What?!? Come here ya little...

+ You died... Restart?
 -> prompt_restart

== look_for_key ==
something


== prompt_restart ==
+ [Restart?] Restarting... # RESTART
-> END

