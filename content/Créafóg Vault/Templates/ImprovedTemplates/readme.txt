Created by Alyksandrei, for use by the Reroll community. I hope these templates are useful!

Included Templates:
Backgrounds
Classes
Races
Subclasses

In Progress:
Feats
Spells

----------------

Notes and Comments (because JSON doesn't accept comments, and some things need more explanation):

backgrounds.json
* "skills_count_choose" takes an integer. This is the number of skills the user is allowed to select from the list.
* "Skills" is an array (list) of which skills the user is allowed to select. If "skills_count_choose" is set to 0, all skills in this list will be marked as Proficient.

classes.json
* "hit_die" takes an integer, and should be 6, 8, 10, or 12. This represents the die used when rolling/calculating a character's Maximum Hit Points. Other integers may be accepted (I haven't tested them), but they may cause the level-up process to break. Alternately, any value other than the four standard ones may simply be ignored and a default (probably 6) used instead.
* "combat_resource" is for things like Rage uses or Ki points - things that get used up in battle and restored on a rest. I'd imagine that they could also be used for Sorcery Points or a Battlemaster's Superiority Dice, but those might be tracked elsewhere.
* "skills_count_choose" takes an integer. This is the number of skills the user is allowed to select from the list.
* "Skills" is an array (list) of which skills the user is allowed to select. If "skills_count_choose" is set to 0, all skills in this list will be marked as Proficient.
* "saving_throws" is an array (list) selecting which saving throws members of the class are proficient in. A standard class is proficient in two of the six saving throws.
* "level_for_subclass" specifies which level the character chooses their Class Archetype at. It should only be 1, 2, or 3; anything else will either throw an error or break the level-up process.
* "level_for_asi_bonuses" is an array of integers specifying when the class grants Ability Score Increases. Most classes get them at 4, 8, 12, 16, and 19, although some, such as the Fighter, also get additional ASIs at other levels.
* "levels" is an array of 'objects', each of which details certain parameters of the class. There are 20 of these, one for each level as laid out in the SRD. I've included detailed examples of each type of class (martial, half-caster, full-caster, warlock-style), so you hopefully won't need to edit any of the information in this section. But if your homebrew class does wacky things, here's an explanation just in case.
  + "number" is an integer which specifies which level the 'object' is detailing.
  + "prof_bonus" is an integer representing the proficiency bonus used at the specified level. These are identical for all officially published classes (WotC, UA, and 3PP), and I doubt anyone has tried fiddling with these numbers for any homebrew, either.
  + "spells_levels" is an array that specifies how many spell slots the class has available, and which spell levels they are. This is probably the only part you might want to tinker with, but I don't think any Wotc, UA, or 3PP class uses a distribution other than those found in the SRD.

races.json
* "Speed" is an integer (normally 30) indicating the race's Base Movement Speed. Small races (and Dwarves, who are Medium) have a speed of 25.
* "ability_bonuses" is an array indicating which ability scores get bonuses. In order, they are Strength, Dexterity, Constitution, Intelligence, Wisdom, and Charisma. There is no way to reorder these, so please be careful when typing these in.
* "flex_ability_bonuses" is an array specifying the bonuses to ability scores the race gives, but not which score they affect. The user then distributes these bonuses to whatever ability scores they choose. Please note that the same ability score cannot be chosen twice (I think; can someone verify please?).
* "traits" is an array of 'objects' that describe the various racial traits. In officially published material, these are listed in the following order: ASI (base only, if subraces also give ASIs), Age, Alignment, Size, Speed, Shared Traits (there can be more than one of these, and only include traits of the base race, not subraces), and Languages.
  + Because Reroll currently does not support Subraces the way it supports Subclasses (as "Subraces" seems irrelevant when you're only looking at the SRD), each Subrace must be entered as a separate Race. For standardization purposes, it would be "best practices" to put subrace-specific traits *after* the Languages shared trait.
    - Some subraces might have traits with the same name as a shared trait. These should be listed separately, as subrace traits, for uniformity.