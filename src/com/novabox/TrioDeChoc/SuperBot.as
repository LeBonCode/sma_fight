package com.novabox.TrioDeChoc 
{
	import com.novabox.MASwithTwoNests.Bot;
	import com.novabox.MASwithTwoNests.Agent;
	import com.novabox.MASwithTwoNests.AgentCollideEvent;
	import com.novabox.MASwithTwoNests.AgentType;
	import com.novabox.MASwithTwoNests.BotHome;
	import com.novabox.MASwithTwoNests.Resource;
	import com.novabox.MASwithTwoNests.TimeManager;
	import com.novabox.MASwithTwoNests.World;
	import flash.events.Event;
	import flash.geom.Point;

	public class SuperBot extends Bot
	{	
		protected var updateTime:Number = 0;
		
		public function SuperBot(_type:AgentType) 
		{
			super(_type);
			updateTime = 0;
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
				return true;
			}
		}
	}

}