VAR ate_food = false
VAR with_guard = false
VAR with_prisoner = false
VAR has_guards_gun = false
VAR is_alone = true
VAR back_from_key_search = false
VAR ate_the_guard = false
VAR num_evil_choices = 0

Would you like to skip the introduction?

+ [Yes]
  -> begin
+ [No]
  -> exposition

== exposition ==
= expo_1
You used to be someone important, or at least you told yourself that. You didn't think you were cruel, you just believed rules were for people who needed them. Other people waited in lines. Other people paid the price when things went wrong.
# EMPTY_LINE
When the Burger Consortium expanded into your sector, you didn’t see them as invaders, you saw an opportunity. You made contracts and cut corners. Some raised complaints, but they were silenced with money or a well-timed disappearance. You reassured yourself it was just business. No one was really getting hurt. But someone did get hurt. A lot of someones, you think.

+ [...]
  -> exposition.expo_2

= expo_2
You don't remember the trial. Just your sentence: space prison. It sounded absurd at the time. You laughed, all the way up until the cuffs locked and the stars started moving the wrong way.
# EMPTY_LINE
Now, you're here. Stripped of your comfort and status, you are reduced to a body with needs: hunger, fear, and survival. But omewhere deep inside, beneath the outrage and denial, something is stirring. A thought you don’t like: "If this is who you really are... why pretend otherwise?"

+ [Begin your adventure]
  -> begin


== begin ==
= begin_1
You wake up in a cramped prison cell, the kind designed for corpses, not people. Your head is pounding. Not in a dramatic way, more like the dull ache of a bad decision from a previous you refuse to replay. You remember your name. You remember signing... contracts. You remember being important.
+ [...]
 -> begin.begin_2
= begin_2
You don't remember doing anything that deserves treament like this. Bright lights buzz overhead. The air smells faintly of ozone... and cheese? Like limburger, but worse. So much worse. Whoever runs this place clearly has no standards.
+ [...]
 -> begin.begin_3

= begin_3
You try to reconstruct the last few hours. A corporate boardroom? People yelling... someone saying, "We can make this work." Then movement. Restraints. Stars sliding sideways across a narrow porthole. After that, nothing you’re willing to claim.
+ [...]
 -> begin.begin_4
= begin_4
An alien... guard waddles past your cell, carrying a tray of green slime. They stop and slide it through the slot in your cell door, vaguely gesturing toward it before moving on to the next cell.
# EMPTY_LINE
The slime quivers a bit. You're not sure if you trust it. This is prison food, sustenance stripped of all dignity. You'd much prefer a gourmet meal by the Lamb Sauce Oracle.
# EMPTY_LINE
You feel a familiar irritation rise up, one that strikes offense, as if the universe has made a serious error. You were never meant to be on this side of the transaction.

+ [This is too disgusting, refuse] You slide the tray away with your foot. Whatever this is, it's meant to keep prisoners barely functional, not human. Your stomach groans in protest, but you ignore it. Hunger is temporary, your dignity is not.
# EMPTY_LINE
 ~ ate_food = false
 -> stay_or_leave
+ [Eat it, you're hungry] You hesitate, then scoop up the quivering mass and force it down. It tastes like nothing you’d ever pay for, but warmth spreads through your body almost immediately. Your muscles loosen and your head clears. You hate how much better you feel. "You feel energized!"
 ~ ate_food = true
 -> stay_or_leave

== stay_or_leave ==
Suddenly, the lights flicker in the cell. The entire building shakes several times, and then the lights turn off. The light on the door locks fade away, you might be able to force the door open now.
# EMPTY_LINE
Do you stay in the cell block?

+ [Stay in the cell block] The cell shakes and you hear a hissing. 
All the oxygen leaves the room and you suffocate.
You died.
 -> prompt_restart
+ [Break out] You break out of the cell block! You hear a hissing sound, but find an oxygen mask on the wall and put it on.
 -> go_to_hangar

== go_to_hangar ==
You look out the window. It looks like you're on a space station! Orbiting the planet... uh, you're not sure what this planet is called. The only way out of here is to get on a shuttle. You think you can find one in the hangar bay.

Following the signs mounted on the wall, you make your way to the hangar. You hear screaming from a corridor to the left. Glancing that way, you notice a guard with his leg stuck in a door.

What do you do?

+ [Help the guard] You help the guard out of the door. His name is Bob, and he's heading to the hangar too. He agrees to help you out, and you head towards the hangar together.

 -> evil_whisper
+ [Knock him out and take his gun] You kick him in the head and take a gun out of his pocket, leaving him to die.
 ~ has_guards_gun = true
 -> open_bay_doors
+ [Leave them alone] You ignore him and walk away.
 -> open_bay_doors

== evil_whisper ==
Wait, you really want to help him? After what you did, really? Come on, there's no changing now...

+ [Continue and help the guard] You help the guard out of the door. His name is Bob, and he's heading to the hangar too. He agrees to help you out, and you head towards the hangar together.
 ~ with_guard = true
 ~ is_alone = false
 -> open_bay_doors
+ [Knock him out and take his gun] You kick him in the head and take a gun out of his pocket, leaving him to die.
 ~ has_guards_gun = true
 ~ num_evil_choices = num_evil_choices + 1
 -> open_bay_doors
+ [Leave them alone] You ignore him and walk away.
 -> open_bay_doors


== open_bay_doors ==
\.\.\.\.\.\.\.\.\.\.
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
    + [Save yourself... and throw the guard at the door] You pick up Bob and yeet him towards the door, hoping to pry it open somehow.
    Bob: "What?!? Come here ya little..."
    Bob is enraged and beats you to death with his baton, before throwing you out an airlock.
     Some people never change... Try again?
      -> prompt_restart

 }

+ [Look for a crowbar]
 -> look_for_crowbar

{ 
 - back_from_key_search == true && with_guard == true:
    + There's no changing your ways... [eat the guard for energy] You devour the guard and gain enough strength to pry open the door.
     ~ with_guard = false
	~ ate_food = true
     ~ num_evil_choices = num_evil_choices + 1
     -> open_bay_doors

 }

== look_for_crowbar ==
While looking for something to wedge open the door, you come across the prison bay. You see a few high-security cells near the back, still running on backup power.

You notice one of the prisoners inside holding a crowbar and prying open the cell door. They're about to escape when they notice you.

~back_from_key_search = true

{
 - with_guard == true:
The prisoner notices Bob standing next to you.  
"Crowbar's mine! Get outta here, you filthy coppah!"
    + [Return to the hangar bay]
      -> open_bay_doors

- else:
	"You want me to help you? Sure. In fact, let me give you a little gift - here's some cybernetic body armor. Put it on!"
+ [Accept the body modification]
 ~with_prisoner = true
 -> obtain_escape_pod
{
 - has_guards_gun == true:
+ [Shoot the prisoner and take the crowbar] You shoot the prisoner in cold blood and take the crowbar from his dead hands.
 -> obtain_escape_pod
	}
	+ [Reject the body modification and leave by yourself]
 -> evil_whisper_with_prisoner
}

== evil_whisper_with_prisoner ==
Wait, why shouldn't you go with him, he can be of some help. 
After all, you two aren't so different... Especially after what you did.
+ [Accept the body modification]
 ~with_prisoner = true
 -> obtain_escape_pod
{
 - has_guards_gun == true:
+ [Shoot the prisoner and take the crowbar] You shoot the prisoner in cold blood and take the crowbar from his dead hands.
 ~ num_evil_choices = num_evil_choices + 1
 -> obtain_escape_pod
	}
	+ [Continue by yourself]
 -> obtain_escape_pod


== obtain_escape_pod ==
You finally enter the hangar bay. Parts of the ceiling are breaking apart, and several shuttles have been crushed by falling debris. Most of the remaining shuttles seem to have already been taken.

You notice one seemingly intact shuttle near the exit doors of the hangar bay and rush towards it, carefully avoiding the debris.
# EMPTY_LINE
You suddenly hear something fly through the open hangar doors and crash into the shuttle. It's a dropship!
# EMPTY_LINE
You are being jumped by a burger brigade! Ducking behind some crates to avoid the barrage of machine gun cheese, you evaluate your options.

# EMPTY_LINE
{
 - has_guards_gun == true:
  + [Shoot the burgers]
	Coming to a decision, you use your gun. Firing at the nearest burger, you see meat and condiments burst out the other side of the alien. You feel something within you change... You carefully pick off the burgers one by one from behind cover. Finally, the last burger falls.  Fortunately they were only discount burgers.
   -> try_to_escape
 - with_guard == true:
  Bob: "Get behind me!" *Fires gun*
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
  Wait, how do I steer?!? AHHHHH!
  + A pathetic death, even for a criminal... Try again? 
   -> prompt_restart

 - with_guard == true:
  Bob: "I've got this, I took a pilot training course back in the academy. Buckle up, it's going to be a bumpy ride!"

Bob grabs the wheel and carefully pilots the pod towards the planet.
# EMPTY_LINE
  What goes around comes around, maybe you aren't such a bad guy after all…
  To be continued...
-> prompt_restart

 - with_prisoner == true:
  Prisoner: *chuckles* "Now that I'm free... did you know? Those 'enhancements' I gave you were a little.. modified."
# EMPTY_LINE
  \*The prisoner presses a button on his wrist, and you feel a shock. You're paralyzed!\*
  Prisoner: "I have no need for dead weight. Have a nice trip!"
The prisoner throws you out of the hangar bay, and takes the escape pod for himself.
# EMPTY_LINE
Birds of a feather flock together... Try again?
   -> prompt_restart

}

== prompt_restart ==
+ [Restart?] Restarting... # RESTART
-> END
