package orangepeel.kinect.objects
{
	import com.as3nui.nativeExtensions.air.kinect.data.*;
	import orangepeel.kinect.data.SkeletonBoneExtended;
	import orangepeel.kinect.geom.Point3D;

	public class KinectSkeleton extends Object
	{
		private var _id:uint;
		private var _joints:Vector.<Join>;
		private var _bones:Vector.<Join>;
		
		// Joints.
		private var _head:Point3D;
		private var _neck:Point3D;
		private var _torso:Point3D;
		
		private var _leftShoulder:Point3D;
		private var _rightShoulder:Point3D;
		
		private var _leftHip:Point3D;
		private var _rightHip:Point3D;
		
		private var _leftKnee:Point3D;
		private var _rightKnee:Point3D;
		
		private var _leftFoot:Point3D;
		private var _rightFoot:Point3D;
		
		private var _leftElbow:Point3D;
		private var _rightElbow:Point3D;
		
		private var _leftHand:Point3D;
		private var _rightHand:Point3D;
		
		// Bones.
		private var _spine:Point3D;
		
		private var _leftUpperArm:Point3D;
		private var _leftLowerArm:Point3D;
		
		private var _leftUpperLeg:Point3D;
		private var _leftLowerLeg:Point3D;
		
		private var _rightUpperArm:Point3D;
		private var _rightLowerArm:Point3D;
		
		private var _rightUpperLeg:Point3D;
		private var _rightLowerLeg:Point3D;
		
		private var _shoulderBlade:Point3D;
		private var _waist:Point3D;
		private var _upperStomach:Point3D;
		private var _lowerStomach:Point3D;
		
		/**
		 * Class setup.
		 */
		public function KinectSkeleton(pID:uint, pHead:Point3D, pTorso:Point3D, 
									   pLeftShoulder:Point3D, pRightShoulder:Point3D, pLeftElbow:Point3D, 
									   pRightElbow:Point3D, pLeftHand:Point3D, pRightHand:Point3D,
									   pLeftHip:Point3D, pRightHip:Point3D, pLeftKnee:Point3D, pRightKnee:Point3D, 
									   pLeftFoot:Point3D, pRightFoot:Point3D, pNeck:Point3D,
									   pSpine:Point3D, pLeftUpperLeg:Point3D, pLeftLowerLeg:Point3D, 
									   pRightUpperLeg:Point3D, pRightLowerLeg:Point3D,
									   pLeftUpperArm:Point3D, pLeftLowerArm:Point3D, 
									   pRightUpperArm:Point3D, pRightLowerArm:Point3D,
									   pShoulderBlade:Point3D, pWaist:Point3D, 
									   pUpperStomach:Point3D, pLowerStomach:Point3D)
		{
			// Define.
			this._id = pID;
			this._joints = new Vector.<Join>;
			this._bones = new Vector.<Join>;
			
			// Joints.
			this._head = pHead;
			this._neck = pNeck;
			this._torso = pTorso;
			
			this._leftShoulder = pLeftShoulder;
			this._rightShoulder = pRightShoulder;
			
			this._leftElbow = pLeftElbow;
			this._rightElbow = pRightElbow;
			
			this._leftHand = pLeftHand;
			this._rightHand = pRightHand;
			
			this._leftHip = pLeftHip;
			this._rightHip = pRightHip;
			
			this._leftKnee = pLeftKnee;
			this._rightKnee = pRightKnee;
			
			this._leftFoot = pLeftFoot;
			this._rightFoot = pRightFoot;
			
			// Bones.
			this._spine = pSpine;
			
			this._leftUpperLeg = pLeftUpperLeg;
			this._leftLowerLeg = pLeftLowerLeg;
			
			this._rightUpperLeg = pRightUpperLeg;
			this._rightLowerLeg = pRightLowerLeg;
			
			this._leftUpperArm = pLeftUpperArm;
			this._leftLowerArm = pLeftLowerArm;
			
			this._rightUpperArm = pRightUpperArm;
			this._rightLowerArm = pRightLowerArm;
			
			this._shoulderBlade = pShoulderBlade;
			this._waist = pWaist;
			this._upperStomach = pUpperStomach;
			this._lowerStomach = pLowerStomach;
			
			// Collect all joints.
			this._joints.push(this.head, this.torso, this.leftShoulder, this.rightShoulder,
							this.leftElbow, this.rightElbow, this.leftHand, this.rightHand, this.leftHip,
							this.rightHip, this.leftKnee, this.rightKnee, this.leftFoot, this.rightFoot);
			
			// Collect all bones.
			this._bones.push(this.spine, this.neck, this.leftUpperLeg, this.leftLowerLeg, 
							this.rightUpperLeg, this.rightLowerLeg,this.leftUpperArm, this.leftLowerArm, 
							this.rightUpperArm, this.rightLowerArm, this.shoulderBlade, this.waist,
							this.upperStomach, this.lowerStomach);
		}
		
		/**
		 * Getters/Setters.
		 */
		public function get id():uint
		{
			return this._id;
		}
		
		public function get joints():Vector.<Join>
		{
			return this._joints;
		}
		
		public function get bones():Vector.<Join>
		{
			return this._bones;
		}
		
		public function get head():Join
		{
			return new Join(SkeletonJoint.HEAD, this._head);
		}
		
		public function get torso():Join
		{
			return new Join(SkeletonJoint.TORSO, this._torso);
		}
		
		public function get leftShoulder():Join
		{
			return new Join(SkeletonJoint.LEFT_SHOULDER, this._leftShoulder);
		}
		
		public function get rightShoulder():Join
		{
			return new Join(SkeletonJoint.RIGHT_SHOULDER, this._rightShoulder);
		}
		
		public function get leftElbow():Join
		{
			return new Join(SkeletonJoint.LEFT_ELBOW, this._leftElbow);
		}
		
		public function get rightElbow():Join
		{
			return new Join(SkeletonJoint.RIGHT_ELBOW, this._rightElbow);
		}
		
		public function get leftHand():Join
		{
			return new Join(SkeletonJoint.LEFT_HAND, this._leftHand);
		}
		
		public function get rightHand():Join
		{
			return new Join(SkeletonJoint.RIGHT_HAND, this._rightHand);
		}
		
		public function get leftHip():Join
		{
			return new Join(SkeletonJoint.LEFT_HIP, this._leftHip);
		}
		
		public function get rightHip():Join
		{
			return new Join(SkeletonJoint.RIGHT_HIP, this._rightHip);
		}
		
		public function get leftKnee():Join
		{
			return new Join(SkeletonJoint.LEFT_KNEE, this._leftKnee);
		}
		
		public function get rightKnee():Join
		{
			return new Join(SkeletonJoint.RIGHT_KNEE, this._rightKnee);
		}
		
		public function get leftFoot():Join
		{
			return new Join(SkeletonJoint.LEFT_FOOT, this._leftFoot);
		}
		
		public function get rightFoot():Join
		{
			return new Join(SkeletonJoint.RIGHT_FOOT, this._rightFoot);
		}
		
		public function get neck():Join
		{
			return new Join(SkeletonJoint.NECK, this._neck, SkeletonJoint.HEAD, SkeletonJoint.NECK);
		}
		
		public function get spine():Join
		{
			return new Join(SkeletonBone.SPINE, this._spine, SkeletonJoint.TORSO, SkeletonJoint.NECK);
		}
		
		public function get leftUpperLeg():Join
		{
			return new Join(SkeletonBone.LEFT_UPPER_LEG, this._leftUpperLeg, SkeletonJoint.LEFT_HIP, SkeletonJoint.LEFT_KNEE);
		}
		
		public function get leftLowerLeg():Join
		{
			return new Join(SkeletonBone.LEFT_LOWER_LEG, this._leftLowerLeg, SkeletonJoint.LEFT_KNEE, SkeletonJoint.LEFT_FOOT);
		}
		
		public function get rightUpperLeg():Join
		{
			return new Join(SkeletonBone.RIGHT_UPPER_LEG, this._rightUpperLeg, SkeletonJoint.RIGHT_HIP, SkeletonJoint.RIGHT_KNEE);
		}
		
		public function get rightLowerLeg():Join
		{
			return new Join(SkeletonBone.RIGHT_LOWER_LEG, this._rightLowerLeg, SkeletonJoint.RIGHT_KNEE, SkeletonJoint.RIGHT_FOOT);
		}
		
		public function get leftUpperArm():Join
		{
			return new Join(SkeletonBone.LEFT_UPPER_ARM, this._leftUpperArm, SkeletonJoint.LEFT_SHOULDER, SkeletonJoint.LEFT_ELBOW);
		}
		
		public function get leftLowerArm():Join
		{
			return new Join(SkeletonBone.LEFT_LOWER_ARM, this._leftLowerArm, SkeletonJoint.LEFT_ELBOW, SkeletonJoint.LEFT_HAND);
		}
		
		public function get rightUpperArm():Join
		{
			return new Join(SkeletonBone.RIGHT_UPPER_ARM, this._rightUpperArm, SkeletonJoint.RIGHT_SHOULDER, SkeletonJoint.RIGHT_ELBOW);
		}
		
		public function get rightLowerArm():Join
		{
			return new Join(SkeletonBone.RIGHT_LOWER_ARM, this._rightLowerArm, SkeletonJoint.RIGHT_ELBOW, SkeletonJoint.RIGHT_HAND);
		}
		
		public function get shoulderBlade():Join
		{
			return new Join(SkeletonBoneExtended.SHOULDER_BLADE, this._shoulderBlade, SkeletonJoint.LEFT_SHOULDER, SkeletonJoint.RIGHT_SHOULDER);
		}
		
		public function get waist():Join
		{
			return new Join(SkeletonBoneExtended.WAIST, this._waist, SkeletonJoint.LEFT_HIP, SkeletonJoint.RIGHT_HIP);
		}
		
		public function get upperStomach():Join
		{
			return new Join(SkeletonBoneExtended.UPPER_STOMACH, this._upperStomach, SkeletonJoint.NECK, SkeletonJoint.TORSO);
		}
		
		public function get lowerStomach():Join
		{
			return new Join(SkeletonBoneExtended.LOWER_STOMACH, this._lowerStomach, SkeletonJoint.TORSO, SkeletonBoneExtended.WAIST);
		}
	}
}