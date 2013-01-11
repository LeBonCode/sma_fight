package com.novabox.TrioDeChoc 
{
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.EventDispatcher;
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

	public class BotDeChoc extends SuperBot
	{
		public var unNidEnnemi : Array = new Array;     // [0] coord, [1] timestamp
		public var nidHome : Array = new Array ();      // [0] coord, [1] timestamp
		public var uneResource : Array = new Array ();  // [0] coord, [1] timestamp, [2] life
		public var myTimer:Timer = new Timer(20000, 1); // Chrono pour le déclenchement de la défense (1:10s)
		
		public function timerListener (e:TimerEvent):void {
			trace("DEFENSE DE LA BASE");
			if (nidHome[0] != null) {
				moveAt(nidHome[0]);
			}
		}
		
		public function BotDeChoc(_type:AgentType) 
		{
			super(_type);
			// Lancement du Timer
			myTimer.addEventListener(TimerEvent.TIMER, timerListener);
			myTimer.start();
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
				
				//////////////////////////////////////////////////////////////
				//                        COLLISION  						//	
				//////////////////////////////////////////////////////////////
				
				/********************      BOT HOME      ********************/
				if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME) {
					// Notre Nid 
					if ((collidedAgent as BotHome).GetTeamId() == "TrioDeChoc" ) { 
						
						nidHome[0] = (collidedAgent as BotHome).GetTargetPoint();
						nidHome[1] = new Date().time;
						
						if (HasResource()) {
							(collidedAgent as BotHome).AddResource();
							SetResource(false);
						}
						
						if (uneResource[0] != null) {
							moveAt(uneResource[0]);
						}else if (unNidEnnemi[0] != null) {
							moveAt(unNidEnnemi[0]);
						}else{	
							ChangeDirection();
						}
					}else { 
						//Nid Ennemi      
						unNidEnnemi[0] = (collidedAgent as BotHome).GetTargetPoint();
						unNidEnnemi[1] = new Date().time;
						
						if (!HasResource() && (collidedAgent as BotHome).HasResource())
						{
							(collidedAgent as BotHome).TakeResource();
							SetResource(true);
							
							if(nidHome[0] != null){
								moveAt(nidHome[0]);
							}else if (uneResource[0] != null) {
								moveAt(uneResource[0]);
							}else {
								ChangeDirection();
							}
						}else if (!HasResource() && (collidedAgent as BotHome).HasResource() == false) {
							if (uneResource[0] != null) {
								moveAt(uneResource[0]);
							}	
						}else if (HasResource()) {
							if(nidHome[0] != null){
								moveAt(nidHome[0]);
							}
						}else {
							// trace("Bug impossible");
						}
					}
				}
				
				/********************      RESSOURCE     ********************/
				if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE) {
					if ((collidedAgent as Resource).GetLife() > 0) {
						
						uneResource[0] = (collidedAgent as Resource).GetTargetPoint();
						uneResource[1] = new Date().time;
						uneResource[2] = (collidedAgent as Resource).GetLife();	
						
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
				
				/********************      BOT      ********************/
				if ((collidedAgent as Bot) != null && (collidedAgent as Bot) != this) {
					// BotDeChoc
					if ((collidedAgent as Bot).GetTeamId() == "TrioDeChoc" ) { 
						CommunicationEntreBots(collidedAgent);	
					}else {
						// Bot Ennemi     
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
			}else {
				//////////////////////////////////////////////////////////////
				//                        PERCEPTION						//	
				//////////////////////////////////////////////////////////////
				
				/********************      BOT HOME      ********************/
				if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME) {
					// Perception du nid
					if ((collidedAgent as BotHome).GetTeamId() == "TrioDeChoc" ) { 
						nidHome[0] = (collidedAgent as BotHome).GetTargetPoint();
						nidHome[1] = new Date().time;
						
						if (HasResource()) {
							moveAt(nidHome[0]);
						}
					// Perception du nid ennemi	
					}else { 
						unNidEnnemi[0] = (collidedAgent as BotHome).GetTargetPoint();
						unNidEnnemi[1] = new Date().time;
						
						if (!HasResource() && (collidedAgent as BotHome).HasResource()) {
							moveAt(unNidEnnemi[0]);
						}
					}
				}
				
				/********************      RESSOURCE     ********************/
				if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE) {
					if ((collidedAgent as Resource).GetLife() > 0) {
					
						uneResource[0] = (collidedAgent as Resource).GetTargetPoint();
						uneResource[1] = new Date().time;
						uneResource[2] = (collidedAgent as Resource).GetLife();	
						
						if (!HasResource()) {
							moveAt(uneResource[0]);
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
				
				/********************      BOT      ********************/
				if ((collidedAgent as Bot) != null && (collidedAgent as Bot) != this) {
					// BotDeChoc
					if ((collidedAgent as Bot).GetTeamId() == "TrioDeChoc" ) { 
						CommunicationEntreBots(collidedAgent);
					}else {
						// Bot ennemi
						if (!HasResource() && (collidedAgent as Bot).HasResource()){
							moveAt((collidedAgent as Bot).GetTargetPoint());
						}
					}
				}
			}
				
		}
		
		private function CommunicationEntreBots(collidedAgent:Agent):void 
		{	
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