package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import entities.Level;
import entities.Player;
 
class Bat extends Entity
{
    static var AgressionTrigger = 70;
    static var PursuitVelocity = 1;
    static var PursuitTimeout = 90;

    public function new(x:Float, y:Float, level:Level, player:Player)
    {
        super(x, y);
        var img = new Image("gfx/bat.png");
        img.centerOrigin();
        addGraphic(img);
        this.level = level;
        this.player = player;
        setHitbox(12, 4, 6, 2);

        layer = 60;
    }

    public override function update()
    {
        if (distanceFrom(player) < AgressionTrigger)
        {
            pursuitTimer = PursuitTimeout;
        }
        if (pursuitTimer >= 0)
        {
            moveTowards(player.x, player.y, PursuitVelocity, "level");
            pursuitTimer -= 1;
        }
        super.update();
    }

    var level:Level;
    var player:Player;
    var pursuitTimer:Int;
}
