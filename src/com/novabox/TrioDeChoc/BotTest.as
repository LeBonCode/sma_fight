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
	public class BotTest extends SuperBot
	{
		
		public function BotTest(_type:AgentType) 
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
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			
			/*if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE) {
				setPointResource((collidedAgent as Resource).GetTargetPoint());
				if (botSuiveurResource == null){
					botSuiveurResource = this;
				}
			}*/
			
			
			
			/*else if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME){
				setPointNidHome((collidedAgent as BotHome).GetTargetPoint());
				if(botSuiveurNidHome == null){
					botSuiveurNidHome = this;
				}
			}*/
			//trace("botsuiveurresource " + botSuiveurResource);
			//trace("botnidhome " + botSuiveurNidHome);
			
			
			
			
			
			
			//good
			if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME){
				if ((collidedAgent as BotHome).GetTeamId() != "TrioDeChoc" ) {
					//... et qu'on ne transporte pas de ressource alors on vole le nid ennemi
					//setPointNidEnnemi((collidedAgent as BotHome).GetTargetPoint());
					nidEnnemi = (collidedAgent as BotHome);
					if (!HasResource())
					{
						(collidedAgent as BotHome).TakeResource();
						SetResource(true);
					}
					if(nidHome != null){
					//if (getPointNidHome() != null) {
						//moveAt(getPointNidHome());
						moveAt(nidHome.GetTargetPoint());
					}else {
						ChangeDirection();
					}
				}else { // sinon c'est notre nid donc on dépose les ressources
					//setPointNidHome((collidedAgent as BotHome).GetTargetPoint());
					nidHome = (collidedAgent as BotHome);
					if (HasResource())
					{
						(collidedAgent as BotHome).AddResource();
						SetResource(false);
					}
					if(nidEnnemi != null){
					//if (getPointNidEnnemi() != null) {
						//moveAt(getPointNidEnnemi());
						moveAt(nidEnnemi.GetTargetPoint());
					}else {
						ChangeDirection();
					}
				}
			}
			/*else {
				if(pointNidEnnemi != null){
					//if (getPointNidEnnemi() != null) {
						//moveAt(getPointNidEnnemi());
					moveAt(pointNidEnnemi);
				}else {
					ChangeDirection();
				}
			}*/
			
			
			/*if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE) {
				//setPointResource((collidedAgent as Resource).GetTargetPoint());
				pointResource = (collidedAgent as Resource).GetTargetPoint();
				if (!HasResource()) // si je transporte pas de ressources alors je récolte la ressource
				{
					(collidedAgent as Resource).DecreaseLife();
					SetResource(true);	
				}
				if (pointNidHome != null) {
				moveAt(pointNidHome);
				//if (getPointResource() != null) {
					//moveAt(getPointResource());
				}else {
					ChangeDirection();
				}
			}*/
			
				/*setPointResource((collidedAgent as Resource).GetTargetPoint());
				if (!HasResource()) // si je transporte pas de ressources alors je récolte la ressource
				{
					(collidedAgent as Resource).DecreaseLife();
					SetResource(true);
					if (getPointNidHome() != null) { //et si je connais les coordonnees de mon nid je m'y rend
						moveAt(getPointNidHome());
					}else {
						ChangeDirection();
					}
				}else {
					if (getPointNidHome() != null) { //et si je connais les coordonnees de mon nid je m'y rend
						moveAt(getPointNidHome());
					}else {
						ChangeDirection();
					}
				}*/

			/*if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE)
			{
				setPointResource((collidedAgent as Resource).GetTargetPoint());
				trace("point resource " + getPointResource());
				moveAt(getPointResource());
			}/*else if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME) {
				if ((collidedAgent as BotHome).GetTeamId() == "TrioDeChoc" ) {
					setPointNidHome((collidedAgent as BotHome).GetTargetPoint());
					trace("point nid home " + getPointNidHome());
					moveAt((collidedAgent as BotHome).GetTargetPoint());
				}else {
					setPointNidEnnemi((collidedAgent as BotHome).GetTargetPoint());
					trace("point nid ennemi " + getPointNidEnnemi());
					moveAt((collidedAgent as BotHome).GetTargetPoint());
				}
			}*/
		}
		
	}

}