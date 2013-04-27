package scenes;

import com.haxepunk.HXP;
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
        player = null;
    }

    public override function begin()
    {
        var level = new Level();
        var lightmap = new LightMap(level);
        player = new Player(320, 240, lightmap);
        var bat = new Bat(120, 64, level, player, lightmap);
        add(level);
        add(lightmap);
        add(player);
        add(bat);
    }

    public override function update()
    {
        super.update();
        if (player != null)
        {
            var offsetX = player.x * HXP.screen.fullScaleX - HXP.screen.width * 0.5;
            var offsetY = player.y * HXP.screen.fullScaleY - HXP.screen.height * 0.5;
            HXP.screen.x = Math.floor(-offsetX);
            HXP.screen.y = Math.floor(-offsetY);
        }
    }

    var player:Player;
}
