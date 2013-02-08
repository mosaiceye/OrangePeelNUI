package orangepeel.display3D.flare3D
{
	import com.as3nui.nativeExtensions.air.kinect.data.*;
	
	import flare.basic.Scene3D;
	import flare.core.Mesh3D;
	import flare.core.Pivot3D;
	import flare.loaders.ColladaLoader;
	import flare.modifiers.SkinModifier;
	
	import flash.utils.Dictionary;
	
	public class AvatarRigged extends ColladaLoader
	{
		protected var mesh:Mesh3D;
		protected var skin:SkinModifier;
		protected var jointMap:Dictionary;
		
		public function AvatarRigged(request:*, parent:Pivot3D=null, sceneContext:Scene3D=null, texturesFolder:String=null, flipNormals:Boolean=false, cullFace:String="back")
		{
			super(request, parent, sceneContext, texturesFolder, flipNormals, cullFace);
		}
		
		public function init():void
		{
			// Abstract.
		}
		
		protected function getJoint(id:String):Pivot3D
		{
			var p:Pivot3D = (this.skin) ? skin.root.getChildByName(id) : null;
			if(p) p.frames = null;
			return p
		}
		
		protected function setupJointMap():void
		{
			this.jointMap = new Dictionary();
			
			this.jointMap[SkeletonJoint.HEAD] = this.head;
			this.jointMap[SkeletonJoint.NECK] = this.neck;
			this.jointMap[SkeletonJoint.TORSO] = this.torso;
			this.jointMap[SkeletonBone.SPINE] = this.spine;
			
			this.jointMap[SkeletonJoint.RIGHT_SHOULDER] = this.rightArm;
			this.jointMap[SkeletonJoint.RIGHT_ELBOW] = this.rightElbow;
			this.jointMap[SkeletonJoint.RIGHT_HAND] = this.rightHand;
			
			this.jointMap[SkeletonJoint.LEFT_SHOULDER] = this.leftArm;
			this.jointMap[SkeletonJoint.LEFT_ELBOW] = this.leftElbow;
			this.jointMap[SkeletonJoint.LEFT_HAND] = this.leftHand;
			
			this.jointMap[SkeletonJoint.RIGHT_HIP] = this.rightHip;
			this.jointMap[SkeletonJoint.RIGHT_KNEE] = this.rightKnee;
			this.jointMap[SkeletonJoint.RIGHT_FOOT] = this.rightFoot;
			
			this.jointMap[SkeletonJoint.LEFT_HIP] = this.leftHip;
			this.jointMap[SkeletonJoint.LEFT_KNEE] = this.leftKnee;
			this.jointMap[SkeletonJoint.LEFT_FOOT] = this.leftFoot;
		}
		
		public function get map():Dictionary
		{
			return this.jointMap;	
		}
		
		public function get head():Pivot3D
		{
			return null;
		}
		
		public function get neck():Pivot3D
		{
			return null;
		}
		
		public function get torso():Pivot3D
		{
			return null;
		}
		
		public function get spine():Pivot3D
		{
			return null;
		}
		
		public function get hips():Pivot3D
		{
			return null;
		}
		
		public function get leftArm():Pivot3D
		{
			return null;
		}
		
		public function get rightArm():Pivot3D
		{
			return null;
		}
		
		public function get leftShoulder():Pivot3D
		{
			return null;
		}
		
		public function get rightShoulder():Pivot3D
		{
			return null;
		}
		
		public function get leftElbow():Pivot3D
		{
			return null;
		}
		
		public function get rightElbow():Pivot3D
		{
			return null;
		}
		
		public function get leftHand():Pivot3D
		{
			return null;
		}
		
		public function get rightHand():Pivot3D
		{
			return null;
		}
		
		public function get leftHip():Pivot3D
		{
			return null;
		}
		
		public function get rightHip():Pivot3D
		{
			return null;
		}
		
		public function get leftKnee():Pivot3D
		{
			return null;
		}
		
		public function get rightKnee():Pivot3D
		{
			return null;
		}
		
		public function get leftFoot():Pivot3D
		{
			return null;
		}
		
		public function get rightFoot():Pivot3D
		{
			return null;
		}
	}
}