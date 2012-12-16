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
		
		private var nidEnnemi : BotHome;
		private var nidHome : BotHome;
		private var uneResource : Resource;
		
		public function getNidHome() : BotHome {
			return this.nidHome;
		}
		
		public function setNidHome(_nidHome:BotHome) : void {
			this.nidHome = _nidHome;
		}
		
		public function getNidEnnemi() :BotHome {
			return this.nidEnnemi;
		}
		
		public function setNidEnnemi(_nidEnnemi:BotHome) :void {
			this.nidEnnemi = _nidEnnemi;
		}
		
		public function getUneResouce() : Resource {
			return this.uneResource;
		}
		
		public function setUneResource(_uneResource:Resource) : void {
			this.uneResource = _uneResource;
		}
		
		public function BotTest(_type:AgentType) 
		{
			super(_type);
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
		
			if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME){
				if ((collidedAgent as BotHome).GetTeamId() != "TrioDeChoc" ) {
					//... et qu'on ne transporte pas de ressource alors on vole le nid ennemi
					setNidEnnemi(collidedAgent as BotHome);
					if (!HasResource())
					{
						if (getNidEnnemi().HasResource()) {
							(collidedAgent as BotHome).TakeResource();
							SetResource(true);
						}
					}
					if(nidHome != null){
						moveAt(getNidHome().GetTargetPoint());
					}else {
						ChangeDirection();
					}
				}else { // sinon c'est notre nid donc on dépose les ressources
					setNidHome((collidedAgent as BotHome));
					if (HasResource())
					{
						(collidedAgent as BotHome).AddResource();
						SetResource(false);
					}
					if(getNidEnnemi() != null){
						moveAt(getNidEnnemi().GetTargetPoint());
					}else if (getUneResouce() != null) {
						moveAt(getUneResouce().GetTargetPoint());
					}else {
						ChangeDirection();
					}
				}
			}
			
			if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE)
			{
				if (getUneResouce() == null) {
					setUneResource((collidedAgent as Resource));
					//trace("coordonnées resources " + getUneResouce().GetTargetPoint());
					//trace("vie" + getUneResouce().GetLife());
				}
				
				if((collidedAgent as Resource).GetLife() > getUneResouce().GetLife()){
					setUneResource((collidedAgent as Resource));
					//trace("big ressource" + getUneResouce().GetTargetPoint());
					//trace("vie big" + getUneResouce().GetLife());
				}
				
				if (!HasResource()) // si je transporte pas de ressources alors je récolte la ressource
				{
					if (getUneResouce().GetLife() > 0) { 
						(collidedAgent as Resource).DecreaseLife();
						SetResource(true);	
					}
				}
			
				if (getNidHome() != null) {
					moveAt(getNidHome().GetTargetPoint());
				}else {
					ChangeDirection();
				}
			}
			
			//fonctionne visiblement pas
			/*if (collidedAgent.GetType() == AgentType.AGENT_BOT) {
				if ((collidedAgent as Bot).GetTeamId() == "TrioDeChoc" ) {
					if (getNidHome() != null) {
						(collidedAgent as BotTest).setNidHome(this.getNidHome());
					}
					if (getNidEnnemi() != null) {
						(collidedAgent as BotTest).setNidEnnemi(this.getNidEnnemi());
					}
					if (getNidHome() != null) {
						(collidedAgent as BotTest).setUneResource(this.getUneResouce());
					}
				}
			}*/
			
		}
		
	}

}