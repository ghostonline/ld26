package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import entities.Level;
import entities.Player;
import entities.LightMap;
import utils.BresenhamLine;
 
class Bat extends Entity
{
    static var AgressionTrigger = 70;
    static var PursuitVelocity = 2;
    static var PursuitTimeout = 90;

    public function new(x:Float, y:Float, level:Level, player:Player, lightmap:LightMap)
    {
        super(x, y);
        var img = new Image("gfx/bat.png");
        img.centerOrigin();
        addGraphic(img);
        this.level = level;
        this.player = player;
        this.lightmap = lightmap;
        setHitbox(12, 4, 6, 2);
        pursuitTimer = -1;

        layer = 60;
    }

    public override function update()
    {
        super.update();
        if (lightmap.isPointLit(x, y) && entityVisible(player))
        {
            pursuitTimer = PursuitTimeout;
        }

        if (pursuitTimer >= 0)
        {
            if (entityVisible(player))
            {
                lastPlayerX = player.x;
                lastPlayerY = player.y;
            }
            moveTowards(lastPlayerX, lastPlayerY, PursuitVelocity, "level");
            pursuitTimer -= 1;
        }

        if (collideWith(player, x, y) != null)
        {
            player.attackFromBat(this);
        }
    }

    function entityVisible(e:Entity)
    {
        var tileX = Math.floor(x / 16);
        var tileY = Math.floor(y / 16);
        var tilePlayerX = Math.floor(e.x / 16);
        var tilePlayerY = Math.floor(e.y / 16);
        var walker = BresenhamLine.walk(tileX, tileY, tilePlayerX, tilePlayerY);
        for (point in walker)
        {
            if (level.isSolid(Math.floor(point.x), Math.floor(point.y)))
            {
                return false;
            }
        }
        return true;
    }

    var level:Level;
    var player:Player;
    var lightmap:LightMap;
    var pursuitTimer:Int;
    var lastPlayerX:Float;
    var lastPlayerY:Float;
}
