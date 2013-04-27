package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Tilemap;
 
class LightMap extends Entity
{
    public function new()
    {
        super(0, 0);
        darkness = new Tilemap("gfx/shadow.png", 640, 480, 16, 16);
        addGraphic(darkness);
        updateSources();
        layer = 10;
    }

    function updateSources()
    {
        darkness.setRect(0,0,darkness.width, darkness.height, 0);
    }

    public override function update()
    {
        super.update();
    }

    var darkness:Tilemap;
}
