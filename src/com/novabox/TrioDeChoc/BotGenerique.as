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
	public class BotGenerique extends Bot
	{
		
		
		protected var updateTime:Number = 0;
		
		public function BotGenerique(_type:AgentType) 
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
			//sinon si je rencontre mon nid je dépose mes ressources si j'en ai 
			else if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME)
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