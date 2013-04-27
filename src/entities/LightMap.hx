package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Tilemap;
 
typedef Point = { x:Float, y:Float }

class LightMap extends Entity
{
    public function new()
    {
        super(0, 0);
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
        var fallOffX = 9;
        var fallOffY = 9;
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
        for (col in 0...fallOffX)
        {
            for (row in 0...fallOffY)
            {
                var test = (startX + col) + (startY + row) * widthInTiles; 
                map[test] = 1;
            }
        }
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
}
