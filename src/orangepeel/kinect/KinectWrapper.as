package orangepeel.kinect
{
	import com.as3nui.nativeExtensions.air.kinect.Kinect;
	import com.as3nui.nativeExtensions.air.kinect.KinectSettings;
	import com.as3nui.nativeExtensions.air.kinect.constants.CameraResolution;
	import com.as3nui.nativeExtensions.air.kinect.data.DeviceCapabilities;
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.as3nui.nativeExtensions.air.kinect.events.CameraImageEvent;
	import com.as3nui.nativeExtensions.air.kinect.events.DeviceErrorEvent;
	import com.as3nui.nativeExtensions.air.kinect.events.DeviceEvent;
	import com.as3nui.nativeExtensions.air.kinect.events.DeviceInfoEvent;
	import com.as3nui.nativeExtensions.air.kinect.events.UserEvent;
	import orangepeel.display.BaseSprite;
	import orangepeel.kinect.events.KinectTrackedUserEvent;
	import orangepeel.kinect.events.KinectWrapperEvent;
	import orangepeel.kinect.objects.TrackedUser;
	import orangepeel.kinect.utils.KinectHelper;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.utils.describeType;

	public class KinectWrapper extends BaseSprite
	{
		public static const KinectMaxDepthInFlash:uint = 200;
		
		public var depthSupport:Boolean = true;
		public var rgbSupport:Boolean = true;
		public var userMaskSupport:Boolean = true;
		public var bodyTrackingSupport:Boolean = true;
		
		public var rgbMirrored:Boolean = true;
		public var depthMirrored:Boolean = true;
		public var skeletonsMirrored:Boolean = true;
		public var userMaskMirrored:Boolean = true;
		public var debug:Boolean = false;
		
		public var rgbResolution:Point = CameraResolution.RESOLUTION_320_240;
		public var depthResolution:Point = CameraResolution.RESOLUTION_320_240;
		public var userMaskResolution:Point = CameraResolution.RESOLUTION_320_240;
		
		private var _trackedUsers:Vector.<TrackedUser>;
		private var _kinect:Kinect;
		private var _kinectSettings:KinectSettings;
		private var _kinectDeviceCapabilities:DeviceCapabilities;
		
		private var _debugImageWidth:Number = 320;
		private var _debugImageHeight:Number = 240;
		private var _debugDepthBitmap:Bitmap;
		private var _rgbDebugBitmap:Bitmap;
		
		/**
		 * Class setup.
		 */
		public function KinectWrapper(debug:Boolean = false)
		{
			this.debug = debug;
			this._trackedUsers = new Vector.<TrackedUser>;
		}
		
		/**
		 * Start the kinect up.
		 */
		public function start():void
		{
			if(Kinect.isSupported()) 
			{
				if(this.depthSupport && this.debug) this.setupDebugDepthCamera();
				if(this.rgbSupport && this.debug) this.setupDebugRGBCamera();
				this.initKinectDevice();
				this.addKinectListeners();
				this.layout();
			}
		}
		
		/**
		 * Protected and Private methods.
		 */
		protected function defineKinectDeviceCapabilities():void
		{
			this._kinectDeviceCapabilities = this._kinect.capabilities;
			var capability:String;
			for each(var capabilityXML:XML in describeType(this._kinectDeviceCapabilities)..accessor) 
			{
				capability = capabilityXML.@name.toString();
				var value:String = this._kinectDeviceCapabilities[capability].toString();
				if(this.debug) trace("[Kinect] INFO: " + capability + " :: " + value);
			}
		}
		
		protected function initKinectDevice():void
		{
			// Init Kinect device.
			this._kinect = Kinect.getDevice();
			this.defineKinectDeviceCapabilities();
			
			// Kinect device settings.
			this._kinectSettings = new KinectSettings();
			if(this.rgbSupport && this._kinectDeviceCapabilities.hasRGBCameraSupport)
			{
				this._kinectSettings.rgbResolution = this.rgbResolution;
				this._kinectSettings.rgbEnabled = this.rgbSupport;
				this._kinectSettings.rgbMirrored = this.rgbMirrored;
			}
			
			if(this.depthSupport && this._kinectDeviceCapabilities.hasRGBCameraSupport)
			{
				this._kinectSettings.depthResolution = this.depthResolution;
				this._kinectSettings.depthEnabled = this.depthSupport;
				this._kinectSettings.depthShowUserColors = true;
				this._kinectSettings.depthMirrored = this.depthMirrored;
			}
			
			if(this.bodyTrackingSupport && this._kinectDeviceCapabilities.hasSkeletonSupport)
			{
				this._kinectSettings.skeletonMirrored = this.skeletonsMirrored;
				this._kinectSettings.skeletonEnabled = this.bodyTrackingSupport;
			}
			
			if(this.userMaskSupport && this._kinectDeviceCapabilities.hasUserMaskSupport)
			{
				this._kinectSettings.userMaskEnabled = this.userMaskSupport;
				this._kinectSettings.userMaskMirrored = this.userMaskMirrored;
				this._kinectSettings.userMaskResolution = this.userMaskResolution;
			}
			
			// Start the kinect.
			this._kinect.start(this._kinectSettings);
		}
		
		protected function addKinectListeners():void
		{
			this._kinect.addEventListener(DeviceEvent.STARTED, this.kinectStarted, false, 0, true);
			this._kinect.addEventListener(DeviceEvent.STOPPED, this.kinectStopped, false, 0, true);
			this._kinect.addEventListener(DeviceInfoEvent.INFO, this.onDeviceInfo, false, 0, true);
			this._kinect.addEventListener(DeviceErrorEvent.ERROR, this.onDeviceError, false, 0, true);
			
			if(this.rgbSupport) this._kinect.addEventListener(CameraImageEvent.RGB_IMAGE_UPDATE, this.rgbImageUpdate);
			if(this.depthSupport) this._kinect.addEventListener(CameraImageEvent.DEPTH_IMAGE_UPDATE, this.depthImageUpdate);
			
			if(this.bodyTrackingSupport)
			{
				this._kinect.addEventListener(UserEvent.USERS_UPDATED, this.usersUpdatedHandler);
				this._kinect.addEventListener(UserEvent.USERS_ADDED, this.usersAddedHandler);
				this._kinect.addEventListener(UserEvent.USERS_REMOVED, this.usersRemovedHandler);
				this._kinect.addEventListener(UserEvent.USERS_WITH_SKELETON_ADDED, this.usersSkeletonAddedHandler);
				this._kinect.addEventListener(UserEvent.USERS_WITH_SKELETON_REMOVED, this.usersRemovedHandler);
			}
			
			if(this.userMaskSupport)
			{
				this._kinect.addEventListener(UserEvent.USERS_MASK_IMAGE_UPDATE, this.userMaskImageUpdate);
			}
		}
		
		protected function setupDebugDepthCamera():void
		{
			this._debugDepthBitmap = new Bitmap();
			this.addChild(this._debugDepthBitmap);
		}
		
		protected function setupDebugRGBCamera():void
		{
			this._rgbDebugBitmap = new Bitmap();
			this.addChild(this._rgbDebugBitmap);
		}
		
		override protected function layout():void
		{
			if(this._debugDepthBitmap) this._debugDepthBitmap.y = (stage.nativeWindow.height - this._debugImageHeight);
			if(this._rgbDebugBitmap)
			{
				this._rgbDebugBitmap.x = (stage.nativeWindow.width - this._debugImageWidth);
				this._rgbDebugBitmap.y = (stage.nativeWindow.height - this._debugImageHeight);
			}
		}
		
		protected function removeTrackedUser(user:User):void
		{
			for each(var tu:TrackedUser in this._trackedUsers)
			{
				if(tu.kinectUser == user)
				{
					this._trackedUsers.splice(this._trackedUsers.indexOf(tu), 1);
					this.dispatchEvent(new KinectTrackedUserEvent(KinectTrackedUserEvent.TRACKED_USER_REMOVED, tu));
					if(this.debug) trace('[Kinect] tracked user removed: ' + this._trackedUsers);
				}
			}
		}
		
		/**
		 * Events methods.
		 */
		protected function usersSkeletonAddedHandler(event:UserEvent):void
		{
			for each(var tu:TrackedUser in this._trackedUsers)
			{
				tu.update();
				this.dispatchEvent(new KinectTrackedUserEvent(KinectTrackedUserEvent.TRACKED_USER_SKELETON_ADDED, tu));
				if(this.debug) trace('[Kinect] tracked user skeleton added: ' + this._trackedUsers);
			}
		}
		
		protected function usersAddedHandler(event:UserEvent):void
		{
			for each(var addedUser:User in event.users)
			{
				var tu:TrackedUser = new TrackedUser(addedUser);
				this._trackedUsers.push(tu);
				this.dispatchEvent(new KinectTrackedUserEvent(KinectTrackedUserEvent.TRACKED_USER_ADDED, tu));
				if(this.debug) trace('[Kinect] tracked user added: ' + this._trackedUsers);
			}
		}
		
		protected function usersUpdatedHandler(event:UserEvent):void
		{
			var closestUser:TrackedUser;
			for each(var tu:TrackedUser in this._trackedUsers) 
			{
				closestUser ||= tu;
				tu.closestToCamera = (tu.positionWorld.z < closestUser.positionWorld.z) ? true : false; 
				
				if(tu.offScreen) this.removeTrackedUser(tu.kinectUser);
				else tu.update();
			}
			
			this.dispatchEvent(new KinectWrapperEvent(KinectWrapperEvent.RENDERING, this._trackedUsers));
		}
		
		protected function usersRemovedHandler(event:UserEvent):void
		{
			for each(var u:User in event.users) this.removeTrackedUser(u);
		}
		
		protected function kinectStarted(event:DeviceEvent):void 
		{
			this.dispatchEvent(new KinectWrapperEvent(KinectWrapperEvent.STARTED));
			if(this.debug) trace("[Kinect] device started.");
		}
		
		protected function kinectStopped(event:DeviceEvent):void 
		{
			this.dispatchEvent(new KinectWrapperEvent(KinectWrapperEvent.STOPPED));
			if(this.debug) trace("[Kinect] device stopped.");
			
			if(this._kinect != null) 
			{
				this._kinect.removeEventListener(CameraImageEvent.RGB_IMAGE_UPDATE, rgbImageUpdate);
				this._kinect.removeEventListener(CameraImageEvent.DEPTH_IMAGE_UPDATE, depthImageUpdate);
				this._kinect.removeEventListener(DeviceEvent.STARTED, kinectStarted);
				this._kinect.removeEventListener(DeviceInfoEvent.INFO, onDeviceInfo);
				this._kinect.removeEventListener(DeviceErrorEvent.ERROR, onDeviceError);
				this._kinect.stop();
				this._kinect.removeEventListener(DeviceEvent.STOPPED, kinectStopped);
			}
		}
		
		protected function onDeviceInfo(event:DeviceInfoEvent):void 
		{
			if(this.debug) trace("[Kinect] INFO: " + event.message + '.');
		}
		
		protected function onDeviceError(event:DeviceErrorEvent):void 
		{
			if(this.debug) trace("[Kinect] ERROR: " + event.message + '.');
		}
		
		protected function depthImageUpdate(event:CameraImageEvent):void 
		{
			if(this.debug) 
			{
				this._debugDepthBitmap.bitmapData = event.imageData;
				this._debugDepthBitmap.width = this._debugImageWidth;
				this._debugDepthBitmap.height = this._debugImageHeight;
			}
		}
		
		protected function rgbImageUpdate(event:CameraImageEvent):void 
		{
			if(this.debug) 
			{
				this._rgbDebugBitmap.bitmapData = event.imageData;
				this._rgbDebugBitmap.width = this._debugImageWidth;
				this._rgbDebugBitmap.height = this._debugImageHeight;
			}
		}
		
		protected function userMaskImageUpdate(event:UserEvent):void 
		{
			for each(var user:User in event.users) 
			{
				if(user && user.userMaskData)
				{
					var tu:TrackedUser = KinectHelper.getTrackedUserByTrackingID(user.trackingID, this.trackedUsers);
					if(tu && tu.userMask) tu.userMask.bitmapData = user.userMaskData;
				}
			}
		}
		
		/**
		 * Getters/Setters.
		 */
		public function get device():Kinect
		{
			return this._kinect;
		}
		
		public function get trackedUsers():Vector.<TrackedUser>
		{
			return this._trackedUsers;
		}
	}
}