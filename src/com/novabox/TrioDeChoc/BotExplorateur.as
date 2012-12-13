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
	
	public class BotExplorateur extends SuperBot
	{
		
		public function BotExplorateur(_type:AgentType) 
		{
			super(_type);
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			
			if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE)
			{
				if (uneResource == null) {
					uneResource = (collidedAgent as Resource);
					//trace("point resource " + uneResource.GetTargetPoint());
					//trace("life resource  " + uneResource.GetLife());
				}
				
				if((collidedAgent as Resource).GetLife() > uneResource.GetLife()){
					uneResource = (collidedAgent as Resource);
					//trace("point resource big" + uneResource.GetTargetPoint());
					//trace("life resource big " + uneResource.GetLife());
				}
			}
			
			if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME) {
				if ((collidedAgent as BotHome).GetTeamId() == "TrioDeChoc" ) {
					nidHome = (collidedAgent as BotHome);
					//trace("point nid home " + nidHome.GetTargetPoint());
				}else {
					nidEnnemi = (collidedAgent as BotHome);
					//trace("point nid ennemi " + nidEnnemi.GetTargetPoint());
				}
			}
		}
		
	}

}