package scenes;

import com.haxepunk.Scene;
import entities.Level;
import entities.Player;
import entities.LightMap;
 
class GameScene extends Scene
{

    public function new()
    {
        super();
    }

    public override function begin()
    {
        add(new Level());
        add(new LightMap());
        add(new Player(320, 240));
    }

}
