package org.flixel
{
	/**
	 * Stores a 2D floating point coordinate.
	 */
	public class FlxPoint
	{
		/**
		 * @default 0
		 */
		public var x:Number;
		/**
		 * @default 0
		 */
		public var y:Number;
		
		/**
		 * Instantiate a new point object.
		 * 
		 * @param	X		The X-coordinate of the point in space.
		 * @param	Y		The Y-coordinate of the point in space.
		 */
		public function FlxPoint(...args)
		{
			if (args[0] && args[0] is FlxObject) {
				x = args[0].x || 0;
				y = args[0].y || 0;
			}else{
				x = args[0] || 0;
				y = args[1] || 0;
			}
		}
		
		/**
		 * Convert object to readable string name.  Useful for debugging, save games, etc.
		 */
		public function toString():String
		{
			return FlxU.getClassName(this,true);
		}
		
		public function GetDistanceTo(OtherPoint:FlxPoint):Number {
			return Math.sqrt( Math.pow(this.x - OtherPoint.x, 2) + Math.pow(this.y - OtherPoint.y, 2));
		}
	}
}