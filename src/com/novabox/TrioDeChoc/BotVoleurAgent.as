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
	public class BotVoleurAgent extends SuperBot
	{
		
		public function BotVoleurAgent(_type:AgentType) 
		{
			super(_type);
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