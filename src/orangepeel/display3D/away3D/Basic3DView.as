package orangepeel.display3D.away3D
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	
	import orangepeel.display.BaseSprite;
	
	import flash.events.*;
	
	public class Basic3DView extends BaseSprite
	{
		protected var _view:View3D;
		protected var _scene:Scene3D;
		protected var _camera:Camera3D;
		protected var _cameraController:HoverController;
		
		private var _move:Boolean = false;
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _lastMouseX:Number;
		private var _lastMouseY:Number;
		
		private var _mouseControl:Boolean = true;
		
		public function Basic3DView(mouseControl:Boolean = true)
		{
			super();
			this._mouseControl = mouseControl;
		}
		
		override protected function init(event:Event):void
		{
			super.init(event);
			this.initEngine();
			this.initMaterials();
			this.initParticles();
			this.initObjects();
			this.initListeners();
			this.layout();
		}
		
		override protected function layout():void
		{
			super.layout();
			if(this.stage && this._view)
			{
				this.setSize(this.stage.stageWidth, this.stage.stageHeight);
				this._view.width = this.width;
				this._view.height = this.height;
			}
		}
		
		override protected function destroy(event:Event):void
		{
			super.destroy(event);
			this.removeChild(this._view);
			this.removeEventListener(Event.ENTER_FRAME, this.renderView);
			this.stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			this.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		protected function renderView(event:Event):void
		{
			if(this._move && this.stage) 
			{
				this._cameraController.panAngle = 0.3*(stage.mouseX - this._lastMouseX) + this._lastPanAngle;
				this._cameraController.tiltAngle = 0.3*(stage.mouseY - this._lastMouseY) + this._lastTiltAngle;
			}
			this._view.render();
		}
		
		protected function initEngine():void
		{
			this._scene = new Scene3D();
			this._camera = new Camera3D();
			
			this._view = new View3D();
			this._view.antiAlias = 4;
			this._view.scene = this._scene;
			this._view.camera = this._camera;
			this._view.backgroundColor = 0xE3E3E3;
			if(this._mouseControl) this._cameraController = new HoverController(this._camera, null, 180, 0, 100);
			this.addChild(this._view);
		}
		
		protected function initMaterials():void
		{
			// Abstract.
		}
		
		protected function initParticles():void
		{
			// Abstract.
		}
		
		protected function initObjects():void
		{
			// Abstract.
		}
		
		protected function initListeners():void
		{
			this.addEventListener(Event.ENTER_FRAME, this.renderView);
			if(this.stage && this._mouseControl)
			{
				this.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				this.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);	
			}
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			if(this.stage)
			{
				this._lastPanAngle = this._cameraController.panAngle;
				this._lastTiltAngle = this._cameraController.tiltAngle;
				this._lastMouseX = this.stage.mouseX;
				this._lastMouseY = this.stage.mouseY;
				this._move = true;
				this.stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);	
			}
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			this._move = false;
			if(this.stage) this.stage.removeEventListener(Event.MOUSE_LEAVE, this.onStageMouseLeave);
		}
		
		private function onStageMouseLeave(event:Event):void
		{
			this._move = false;
			if(this.stage) this.stage.removeEventListener(Event.MOUSE_LEAVE, this.onStageMouseLeave);
		}
		
		public function get view3D():View3D
		{
			return this._view;
		}
	}
}