package orangepeel.kinect.utils
{
	import com.as3nui.nativeExtensions.air.kinect.data.SkeletonBone;
	import com.as3nui.nativeExtensions.air.kinect.data.SkeletonJoint;
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import orangepeel.kinect.KinectWrapper;
	import orangepeel.kinect.geom.Point3D;
	import orangepeel.kinect.objects.KinectSkeleton;
	import orangepeel.kinect.objects.TrackedUser;
	
	import flash.geom.Matrix3D;
	import flash.geom.Orientation3D;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import sweatless.utils.GeometryUtils;

	public class KinectHelper
	{
		public function KinectHelper()
		{
			// Abstract.
		}
		
		public static function getTrackedUserByID(id:uint, trackedUsers:Vector.<TrackedUser>):TrackedUser
		{
			var tu:TrackedUser = null;
			for each(var eachTU:TrackedUser in trackedUsers)
			{
				if(id == eachTU.userID) tu = eachTU;	
			}
			return tu;
		}
		
		public static function getTrackedUserByTrackingID(trackingID:uint, trackedUsers:Vector.<TrackedUser>):TrackedUser
		{
			var tu:TrackedUser = null;
			for each(var eachTU:TrackedUser in trackedUsers)
			{
				if(trackingID == eachTU.trackingID) tu = eachTU;	
			}
			return tu;
		}
		
		public static function extractJointQuaternion(m:Matrix3D):Vector3D
		{
			var v3:Vector.<Vector3D> = new Vector.<Vector3D>(3);
			v3 = m.decompose(Orientation3D.QUATERNION);
			var ea:Vector3D = v3[1];
			return ea;
		}
		
		public static function getKinectJointPosition(kinectSkeletonJoint:SkeletonJoint):Vector3D
		{
			var p:Vector3D = kinectSkeletonJoint.position.world.clone();
			return p;
		}
		
		public static function getKinectJointWorldRelativePosition(kinectSkeletonJoint:SkeletonJoint):Vector3D
		{
			var p:Vector3D = kinectSkeletonJoint.position.worldRelative.clone();
			return p;
		}
		
		public static function getKinectJointRGBRelativePosition(kinectSkeletonJoint:SkeletonJoint):Point
		{
			var p:Point = kinectSkeletonJoint.position.rgbRelative.clone();
			return p;
		}
		
		public static function getKinectJointRGBPosition(kinectSkeletonJoint:SkeletonJoint):Point
		{
			var p:Point = kinectSkeletonJoint.position.rgb.clone();
			return p;
		}
		
		public static function getKinectJointDepthRelativePosition(kinectSkeletonJoint:SkeletonJoint):Point
		{
			var p:Point = kinectSkeletonJoint.position.depthRelative.clone();
			return p;
		}
		
		public static function getKinectJointDepthPosition(kinectSkeletonJoint:SkeletonJoint):Point
		{
			var p:Point = kinectSkeletonJoint.position.depth.clone();
			return p;
		}
		
		public static function getKinectBoneOrientation(kinectSkeletonBone:SkeletonBone):Vector3D
		{
			var m:Matrix3D = kinectSkeletonBone.orientation.absoluteOrientationMatrix;
			var p:Vector3D = extractJointQuaternion(m);
			return p;
		}
		
		public static function getUserWorldRelativePosition(user:User):Point3D
		{
			var p:Vector3D = user.position.worldRelative.clone();
			var cp:Point3D = new Point3D(p.x, p.y, p.z);
			return cp;
		}
		
		public static function defineColorByPoint(p:Point3D):uint
		{
			var color:uint = (p.z / (KinectWrapper.KinectMaxDepthInFlash * 4)) * 255 << 16 | (1 - (p.z / (KinectWrapper.KinectMaxDepthInFlash * 4))) * 255 << 8 | 0;
			return color;
		}
		
		public static function parseSkeleton(user:User, useRelative:Boolean = false):KinectSkeleton
		{
			var waist:Point3D = convertBoneAndRotation(user.leftHip, user.rightHip, useRelative);
			var rs:KinectSkeleton = new KinectSkeleton
			(
				user.trackingID,
				convertHead(user.head, user.neck, useRelative),
				convertJointType(user.torso, useRelative),
				convertJointType(user.leftShoulder, useRelative),
				convertJointType(user.rightShoulder, useRelative),
				convertJointType(user.leftElbow, useRelative),
				convertJointType(user.rightElbow, useRelative),
				convertJointType(user.leftHand, useRelative),
				convertJointType(user.rightHand, useRelative),
				convertJointType(user.leftHip, useRelative),
				convertJointType(user.rightHip, useRelative),
				convertJointType(user.leftKnee, useRelative),
				convertJointType(user.rightKnee, useRelative),
				convertJointType(user.leftFoot, useRelative),
				convertJointType(user.rightFoot, useRelative),
				convertBoneAndRotation(user.head, user.neck, useRelative),
				convertBoneAndRotation(user.torso, user.neck, useRelative),
				convertBoneAndRotation(user.leftHip, user.leftKnee, useRelative),
				convertBoneAndRotation(user.leftKnee, user.leftFoot, useRelative),
				convertBoneAndRotation(user.rightHip, user.rightKnee, useRelative),
				convertBoneAndRotation(user.rightKnee, user.rightFoot, useRelative),
				convertBoneAndRotation(user.leftShoulder, user.leftElbow, useRelative),
				convertBoneAndRotation(user.leftElbow, user.leftHand, useRelative),
				convertBoneAndRotation(user.rightShoulder, user.rightElbow, useRelative),
				convertBoneAndRotation(user.rightElbow, user.rightHand, useRelative),
				convertBoneAndRotation(user.leftShoulder, user.rightShoulder, useRelative),
				waist,
				convertBoneAndRotation(user.neck, user.torso, useRelative),
				convertLowerStomach(user.torso, waist, useRelative)
			)
			return rs;
		}
		
		public static function convertHead(head:SkeletonJoint, neck:SkeletonJoint, useRelative:Boolean = false):Point3D
		{
			var n:Point3D = convertJointType(neck, useRelative);
			var p:Point3D = convertJointType(head, useRelative);
			p.rotationX = GeometryUtils.getPitch(n.vector3D, p.vector3D);
			p.rotationY = GeometryUtils.getYaw(n.vector3D, p.vector3D);
			return p;
		}
		
		public static function convertLowerStomach(torso:SkeletonJoint, waist:Point3D, useRelative:Boolean = false):Point3D
		{
			var tp:Point3D = convertJointType(torso, useRelative);
			var vMidPoint:Vector3D = GeometryUtils.getMiddlePoint(tp.vector3D, waist.vector3D);
			
			var p:Point3D = new Point3D
			(
				vMidPoint.x,
				vMidPoint.y,
				vMidPoint.z,
				waist.confidence,
				GeometryUtils.getDistance(waist.vector3D, tp.vector3D),
				GeometryUtils.getPitch(waist.vector3D, tp.vector3D),	
				GeometryUtils.getYaw(waist.vector3D, tp.vector3D),
				0
			)
			return p;
		}
		
		public static function convertJointType(joint:SkeletonJoint, useRelative:Boolean = false):Point3D
		{
			var j:Vector3D = ((useRelative) ? getKinectJointWorldRelativePosition(joint) : getKinectJointPosition(joint));
			var p:Point3D = new Point3D(j.x, j.y, j.z, joint.positionConfidence);
			return p;
		}
		
		public static function convertBoneAndRotation(origin:SkeletonJoint, target:SkeletonJoint, useRelative:Boolean = false):Point3D
		{
			var oV:Vector3D = ((useRelative) ? getKinectJointWorldRelativePosition(origin) : getKinectJointPosition(origin));
			var tV:Vector3D = ((useRelative) ? getKinectJointWorldRelativePosition(target) : getKinectJointPosition(target));
			var vMidPoint:Vector3D = GeometryUtils.getMiddlePoint(oV, tV);
			
			var p:Point3D = new Point3D
			(
				vMidPoint.x,
				vMidPoint.y,
				vMidPoint.z,
				target.positionConfidence,
				GeometryUtils.getDistance(oV, tV),
				GeometryUtils.getPitch(oV, tV),
				GeometryUtils.getYaw(oV, tV),
				0
			);
			return p;
		}
		
		public static function constraintProcessor(value:Number, constraitValue:Number):Number
		{
			var v:Number = 0;
			if(value < 0) v = (value < -constraitValue) ? -constraitValue : value;
			else v = (value > constraitValue) ? constraitValue : value;
			return v;
		}
	}
}