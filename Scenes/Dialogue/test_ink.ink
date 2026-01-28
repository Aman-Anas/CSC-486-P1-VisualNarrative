Once upon a time... 
bla bla bla you are stuck in prison
Begin your adventure?

VAR ate_food = false

+ [Letsgooooo]
  -> begin

== begin ==
A: Eat breakfast
# EMPTY_LINE
Eat the prison food or not

+ [Refuse] You refuse the prison food.
 -> stay_or_leave
+ [Eat] You eat the food and feel energized!
 ~ate_food = true
 -> stay_or_leave

== stay_or_leave ==
B: Stay or leave cell block
Do you stay in the cell block?
{ate_food}
+ [Stay in the cell block] RIP you died
 -> prompt_restart
+ [Break out] You break out of the cell block
 -> go_to_hangar

== go_to_hangar ==
C: Get to the hangar
Help guard?

+ to be continued
 -> prompt_restart

== prompt_restart ==
+ [Restart?] Restarting... # RESTART
-> END
