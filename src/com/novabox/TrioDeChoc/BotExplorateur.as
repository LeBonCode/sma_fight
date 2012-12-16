package com.novabox.TrioDeChoc 
{
	import com.novabox.MASwithTwoNests.Agent;
	import com.novabox.MASwithTwoNests.AgentCollideEvent;
	import com.novabox.MASwithTwoNests.AgentType;
	import com.novabox.MASwithTwoNests.Bot;
	import com.novabox.MASwithTwoNests.BotHome;
	import com.novabox.MASwithTwoNests.Resource;
	import com.novabox.MASwithTwoNests.TimeManager;
	import com.novabox.MASwithTwoNests.World;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class BotExplorateur extends SuperBot
	{
		
		public function BotExplorateur(_type:AgentType) 
		{
			super(_type);
			//idBot = "explorer";
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			
			/*if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE)
			{
				if (getUneResouce() == null) {
					setUneResource(collidedAgent as Resource);
					//trace("coordonnées resources " + getUneResouce().GetTargetPoint());
					//trace("vie" + getUneResouce().GetLife());
				}
				
				if((collidedAgent as Resource).GetLife() > getUneResouce().GetLife()){
					setUneResource(collidedAgent as Resource);
					//trace("big ressource" + getUneResouce().GetTargetPoint());
					//trace("vie big" + getUneResouce().GetLife());
				}
			}
			
			if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME) {
				if ((collidedAgent as BotHome).GetTeamId() == "TrioDeChoc" ) {
					setNidHome(collidedAgent as BotHome);
					//trace("coordonnees nidHome " + getNidHome().GetTargetPoint());
				}else {
					setNidEnnemi(collidedAgent as BotHome);
					//trace("coordonnees nidEnnemi " + getNidEnnemi().GetTargetPoint());		
				}
			}*/
		}
		
	}

}