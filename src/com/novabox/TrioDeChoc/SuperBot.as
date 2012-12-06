package com.novabox.TrioDeChoc 
{
	import com.novabox.MASwithTwoNests.Bot;
	import com.novabox.MASwithTwoNests.Agent;
	import com.novabox.MASwithTwoNests.AgentCollideEvent;
	import com.novabox.MASwithTwoNests.AgentType;
	import com.novabox.MASwithTwoNests.BotHome;
	import com.novabox.MASwithTwoNests.Resource;
	import com.novabox.MASwithTwoNests.TimeManager;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	public class SuperBot extends Bot
	{	
		protected var updateTime:Number = 0;
		protected var pointNidHome:Point;
		protected var pointNidEnnemi:Point;
		
		public function getPointNidHome() : Point
		{
			return pointNidHome
		}
		
		public function setPointNidHome(_point:Point) : void
		{
			pointNidHome = _point;
		}
		
		public function getPointNidEnnemi() : Point
		{
			return pointNidEnnemi
		}
		
		public function setPointNidEnnemi(_point:Point) : void
		{
			pointNidEnnemi = _point;
		}
		
		public function SuperBot(_type:AgentType) 
		{
			super(_type);
			updateTime = 0;
		}
		
		public function GetColor() : int
		{
			return color;
		}
		
		override public function Update() : void
		{
			var elapsedTime:Number = TimeManager.timeManager.GetFrameDeltaTime();
			
			updateTime += elapsedTime;
				
			if (updateTime >=  directionChangeDelay)
			{
				//ChangeDirection();
				updateTime = 0;
			}
			
			
			 targetPoint.x = x + direction.x * speed * elapsedTime / 1000 ;
			 targetPoint.y = y + direction.y * speed * elapsedTime / 1000;
			
			if (targetPoint.y<0) {
				ChangeDirection();
			}
			if (targetPoint.y >600) {
				ChangeDirection();
			}
			if (targetPoint.x<0) {
				ChangeDirection();
			}
			if (targetPoint.x>650) {
				ChangeDirection();
			}

		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			
		}
		
		public function moveAt(_thisPoint:Point) : Boolean
		{
			var pixelByFrame:Number = this.speed / (TimeManager.timeManager.GetFrameDeltaTime());
			var distanceBetweenMeAndTisPoint:Number = Math.sqrt(Math.pow((this.x - _thisPoint.x), 2) + Math.pow((this.y - _thisPoint.y), 2));
				
			if ((distanceBetweenMeAndTisPoint > pixelByFrame) || (pixelByFrame == Infinity)) {
				direction = _thisPoint.subtract(targetPoint);
				direction.normalize(1);
				return false;
			}else {
				this.x = _thisPoint.x;
				this.y = _thisPoint.y;
				direction.x = 0;
				direction.y = 0;
				trace("je suis arrivé");
				return true;
			}
		}
	}

}