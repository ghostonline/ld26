package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import entities.LightMap;
import com.haxepunk.graphics.Emitter;
import flash.display.BitmapData;
import com.haxepunk.utils.Ease;
 
class Torch extends Entity
{
    static var emitterTimeout = 15;
    static var ParticleName = "embers";

    public function new(x:Float, y:Float, source:LightPoint)
    {
        super(x, y);
        var img = new Image("gfx/torch.png");
        img.centerOrigin();
        addGraphic(img);
        this.source = source;
        layer = 60;
        emitter = new Emitter(new BitmapData(2,2, false, 0xFFFFFFFF), 2, 2);
        emitter.relative = false;

        emitter.newType(ParticleName, [0]);
        emitter.setColor(ParticleName, 0xFFFF00, 0xFF8800);
        emitter.setAlpha(ParticleName, 1, 0);
        emitter.setMotion(ParticleName, 80, 10, 2, 20, 0, 0, Ease.quadInOut);
        addGraphic(emitter);
        emitterTimer = 0;
    }

    public override function update()
    {
        super.update();
        if (emitterTimer < 0)
        {
            emitter.emit(ParticleName, x, y-5);
            emitterTimer = emitterTimeout;
        }
        else
        {
            emitterTimer--;
        }
    }

    var source:LightPoint;
    var emitter:Emitter;
    var emitterTimer:Int;
}
