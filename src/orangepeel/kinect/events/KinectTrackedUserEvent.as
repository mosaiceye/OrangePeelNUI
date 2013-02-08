package orangepeel.kinect.events
{
	import orangepeel.kinect.objects.TrackedUser;
	
	import flash.events.Event;
	
	public class KinectTrackedUserEvent extends Event
	{
		public static const TRACKED_USER_ADDED:String = "trackedUserAdded";
		public static const TRACKED_USER_REMOVED:String = "trackedUserRemoved";
		public static const TRACKED_USER_SKELETON_ADDED:String = "trackedUserSkeletonAdded";
		
		public var trackedUser:TrackedUser;
		
		public function KinectTrackedUserEvent(type:String, trackedUser:TrackedUser, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.trackedUser = trackedUser;
		}
	}
}