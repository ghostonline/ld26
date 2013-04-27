package scenes;

import com.haxepunk.Scene;
import entities.Level;
import entities.Player;
 
class GameScene extends Scene
{

    public function new()
    {
        super();
    }

    public override function begin()
    {
        add(new Level());
        add(new Player(320, 240));
    }

}
