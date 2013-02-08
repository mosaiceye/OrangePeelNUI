package orangepeel.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BaseSprite extends Sprite
	{
		protected var _explicitWidth:Number = 800;
		protected var _explicitHeight:Number = 600;
		
		/**
		 * Class setup.
		 */
		public function BaseSprite()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, destroy, false, 0, true);
		}
		
		/**
		 * Public methods.
		 */
		public function show():void
		{
			this.visible = true;
		}
		
		public function hide():void
		{
			this.visible = false;
		}
		
		public function setSize(explicitWidth:Number, explicitHeight:Number):void
		{
			this._explicitWidth = explicitWidth;
			this._explicitHeight = explicitHeight;
		}
		
		/** 
		 * Protected and Private methods.
		 */
		protected function layout():void
		{
			// Abstract.
		}
		
		protected function init(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			this.stage.nativeWindow.addEventListener(Event.RESIZE, resizeHandler, false, 0, true);
			this.setSize(this._explicitWidth, this._explicitHeight);
			this.layout();
		}
		
		protected function resizeHandler(event:Event):void
		{
			this.layout();
		}
		
		protected function destroy(event:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		/**
		 * Getters/Setters.
		 */
		override public function get width():Number
		{
			return this._explicitWidth;
		}
		
		override public function get height():Number
		{
			return this._explicitHeight;
		}
	}
}