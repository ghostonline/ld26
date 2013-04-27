package scenes;

import com.haxepunk.Scene;
import entities.Level;
import entities.Player;
import entities.LightMap;
import entities.Bat;
 
class GameScene extends Scene
{

    public function new()
    {
        super();
    }

    public override function begin()
    {
        var level = new Level();
        var lightmap = new LightMap();
        var player = new Player(320, 240, lightmap);
        var bat = new Bat(320, 24, level, player);
        add(level);
        add(lightmap);
        add(player);
        add(bat);
    }

}
