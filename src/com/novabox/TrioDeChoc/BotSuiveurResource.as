package com.novabox.TrioDeChoc 
{
	import com.novabox.MASwithTwoNests.Agent;
	import com.novabox.MASwithTwoNests.AgentCollideEvent;
	import com.novabox.MASwithTwoNests.AgentType;
	import com.novabox.MASwithTwoNests.Bot;
	import com.novabox.MASwithTwoNests.BotHome;
	import com.novabox.MASwithTwoNests.Resource;
	import com.novabox.MASwithTwoNests.TimeManager;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	public class BotSuiveurResource extends SuperBot 
	{
		
		public function BotSuiveurResource(_type:AgentType) 
		{
			super(_type);
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
			
			//on change de direction en cas de collisions avec les bords de la fenêtre 
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
			
			if (uneResource != null ){
				moveAt(uneResource.GetTargetPoint());
			}	
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			
			if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE)
			{
				//on met à jour la resource (notament ses coordonnees) pour avoir sa position exacte
				//si la ressource collisioné est bien la ressource repérée par les bots explorateurs.
				if (collidedAgent == uneResource) {
					uneResource = (collidedAgent as Resource); 
					trace("MAJ point resource " + uneResource.GetTargetPoint());
				}
			}
		}
		
	}

}