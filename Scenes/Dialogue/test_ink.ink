Begin your adventure?

VAR ate_food = false

VAR with_guard = false

VAR with_prisoner = false

VAR has_guards_gun = false

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
+ [Eat it, you're hungry] You crunch through the slime and eat the meal. You feel energized!
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
 ~ has_guards_gun = true
 -> open_bay_doors
+ [Leave them alone] You ignore him and walk away.
 -> open_bay_doors

== open_bay_doors ==
\-\-\-
You make it to the hangar bay doors. The doors are six meters tall and would normally be powered by an internal mechanism.

Hitting the "open" button doesn't seem to do anything. The doors don't have any power. 

{ 
 - ate_food == true:
    + [Try to force open the door manually] You force open the door by hand, and it makes a screech as the gear assembly bends apart. It slowly creaks open.
     -> obtain_escape_pod
 - else:
    + [Try to force open the door manually] You try to open the door manually, but you're too hungry and tired.
	-> open_bay_doors

 }

{ 
 - with_guard == true:
    + Throw the guard at the door
    Guard Bob: What?!? Come here ya little...
    Bob is enraged and beats you to death with his baton, before throwing you out an airlock.
    You died... Restart?
      -> prompt_restart

 }

+ Look for a crowbar
 -> look_for_crowbar

{ 
 - back_from_key_search == true && with_guard == true:
    + Eat the guard and open the door
     ~ate_the_guard = true
     -> obtain_escape_pod

 }

== look_for_crowbar ==
While looking for something to wedge open the door, you come across the prison bay. You see a few high-security cells near the back, still running on backup power.

You notice one of the prisoners inside holding a crowbar and prying open the cell door. They're about to escape when they notice you.

{
 - with_guard == true:
The prisoner notices Bob standing next to you.  
"Crowbar's mine! Get outta you filthy copper!"
    + [Return to the hangar bay]
      -> open_bay_doors

- else:
	"You want me to help you? Sure.. In fact, let me give you a little gift - here's some cybernetic body armor. Put it on!"
+ [Accept the body modification]
 ~with_prisoner = true
 -> obtain_escape_pod
{
 - has_guards_gun == true:
+ [Shoot the prisoner and take the crowbar] You shoot the prisoner in cold blood and take the crowbar from his dead hands.
 -> obtain_escape_pod
	}
}


== obtain_escape_pod ==
You finally enter the hangar bay. Parts of the ceiling are breaking apart, and several shuttles have been crushed by falling debris. Most of the remaining shuttles seem to have already been taken.

You notice one seemingly intact shuttle near the exit doors of the hangar bay and rush towards it, carefully avoiding the debris.
\-\-\-
You suddenly hear something fly through the open hangar doors and crash into the shuttle. It's a dropship!
\-\-\-
You are being jumped by a burger brigade! Ducking behind some crates to avoid the barrage of machine gun cheese, you evaluate your options.

# EMPTY_LINE
{
 - has_guards_gun == true:
  + [Shoot the burgers]
	Using your gun, you carefully pick off the burgers one by one from behind cover. Finally, the last burger falls.  Fortunately these were only discount burgers.
   -> try_to_escape
 - with_guard == true:
  Bob: Get behind me! *Fires gun*
	Bob masterfully dodges cheesefire while firing back at the burger brigade. Within 20 seconds, he single-handedly disarms and dismembers the entire squadron.
# EMPTY_LINE
You remind yourself not to get on his bad side in the future.
+ [Escape]
  -> try_to_escape
 - else:
  Without any method of fighting back, you have no choice but to give up. You put your hands in the air. The burgers interpret this as the Burgerian symbol for attack and cheese you immediately.
# EMPTY_LINE
The Burger Brigade ate you alive... Try again?
   -> prompt_restart

}

== try_to_escape ==
Fortunately, you notice a row of escape pod bays on the side of the hangar and make your way towards it.

There's only a few functional escape pods left. You enter, and the systems initialize. It looks like these escape pods don't have an autopilot... and there's only enough fuel to reach the nearest planet.

You buckle in the pilot seat and slam the eject button.
{
 - (with_guard == false && with_prisoner == false):
  Wait, how do i steer?!? AHHHHHHHHHHHHHHHHHHHHH!
  + A pathetic death, even for a criminal... Try again? 
   -> prompt_restart

 - with_guard == true:
  Bob: "I got this, I've taken a pilot training course before. Buckle up for a bumpy ride!"

Bob grabs the wheel and carefully pilots the pod towards the planet.
# EMPTY_LINE
  What goes around comes around, maybe you aren't such a bad guy after all…
  To be continued...
-> END

 - with_prisoner == true:
  Prisoner: *chuckles* Now that I'm free... did you know? Those 'enhancements' I gave you were a little.. modified.
# EMPTY_LINE
  \*The prisoner presses a button on his wrist, and you feel a shock. You're paralyzed!\*
  Prisoner: I have no need for dead weight. Have a nice trip!
The prisoner throws you out of the hangar bay, and takes the escape pod for himself.
# EMPTY_LINE
Birds of a feather flock together... Try again?
   -> prompt_restart

}

== prompt_restart ==
+ [Restart?] Restarting... # RESTART
-> END


