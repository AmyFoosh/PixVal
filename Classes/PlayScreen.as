package {

	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.events.TouchEvent;

	public class PlayScreen extends ScreenSuperclass {

		// ---------------------------------------

		// -- DISPLAY CONTENT --

		private var player: Player;
		private var playerWalkingHitbox: AssetSuperclass;

		private var joystick: Joystick;

		private var primaryAttackBtn: AssetSuperclass;
		private var dashBtn: AssetSuperclass;
		private var primaryAbilityBtn: AssetSuperclass;
		private var ultimateAbilityBtn: AssetSuperclass;

		// ---------------------------------------

		// -- MAP VARIABLES --

		private var mapGenerator: MapGenerator;

		// ---------------------------------------

		// -- ARMYS --

		private var tilesArmy: Array;
		private var enemyArmy: Array;

		// ---------------------------------------

		public function PlayScreen(scaled: Number, scaled2: Number, screenW: int, screenH: int) {

			super(scaled * 0.6, scaled2, screenW, screenH);
		}

		override public function initializeVariables(): void {

			// This creates a 15x15 map. 11x11 can be used as walking zone with a 2x2 water border.
			mapGenerator = new MapGenerator(3, 15);

			tilesArmy = new Array();
			enemyArmy = new Array();
		}

		override public function addContent(): void {

			createMap();

			player = new Player(scaled, scaled2);
			addChild(player);

			playerWalkingHitbox = new AssetSuperclass(scaled, new PlayerWalkingHitbox);
			addChild(playerWalkingHitbox);

			var dummy: AssetSuperclass = new AssetSuperclass(scaled, new ScarecrowHory);
			addChild(dummy);
			enemyArmy.push(dummy);

			joystick = new Joystick(scaled, screenW, screenH, new BG, new Analog, new Area);
			addChild(joystick);

			primaryAttackBtn = new AssetSuperclass(scaled, new PrimaryAttackBtn);
			addChild(primaryAttackBtn);

			dashBtn = new AssetSuperclass(scaled, new DashBtn);
			addChild(dashBtn);

			primaryAbilityBtn = new AssetSuperclass(scaled, new PrimaryAbilityBtn);
			addChild(primaryAbilityBtn);

			ultimateAbilityBtn = new AssetSuperclass(scaled, new UltimateAbilityBtn);
			addChild(ultimateAbilityBtn);
		}

		override public function adjustContent(): void {

			// ---------------------------------------

			// PLAYER LOCATION

			// posX and posY will locate the player on the middle of the map.
			var posX: int = tilesArmy.length / 2;
			var posY: int = tilesArmy[0].length / 2 + 1;

			var tile: AssetSuperclass = tilesArmy[posX][posY];

			player.x = tile.x;
			player.y = tile.y;

			// ---------------------------------------

			playerWalkingHitbox.x = player.x;
			playerWalkingHitbox.y = player.y + player.height / 2 - playerWalkingHitbox.height / 2;

			// ---------------------------------------

			var dummy: AssetSuperclass = enemyArmy[0];

			posY -= 1;
			tile = tilesArmy[posX][posY];

			dummy.x = tile.x;
			dummy.y = tile.y;

			// ---------------------------------------

			joystick.setStartPos(0 + joystick.joystickBG.width, screenH - joystick.joystickBG.height);

			joystick.x = player.x - screenW / 2;
			joystick.y = player.y - screenH / 2;

			// ---------------------------------------

			primaryAttackBtn.x = player.x + screenW / 2 - primaryAttackBtn.width;
			primaryAttackBtn.y = player.y + screenH / 2 - primaryAttackBtn.height;

			// ---------------------------------------

			dashBtn.x = primaryAttackBtn.x - primaryAttackBtn.width;
			dashBtn.y = primaryAttackBtn.y;

			// ---------------------------------------

			primaryAbilityBtn.x = primaryAttackBtn.x - primaryAttackBtn.width * 0.8;
			primaryAbilityBtn.y = primaryAttackBtn.y - primaryAttackBtn.height * 0.8;

			// ---------------------------------------

			ultimateAbilityBtn.x = primaryAttackBtn.x;
			ultimateAbilityBtn.y = primaryAttackBtn.y - primaryAttackBtn.height;

			// ---------------------------------------

			// VCAM LOCATION

			// This sets PlayScreen class as a VCam, the following target will be the player.
			this.scrollRect = new Rectangle(player.x - screenW / 2, player.y - screenH / 2, screenW, screenH);

			// ---------------------------------------
		}

		override public function addListeners(): void {

			addEventListener(Event.ENTER_FRAME, gameLoop, false, 0, true);

			primaryAttackBtn.addEventListener(TouchEvent.TOUCH_TAP, primaryAttack, false, 0, true);
			dashBtn.addEventListener(TouchEvent.TOUCH_TAP, dash, false, 0, true);
			primaryAbilityBtn.addEventListener(TouchEvent.TOUCH_TAP, primaryAbility, false, 0, true);
			ultimateAbilityBtn.addEventListener(TouchEvent.TOUCH_TAP, ultimateAbility, false, 0, true);
		}

		override public function removeListeners(): void {

			removeEventListener(Event.ENTER_FRAME, gameLoop, false);

			primaryAttackBtn.removeEventListener(TouchEvent.TOUCH_TAP, primaryAttack, false);
			dashBtn.removeEventListener(TouchEvent.TOUCH_TAP, dash, false);
			primaryAbilityBtn.removeEventListener(TouchEvent.TOUCH_TAP, primaryAbility, false);
			ultimateAbilityBtn.removeEventListener(TouchEvent.TOUCH_TAP, ultimateAbility, false);
		}

		// ---------------------------------------

		// MAP CREATION AND DESTRUCTION

		private function createMap(): void {

			var mapPlain: Array = mapGenerator.getMapPlain();
			var array: Array = new Array();

			for (var i: int = 0; i < mapPlain.length; i++) {

				for (var j: int = 0; j < mapPlain[i].length; j++) {

					var tile: Tile;

					if (mapPlain[i][j] == 1) tile = new Tile(scaled, "Ground");
					if (mapPlain[i][j] == 0) tile = new Tile(scaled, "Water");

					tile.x = 0 + tile.width / 2 + tile.width * i;
					tile.y = 0 + tile.height / 2 + tile.height * j;

					addChild(tile);
					array.push(tile);

					// This codeline sents the tile to the bottom.
					this.setChildIndex(tile, 0);
				}

				tilesArmy.push(array);
				array = new Array();
			}
		}

		private function deleteMap(): void {

			var tile: Tile;

			for (var i: int = 0; i < tilesArmy.length; i++) {

				for (var j: int = 0; j < tilesArmy[i].length; j++) {

					tile = tilesArmy[i][j];

					removeChild(tile);
				}
			}

			tilesArmy = new Array();
		}

		private function expandMapZone(): void {

			// Map will always contain 2 water tiles on borders.
			if (mapGenerator.initialSize == mapGenerator.maxSize - 4) return;

			mapGenerator.expandMap();
			deleteMap();
			createMap();
		}

		// ---------------------------------------

		// -- UI BUTTONS --

		private function primaryAttack(event: TouchEvent): void {
			
			// ---------------------------------------

			if (!player.canAttack) return;
			if (player.isStunned) return;
			if (player.isKnockbacked) return;
			
			// ---------------------------------------
			
			player.canAttack = false;
			
			if (player.playerName == "Neal") nealAttack();
			
			// ---------------------------------------
		}
		
		private function nealAttack(): void {
			
			trace("Neal Attack.");
		}

		private function dash(event: TouchEvent): void {

			if (isNaN(joystick.getDirX) && isNaN(joystick.getDirY)) return;

			player.addDash(joystick.getAngle);
		}

		private function primaryAbility(event: TouchEvent): void {

			trace("Primary Ability.");
		}

		private function ultimateAbility(event: TouchEvent): void {

			trace("Ultimate Ability.");
		}

		// ---------------------------------------

		// -- GAME LOOP --

		private function gameLoop(event: Event): void {

			playerController();
			collisionsController();
			vCamMovement();
			gameOver();
		}

		// ---------------------------------------

		// -- PLAYER CONTROLLER --

		private function playerController(): void {

			playerMovement();
			player.ticks();
		}

		private function playerMovement(): void {

			joystick.tick();
			
			if (joystick.getJoystickIsClicked) player.move(joystick.getAngle);
			if (!joystick.getJoystickIsClicked) player.unmove(joystick.getAngle);
		}

		// ---------------------------------------

		// -- COLLISIONS CONTROLLER --

		private function collisionsController(): void {

			checkPlayerAndWaterCollision();
			checkPlayerAndEnemiesCollisions();
		}

		private function checkPlayerAndWaterCollision(): void {

			var tile: Tile;
			var isHittingWater: Boolean = false;

			for (var i: int = 0; i < tilesArmy.length; i++) {

				for (var j: int = 0; j < tilesArmy[i].length; j++) {

					tile = tilesArmy[i][j];

					if (playerWalkingHitbox.hitTestObject(tile) && tile.tileTpye == "Water") {

						isHittingWater = true;
						break;
					}
				}
			}

			if (isHittingWater) {

				player.isOnWater = true;
				player.addSlow(20, 0.8);

			} else {

				player.isOnWater = false;
			}
		}

		private function checkPlayerAndEnemiesCollisions(): void {

			if (!player.canReceiveDamage) return;

			var enemy: AssetSuperclass;

			for (var i: int = 0; i < enemyArmy.length; i++) {

				enemy = enemyArmy[i];

				if (CircularCollision.circularHitTestObject(player, enemy)) {

					var angle: Number = Math.atan2(player.y - enemy.y, player.x - enemy.x);

					player.addKnockback(angle, 12);

					player.health--;
				}
			}
		}

		// ---------------------------------------

		// GAME OVER 

		private function gameOver(): void {

			if (player.health <= 0) player.isDead = true;
			if (player.isDead) removeListeners();
		}

		// ---------------------------------------

		// VIRTUAL CAMERA

		private function vCamMovement(): void {

			// ---------------------------------------

			// Set rect variable equal to scrollRect PlayScreen class to manipulate VCam position.
			var rect: Rectangle = this.scrollRect;

			// This will center the camera on player current position.
			rect.x = player.x - screenW / 2;
			rect.y = player.y - screenH / 2;

			// Here the changes are applied to PlayScreen class to show new VCam coordinates.
			this.scrollRect = rect;

			// ---------------------------------------

			// UI MOVEMENT

			playerWalkingHitbox.x = player.x;
			playerWalkingHitbox.y = player.y + player.height / 2 - playerWalkingHitbox.height / 2;

			joystick.x = player.x - screenW / 2;
			joystick.y = player.y - screenH / 2;

			primaryAttackBtn.x = player.x + screenW / 2 - primaryAttackBtn.width;
			primaryAttackBtn.y = player.y + screenH / 2 - primaryAttackBtn.height;

			dashBtn.x = primaryAttackBtn.x - primaryAttackBtn.width;
			dashBtn.y = primaryAttackBtn.y;

			primaryAbilityBtn.x = primaryAttackBtn.x - primaryAttackBtn.width * 0.8;
			primaryAbilityBtn.y = primaryAttackBtn.y - primaryAttackBtn.height * 0.8;

			ultimateAbilityBtn.x = primaryAttackBtn.x;
			ultimateAbilityBtn.y = primaryAttackBtn.y - primaryAttackBtn.height;

			// ---------------------------------------
		}

		// ---------------------------------------




	}
}