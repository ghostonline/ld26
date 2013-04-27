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
        var lightmap = new LightMap(level);
        var player = new Player(320, 240, lightmap);
        var bat = new Bat(120, 64, level, player, lightmap);
        add(level);
        add(lightmap);
        add(player);
        add(bat);
    }

}
