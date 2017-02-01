//argument0 - actor whose buttons to create

actor = argument0;

buttonList = ds_list_create();

if(actor.canAct)
{
    if (actor.firstLevelSlot>0)
    {
        for (i=0;i<ds_list_size(actor.firstLevelSpellList);i+=1)
        {
            ds_list_add(buttonList,ds_list_find_value(actor.firstLevelSpellList,i));
        }
    }
}

for (i=0;i<ds_list_size(actor.defaultActions);i+=1)
{
    ds_list_add(buttonList,ds_list_find_value(actor.defaultActions,i));
}

buttonY = room_height - 48;
buttonX = room_width/2 - ((ds_list_size(buttonList) - 1) * 48);

for (i=0;i<ds_list_size(buttonList);i+=1)
{
    button = ds_list_find_value(buttonList,i);
    
    switch(button)
    {
        //default actions
        case "end turn":
            with(instance_create(buttonX+(i*96),buttonY,obj_button))
            {
                sprite_index = spr_button_end_turn;
                title = "END TURN";
                text = "finish turn of current character";
                hotKey = "X";
            }
            break;

        //cleric spells
                case "Bless":
            with(instance_create(buttonX + (i*96), buttonY, obj_button))
            {
                title = "BLESS";
                text = "Give all party members a small bonus to attack and save rolls#1d4 bonus (5 rounds)";
                hotKey = string(other.i + 1);
                spell = true;
                spellSlot = string(other.actor.firstLevelSlot);
            }
            break;
            
        case "Guiding Bolt":
            with(instance_create(buttonX + (i*96), buttonY, obj_button))
            {
                title = "GUIDING BOLT";
                text = "Right-Click an enemy to fire an illuminating bolt!#4d6 RADIANT damage#bonus on next attack against target";
                hotKey = string(other.i + 1);
                spell = true;
                spellSlot = string(other.actor.firstLevelSlot);
            }
            break;    
            
        case "Healing Word":
            with(instance_create(buttonX + (i*96), buttonY, obj_button))
            {
                title = "HEALING WORD";
                text = "Right-Click an ally in range to heal them#1d8"+string(other.actor.wisMod)+"HEALING";
                hotKey = string(other.i + 1);
                spell = true;
                spellSlot = string(other.actor.firstLevelSlot);
            }
            break;
                    
        //wizard spells
        case "Acid Orb":
            with(instance_create(buttonX + (i*96), buttonY, obj_button))
            {
                title = "ACID ORB";
                text = "Right-Click and enemy to fire an orb of deadly acid!#3d10 ACID damage#ongoing burn";
                hotKey = string(other.i + 1);
                spell = true;
                spellSlot = string(other.actor.firstLevelSlot);
            }
            break;
            
        case "Burning Hands":
            with(instance_create(buttonX + (i*96), buttonY, obj_button))
            {
                title = "BURNING HANDS";
                text = "Right-Click a square in range to emit a cone of flame!#3d6 FIRE damage (AOE)";
                hotKey = string(other.i + 1);
                spell = true;
                spellSlot = string(other.actor.firstLevelSlot);
            }
            break;
            
        case "Magic Missiles":
            with(instance_create(buttonX + (i*96), buttonY, obj_button))
            {
                title = "MAGIC MISSILES";
                text = "Fire a Magic Missile at each visible enemy#1d4+1 FORCE damage#cannot miss!";
                hotKey = string(other.i + 1);
                spell = true;
                spellSlot = string(other.actor.firstLevelSlot);
            }
            break;
    }
}

ds_list_destroy(buttonList);















