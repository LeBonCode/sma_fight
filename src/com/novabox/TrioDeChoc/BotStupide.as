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
	public class BotStupide extends SuperBot
	{
		
		public function BotStupide(_type:AgentType) 
		{
			super(_type);
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			
			//comportement donné par le prof
			// si c'est une ressource... 
			if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE)
			{
				if (!HasResource()) // si je transporte pas de ressources alors je récolte la ressource
				{
					(collidedAgent as Resource).DecreaseLife();
					SetResource(true);
				}
				else // sinon si j'en transporte alors je la dépose sur cette ressource pour former un tas plus gros
				{
					(collidedAgent as Resource).IncreaseLife();
					SetResource(false);			
				}
				ChangeDirection();
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