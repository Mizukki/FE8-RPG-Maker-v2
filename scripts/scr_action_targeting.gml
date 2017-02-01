//argument0 - actro performing the action
//argument1- targeting type
//argument2 - targeting range

actor = argument0;
targetingType = argument1;
range = argument2;

switch(targetingType)
{
    case "cone":
        originX = actor.x +8;
        originY = actor.y +8;
        dir = point_direction(originX,originY,obj_cursor.hoverNode.x+8,obj_cursor.hoverNode.y+8);
        originX += lengthdir_x(15,dir);
        originY += lengthdir_y(15,dir);
        dist = range -16;
        
        for (i=-30;i<=30;i+=15)
        {
            for(j=0;j<=dist;j+=8)
            {
                tempX = originX + lengthdir_x(j,dir+i);
                tempY = originY + lengthdir_y(j,dir+i);
                
                //check if there is a wall between the actor and the target
                if (!collision_line(originX,originY, tempX,tempY,obj_wall,false,false))
                {
                    if (instance_position(tempX,tempY,obj_node))
                    {
                        node = instance_position(tempX,tempY,obj_node);
                        
                        if (node.type != "wall")
                        {
                            node.actionNode = true;
                            node.color = c_purple;
                        }
                    }
                }
            }
        }
        break;
        
    case "visible allies":
        with(obj_actor)
        {
            if (army == other.actor.army)
            {
                if (!collision_line(x,y,other.actor.x,other.actor.y,obj_wall,false,false))
                {
                    node = map[gridX,gridY];
                    
                    node.actionNode = true;
                    node.color = c_purple;
                }
            }
        }
        break;
        
    case "visible enemies":
        with(obj_actor)
        {
            if (army != other.actor.army)
            {
                if (!collision_line(x,y,other.actor.x,other.actor.y,obj_wall,false,false))
                {
                    node = map[gridX,gridY];
                    
                    node.actionNode = true;
                    node.color = c_purple;
                }
            }
        }
        break;
}



















