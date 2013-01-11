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
	public class BotDeChoc extends SuperBot
	{
		public var unNidEnnemi : Array = new Array;  // [0] coord, [1] timestamp
		public var nidHome : Array = new Array ();      // [0] coord, [1] timestamp
		public var uneResource : Array = new Array ();  // [0] coord, [1] timestamp, [2] life
		
		public function BotDeChoc(_type:AgentType) 
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
			
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			
			if (IsCollided(collidedAgent)) {
				
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
						unNidEnnemi[0] = (collidedAgent as BotHome).GetTargetPoint();
						unNidEnnemi[1] = new Date().time;
						
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
						
						uneResource[0] = (collidedAgent as Resource).GetTargetPoint();
						uneResource[1] = new Date().time;
						uneResource[2] = (collidedAgent as Resource).GetLife();	
						
						if (uneResource[2] == 0) { // je reset mes infos ressources si la ressource n'a plus de vie
							uneResource[0] = null;
							uneResource[1] = null;
							uneResource[2] = null;
						}
						
						if(!HasResource()){
							(collidedAgent as Resource).DecreaseLife();
							SetResource(true);
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
				if ((collidedAgent as Bot) != null && (collidedAgent as Bot) != this) {
					if ((collidedAgent as Bot).GetTeamId() == "TrioDeChoc" ) { 
						CommunicationEntreBots(collidedAgent);
					// sinon c'est un bot adverse et on vole c'est ressource si on est a vide et lui non.	
					}else {
						if ((collidedAgent as Bot).HasResource()) {
							if (!HasResource()) {
								StealResource((collidedAgent as Bot))
								SetResource(true);
								if (nidHome[0] != null) {
									if(HasResource()){
										moveAt(nidHome[0]);
									}
								}else {
									ChangeDirection();
								}
							}
						}
					}
				}
			}else {//FIN COLLISION
				//DEBUT PERCEPTION
				if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME) {
					if ((collidedAgent as BotHome).GetTeamId() == "TrioDeChoc" ) { //perception avec notre nid
						nidHome[0] = (collidedAgent as BotHome).GetTargetPoint();
						nidHome[1] = new Date().time;
						
						if (HasResource()) {
							moveAt(nidHome[0]);
						}
						
					}else { //perception avec un nid ennemi
						unNidEnnemi[0] = (collidedAgent as BotHome).GetTargetPoint();
						unNidEnnemi[1] = new Date().time;
						
						if (!HasResource()) {
							moveAt(unNidEnnemi[0]);
						}
					}
				}
				
				//perception avec une ressource
				if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE) {
					if ((collidedAgent as Resource).GetLife() > 0) {
					
						uneResource[0] = (collidedAgent as Resource).GetTargetPoint();
						uneResource[1] = new Date().time;
						uneResource[2] = (collidedAgent as Resource).GetLife();	
						
						if (!HasResource()) {
							moveAt(uneResource[0]);
						}
						
						// je reset mes infos ressources si la ressource n'a plus de vie
						/*if (uneResource[2] == 0) { 
							uneResource[0] = null;
							uneResource[1] = null;
							uneResource[2] = null;
							ChangeDirection();
						}*/	
						
						if (nidHome[0] != null) {
							if(HasResource()){
								moveAt(nidHome[0]);
							}
						}else {
							ChangeDirection();
						}
					}
				}
				
				//perception entre mes bots
				if ((collidedAgent as Bot) != null && (collidedAgent as Bot) != this) {
					if ((collidedAgent as Bot).GetTeamId() == "TrioDeChoc" ) { 
						CommunicationEntreBots(collidedAgent);
					}else {//perception bots ennemis
						if (!HasResource())
							if((collidedAgent as Bot).HasResource()){
							moveAt((collidedAgent as Bot).GetTargetPoint());
						}
					}
				}
			}
				
		}
		
		private function CommunicationEntreBots(collidedAgent:Agent):void 
		{
			//Communication entre mes agents	
			//COMMUNICATION NID HOME
			//j'ai des infos et l'autre non
			if (nidHome[0] != null && (collidedAgent as BotDeChoc).nidHome[0] == null) {
				(collidedAgent as BotDeChoc).nidHome[0] = nidHome[0];
				(collidedAgent as BotDeChoc).nidHome[1] = nidHome[1];
			}
			
			//j'ai pas d'infos et l'autre oui
			if (nidHome[0] == null && (collidedAgent as BotDeChoc).nidHome[0] != null) {
				nidHome[0] = (collidedAgent as BotDeChoc).nidHome[0];
				nidHome[1] = (collidedAgent as BotDeChoc).nidHome[1];
			}
			
			//on est tout les deux sans infos
			if (nidHome[0] == null && (collidedAgent as BotDeChoc).nidHome[0] == null) {
				//trace("pas d'infos des 2 cotés");
			}
			
			//On a tt les deux des infos, on détermine les plus récentes via le timestamp 
			if (nidHome[0] != null && (collidedAgent as BotDeChoc).nidHome[0] != null) {
				if (nidHome[1] > (collidedAgent as BotDeChoc).nidHome[1]) { //si j'ai un timestamp plus gros (donc plus récent) alors je transmet mes infos à l'autre
					(collidedAgent as BotDeChoc).nidHome[0] = nidHome[0]; // coord
					(collidedAgent as BotDeChoc).nidHome[1] = nidHome[1]; // timestamp
				}else if (nidHome[1] < (collidedAgent as BotDeChoc).nidHome[1]) {
					nidHome[0] = (collidedAgent as BotDeChoc).nidHome[0]; // coord
					nidHome[1] = (collidedAgent as BotDeChoc).nidHome[1]; // timestamp
				}
			}
			//COMMUNICATION NID ENNEMI
			//j'ai des infos et l'autre non
			if (unNidEnnemi[0] != null && (collidedAgent as BotDeChoc).unNidEnnemi[0] == null) {
				(collidedAgent as BotDeChoc).unNidEnnemi[0] = unNidEnnemi[0];
				(collidedAgent as BotDeChoc).unNidEnnemi[1] = unNidEnnemi[1];
			}
			
			//j'ai pas d'infos et l'autre oui
			if (unNidEnnemi[0] == null && (collidedAgent as BotDeChoc).unNidEnnemi[0] != null) {
				unNidEnnemi[0] = (collidedAgent as BotDeChoc).unNidEnnemi[0];
				unNidEnnemi[1] = (collidedAgent as BotDeChoc).unNidEnnemi[1];
			}
			
			//on est tout les deux sans infos
			if (unNidEnnemi[0] == null && (collidedAgent as BotDeChoc).unNidEnnemi[0] == null) {
				//trace("pas d'infos des 2 cotés");
			}
			
			//On a tt les deux des infos, on détermine les plus récentes via le timestamp 
			if (unNidEnnemi[0] != null && (collidedAgent as BotDeChoc).unNidEnnemi[0] != null) {
				if (unNidEnnemi[1] > (collidedAgent as BotDeChoc).unNidEnnemi[1]) { //si j'ai un timestamp plus gros (donc plus récent) alors je transmet mes infos à l'autre
					(collidedAgent as BotDeChoc).unNidEnnemi[0] = unNidEnnemi[0]; // coord
					(collidedAgent as BotDeChoc).unNidEnnemi[1] = unNidEnnemi[1]; // timestamp
				}else if (unNidEnnemi[1] < (collidedAgent as BotDeChoc).unNidEnnemi[1]) {
					unNidEnnemi[0] = (collidedAgent as BotDeChoc).unNidEnnemi[0]; // coord
					unNidEnnemi[1] = (collidedAgent as BotDeChoc).unNidEnnemi[1]; // timestamp
				}
			}
		}
	}

}