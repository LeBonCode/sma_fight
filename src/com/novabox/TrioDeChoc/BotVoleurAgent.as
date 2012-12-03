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
	public class BotVoleurAgent extends Bot
	{
		
		protected var updateTime:Number = 0;
		
		public function BotVoleurAgent(_type:AgentType) 
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
				ChangeDirection();
				updateTime = 0;
			}
			
			
			 targetPoint.x = x + direction.x * speed * elapsedTime / 1000 ;
			 targetPoint.y = y + direction.y * speed * elapsedTime / 1000;
					
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			
			// si c'est un agent... 
			if (collidedAgent.GetType() == AgentType.AGENT_BOT)
			{
				//.. qui n'est pas de notre équipe ...
				if ((collidedAgent as Bot).GetTeamId() != "TrioDeChoc") {
					if (!HasResource()) //.. alors si je transporte pas de ressources, je vol la ressource de l'agent ennemi
					{
						StealResource(collidedAgent as Bot);
						SetResource(true);
					}
					ChangeDirection();
				}	
			} 

			//si je rencontre mon nid je dépose mes ressources si j'en ai 
			if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME)
			{
				if ((collidedAgent as BotHome).GetTeamId() == "TrioDeChoc" )
				{
					if (HasResource())
					{
						(collidedAgent as BotHome).AddResource();
						SetResource(false);
					}
				}
			}
		}
		
	}

}