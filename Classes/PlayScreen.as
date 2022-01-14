package {

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.TouchEvent;

	public class PlayScreen extends ScreenSuperclass {
		
		// ---------------------------------------
		
		// UTILS
		
		private var playerKit: String;
		private var primaryAttack: Boolean;
		
		private var canLoadContent: Boolean;
		private var characterSelector: CharacterSelector;
		
		private var abilityPosX: Number;
		
		private var shake: Shake;

		// ---------------------------------------

		// MAP STUFF

		private var mapSize: int;
		private var waterSize: int;
		private var waterSize2: int;

		// ---------------------------------------

		// DISPLAY

		private var player: Player;
		
		private var screenDamage: BackgroundSuperclass;
		
		private var joystick: Joystick;
		
		// Attack buttons.
		
		private var primaryAttackBtn: AssetSuperclass;
		private var abilityBtn: AssetSuperclass;
		
		// Ability cooldown stuff.

		private var abilityReloadingBarContainer: AssetSuperclass;
		private var abilityReloadingBar: AssetSuperclass;
		private var abilityReloadingText: AbilityReloadingText;
		
		// Player card and life stuff.

		private var playerCard: Card;
		private var playerHealthBarContainer: AssetSuperclass;
		private var playerHealthBar: AssetSuperclass;
		private var playerNameText: PlayerNameText;

		// ---------------------------------------
		
		// ARMYS
		
		private var tilesArmy: Array;
		private var enemyArmy: Array;
		private var weaponArmy: Array;
		private var particleArmy: Array;
		private var petArmy: Array;
		
		// ---------------------------------------

		public function PlayScreen(scaled: Number, scaled2: Number, screenW: int, screenH: int) {

			super(scaled * 0.6, scaled2, screenW, screenH);
			init();
		}
		
		public function init(): void {

			characterSelector = new CharacterSelector(scaled, scaled, screenW, screenH);
			characterSelector.addEventListener(CharacterSelectorEvent.CHARACTER_SELECTED, characterSelected, false, 0, true);
			addChild(characterSelector);
		}

		private function characterSelected(event: CharacterSelectorEvent): void {

			playerKit = characterSelector.getPlayerKit();

			characterSelector.removeEventListener(CharacterSelectorEvent.CHARACTER_SELECTED, characterSelected, false);
			removeChild(characterSelector);

			canLoadContent = true;

			addContent();
			adjustContent();
			addListeners();
		}

		override public function initializeVariables(): void {
			
			// Utils.
			
			playerKit = "Hory";
			primaryAttack = false;
			
			shake = new Shake(2 * scaled2);

			mapSize = 21;
			waterSize = 1;
			waterSize2 = waterSize + 1;
			
			// Armys.
			
			tilesArmy = new Array();
			enemyArmy = new Array();
			weaponArmy = new Array();
			particleArmy = new Array();
			petArmy = new Array();

			var array: Array = [
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
			];
		}

		override public function addContent(): void {
			
			if (!canLoadContent) return;
			
			
			loadMap();

			player = new Player(scaled, scaled2, playerKit);
			addChild(player);
			
			screenDamage = new BackgroundSuperclass(screenW, screenH, new ScreenDamage);
			addChild(screenDamage);

			joystick = new Joystick(scaled * 1.2, screenW, screenH, new JoystickBG, new JoystickAnalog, new JoystickArea);
			addChild(joystick);
			
			primaryAttackBtn = new AssetSuperclass(scaled * 1.2, new PrimaryAttackBtn);
			addChild(primaryAttackBtn);

			abilityBtn = new AssetSuperclass(scaled * 1.2, new AbilityBtn);
			addChild(abilityBtn);

			abilityReloadingBarContainer = new AssetSuperclass(scaled * 1.2, new AbilityReloadingBarContainer);
			addChild(abilityReloadingBarContainer);

			abilityReloadingBar = new AssetSuperclass(scaled * 1.2, new AbilityReloadingBar);
			addChild(abilityReloadingBar);

			abilityReloadingText = new AbilityReloadingText();
			abilityReloadingText.scaleX = scaled * 1.2;
			abilityReloadingText.scaleY = scaled * 1.2;
			addChild(abilityReloadingText);
			
			playerCard = new Card(scaled * 1.2, playerKit);
			addChild(playerCard);

			playerHealthBarContainer = new AssetSuperclass(scaled * 1.2, new PlayerHealthBarContainer);
			addChild(playerHealthBarContainer);

			playerHealthBar = new AssetSuperclass(scaled * 1.2, new PlayerHealthBar);
			addChild(playerHealthBar);

			playerNameText = new PlayerNameText();
			playerNameText.scaleX = scaled * 1.2;
			playerNameText.scaleY = scaled * 1.2;
			addChild(playerNameText);

			playerNameText.texto.text = "~ " + playerKit;
		}

		override public function adjustContent(): void {
			
			if (!canLoadContent) return;
			

			player.x = screenW / 2;
			player.y = screenH / 2;
			
			screenDamage.x = 0 - screenDamage.width;
			screenDamage.y = 0;

			joystick.setStartPos(0 + joystick.joystickBG.width, screenH - joystick.joystickBG.height);
			
			primaryAttackBtn.x = screenW - primaryAttackBtn.width * 2;
			primaryAttackBtn.y = screenH - primaryAttackBtn.height * 2;

			abilityBtn.x = screenW - abilityBtn.width * 3;
			abilityBtn.y = screenH - abilityBtn.height * 3;

			abilityPosX = abilityBtn.x;

			abilityReloadingBarContainer.x = 0 - abilityReloadingBarContainer.width;
			abilityReloadingBarContainer.y = abilityBtn.y;

			abilityReloadingBar.x = 0 - abilityReloadingBar.width;
			abilityReloadingBar.y = abilityBtn.y;

			abilityReloadingText.x = 0 - abilityReloadingText.width;
			abilityReloadingText.y = abilityBtn.y - abilityReloadingText.height * 1.5;
			
			playerCard.x = 0 + playerCard.width;
			playerCard.y = 0 + playerCard.height;

			playerHealthBarContainer.x = playerCard.x + playerHealthBarContainer.width;
			playerHealthBarContainer.y = playerCard.y - playerHealthBarContainer.height / 2;

			playerHealthBar.x = playerHealthBarContainer.x;
			playerHealthBar.y = playerHealthBarContainer.y;

			playerNameText.x = playerCard.x - playerCard.width / 2 + playerNameText.width;
			playerNameText.y = playerHealthBarContainer.y + playerHealthBarContainer.height / 2 + playerNameText.height / 2;
		}

		override public function addListeners(): void {
			
			if (!canLoadContent) return;
			

			addEventListener(Event.ENTER_FRAME, gameLoop, false, 0, true);
			
			primaryAttackBtn.addEventListener(TouchEvent.TOUCH_BEGIN, primaryAttackClicked, false, 0, true);
			primaryAttackBtn.addEventListener(TouchEvent.TOUCH_END, primaryAttackUnclicked, false, 0, true);
			primaryAttackBtn.addEventListener(TouchEvent.TOUCH_OUT, primaryAttackUnclicked, false, 0, true);

			abilityBtn.addEventListener(TouchEvent.TOUCH_BEGIN, abilityClicked, false, 0, true);
		}

		override public function removeListeners(): void {

			removeEventListener(Event.ENTER_FRAME, gameLoop, false);
			
			primaryAttackBtn.removeEventListener(TouchEvent.TOUCH_BEGIN, primaryAttackClicked, false);
			primaryAttackBtn.removeEventListener(TouchEvent.TOUCH_END, primaryAttackUnclicked, false);
			primaryAttackBtn.removeEventListener(TouchEvent.TOUCH_OUT, primaryAttackUnclicked, false);

			abilityBtn.removeEventListener(TouchEvent.TOUCH_BEGIN, abilityClicked, false);
		}

		private function loadMap(): void {

			loadTiles();
			adjustTilesPosition();
		}

		private function loadTiles(): void {

			var tile: Tile;

			for (var i: int = 0; i < mapSize; i++) {

				var array: Array = new Array();

				for (var j: int = 0; j < mapSize; j++) {

					if (i > waterSize - 1 && i < mapSize + 1 - waterSize2 && j > waterSize - 1 && j < mapSize + 1 - waterSize2) {

						tile = new Tile(scaled, "Ground");

					} else {

						tile = new Tile(scaled, "Water");
					}

					addChild(tile);
					array.push(tile);

					tile.x = (screenW / 2) + (tile.width * i);
					tile.y = (screenH / 2) + (tile.height * j);

					tile.addEventListener(MouseEvent.CLICK, tileClicked, false, 0, true);
				}

				tilesArmy.push(array);
			}
		}

		private function adjustTilesPosition(): void {

			var tile: Tile;

			for (var i: int = 0; i < tilesArmy.length; i++) {

				for (var j: int = 0; j < tilesArmy[i].length; j++) {

					tile = tilesArmy[i][j];

					tile.x -= tile.width * tilesArmy.length / 2;
					tile.y -= tile.height * tilesArmy.length / 2;

					tile.x += tile.width / 2;
					tile.y += tile.height / 2;
				}
			}
		}

		private function tileClicked(event: MouseEvent): void {

			var tile: Sprite = event.target as Sprite;
			var index: int = tilesArmy.indexOf(tile);

			trace(tile.x);
			trace(tile.y);
		}
		
		// ---------------------------------------
		
		// GAME LOOP
		
		private function gameLoop(event: Event): void {

			// Joystick functionality.

			joystick.tick();
			
			// Controller.
			
			playerController();
			movementController();
			enemyController();
			weaponController();
			petController();
			particleController();
			shakeController();
			
			// Collisions.
			
			checkPlayerAndEnemiesCollisions();
			checkWeaponsAndEnemiesCollisions();
			checkPetsAndEnemiesCollisions();
			
			// Draw order.
			
			drawOrder();
			
			// Game Over.
			
			gameOver();
		}
		
		// ---------------------------------------
		
		// PLAYER CONTROLLER
		
		private function playerController(): void {
			
			// This code will move in aceleration and desaceleration based on joystick movement and if its touched or no.
			
			if (joystick.getJoystickIsClicked) {
				
				player.move(true, joystick.getDirX);
				
			} else {
				
				player.move(false, joystick.getDirX);
			}
			
			// This code will check player primary attack and ability functionality.
			
			playerPrimaryAttack();
			playerAbility();
		}
		
		private function playerPrimaryAttack(): void {
			
			// This code will check fi the player can attack.

			player.attackTick();

			if (enemyArmy.length == 0) return;

			if (primaryAttack) {

				if (player.attackCheck()) {

					var pos: int = CircularCollision.getClosestObject(0, player, enemyArmy);

					var angle: Number = Math.atan2(player.y - enemyArmy[pos].y, player.x - enemyArmy[pos].x);

					var weapon: Weapon = new Weapon(scaled, scaled2, angle, "Bullet", player.getAttack, player.getWeaponMovementSpeed, player.getWeaponFlyingTime);
					addChild(weapon);
					weaponArmy.push(weapon);

					weapon.x = player.x;
					weapon.y = player.y;
				}
			}
		}

		private function playerAbility(): void {
			
			// This code will check if the player can trigger its ability. 
			// It also display a cooldown UI when the ability is not ready.

			// ---------------------------------------

			player.abilityTick();

			// ---------------------------------------

			// - Here the cooldown bar and text will appear in case the ability was triggered.
			// - Button will be removed too.

			if (player.abilityCheck()) {

				abilityReloadingBarContainer.x = 0 - abilityReloadingBarContainer.width;
				abilityReloadingBar.x = 0 - abilityReloadingBar.width;
				abilityReloadingText.x = 0 - abilityReloadingText.width;

				abilityBtn.x = screenW - abilityBtn.width * 3;

			} else {

				abilityReloadingBar.scaleX = player.getAbilityCooldown / player.getAbilityCooldownOriginalValue;

				abilityReloadingBarContainer.x = abilityPosX;
				abilityReloadingBar.x = abilityPosX;
				abilityReloadingText.x = abilityPosX;

				abilityBtn.x = 0 - abilityBtn.width;
			}
		}
		
		// ---------------------------------------
		
		// MOVEMENT CONTROLLER
		
		private function movementController(): void {
			
			// This function will move all content on screen when the player moves.
			
			movementTile();
			movementEnemy();
			movementWeapon();
			movementPet();
			movementParticle();
		}
		
		private function movementTile(): void {
			
			// This function move all tiles and check if the player is not hitting a ground tile, so it means Game Over.
			
			var tile: Tile;
			var array: Array = new Array();
			var isPlayerOnGround: Boolean = false;

			for (var i: int = 0; i < tilesArmy.length; i++) {

				for (var j: int = 0; j < tilesArmy[i].length; j++) {

					tile = tilesArmy[i][j];
					
					// Here, the code creates an array with all tiles hitted by the player.
					
					if (CircularCollision.circularHitTestObject(player, tile)) array.push(tile);
					
					if (player.getKnockback) {
						
						tile.x -= Math.cos(player.getKnockbackAngle) * player.getKnockbackSpeed;
						tile.y -= Math.sin(player.getKnockbackAngle) * player.getKnockbackSpeed;
						
					} else {
						
						tile.x += joystick.getDirX * player.movementSpeed;
						tile.y += joystick.getDirY * player.movementSpeed;
					}
				}
			}
			
			// Here, the code will check that at least one tile is Ground-Type, which it means the player is alive.
			// The code stops when it finds a Ground-Type tile.
			
			for (var k: int = 0; k < array.length; k++) {
				
				tile = array[k];
				
				if (tile.getTileName == "Ground") {
					
					isPlayerOnGround = true;
					break;
				}				
			}
			
			if (!isPlayerOnGround) player.setMustDelete = true;
		}
		
		private function movementEnemy(): void {
			
			var enemy: Enemy;
			
			for (var i: int = 0; i < enemyArmy.length; i++) {
				
				enemy = enemyArmy[i];
				
				if (player.getKnockback) {
					
					enemy.x -= Math.cos(player.getKnockbackAngle) * player.getKnockbackSpeed;
					enemy.y -= Math.sin(player.getKnockbackAngle) * player.getKnockbackSpeed;
					
				} else {
					
					enemy.x += joystick.getDirX * player.movementSpeed;
					enemy.y += joystick.getDirY * player.movementSpeed;
				}
			}
		}
		
		private function movementWeapon(): void {
			
			var weapon: Weapon;
			
			for (var i: int = 0; i < weaponArmy.length; i++) {
				
				weapon = weaponArmy[i];
				
				weapon.x += joystick.getDirX * player.movementSpeed;
				weapon.y += joystick.getDirY * player.movementSpeed;
			}
		}
		
		private function movementPet(): void {
			
			var pet: Pet;
			
			for (var i: int = 0; i < petArmy.length; i++) {
				
				pet = petArmy[i];
				
				pet.x += joystick.getDirX * player.movementSpeed;
				pet.y += joystick.getDirY * player.movementSpeed;
			}
		}
		
		private function movementParticle(): void {
			
			var particle: Particle;
			
			for (var i: int = 0; i < particleArmy.length; i++) {
				
				particle = particleArmy[i];
				
				particle.x += joystick.getDirX * player.movementSpeed;
				particle.y += joystick.getDirY * player.movementSpeed;
			}
		}
		
		// ---------------------------------------
		
		// ENEMY CONTROLLER

		private function enemyController(): void {

			enemySpawn();
			enemyMovement();
			enemyRemove();
		}
		
		private function enemySpawn(): void {

			if (enemyArmy.length > 0) return;

			for (var i: int = 0; i < 2; i++) {

				var enemy: Enemy = new Enemy(scaled, scaled2, "Scarecrow");
				addChild(enemy);
				enemyArmy.push(enemy);

				// enemy.x = screenW / 2;
				// enemy.y = screenH / 2;

				do {

					enemy.x = Math.random() * screenW;
					enemy.y = Math.random() * screenH;

				} while (CircularCollision.distanceNumber(player, enemy) < 250 * scaled);

				particleAdd(enemy.x, enemy.y, "ParticleSpawn");
			}
		}

		private function enemyMovement(): void {

			var enemy: Enemy;

			for (var i: int = 0; i < enemyArmy.length; i++) {

				enemy = enemyArmy[i];

				var angle: Number = Math.atan2(enemy.y - player.y, enemy.x - player.x);

				enemy.move(angle);
			}
		}

		private function enemyRemove(): void {

			var enemy: Enemy;
			var i: int = enemyArmy.length - 1;

			while (i > -1) {

				enemy = enemyArmy[i];

				if (enemy.getMustDelete) {

					removeChild(enemy);
					enemyArmy.splice(i, 1);
				}

				i--;
			}
		}
		
		// ---------------------------------------

		// WEAPON CONTROLLER

		private function weaponController(): void {

			weaponMovement();
			weaponRemove();
		}

		private function weaponMovement(): void {

			var weapon: Weapon;

			for (var i: int = 0; i < weaponArmy.length; i++) {

				weapon = weaponArmy[i];

				weapon.move();
			}
		}

		private function weaponRemove(): void {

			var weapon: Weapon;
			var i: int = weaponArmy.length - 1;

			while (i > -1) {

				weapon = weaponArmy[i];

				if (weapon.getMustDelete) {

					if (weapon.getWeaponName == "Sselya") {

						var weapon2: Weapon = new Weapon(scaled, scaled2, 0, "SselyaSplash", player.getAttack, player.getWeaponMovementSpeed, player.getWeaponFlyingTime);
						addChild(weapon2);
						weaponArmy.push(weapon2);

						weapon2.x = weapon.x;
						weapon2.y = weapon.y;
					}

					removeChild(weapon);
					weaponArmy.splice(i, 1);
				}

				i--;
			}
		}
		
		// ---------------------------------------

		// PET CONTROLLER

		private function petController(): void {

			petMovement();
			petRemove();
		}

		private function petSpawn(): void {

			var pet: Pet = new Pet(scaled, scaled2);
			addChild(pet);
			petArmy.push(pet);

			pet.x = player.x;
			pet.y = player.y;

			particleAdd(pet.x, pet.y, "ParticleSpawn");
		}

		private function petMovement(): void {

			if (enemyArmy.length == 0) return;

			var pet: Pet;
			var pos: int = CircularCollision.getClosestObject(0, player, enemyArmy);

			for (var i: int = 0; i < petArmy.length; i++) {

				pet = petArmy[i];

				var angle: Number = Math.atan2(pet.y - enemyArmy[pos].y, pet.x - enemyArmy[pos].x);

				pet.move(angle);
			}
		}

		private function petRemove(): void {

			var pet: Pet;
			var i: int = petArmy.length - 1;

			while (i > -1) {

				pet = petArmy[i];

				if (pet.getMustDelete) {

					removeChild(pet);
					petArmy.splice(i, 1);
				}

				i--;
			}
		}
		
		// ---------------------------------------
		
		// PARTICLE CONTROLLER
		
		private function particleController(): void {

			particleTick();
			particleMovement();
			particleRemove();
		}

		private function particleAdd(posX: int, posY: int, particleName: String): void {

			var random: Number = 5 + Math.ceil(Math.random() * 5);

			for (var i: int = 0; i < random; i++) {

				var particle: Particle = new Particle(scaled, scaled2, particleName);
				addChild(particle);
				particleArmy.push(particle);

				particle.x = posX;
				particle.y = posY;
			}
		}

		private function particleTick(): void {

			var enemy: Enemy;

			for (var i: int = 0; i < enemyArmy.length; i++) {

				enemy = enemyArmy[i];

				if (enemy.getPoisoned && enemy.getPoisonedDuration % 60 == 0) {

					particleAdd(enemy.x, enemy.y, "ParticlePoison");
				}

				if (enemy.getStunned && enemy.getStunnedDuration % 30 == 0) {

					particleAdd(enemy.x, enemy.y, "ParticleStun");
				}

				if (enemy.getSlowed && enemy.getSlowedDuration % 30 == 0) {

					particleAdd(enemy.x, enemy.y, "ParticleSlow");
				}
			}
		}

		private function particleMovement(): void {

			var particle: Particle;

			for (var i: int = 0; i < particleArmy.length; i++) {

				particle = particleArmy[i];

				particle.move();
			}
		}

		private function particleRemove(): void {

			var particle: Particle;
			var i: int = particleArmy.length - 1;

			while (i > -1) {

				particle = particleArmy[i];

				if (particle.getMustDelete()) {

					removeChild(particle);
					particleArmy.splice(i, 1);
				}

				i--;
			}
		}
		
		// ---------------------------------------

		// SHAKE CONTROLLER

		private function shakeController(): void {

			if (player.getKnockback) {

				shake.shakeTick(this);
				screenDamage.x = 0;

			} else {

				screenDamage.x = 0 - screenDamage.width;
			}
		}
		
		// ---------------------------------------

		// COLLISIONS

		private function checkPlayerAndEnemiesCollisions(): void {

			var enemy: Enemy;

			for (var i: int = 0; i < enemyArmy.length; i++) {

				enemy = enemyArmy[i];

				if (CircularCollision.circularHitTestObject(player, enemy)) {

					var angle: Number = Math.atan2(player.y - enemy.y, player.x - enemy.x);

					player.addKnockback(angle, 4);
					player.setHealth = player.getHealth - (enemy.getAttack - 1 * player.getDefense);

					playerHealthBar.scaleX = player.getHealth / player.getHealthOriginalValue;

					particleAdd(player.x, player.y, "ParticleDamage");
				}
			}
		}

		private function checkWeaponsAndEnemiesCollisions(): void {

			var enemy: Enemy;
			var weapon: Weapon;
			var angle: Number;

			for (var i: int = 0; i < weaponArmy.length; i++) {

				weapon = weaponArmy[i];

				for (var j: int = 0; j < enemyArmy.length; j++) {

					enemy = enemyArmy[j];

					if (CircularCollision.circularHitTestObject(weapon, enemy) && !weapon.getMustDelete && weapon.getCanDealDamage) {

						if (weapon.getThrowingWeapon) weapon.setMustDelete = true;
						weapon.setPierce = weapon.getPierce - 1;

						enemy.setHealth = enemy.getHealth - (player.getAttack - 1 * enemy.getDefense);

						particleAdd(enemy.x, enemy.y, "ParticleDamage");

						angle = Math.atan2(player.y - enemy.y, player.x - enemy.x);

						weaponBehavior(angle, weapon, enemy);
					}
				}

				if (weapon.getPierce < weapon.getPierceOriginalValue) weapon.setCanDealDamage = false;
			}
		}

		private function weaponBehavior(angle: Number, weapon: Weapon, enemy: Enemy): void {

			// ---------------------------------------

			// BEHAVIOR TO ALL WEAPONS

			if (weapon.getWeaponName == "Amy") amyWeaponBehavior(angle, weapon, enemy);

			if (weapon.getWeaponName == "Artemis") artemisWeaponBehavior(angle, weapon, enemy);

			if (weapon.getWeaponName == "Hory") horyWeaponBehavior();

			if (weapon.getWeaponName == "Lucy") lucyWeaponBehavior();

			if (weapon.getWeaponName == "Neal") nealWeaponBehavior();

			if (weapon.getWeaponName == "Ring") ringWeaponBehavior(angle, enemy);

			if (weapon.getWeaponName == "Sselya") sselyaWeaponBehavior();

			if (weapon.getWeaponName == "SselyaSplash") sselyaSplashWeaponBehavior(angle, weapon, enemy);

			if (weapon.getWeaponName == "Valeey") valeeyWeaponBehavior(angle, weapon, enemy);

			// ---------------------------------------
		}

		private function amyWeaponBehavior(angle: Number, weapon: Weapon, enemy: Enemy): void {

			// Knockback and slow.

			enemy.addKnockback(angle, 6);
			enemy.addSlowed(120, 0.5);

			particleAdd(enemy.x, enemy.y, "ParticleSlow");
		}

		private function artemisWeaponBehavior(angle: Number, weapon: Weapon, enemy: Enemy): void {

			// Knockback and x3 damage to first target.

			if (weapon.getPierce + 1 == weapon.getPierceOriginalValue) {

				enemy.setHealth = enemy.getHealth - (player.getAttack - 1 * enemy.getDefense);
				enemy.setHealth = enemy.getHealth - (player.getAttack - 1 * enemy.getDefense);
			}

			enemy.addKnockback(angle, 4);
		}

		private function horyWeaponBehavior(): void {

			// No behavior.
		}

		private function lucyWeaponBehavior(): void {

			// No behavior.
		}

		private function nealWeaponBehavior(): void {

			// No behavior.
		}

		private function ringWeaponBehavior(angle: Number, enemy: Enemy): void {

			// Knockback.

			enemy.addKnockback(angle, 4);
		}

		private function sselyaWeaponBehavior(): void {

			// No behavior.
		}

		private function sselyaSplashWeaponBehavior(angle: Number, weapon: Weapon, enemy: Enemy): void {

			// Slow.

			enemy.addSlowed(120, 0.3);

			particleAdd(enemy.x, enemy.y, "ParticleSlow");
		}

		private function valeeyWeaponBehavior(angle: Number, weapon: Weapon, enemy: Enemy): void {

			// Knockback and poison.

			enemy.addPoisoned(300, 0.5);
			enemy.addKnockback(angle, 2);

			particleAdd(enemy.x, enemy.y, "ParticlePoison");
		}

		private function checkPetsAndEnemiesCollisions(): void {

			var pet: Pet;
			var enemy: Enemy;
			var angle: Number;

			for (var i: int = 0; i < enemyArmy.length; i++) {

				enemy = enemyArmy[i];

				for (var j: int = 0; j < petArmy.length; j++) {

					pet = petArmy[j];

					if (CircularCollision.circularHitTestObject(pet, enemy)) {

						angle = Math.atan2(pet.y - enemy.y, pet.x - enemy.x);

						enemy.setHealth = enemy.getHealth - (pet.getAttack - 1 * enemy.getDefense);
						enemy.addKnockback(angle, 4);

						pet.setHealth = pet.getHealth - (enemy.getAttack - 1 * pet.getDefense);
						if (pet.getHealth <= 0) pet.setMustDelete = true;

						particleAdd(enemy.x, enemy.y, "ParticleDamage");
					}
				}
			}
		}
		
		// ---------------------------------------
		
		// DRAW ORDER
		
		private function drawOrder(): void {

			entitiesOrder();
			weaponsOrder();
			particlesOrder();
			drawOrderUI();
		}

		private function entitiesOrder(): void {

			// ---------------------------------------

			// VARIABLES

			var entities: Array = new Array();
			var entitiesPosY: Array = new Array();
			var enemy: Enemy;
			var pet: Pet;

			// ---------------------------------------

			// FILL ENTITIES ARRAY WITH ALL ENTITIES

			entities.push(player);

			for (var i: int = 0; i < enemyArmy.length; i++) {

				enemy = enemyArmy[i];

				entities.push(enemy);
			}

			for (var j: int = 0; j < petArmy.length; j++) {

				pet = petArmy[j];

				entities.push(pet);
			}

			// ---------------------------------------

			// Fill entitiesPosY array with all entities and sort them.

			for (var k: int = 0; k < entities.length; k++) {

				entitiesPosY.push(entities[k].y);
			}

			entitiesPosY.sort(Array.NUMERIC);

			// ---------------------------------------

			// Drawing order.

			for (var l: int = 0; l < entitiesPosY.length; l++) {

				for (var m: int = 0; m < entities.length; m++) {

					if (entitiesPosY[l] == entities[m].y) {

						this.setChildIndex(entities[m], this.numChildren - 1);
					}
				}
			}

			// ---------------------------------------
		}

		private function weaponsOrder(): void {

			var weapon: Weapon;

			for (var i: int = 0; i < weaponArmy.length; i++) {

				weapon = weaponArmy[i];

				this.setChildIndex(weapon, this.numChildren - 1);
			}
		}

		private function particlesOrder(): void {

			var particle: Particle;

			for (var i: int = 0; i < particleArmy.length; i++) {

				particle = particleArmy[i];

				this.setChildIndex(particle, this.numChildren - 1);
			}
		}

		private function drawOrderUI(): void {

			this.setChildIndex(screenDamage, this.numChildren - 1);

			this.setChildIndex(joystick, this.numChildren - 1);

			this.setChildIndex(primaryAttackBtn, this.numChildren - 1);
			this.setChildIndex(abilityBtn, this.numChildren - 1);

			this.setChildIndex(abilityReloadingBarContainer, this.numChildren - 1);
			this.setChildIndex(abilityReloadingBar, this.numChildren - 1);
			this.setChildIndex(abilityReloadingText, this.numChildren - 1);

			this.setChildIndex(playerCard, this.numChildren - 1);
			this.setChildIndex(playerHealthBarContainer, this.numChildren - 1);
			this.setChildIndex(playerHealthBar, this.numChildren - 1);
			this.setChildIndex(playerNameText, this.numChildren - 1);
		}
		
		// ---------------------------------------
		
		// GAME OVER
		
		private function gameOver(): void {
			
			if (player.getMustDelete) {
				
				removeListeners();
			}
		}
		
		// ---------------------------------------
		
		// PRIMARY ATTACK

		private function primaryAttackClicked(event: TouchEvent): void {

			primaryAttack = true;
		}

		private function primaryAttackUnclicked(event: TouchEvent): void {

			primaryAttack = false;
		}
		
		// ---------------------------------------
		
		// ABILITY ATTACK
		
		private function abilityClicked(event: TouchEvent): void {

			// ---------------------------------------

			if (enemyArmy.length == 0) return;

			// ---------------------------------------

			if (!player.abilityTry()) return;

			// ---------------------------------------

			if (playerKit == "Amy") amyAbility();

			if (playerKit == "Artemis") artemisAbility();

			if (playerKit == "Hory") horyAbility();

			if (playerKit == "Lucy") lucyAbility();

			if (playerKit == "Neal") nealAbility();

			if (playerKit == "Ring") ringAbility();

			if (playerKit == "Sselya") sselyaAbility();

			if (playerKit == "Valeey") valeeyAbility();

			// ---------------------------------------
		}

		private function amyAbility(): void {

			var pos: int = CircularCollision.getClosestObject(0, player, enemyArmy);

			var angle: Number = Math.atan2(player.y - enemyArmy[pos].y, player.x - enemyArmy[pos].x);

			var weapon: Weapon = new Weapon(scaled, scaled2, angle, playerKit, player.getAttack, player.getWeaponMovementSpeed, player.getWeaponFlyingTime);
			addChild(weapon);
			weaponArmy.push(weapon);

			weapon.setStartingPosition(player, 60);
		}

		private function artemisAbility(): void {

			var pos: int = CircularCollision.getClosestObject(0, player, enemyArmy);

			var angle: Number = Math.atan2(player.y - enemyArmy[pos].y, player.x - enemyArmy[pos].x);

			var weapon: Weapon = new Weapon(scaled, scaled2, angle, playerKit, player.getAttack, player.getWeaponMovementSpeed, player.getWeaponFlyingTime);
			addChild(weapon);
			weaponArmy.push(weapon);

			weapon.setStartingPosition(player, 30);
		}

		private function horyAbility(): void {

			var pet: Pet;

			if (petArmy.length >= 1) {

				pet = petArmy[0];

				pet.x = player.x;
				pet.y = player.y;

				particleAdd(pet.x, pet.y, "ParticleSpawn");

				return;
			}

			petSpawn();
		}

		private function lucyAbility(): void {

			var enemy: Enemy;
			var angle: Number;

			for (var i: int = 0; i < enemyArmy.length; i++) {

				enemy = enemyArmy[i];
				enemy.addPoisoned(300, 0.5);
				enemy.addStunned(120);

				angle = Math.atan2(player.y - enemy.y, player.x - enemy.x);

				var weapon: Weapon = new Weapon(scaled, scaled2, angle, playerKit, player.getAttack, player.getWeaponMovementSpeed, player.getWeaponFlyingTime);
				addChild(weapon);
				weaponArmy.push(weapon);

				weapon.x = enemy.x;
				weapon.y = enemy.y - enemy.height;

				particleAdd(enemy.x, enemy.y, "ParticleStun");
			}
		}

		private function nealAbility(): void {

			var knifesAmount: int = 20;
			var angleDiff: Number = 360 / knifesAmount;
			var angle: Number;

			for (var i: int = 0; i < knifesAmount; i++) {

				angle = (angleDiff * Math.PI / 180) * i;

				var weapon: Weapon = new Weapon(scaled, scaled2, angle, playerKit, player.getAttack, player.getWeaponMovementSpeed, player.getWeaponFlyingTime);
				addChild(weapon);
				weaponArmy.push(weapon);

				weapon.x = player.x;
				weapon.y = player.y;
			}
		}

		private function ringAbility(): void {

			var pos: int = CircularCollision.getClosestObject(0, player, enemyArmy);

			var spikesAmount: int = 5;
			var angleDiff: Number = Math.atan2(player.y - enemyArmy[pos].y, player.x - enemyArmy[pos].x);
			var weaponAngleDistance: int = 5;
			var angle: Number;

			for (var k: int = 0; k < spikesAmount; k++) {

				angle = angleDiff / Math.PI * 180;
				angle -= k * weaponAngleDistance - ((spikesAmount - 1) * weaponAngleDistance) / 2;
				angle = angle / 180 * Math.PI;

				var weapon: Weapon = new Weapon(scaled, scaled2, angle, playerKit, player.getAttack, player.getWeaponMovementSpeed, player.getWeaponFlyingTime);
				addChild(weapon);
				weaponArmy.push(weapon);

				weapon.x = player.x;
				weapon.y = player.y;
			}

			// ---------------------------------------
		}

		private function sselyaAbility(): void {

			if (enemyArmy.length == 0) return;

			var pos: int;
			var angle: Number;

			for (var i: int = 0; i < enemyArmy.length; i++) {

				if (i >= 3) return;

				pos = CircularCollision.getClosestObject(i, player, enemyArmy);
				angle = Math.atan2(player.y - enemyArmy[pos].y, player.x - enemyArmy[pos].x);

				var weapon: Weapon = new Weapon(scaled, scaled2, angle, playerKit, player.getAttack, player.getWeaponMovementSpeed, player.getWeaponFlyingTime);
				addChild(weapon);
				weaponArmy.push(weapon);

				weapon.x = player.x;
				weapon.y = player.y;
			}
		}

		private function valeeyAbility(): void {

			if (enemyArmy.length == 0) return;

			var pos: int;
			var angle: Number;

			for (var i: int = 0; i < enemyArmy.length; i++) {

				if (i >= 2) return;

				pos = CircularCollision.getClosestObject(i, player, enemyArmy);
				angle = Math.atan2(player.y - enemyArmy[pos].y, player.x - enemyArmy[pos].x);

				var weapon: Weapon = new Weapon(scaled, scaled2, angle, playerKit, player.getAttack, player.getWeaponMovementSpeed, player.getWeaponFlyingTime);
				addChild(weapon);
				weaponArmy.push(weapon);

				weapon.x = player.x;
				weapon.y = player.y;
			}
		}

		// ---------------------------------------
	

	}
}