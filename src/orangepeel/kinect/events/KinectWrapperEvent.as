package orangepeel.kinect.events
{
	import orangepeel.kinect.objects.TrackedUser;
	
	import flash.events.Event;
	
	public class KinectWrapperEvent extends Event
	{
		public static const RENDERING:String = "rendering";
		public static const STARTED:String = "started";
		public static const STOPPED:String = "stopped";
		
		public var trackedUsers:Vector.<TrackedUser>;
		
		public function KinectWrapperEvent(type:String, trackedUsers:Vector.<TrackedUser> = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.trackedUsers = trackedUsers;
		}
	}
}