package org.flixel
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	/**
	 * This is the basic game "state" object - e.g. in a simple game
	 * you might have a menu state and a play state.
	 * It acts as a kind of container for all your game objects.
	 * You can also access the game's background color
	 * and screen buffer through this object.
	 * FlxState is kind of a funny class from the technical side,
	 * it is just a regular Flash Sprite display object,
	 * with one member variable: a flixel <code>FlxGroup</code>.
	 * This means you can load it up with regular Flash stuff
	 * or with flixel elements, whatever works!
	 */
	public class FlxState extends Sprite
	{
		/**
		 * This static variable holds the screen buffer,
		 * so you can draw to it directly if you want.
		 */
		static public var screen:FlxSprite;
		/**
		 * This static variable holds the HUD
		 */
		static public var hud:FlxGroup;
		/**
		 * This static variable indicates the "clear color"
		 * or default background color of the game.
		 * Change it at ANY time using <code>FlxState.bgColor</code>.
		 */
		static public var bgColor:uint;
		/**
		 * Internal group used to organize and display objects you add to this state.
		 */
		public var defaultGroup:FlxGroup;
		
		/**
		 * Creates a new <code>FlxState</code> object,
		 * instantiating <code>screen</code> if necessary.
		 */
		public function FlxState()
		{
			super();
			defaultGroup = new FlxGroup();
			if(screen == null)
			{
				screen = new FlxSprite();
				screen.createGraphic(FlxG.width,FlxG.height,0,true);
				screen.origin.x = screen.origin.y = 0;
				screen.antialiasing = true;
			}
			if (hud == null) {
				hud = new FlxGroup();
			}
		}
		
		
		public function reset():void {
			defaultGroup.destroy();
		}
		
		/**
		 * Override this function to set up your game state.
		 * This is where you create your groups and game objects and all that good stuff.
		 */
		public function create():void
		{
			//nothing to create initially
		}
		
		/**
		 * Adds a new FlxCore subclass (FlxSprite, FlxBlock, etc) to the game loop.
		 * FlxState is adding this object to its built-in FlxGroup to automate updating and rendering.
		 * 
		 * @param	Core	The object you want to add to the game loop.
		 */
		public function add(Core:FlxObject):FlxObject
		{
			return defaultGroup.add(Core);
		}
		
		/**
		 * Adds a new FlxCore subclass (FlxSprite, FlxBlock, etc) to the game loop.
		 * FlxState is adding this object to its built-in FlxGroup to automate updating and rendering.
		 * 
		 * @param	Core	The object you want to add to the game loop.
		 * @param	Index	The index you want it at
		 */
		public function addAt(Core:FlxObject, Index:int):FlxObject
		{
			return defaultGroup.addAt(Core, Index);
		}
		
		/**
		 * Adds a new FlxCore subclass (FlxSprite, FlxBlock, etc) to the game loop behind another object
		 * FlxState is adding this object to its built-in FlxGroup to automate updating and rendering.
		 * 
		 * @param	Core	The object you want to add to the game loop.
		 * @param	Core2	The Object that will be in front
		 */
		public function addBehind(Core:FlxObject, Core2:FlxObject):FlxObject
		{
			
			return defaultGroup.addAt(Core, getIndexOf(Core2));
		}
		
		public function remove(Core:FlxObject):void {
			defaultGroup.remove(Core, true);
		}
		
		
		/**
		 * Returns the index of the object in the group
		 *
		 * @param	Object			The object you want to add
		 *
		 * @return	The index of the object. Returns -1 if none was found.
		 */
		public function getIndexOf(Object:FlxObject):int
		{
			return defaultGroup.getIndexOf(Object);
		}
		/**
		 * Override this function to do special pre-processing FX like motion blur.
		 * You can use scaling or blending modes or whatever you want against
		 * <code>FlxState.screen</code> to achieve all sorts of cool FX.
		 */
		public function preProcess():void
		{
			screen.fill(bgColor);	//Default behavior - just overwrite buffer with background color
		}
		
		/**
		 * Automatically goes through and calls update on everything you added to the game loop,
		 * override this function to handle custom input and perform collisions/
		 */
		public function update():void
		{
			defaultGroup.update();
			hud.update();
		}
		
		/**
		 * This function collides <code>defaultGroup</code> against <code>defaultGroup</code>
		 * (basically everything you added to this state).
		 */
		public function collide():void
		{
			defaultGroup.collide();
		}
		
		/**
		 * Automatically goes through and calls render on everything you added to the game loop,
		 * override this loop to manually control the rendering process.
		 */
		public function render():void
		{
			defaultGroup.render();
			hud.render();
		}

		/**
		 * Override this function to do special pre-processing FX like light bloom.
		 * You can use scaling or blending modes or whatever you want against
		 * <code>FlxState.screen</code> to achieve all sorts of cool FX.
		 */
		public function postProcess():void
		{
			//no fx by default
		}
		
		/**
		 * Override this function to handle any deleting or "shutdown" type operations you
		 * might need (such as removing traditional Flash children like Sprite objects).
		 */
		public function destroy():void
		{
			defaultGroup.destroy();
		}
	}
}