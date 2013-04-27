package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Tilemap;
import com.haxepunk.masks.Grid;
 
class Level extends Entity
{
    public function new()
    {
        super(0, 0);
        background = new Tilemap("gfx/tiles.png", 640, 480, 16, 16);        
        addGraphic(background);
        colliderMask = new Grid(background.width, background.height, background.tileWidth, background.tileHeight);
        mask = colliderMask;
        type = "level";
        setupLevel();
        layer = 100;
    }

    function setupLevel()
    {
        // Draw tiles
        background.clearRect(0,0,background.columns, background.rows);
        background.setRect(0,0,background.columns, background.rows, 2);
        background.setRect(1,1,background.columns - 2, background.rows - 2, 1);
        for (ii in 0...background.rows)
        {
            if (ii % 5 != 0)
                continue;
            background.setRect(1, ii, background.columns, 1, 2);
        }
        var corridorWidth:Int = 4;
        var centerIsle:Int = Math.floor((background.columns - corridorWidth) / 2);
        background.setRect(centerIsle,1, corridorWidth, background.rows - 2, 1);

        // Setup mask
        colliderMask.clearRect(0,0, background.columns, background.rows);
        for (col in 0...background.columns)
        {
            for (row in 0...background.rows)
            {
                var solid = background.getTile(col, row) == 2;
                colliderMask.setTile(col, row, solid);
            }
        }
    }

    public function isSolid(x:Int, y:Int)
    {
        return colliderMask.getTile(x, y);
    }

    var background:Tilemap;
    var colliderMask:Grid;
}
