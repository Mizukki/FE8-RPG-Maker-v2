//argument0 = actor performing the range check

actor = argument0;

with (obj_actor)
{
    tempActor = other.actor;
    if (army != tempActor.army)
    {
        //check range
        if (point_distance(x+8,y+8,tempActor.x+8,tempActor.y+8) <= tempActor.attackRange)
        {
            if (!collision_line(x+8,y+8,tempActor.x+8,tempActor.y+8,obj_wall,false,false))
            {
                map[gridX,gridY].attackNode = true;
                map[gridX,gridY].color = c_red;
            }
        }
    }
}
