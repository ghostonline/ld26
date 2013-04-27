package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Tilemap;
import entities.Level;
import utils.BresenhamLine;
 
typedef Point = { x:Float, y:Float }

class LightMap extends Entity
{
    public function new(level:Level)
    {
        super(0, 0);
        this.level = level;
        darkness = new Tilemap("gfx/shadow.png", 640, 480, 16, 16);
        widthInTiles = Math.floor(darkness.width / darkness.tileWidth);
        heightInTiles = Math.floor(darkness.height / darkness.tileHeight);
        addGraphic(darkness);
        source = {x : 320, y: 240};

        map = new Array<Float>();
        for (ii in 0...widthInTiles * heightInTiles)
        {
            map.push(0);
        }
        updateSources();

        layer = 10;
    }

    public function updateSources()
    {
        for (ii in 0...widthInTiles * heightInTiles)
        {
            map[ii] = 0;
        }
        lightSource(source, map);

        for (ii in 0...widthInTiles * heightInTiles)
        {
            var x = ii % widthInTiles;
            var y = Math.floor(ii / widthInTiles);

            var brightness = Math.floor(map[ii]);
            if (brightness == 0)
                darkness.setTile(x, y, brightness);
            else
                darkness.clearTile(x, y);
        }
    }

    function lightSource(source:Point, map:Array<Float>)
    {
        var maxDistance = 7.5;
        var fallOffX = Math.floor(maxDistance * 2);
        var fallOffY = Math.floor(maxDistance * 2);
        var centerX = Math.floor(source.x / darkness.tileWidth);
        var centerY = Math.floor(source.y / darkness.tileHeight);
        var startX = centerX - Math.floor(fallOffX / 2);
        var startY = centerY - Math.floor(fallOffY / 2);
        if (startX < 0)
        {
            fallOffX += startX;
            startX = 0;
        }
        if (startX + fallOffX > widthInTiles - 1)
        {
            fallOffX -= (startX + fallOffX) - widthInTiles;
        }

        var centerPoint = new nme.geom.Point(centerX, centerY);
        var query = new nme.geom.Point();
        for (col in 0...fallOffX)
        {
            for (row in 0...fallOffY)
            {
                query.x = startX + col;
                query.y = startY + row;
                if (nme.geom.Point.distance(centerPoint, query) < maxDistance && isTracable(startX + col, startY + row, centerX, centerY))
                {
                    var test = (startX + col) + (startY + row) * widthInTiles; 
                    map[test] = 1;
                }
            }
        }
    }

    inline function isTracable(startX:Int, startY:Int, endX:Int, endY:Int)
    {
        var walker = BresenhamLine.walk(startX, startY, endX, endY);
        for (point in walker)
        {
            if (level.isSolid(Math.floor(point.x), Math.floor(point.y)))
            {
                return false;
            }
        }
        return true;
    }

    public function createPoint():Point
    {
        return source;
    }

    var darkness:Tilemap;
    var map:Array<Float>;
    var source:Point;
    var widthInTiles:Int;
    var heightInTiles:Int;
    var level:Level;
}
