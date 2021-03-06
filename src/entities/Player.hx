package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import entities.LightMap;
import entities.Bat;
 
class Player extends Entity
{
    static var MaxVelocity = 3;
    static var PlayerTorchRadius = 150;
    static var PlayerAmbientRadius = 0;

    public function new(x:Float, y:Float, lightmap:LightMap)
    {
        super(x, y);
        var img = new Image("gfx/explorer.png");
        img.centerOrigin();
        img.originY += 4;
        addGraphic(img);
        setHitbox(16, 12, 8, 4);
        collidable = true;

        Input.define("left", [Key.LEFT, Key.A]);
        Input.define("right", [Key.RIGHT, Key.D]);
        Input.define("up", [Key.UP, Key.W]);
        Input.define("down", [Key.DOWN, Key.S]);
        Input.define("toggle_light", [Key.SHIFT, Key.E]);

        velocityX = 0;
        velocityY = 0;

        layer = 50;
        this.lightmap = lightmap;
        source = lightmap.createLight();
        source.x = x;
        source.y = y;
        source.radius = PlayerTorchRadius;
        lightmap.updateSources();
    }

    function handleInput()
    {
        velocityX = 0;
        velocityY = 0;

        if (Input.check("left"))
        {
            velocityX += -MaxVelocity;
        }
        if (Input.check("right"))
        {
            velocityX += MaxVelocity;
        }
        if (Input.check("up"))
        {
            velocityY += -MaxVelocity;
        }
        if (Input.check("down"))
        {
            velocityY += MaxVelocity;
        }

        if (Input.pressed("toggle_light"))
        {
            source.radius = source.radius == PlayerAmbientRadius ? PlayerTorchRadius : PlayerAmbientRadius;
            lightmap.updateSources();
        }
    }

    public override function update()
    {
        super.update();
        handleInput();
        moveBy(velocityX, velocityY, "level");
        if (velocityX != 0 || velocityY != 0)
        {
            source.x = x;
            source.y = y;
            lightmap.updateSources();
        }
    }

    public function attackFromBat(bat:Bat)
    {
        com.haxepunk.HXP.scene = new scenes.GameScene();
    }

    var velocityX:Float;
    var velocityY:Float;
    var lightmap:LightMap;
    var source:LightPoint;
}
