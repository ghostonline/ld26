package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import entities.Level;
import entities.Player;
 
class Bat extends Entity
{
    public function new(x:Float, y:Float, level:Level, player:Player)
    {
        super(x, y);
        var img = new Image("gfx/bat.png");
        img.centerOrigin();
        addGraphic(img);
        this.level = level;
        this.player = player;

        layer = 60;
    }

    public override function update()
    {
        super.update();
    }

    var level:Level;
    var player:Player;
}
