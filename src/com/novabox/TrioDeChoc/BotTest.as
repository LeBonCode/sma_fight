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
	import com.novabox.MASwithTwoNests.Main;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	public class BotTest extends SuperBot
	{
		public var unNidEnnemi : Point;  // coord
		public var nidHome : Array = new Array ();      // [0] coord, [1] timestamp
		public var uneResource : Array = new Array ();  // [0] coord, [1] timestamp, [2] life
		
		public function BotTest(_type:AgentType) 
		{
			super(_type);
		}
		
		override public function Update() : void {
			super.Update();
			
			//on change de direction en cas de collisions avec les bords de la fenêtre 
			if (targetPoint.y < 0) {
				ChangeDirection();		
			}
			if (targetPoint.y > World.WORLD_HEIGHT) {
				ChangeDirection();			
			}
			if (targetPoint.x<0) {
				ChangeDirection();			
			}
			if (targetPoint.x > World.WORLD_WIDTH) {
				ChangeDirection();		
			}
			
			/*if (nidHome[0] != null) {
				if (HasResource()) {
					moveAt(nidHome[0]);
				}
			}*/
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			
			if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME) {
				if ((collidedAgent as BotHome).GetTeamId() == "TrioDeChoc" ) { //collision avec notre nid
					if (HasResource()) {
						(collidedAgent as BotHome).AddResource();
						SetResource(false);
					}
					nidHome[0] = (collidedAgent as BotHome).GetTargetPoint();
					nidHome[1] = new Date().time;
					
					if (uneResource[0] != null) {
						moveAt(uneResource[0]);
					}else {
						ChangeDirection();
					}
				}else { //collision avec un nid ennemi
					unNidEnnemi = (collidedAgent as BotHome).GetTargetPoint();	
					if (!HasResource())
					{
						if((collidedAgent as BotHome).HasResource()){
							(collidedAgent as BotHome).TakeResource();
							SetResource(true);
						}
					}
					
					if(nidHome[0] != null){
						moveAt(nidHome[0]);
					}else if (uneResource[0] != null) {
						moveAt(uneResource[0]);
					}else {
						ChangeDirection();
					}
				}
			}
			
			//collision avec une ressource
			if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE) {
				if ((collidedAgent as Resource).GetLife() > 0) {
					if(!HasResource()){
						(collidedAgent as Resource).DecreaseLife();
						SetResource(true);
						uneResource[0] = (collidedAgent as Resource).GetTargetPoint();
						uneResource[1] = new Date().time;
						uneResource[2] = (collidedAgent as Resource).GetLife();	
						if (uneResource[2] == 0) { // je reset mes infos ressources si la ressource n'a plus de vie
							uneResource[0] = null;
							uneResource[1] = null;
							uneResource[2] = null;
							ChangeDirection();
						}
					}else {
						uneResource[0] = (collidedAgent as Resource).GetTargetPoint();
						uneResource[1] = new Date().time;
						uneResource[2] = (collidedAgent as Resource).GetLife();	
					}		
					
					if (nidHome[0] != null) {
						if(HasResource()){
							moveAt(nidHome[0]);
						}
					}else {
						ChangeDirection();
					}
				}
			}
			
			//collision entre mes bots
			//Communication entre les agents
			if ((collidedAgent as Bot) != null && (collidedAgent as Bot) != this) {
				if ((collidedAgent as Bot).GetTeamId() == "TrioDeChoc" ) {	
					//j'ai des infos et l'autre non
					if (nidHome[0] != null && (collidedAgent as BotTest).nidHome[0] == null) {
						/*trace("moi info, l'autre non");
						trace("AVANT");
						trace("MES infos : coord " + nidHome[0], "timestamp " + nidHome[1]);
						trace("SES infos : coord "+(collidedAgent as BotTest).nidHome[0], "timestamp "+(collidedAgent as BotTest).nidHome[1]);*/
						(collidedAgent as BotTest).nidHome[0] = nidHome[0];
						(collidedAgent as BotTest).nidHome[1] = nidHome[1];
						/*trace("APRES");
						trace("moi info, l'autre non");
						trace("MES infos : coord " + nidHome[0], "timestamp " + nidHome[1]);
						trace("SES infos : coord "+(collidedAgent as BotTest).nidHome[0], "timestamp "+(collidedAgent as BotTest).nidHome[1]);*/
					}
					
					//j'ai pas d'infos et l'autre oui
					if (nidHome[0] == null && (collidedAgent as BotTest).nidHome[0] != null) {
						/*trace("moi info, l'autre non");
						trace("AVANT");
						trace("MES infos : coord " + nidHome[0], "timestamp " + nidHome[1]);
						trace("SES infos : coord "+(collidedAgent as BotTest).nidHome[0], "timestamp "+(collidedAgent as BotTest).nidHome[1]);*/
						nidHome[0] = (collidedAgent as BotTest).nidHome[0];
						nidHome[1] = (collidedAgent as BotTest).nidHome[1];
						/*trace("APRES");
						trace("moi info, l'autre non");
						trace("MES infos : coord " + nidHome[0], "timestamp " + nidHome[1]);
						trace("SES infos : coord "+(collidedAgent as BotTest).nidHome[0], "timestamp "+(collidedAgent as BotTest).nidHome[1]);*/
					}
					
					//on est tout les deux sans infos
					if (nidHome[0] == null && (collidedAgent as BotTest).nidHome[0] == null) {
						//trace("pas d'infos des 2 cotés");
					}
					
					//On a tt les deux des infos, on détermine les plus récentes via le timestamp 
					if (nidHome[0] != null && (collidedAgent as BotTest).nidHome[0] != null) {
						if (nidHome[1] > (collidedAgent as BotTest).nidHome[1]) { //si j'ai un timestamp plus gros (donc plus récent) alors je transmet mes infos à l'autre
							/*trace("AVANT");
							trace("Moi OK, Autre NOK");
							trace("MES infos : coord " + nidHome[0], "timestamp " + nidHome[1]);
							trace("SES infos : coord "+(collidedAgent as BotTest).nidHome[0], "timestamp "+(collidedAgent as BotTest).nidHome[1]);*/
							(collidedAgent as BotTest).nidHome[0] = nidHome[0]; // coord
							(collidedAgent as BotTest).nidHome[1] = nidHome[1]; // timestamp
							/*trace("APRES");
							trace("Moi OK, Autre NOK");
							trace("MES infos : coord " + nidHome[0], "timestamp " + nidHome[1]);
							trace("SES infos : coord "+(collidedAgent as BotTest).nidHome[0], "timestamp "+(collidedAgent as BotTest).nidHome[1]);*/
						}else if (nidHome[1] < (collidedAgent as BotTest).nidHome[1]) {
							/*trace("AVANT");
							trace("Moi NOK, Autre OK");
							trace("MES infos : coord " + nidHome[0], "timestamp " + nidHome[1]);
							trace("SES infos : coord "+(collidedAgent as BotTest).nidHome[0], "timestamp "+(collidedAgent as BotTest).nidHome[1]);*/
							nidHome[0] = (collidedAgent as BotTest).nidHome[0]; // coord
							nidHome[1] = (collidedAgent as BotTest).nidHome[1]; // timestamp
							/*trace("APRES");
							trace("Moi NOK, Autre OK");
							trace("MES infos : coord " + nidHome[0], "timestamp " + nidHome[1]);
							trace("SES infos : coord "+(collidedAgent as BotTest).nidHome[0], "timestamp "+(collidedAgent as BotTest).nidHome[1]);*/
						}
					}
				// sinon c'est un bot adverse	
				}
			}		
			
			
			
			
			
			/*if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME) {
				if ((collidedAgent as BotHome).GetTeamId() != "TrioDeChoc" ) {
					//.. et qu'on ne transporte pas de ressource alors on vole le nid ennemi
					nidEnnemi[0] = (collidedAgent as BotHome).GetTargetPoint();
					nidEnnemi[1] = new Date().time;					
					//trace("coord "+nidEnnemi[0], "timestamp " +nidEnnemi[1]);
					if (!HasResource())
					{
						if ((collidedAgent as BotHome).HasResource()) {
							(collidedAgent as BotHome).TakeResource();
							SetResource(true);
						}
					}
					
					if(nidHome[0] != null){
						moveAt(nidHome[0]);
					}else {
						ChangeDirection();
						trace("change direction bot home ennemi");
					}
				}else { // sinon c'est notre nid donc on dépose les ressources
					nidHome[0] = (collidedAgent as BotHome).GetTargetPoint();
					nidHome[1] = new Date().time;	
					if (HasResource())
					{
						(collidedAgent as BotHome).AddResource();
						SetResource(false);
					}
					
					if(nidEnnemi[0] != null){
						moveAt(nidEnnemi[0]);
					}else if (uneResource[0] != null) {
						moveAt(uneResource[0]);
					}else {
						ChangeDirection();
						trace("change direction bot home");
					}
				}
			}
			
			if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE)
			{
				if (uneResource[0] == null) {
					uneResource[0] = (collidedAgent as Resource).GetTargetPoint();
					uneResource[1] = new Date().time;	
					uneResource[2] = (collidedAgent as Resource).GetLife();
					trace("init : coord " +uneResource[0], "time "+uneResource[1], "life "+uneResource[2]);
				}
				
				/*if ((collidedAgent as Resource).GetLife() > uneResource[2]) {
					trace("AVANT : coord " +uneResource[0], "time "+uneResource[1], "life "+uneResource[2]);
					uneResource[0] = (collidedAgent as Resource).GetTargetPoint();
					uneResource[1] = new Date().time;	
					uneResource[2] = (collidedAgent as Resource).GetLife();
					trace("APRES : coord " +uneResource[0], "time "+uneResource[1], "life "+uneResource[2]);
				}
				*/
				/*if (!HasResource()) // si je transporte pas de ressources alors je récolte la ressource
				{
					if ((collidedAgent as Resource).GetLife() > 0) { 
						(collidedAgent as Resource).DecreaseLife();
						//trace("avant decrease "+uneResource[2]);
						//uneResource[2] = ((collidedAgent as Resource).GetLife() - World.RESOURCE_UPDATE_VALUE);
						//trace("apres decrease "+uneResource[2]);
						SetResource(true);	
					}
				}
			
				if (nidHome[0] != null) {
					moveAt(nidHome[0]);
					trace("change direction (moveat nid home) ressource");
				}else {
					ChangeDirection();
					trace("change direction ressource");
				}
			}*/

		}
		
	}

}