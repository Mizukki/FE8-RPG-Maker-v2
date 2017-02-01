//argument0 - the actor performing the action
//argument14 - the button to be perfomed

actor = argument0;
button = argument1;

switch(button.title)
{
    //default actions
    case "END TURN":
        actor.state = "begin action";
        actor.readiedAction = "END TURN";
        actor.targetingType = "none";
        
        with(instance_create(room_width/2,room_height,obj_confirm_button))
        {
            title = other.button.title;
            text = other.button.text;
            hotKey = other.button.hotKey;
        }
        
        scr_wipe_nodes();
        scr_wipe_buttons();
        break;
        
    //cleric spells
    case "BLESS":
        actor.state = "begin action";
        actor.readiedAction = "Bless";
        actor.targetingType = "visible allies";
        actor.actionRange = 640;
        
        with(instance_create(room_width/2,room_height,obj_confirm_button))
        {
            title = other.button.title;
            text = other.button.text;
        }
        
        scr_wipe_nodes();
        scr_wipe_buttons(); 
        break;
        
    case "GUIDING BOLT":
        actor.state = "begin action";
        actor.readiedAction = "Guiding Bolt";
        actor.targetingType = "visible enemies";
        actor.actionRange = 640;
        
        with(instance_create(room_width/2,room_height,obj_confirm_box))
        {
            title = other.button.title;
            text = other.button.text;
        }
        
        scr_wipe_nodes();
        scr_wipe_buttons(); 
        break;    
        
    case "HEALING WORD":
        actor.state = "begin action";
        actor.readiedAction = "Healing Word";
        actor.targetingType = "visible allies";
        actor.actionRange = 640;
        
        with(instance_create(room_width/2,room_height,obj_confirm_box))
        {
            title = other.button.title;
            text = other.button.text;
        }
        
        scr_wipe_nodes();
        scr_wipe_buttons(); 
        break;
            
    //wizard spells
    case "ACID ORB":
        actor.state = "begin action";
        actor.readiedAction = "Acid Orb";
        actor.targetingType = "visible enemies";
        actor.actionRange = 640;
        
        with(instance_create(room_width/2,room_height,obj_confirm_box))
        {
            title = other.button.title;
            text = other.button.text;
        }
        
        scr_wipe_nodes();
        scr_wipe_buttons(); 
        break;
        
    case "BURNING HANDS":
        actor.state = "begin action";
        actor.readiedAction = "Burning Hands";
        actor.targetingType = "cone";
        actor.actionRange = 96;
        
        with(instance_create(room_width/2,room_height,obj_confirm_box))
        {
            title = other.button.title;
            text = other.button.text;
        }
        
        scr_wipe_nodes();
        scr_wipe_buttons(); 
        break;
        
    case "MAGIC MISSILES":
        actor.state = "begin action";
        actor.readiedAction = "Magic Missiles";
        actor.targetingType = "visible enemies";
        actor.actionRange = 640;
        
        with(instance_create(room_width/2,room_height,obj_confirm_button))
        {
            title = other.button.title;
            text = other.button.text;
            hotKey = other.button.hotKey;
        }
        
        scr_wipe_nodes();
        scr_wipe_buttons(); 
        break;
}
