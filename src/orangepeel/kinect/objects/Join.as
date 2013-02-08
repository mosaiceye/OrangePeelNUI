package orangepeel.kinect.objects 
{
	import orangepeel.kinect.geom.Point3D;

	/**
	 * 
	 * @internal
	 * The <code>Join</code> class is like a bone with 3D coordinates points.
	 * 
	 */
	public class Join extends Point3D
	{
		private var _name:String;
		private var _startJointName:String;
		private var _endJointName:String;
		
		public function Join(pName:String, pTarget:Point3D, pStartJointName:String = "", pEndJointName:String = "")
		{
			super(pTarget.x, pTarget.y, pTarget.z, pTarget.confidence, pTarget.depth, 
				  pTarget.rotationX, pTarget.rotationY, pTarget.rotationZ, pTarget.maxRotation);
			
			this._name = pName;
			this._startJointName = pStartJointName;
			this._endJointName = pEndJointName;
		}
		
		public function get name():String
		{
			return this._name;
		}
		
		public function get startJointName():String
		{
			return this._startJointName;
		}
		
		public function get endJointName():String
		{
			return this._endJointName;
		}
	}
}