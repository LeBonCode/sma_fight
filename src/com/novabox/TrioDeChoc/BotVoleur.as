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
	public class BotVoleur extends Bot
	{
		
		protected var updateTime:Number = 0;
		
		public function BotVoleur(_type:AgentType) 
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
				// si c'est un nid ennemi 
				if ((collidedAgent as BotHome).GetTeamId() != "TrioDeChoc" )
				{
					trace((collidedAgent as BotHome).GetTeamId());
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