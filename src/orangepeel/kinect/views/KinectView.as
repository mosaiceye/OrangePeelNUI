package orangepeel.kinect.views
{
	import orangepeel.display.BaseSprite;
	import orangepeel.kinect.objects.TrackedUser;

	public class KinectView extends BaseSprite
	{
		private var _trackedUsers:Vector.<TrackedUser>;
		private var _isRendering:Boolean = true;
		
		/**
		 * Class setup.
		 */
		public function KinectView()
		{
			super();
		}
		
		/**
		 * Public methods.
		 */
		public function render(trackedUsers:Vector.<TrackedUser>):void
		{
			if(this._isRendering) this._render(trackedUsers);
		}
		
		public function add(trackedUser:TrackedUser):void
		{
			this._isRendering = false;
			this._add(trackedUser);
			this._isRendering = true;
		}
		
		public function addSkeleton(trackedUser:TrackedUser):void
		{
			this._isRendering = false;
			this._addSkeleton(trackedUser);
			this._isRendering = true;
		}
		
		public function remove(trackedUser:TrackedUser):void
		{
			this._isRendering = false;
			this._remove(trackedUser);
			this._isRendering = true;
		}
		
		/**
		 * Protected and Private methods.
		 */
		protected function _render(trackedUsers:Vector.<TrackedUser>):void
		{
			// Abstract method to subclass.
		}
		
		protected function _add(trackedUser:TrackedUser):void
		{
			// Abstract method to subclass.
		}
		
		protected function _addSkeleton(trackedUser:TrackedUser):void
		{
			// Abstract method to subclass.
		}
		
		protected function _remove(trackedUser:TrackedUser):void
		{
			// Abstract method to subclass.
		}
		
		/**
		 * Getters/Setters.
		 */
		public function set isRendering(value:Boolean):void
		{
			this._isRendering = value;
		}
		
		public function get isRendering():Boolean
		{
			return this._isRendering;
		}
		
		public function get trackedUsers():Vector.<TrackedUser>
		{
			return this._trackedUsers;
		}
	}
}