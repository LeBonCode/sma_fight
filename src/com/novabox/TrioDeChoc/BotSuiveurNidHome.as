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
	
	/* étrangement les bots suiveur de ressources et suiveur de nidHome ne servent à rien. 
	Les bots récolteurs connaissent la position exacte du nidHome et de la ressource visée
	en permance malgré leurs positions qui changent en permance */
	
	public class BotSuiveurNidHome extends SuperBot
	{
		
		public function BotSuiveurNidHome (_type:AgentType) 
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
			
			if (nidHome != null ){
				moveAt(nidHome.GetTargetPoint());
			}	
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			
			if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME)
			{
				//on met à jour la resource (notament ses coordonnees) pour avoir sa position exacte
				//si la ressource collisioné est bien la ressource repérée par les bots explorateurs.
				if (collidedAgent == nidHome) {
					nidHome = (collidedAgent as BotHome); 
					trace("MAJ point nid home " + nidHome.GetTargetPoint());
				}
			}
		}
		
	}

}