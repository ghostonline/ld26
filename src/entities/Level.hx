package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Tilemap;
 
class Level extends Entity
{
    public function new()
    {
        super(0, 0);
        background = new Tilemap("gfx/tiles.png", 640, 480, 16, 16);        
        addGraphic(background);
        setupLevel();
    }

    function setupLevel()
    {
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
    }

    public override function update()
    {
        super.update();
    }

    var background:Tilemap;
}
