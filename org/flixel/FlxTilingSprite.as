package org.flixel {
	import flash.geom.Point;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Adam Bielinski
	 */
	public class FlxTilingSprite extends FlxSprite{
		
		public var tile_horz:Boolean;
		public var tile_vert:Boolean;
		
		public function FlxTilingSprite(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null, Horizontal:Boolean = true, Vertical:Boolean=true ) {
			super(X, Y, SimpleGraphic);
			tile_horz = Horizontal;
			tile_vert = Vertical;
		}
		
		override protected function renderSprite():void {
			getScreenXY(_point);
			render_horz(_point.x, _point.y);
		}
		
		protected function render_horz(left:Number, top:Number):void {
			if (tile_horz) {
				left = left % width - width;
				while (left <= FlxG.width) {
					render_vert(left, top);
					left += width;
				}
			}else {
				render_vert(left, top);
			}
		}
		
		protected function render_vert(left:Number, top:Number):void {
			if (tile_vert) {
				top = top % height - height;
				while (top <= FlxG.height) {
					render_here(left, top);
					top += height;
				}
			}else {
				render_here(left, top);
			}
		}
		
		public function render_here(X:Number, Y:Number):void {
			_flashPoint.x = X;
			_flashPoint.y = Y;
			
			//Simple render
			if(((angle == 0) || (_bakedRotation > 0)) && (scale.x == 1) && (scale.y == 1) && (blend == null))
			{
				FlxG.buffer.copyPixels(_framePixels,_flashRect,_flashPoint,null,null,true);
				return;
			}
			
			//Advanced render
			_mtx.identity();
			_mtx.translate(-origin.x,-origin.y);
			_mtx.scale(scale.x,scale.y);
			if(angle != 0) _mtx.rotate(Math.PI * 2 * (angle / 360));
			_mtx.translate(_point.x+origin.x,_point.y+origin.y);
			FlxG.buffer.draw(_framePixels,_mtx,null,blend,null,antialiasing);
		}
		
	}

}