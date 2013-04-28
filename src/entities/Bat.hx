package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import entities.Level;
import entities.Player;
import entities.LightMap;
import utils.BresenhamLine;
import nme.geom.Point;
 
class Bat extends Entity
{
    static var AgressionTrigger = 70;
    static var PursuitVelocity = 2;
    static var PursuitTimeout = 90;

    public function new(x:Float, y:Float, level:Level, player:Player, lightmap:LightMap)
    {
        super(x, y);
        var img = new Spritemap("gfx/bat.png", 16, 16);
        img.add("static", [0,1,2,3,4], 15, true);
        img.play("static", true);
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
        if (lightmap.isPointLit(x, y))
        {
            var point = new Point(x, y);
            var sourcePoint = new Point();
            var nearestPointDistance:Float = 1000000;
            for (source in lightmap.sources)
            {
                sourcePoint.x = source.x;
                sourcePoint.y = source.y;
                var dist = Point.distance(sourcePoint, point);
                if (dist < nearestPointDistance && dist < source.radius)
                {
                    nearestPointDistance = dist;
                    pursuitTimer = PursuitTimeout;
                    target = source;
                }
            }
        }

        if (pursuitTimer >= 0)
        {
            if (pointVisible(target.x, target.y))
            {
                lastTargetX = target.x;
                lastTargetY = target.y;
            }
            moveTowards(lastTargetX, lastTargetY, PursuitVelocity, "level");
            pursuitTimer -= 1;
        }

        if (collideWith(player, x, y) != null)
        {
            player.attackFromBat(this);
        }
    }

    function pointVisible(targetX:Float, targetY:Float)
    {
        var tileX = Math.floor(x / 16);
        var tileY = Math.floor(y / 16);
        var tilePlayerX = Math.floor(targetX / 16);
        var tilePlayerY = Math.floor(targetY / 16);
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

    var target:LightPoint;
    var lastTargetX:Float;
    var lastTargetY:Float;
}
