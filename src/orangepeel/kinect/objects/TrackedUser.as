package orangepeel.kinect.objects
{
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import orangepeel.kinect.geom.Point3D;
	import orangepeel.kinect.objects.KinectSkeleton;
	import orangepeel.kinect.utils.KinectHelper;
	
	import flash.display.Bitmap;
	import flash.geom.Vector3D;

	public class TrackedUser extends Object
	{
		private var _position:Point3D;
		private var _kinectUser:User;
		private var _offScreen:Boolean = false;
		private var _worldRelativeSkeleton:KinectSkeleton;
		private var _worldSkeleton:KinectSkeleton;
		private var _isClosestToCamera:Boolean = false;
		private var _userMask:Bitmap;
		
		/**
		 * Class setup.
		 */
		public function TrackedUser(user:User)
		{
			this._kinectUser = user;
			this._position = new Point3D();
			this._userMask = new Bitmap();
			this.update();
			super();
		}
		
		/**
		 * Public methods.
		 */
		public function update():void
		{
			this._position = KinectHelper.getUserWorldRelativePosition(this._kinectUser);
			this._offScreen = ((this._position.x + this._position.y + this._position.z) == 0) ? true : false;
			this._worldRelativeSkeleton = KinectHelper.parseSkeleton(this._kinectUser, true);
			this._worldSkeleton = KinectHelper.parseSkeleton(this._kinectUser);
		}
		
		/**
		 * Getters/Setters.
		 */
		public function get offScreen():Boolean
		{
			return this._offScreen;
		}
		
		public function get hasSkeleton():Boolean
		{
			return this._kinectUser.hasSkeleton;
		}
		
		public function get position():Point3D
		{
			return this._position;	
		}
		
		public function get positionWorld():Vector3D
		{
			return this._kinectUser.position.world;	
		}
		
		public function get userID():uint
		{
			return this._kinectUser.userID;
		}
		
		public function get trackingID():uint
		{
			return this._kinectUser.trackingID;
		}
		
		public function get kinectUser():User
		{
			return this._kinectUser;
		}
		
		public function get worldRelativeSkeleton():KinectSkeleton
		{
			return this._worldRelativeSkeleton;
		}
		
		public function get worldSkeleton():KinectSkeleton
		{
			return this._worldSkeleton;
		}
		
		public function get x():Number
		{
			return this._position.x;
		}
		
		public function get y():Number
		{
			return this._position.y;
		}
		
		public function get z():Number
		{
			return this._position.z;
		}
		
		public function get closestToCamera():Boolean
		{
			return this._isClosestToCamera;
		}
		
		public function set closestToCamera(value:Boolean):void
		{
			this._isClosestToCamera = true;
		}
		
		public function get userMask():Bitmap
		{
			return this._userMask;
		}
		
		public function set userMask(value:Bitmap):void
		{
			this._userMask = value;
		}
	}
}