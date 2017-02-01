//argument0 - actor performing the action
//argument1 - action to be perfomed

actor = argument0;
action = argument1;

switch(action)
{
    //default actions
    case "END TURN":
        actor.state = "end turn";
        actor.actionTimer = 20;
        break;
        
    //cleric spells
    case "Bless":
        targets = ds_list_create();
        
        with(obj_node)
        {
            if (actionNode)
            {
                ds_list_add(other.targets,id);
            }
        }
        
        for (i=0;i<ds_list_size(targets);i+=1)
        {
            target = ds_list_find_value(targets,i).occupant;
            target.blessed = obj_control.roundCounter + 5;
            
            with(instance_create(target.x,target.y,obj_bless))
            {
                target = other.target;
            }
        }
        ds_list_destroy(targets);
        
        actor.firstLevelSlot -= 1;
        actor.canAct = false;
        actor.actions -= 1;
        actor.state = "end action";
        actor.actionTimer = 15;
        
        break;
        
    case "Guiding Bolt":
        target = obj_cursor.hoverNode.occupant;
        attackRoll = irandom_range(1,20);
        attackStatus = scr_attack_roll(actor,target);
        damageType = "radiant";
        tempDamage = 0;
        
        for (i=0;i<4;i+=1)
        {
            tempDamage += irandom_range(1,6);
        }
        attackDir = point_direction(actor.x+8,actor.y+8,target.x+8,target.y+8);
        
        with(instance_create(actor.x+8,actor.y+8,obj_guiding_bolt))
        {
            target = other.target;
            status = other.attackStatus;
            damage = other.tempDamage;
            path_add_point(movementPath,other.actor.x+8,other.actor.y+8,100);
            
            if ( status != "miss")
            {
                path_add_point(movementPath,target.x+8,target.y+8,100);
            }
            else
            {
                path_add_point(movementPath,target.x+8+(irandom_range(30,50)*choose(-1,1)),taget.y+8+(irandom_range(30,50)*choose(-1,1)),100);
            }
            path_start(movementPath,speed,true,true);
        }
        actor.firrstLevelSlot -= 1;
        actor.canAct = false;
        actor.actions -= 1;
        actor.state = "end action";
        actor.actionTimer = 30;
        
        break; 
        
    case "Healing Word":
        target = obj_cursor.hoverNode.occupant;
        heal = irandom_range(1,8) + actor.wisMod;
        heal = min(heal,target.maxHitPoints - target.hitPoints);
        target.hitPoints += heal;
        
        with(instance_create(target.x+28,target.y+4,obj_damage_text))
        {
            ground = y;
            text = "+" string(other.heal);
            color = c_lime;
        }
        
        actor.firstLevelSlot -= 1;
        actor.canAct = false;
        actor.actions -= 1;
        actor.state = "end action";
        actor.actionTimer = 15;
        
        break;
    
    //wizard spells
    case "Acid Orb":
        target = obj_cursor.hoverNode.occupant;
        attackRoll = irandom_range(1,20);
        attackStatus = scr_attack_roll(actor,target);
        damageType = "acid";
        tempDamage = 0;
        
        for (i=0;i<3;i+=1)
        {
            tempDamage += irandom_range(1,10);
        }
        attackDir = point_direction(actor.x+8,actor.y+8,target.x+8,target.y+8);
        
        with(instance_create(actor.x+8,actor.y+8,obj_acid_orb))
        {
            target = other.target;
            status = other.attackStatus;
            damage = other.tempDamage;
            path_add_point(movementPath,other.actor.x+8,other.actor.y+8,100);
            
            if ( status != "miss")
            {
                path_add_point(movementPath,target.x+8,target.y+8,100);
            }
            else
            {
                path_add_point(movementPath,target.x+8+(irandom_range(30,50)*choose(-1,1)),taget.y+8+(irandom_range(30,50)*choose(-1,1)),100);
            }
            path_start(movementPath,speed,true,true);
        }
        actor.firrstLevelSlot -= 1;
        actor.canAct = false;
        actor.actions -= 1;
        actor.state = "end action";
        actor.actionTimer = 30;
        
        break;
    
    case "Burning Hands":
        targets = ds_list_create();
        damage = 0;
        
        for (i=0;i<3;i+=1)
        {
            damage += irandom_range(1,6);
        }
        with(obj_node)
        {
            if(actionNode)
            {
                ds_list_add(other.targets,id);
            }
        }
        
        for (i=0;i<ds_list_size(targets);i+=1)
        {
            node = ds_list_find_value(targets,i);
            
            with(instance_create(node.x+8,node.y+8,obj_flame_emitter))
            {
                target = other.node.occupant;
                saveDC = other.actor.spellSaveDC;
                damage = other.damage;
            }
        }
        
        ds_list_destroy(targets);
        
        actor.firrstLevelSlot -= 1;
        actor.canAct = false;
        actor.actions -= 1;
        actor.state = "end action";
        actor.actionTimer = 30;
        
        break;
        
    case "Magic Missiles":
        targets = ds_list_create();
        
        with(obj_node)
        {
            if (actionNode)
            {
                ds_list_add(other.targets,id);
            }
        }
        
        for (i=0;i<ds_list_size(targets);i+=1)
        {
            target = ds_list_find_value(targets,i).occupant;
            
            with(instance_create(actor.x+8,actor.y+8,obj_arrow))
            {
                target = other.target;
                status = "hit";
                damage = irandom_range(1,4) + 1;
                damageType = "force";
                
                path_add_point(movementPath,other.actor.x+8,other.actor.y+8,10);
                path_add_point(movementPath,other.target.x+8,other.target.y+8,10);
                path_start(movement,speed,true,true);
            }
        }
        
        ds_list_destroy(targets);
        
        actor.firstLevelSlot -= 1;
        actor.canAct = false;
        actor.actions -= 1;
        actor.state = "end action";
        actor.actionTimer = 30;
        
        break;
}





















