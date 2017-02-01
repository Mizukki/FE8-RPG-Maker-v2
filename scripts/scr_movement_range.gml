//argument0 - origin node, the node to pathfind from
//argument1 - unit's movement range
//argument2 - unit's remaining actions

//reset all node data
scr_wipe_nodes();

var open, closed;
var start, current, neighbor;
var tempG, range, costMod;

//declare relevant variables from arguments
start = argument0;
range = argument1 * argument2;

//create data structures
open = ds_priority_create();
closed = ds_list_create();

//add starting node to the open list
ds_priority_add(open,start,start.G);

//while open queue is not empty
//repeat the following until all nodes have been looked at
while (ds_priority_size(open) > 0)
{
    //remove node with lowest G score from open
    current =ds_priority_delete_min(open);
    
    //add that node to the closed list
    ds_list_add(closed, current);
    
    //steop through all of current's neighbors
    for (i=0;i<ds_list_size(current.neighbors);i+=1)
    {
        //store current neighbor in neighbor variable
        neighbor = ds_list_find_value(current.neighbors,i);
        
        //add neighbor to open list if it qualifies
        //define qualifies
        //check neighbor is passable
        //check neighbor has no occupant
        //check neighbor's projected G score is less than movement range
        //check neighbor isn't already on the closed list
        if (ds_list_find_index(closed, neighbor) < 0 && neighbor.passable && neighbor.occupant == noone && neighbor.cost + current.G <= range)
        {
            //only calculate a new G score for neighbor
            //if it isn't already been calculated
            if (ds_priority_find_priority(open, neighbor) == 0 || ds_priority_find_priority(open, neighbor) == undefined)
            {
                costMod = 1;
                
                //give neighbor the appropriate parent
                neighbor.parent = current;
                
                //if node is diagonal, create appropriate costMod
                if (neighbor.gridX != current.gridX && neighbor.gridY != current.gridY)
                {
                    costMod = 1.5;
                }
                //calculate G score of neighbor, with costMod in place
                neighbor.G = current.G + (neighbor.cost * costMod);
                
                //add neighbor to the open list so it can be checked out too!
                ds_priority_add(open, neighbor, neighbor.G);
            }
            // else if neighbor's score has already been calculated for the open list
            else
            {
                //figure out if the neighbor's score would be lower if found from the current node
                costMod = 1;
                
                //if node is diagonal, create appropriate costMod
                if (neighbor.gridX != current.gridX && neighbor.gridY != current.gridY)
                {
                    costMod = 1.5;
                }
                tempG = current.G + (neighbor.cost * costMod);
                
                //check if G score would be lower
                if (tempG < neighbor.G)
                {
                    neighbor.parent = current;
                    neighbor.G = tempG;
                    ds_priority_change_priority(open, neighbor, neighbor.G);
                }
            }
        }
    }
}
//round down all G scores for movement calculations
with (obj_node)
{
    G = floor(G);
}

//destroy open -> crash and fail
ds_priority_destroy(open);

//color all those move nodes
for (i=0;i<ds_list_size(closed); i+=1)
{
    current = ds_list_find_value(closed,i);
    current.moveNode = true;
    scr_color_move_node(current, argument1, argument2);   
}

start.moveNode = false;

//destroy closed list
ds_list_destroy(closed);

start.moveNode = false;

scr_create_buttons(start.occupant);


















