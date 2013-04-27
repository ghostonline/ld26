package utils;

import nme.geom.Point;

class BresenhamLine
{
    var start:Point;
    var end:Point;
    var dX:Float;
    var dY:Float;
    var sX:Float;
    var sY:Float;
    var err:Float;

    public static function walk(startX:Float, startY:Float, endX:Float, endY:Float)
    {
        return new BresenhamLine(new Point(startX, startY), new Point(endX, endY));
    }

    function new(start:Point, end:Point)
    {
        this.start = start;
        this.end = end;
        dX = Math.abs(end.x - start.x);
        dY = Math.abs(end.y - start.y);
        sX = start.x < end.x ? 1 : -1;
        sY = start.y < end.y ? 1 : -1;
        err = dX - dY;
    }

    public function hasNext()
    {
        return Point.distance(start, end) > 0.1;
    }

    public function next()
    {
        var result = start;
        var e2 = 2*err;
        if (e2 > -dY)
        {
            err -= dY;
            start.x += sX;
        }
        if (e2 < dX)
        {
            err += dX;
            start.y += sY;
        }
        return result;
    }
}
