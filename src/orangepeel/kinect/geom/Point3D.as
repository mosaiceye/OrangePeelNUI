package orangepeel.kinect.geom
{
	import flash.geom.Vector3D;
	
	import sweatless.geom.Point3D;
	
	public class Point3D extends sweatless.geom.Point3D
	{
		private var _confidence:Number = 0.0;
		private var _depth:Number = 0.0;
		private var _maxRotation:Vector3D;
		
		public function Point3D(p_x:Number=0.0, p_y:Number=0.0, p_z:Number=0.0, 
								p_confidence:Number=0.0, p_depth:Number = 0.0,
								p_rotx:Number=0.0, p_roty:Number = 0.0, p_rotz:Number = 0.0,
								p_max_rot:Vector3D = null, p_matrix3x3:String = null)
		{
			super(p_x, p_y, p_z, p_matrix3x3);
			this._confidence = p_confidence;
			this._depth = p_depth;
			this.rotationX = p_rotx;
			this.rotationY = p_roty;
			this.rotationZ = p_rotz;
			this._maxRotation = p_max_rot;
		}
		
		public function get confidence():Number
		{
			return this._confidence;
		}
		
		public function set confidence(p_confidence:Number):void
		{
			this._confidence = p_confidence;
		}
		
		public function get depth():Number
		{
			return this._depth;
		}
		
		public function set depth(p_depth:Number):void
		{
			this._depth = p_depth;
		}
		
		public function get maxRotation():Vector3D
		{
			return this._maxRotation;
		}
		
		public function set maxRotation(p_max_rot:Vector3D):void
		{
			this._maxRotation = p_max_rot;
		}
	}
}