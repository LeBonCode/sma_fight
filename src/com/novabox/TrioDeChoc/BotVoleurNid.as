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
	public class BotVoleurNid extends SuperBot
	{
		
		public function BotVoleurNid(_type:AgentType) 
		{
			super(_type);
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			
			/*if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE)
			{
				if (!HasResource())
				{
					(collidedAgent as Resource).DecreaseLife();
					SetResource(true);
				}
			}
			
			if (collidedAgent.GetType() == AgentType.AGENT_BOT) 
			{
				if (!HasResource())
				{
					StealResource((collidedAgent as Bot));
					trace ("vol");
					SetResource(true);
				}
				ChangeDirection();
			}*/
			
			if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME)
			{
				// si c'est un nid ennemi ...
				if ((collidedAgent as BotHome).GetTeamId() != "TrioDeChoc" )
				{
					//... et qu'on ne transporte pas de ressource alors on vole le nid ennemi
					if (!HasResource())
					{
						(collidedAgent as BotHome).TakeResource();
						SetResource(true);
					}
				}else { // sinon c'est notre nid donc on dépose les ressources
					if (HasResource())
					{
						(collidedAgent as BotHome).AddResource();
						SetResource(false);
					}
				}
			}
			
			/*if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME)
			{
				if (HasResource())
				{
					(collidedAgent as BotHome).AddResource();
					SetResource(false);
				}
			}
			
			if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE)
			{
				if (!HasResource())
				{
					(collidedAgent as Resource).DecreaseLife();
					SetResource(true);
				}
			}
			else if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME)
			{
				if (HasResource())
				{
					(collidedAgent as BotHome).AddResource();
					SetResource(false);
				}
			}else if (collidedAgent.GetType() == AgentType.AGENT_BOT) 
			{
				if (!HasResource())
				{
					(collidedAgent as Agent).;
					SetResource(true);
				}
				else
				{
					(collidedAgent as Resource).IncreaseLife();
					SetResource(false);			
				}
				ChangeDirection();
			}
			
			
			//defaut
			/*if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE)
			{
				if (!HasResource())
				{
					(collidedAgent as Resource).DecreaseLife();
					SetResource(true);
				}
				else
				{
					(collidedAgent as Resource).IncreaseLife();
					SetResource(false);			
				}
				ChangeDirection();
			}
			else if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME)
			{
				if (HasResource())
				{
					(collidedAgent as BotHome).AddResource();
					SetResource(false);
				}
			}*/
		}
	}

}