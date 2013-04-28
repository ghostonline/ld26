package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Tilemap;
import com.haxepunk.masks.Grid;
import haxe.xml.Fast;
import nme.geom.Point;
 
class Level extends Entity
{
    public function new()
    {
        super(0, 0);
        type = "level";
        playerPos = new Point(0, 0);
        setupLevel();
        layer = 100;
    }

    function setupLevel()
    {
        var xmlData = Xml.parse(nme.Assets.getText("levels/room1.tmx"));
        var levelData = new Fast(xmlData).node.map;
        var layerData = null;
        for (layer in levelData.nodes.layer)
        {
            if (layer.att.name == "Tile Layer 1")
            {
                layerData = layer;
            }
        }
        if (layerData == null)
        {
            trace("No suitable layer found.");
            return;
        }

        var width = Std.parseInt(layerData.att.width);
        var height = Std.parseInt(layerData.att.height);

        background = new Tilemap("gfx/tiles.png", width * 16, height * 16, 16, 16);        
        graphic = background;
        colliderMask = new Grid(background.width, background.height, background.tileWidth, background.tileHeight);
        mask = colliderMask;

        // Draw tiles
        var rows = layerData.node.data.innerData.split('\n');
        var rowIdx = 0;
        for (row in rows)
        {
            if (row == "")
                continue;
            var cols = row.split(',');
            var colIdx = 0;
            for (col in cols)
            {
                if (col == "")
                    continue;

                var tileID = Std.parseInt(col) - 1;
                if (tileID == -1)
                    continue;

                background.setTile(colIdx, rowIdx, tileID);

                var solid = tileID == 0 || tileID == 2;
                colliderMask.setTile(colIdx, rowIdx, solid);

                colIdx += 1;
            }
            rowIdx += 1;
        }

        // Load all entities
        bats = new Array<Point>();
        for (object in levelData.node.objectgroup.nodes.object)
        {
            var type = object.att.type;
            var x = Std.parseInt(object.att.x);
            var y = Std.parseInt(object.att.y);
            switch type
            {
                case "player":
                    playerPos = new Point(x, y);
                case "bat":
                    bats.push(new Point(x, y));
            }
        }
    }

    public function isSolid(x:Int, y:Int)
    {
        return colliderMask.getTile(x, y);
    }

    public function getWidth()
    {
        return background.width;
    }

    public function getHeight()
    {
        return background.height;
    }

    var background:Tilemap;
    var colliderMask:Grid;
    public var playerPos:Point;
    public var bats:Array<Point>;
}
