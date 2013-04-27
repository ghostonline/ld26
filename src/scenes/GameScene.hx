package scenes;

import com.haxepunk.Scene;
import entities.Level;
 
class GameScene extends Scene
{

    public function new()
    {
        super();
    }

    public override function begin()
    {
        add(new Level());
    }

}
