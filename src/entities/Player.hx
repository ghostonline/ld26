package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
 
class Player extends Entity
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        var img = new Image("gfx/explorer.png");
        img.centerOrigin();
        img.originY += 4;
        addGraphic(img);
        setHitbox(12, 12, 6, 6);
    }

    public override function update()
    {
        super.update();
    }
}
