package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import entities.LightMap;
 
class Torch extends Entity
{
    public function new(x:Float, y:Float, source:LightPoint)
    {
        super(x, y);
        var img = new Image("gfx/torch.png");
        img.centerOrigin();
        addGraphic(img);
        this.source = source;
    }

    var source:LightPoint;
}
