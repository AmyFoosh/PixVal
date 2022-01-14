package {

	public class Player extends Entity {

		// ---------------------------------------

		// UTILS

		private var playerName: String;
		private var canAttack: Boolean;

		// Neal passive.

		private var avoidDeath: Boolean;

		// ---------------------------------------

		// STATS

		private var attackSpeed: int;
		private var attackSpeedOriginalValue: int;

		private var weaponMovementSpeed: Number;
		private var weaponFlyingTime: int;

		// ---------------------------------------

		// ABILITY

		private var ability: Boolean;
		private var abilityCooldown: int;
		private var abilityCooldownOriginalValue: int;

		// ---------------------------------------

		// ANIMATION

		private var walking: Boolean;
		private var walkingDirection: String;

		// ---------------------------------------

		public function Player(scaled: Number, scaled2: Number, playerName: String) {

			// ---------------------------------------

			super(scaled, scaled2);

			// ---------------------------------------

			// UTILS

			this.playerName = playerName;
			canAttack = true;

			// ---------------------------------------

			// DISPLAY

			loadDisplay();

			// ---------------------------------------

			// STATS

			loadStartingStats();

			if (playerName == "Ring") defense = 0.2;

			// ---------------------------------------

			// ABILITY

			ability = true;
			abilityCooldown = 240;
			abilityCooldownOriginalValue = abilityCooldown;

			// ---------------------------------------

			// ANIMATION

			walking = false;
			walkingDirection = "";

			// ---------------------------------------
		}

		// ---------------------------------------

		// DISPLAY

		private function loadDisplay(): void {

			switch (playerName) {

				case "Amy":
					display = new Amy();
					break;
				case "Artemis":
					display = new Artemis();
					break;
				case "Hory":
					display = new Hory();
					break;
				case "Lucy":
					display = new Lucy();
					break;
				case "Neal":
					display = new Neal();
					avoidDeath = true;
					break;
				case "Ring":
					display = new Ring();
					break;
				case "Sselya":
					display = new Sselya();
					break;
				case "Valeey":
					display = new Valeey();
					break;
			}

			display.scaleX = scaled;
			display.scaleY = scaled;
			addChild(display);
		}

		// ---------------------------------------

		// STATS

		private function loadStartingStats(): void {

			health = 30000;
			healthOriginalValue = health;

			attack = 1;
			attackOriginalValue = attack;

			defense = 0;
			defenseOriginalValue = defense;

			movementSpeed = 0;
			movementSpeedOriginalValue = 4 * scaled2;
			movementSpeedIncrement = 0.25 * scaled2;

			attackSpeed = 30;
			attackSpeedOriginalValue = attackSpeed;

			weaponMovementSpeed = 8 * scaled2;
			weaponFlyingTime = 60;
		}

		// ---------------------------------------

		// MOVEMENT

		public function move(move: Boolean, dirX: Number): void {

			// ---------------------------------------

			// DEBUFFS

			tickDebuffs();
			
			// ---------------------------------------

			// MOVEMENT

			if (move) {

				walkingAnimation(dirX);

				movementSpeed += movementSpeedIncrement;

				if (movementSpeed > movementSpeedOriginalValue) movementSpeed = movementSpeedOriginalValue;

				// x -= dirX * movementSpeed;
				// y -= dirY * movementSpeed;

			} else {

				if (movementSpeed <= 0) return;

				idleAnimation(dirX);

				movementSpeed -= movementSpeedIncrement;

				if (movementSpeed < 0) movementSpeed = 0;

				// x -= dirX * movementSpeed;
				// y -= dirY * movementSpeed;
			}

			// ---------------------------------------

			// LIMITS

			// playerLimits(ground);

			// ---------------------------------------
		}
		
		override public function tickKnockback(): void {
			
				if (knockback) {

				knockbackSpeed -= knockbackSpeedIncrement;

				if (knockbackSpeed <= 0) {

					movementSpeed = 0;
					knockback = false;
				}
			}
		}

		private function playerLimits(ground: Object): void {

			// X COORD

			if (x < ground.x - ground.width / 2) {

				x = ground.x - ground.width / 2;

			} else if (x > ground.x + ground.width / 2) {

				x = ground.x + ground.width / 2;
			}

			// Y COORD

			if (y < ground.y - ground.height / 2) {

				y = ground.y - ground.height / 2;

			} else if (y > ground.y + ground.height / 2) {

				y = ground.y + ground.height / 2
			}
		}

		// ---------------------------------------

		// ANIMATION

		private function walkingAnimation(dirX: Number): void {

			if (dirX < 0) {

				if (walking && walkingDirection != "Left") return;

				walkingDirection = "Right";
				display.character.gotoAndPlay("WalkingRight34");
			}

			if (dirX > 0) {

				if (walking && walkingDirection != "Right") return;

				walkingDirection = "Left";
				display.character.gotoAndPlay("WalkingLeft34");
			}

			walking = true;
		}

		private function idleAnimation(dirX: Number): void {

			if (dirX < 0) {

				if (!walking && walkingDirection != "Left") return;

				walkingDirection = "Right";
				display.character.gotoAndPlay("IdleRight34");
			}

			if (dirX > 0) {

				if (!walking && walkingDirection != "Right") return;

				walkingDirection = "Left";
				display.character.gotoAndPlay("IdleLeft34");
			}

			walking = false;
		}

		// ---------------------------------------

		// ATTACK

		public function attackTick(): void {

			attackSpeed--;

			if (attackSpeed <= 0) {

				attackSpeed = 0;
				canAttack = true;
			}
		}

		public function attackCheck(): Boolean {

			if (canAttack) {

				attackSpeed = attackSpeedOriginalValue;
				canAttack = false;
				return true;

			} else {

				return false;
			}
		}

		// ---------------------------------------

		// ABILITY

		public function abilityCheck(): Boolean {

			// This will check if we can use ability or no.

			return ability;
		}

		public function abilityTry(): Boolean {

			// This will try to use the ability.

			if (ability) {

				ability = false;
				return true;

			} else {

				return false;
			}
		}

		public function abilityTick(): void {

			// This works as a ability cooldown timer.

			if (!ability) {

				abilityCooldown--;

				if (abilityCooldown <= 0) {

					ability = true;
					abilityCooldown = abilityCooldownOriginalValue;
				}
			}
		}

		// ---------------------------------------

		// GET

		public function get getPlayerName(): String {

			return playerName;
		}

		public function get getAvoidDeath(): Boolean {

			return avoidDeath;
		}

		public function get getWeaponMovementSpeed(): Number {

			return weaponMovementSpeed;
		}

		public function get getWeaponFlyingTime(): int {

			return weaponFlyingTime;
		}

		public function get getAbilityCooldown(): int {

			return abilityCooldown;
		}

		public function get getAbilityCooldownOriginalValue(): int {

			return abilityCooldownOriginalValue;
		}

		// ---------------------------------------

		// SET

		public function set setAvoidDeath(value: Boolean): void {

			avoidDeath = value;
		}

		// ---------------------------------------


	}
}