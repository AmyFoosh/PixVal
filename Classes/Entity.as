package {

	import flash.display.Sprite;

	public class Entity extends Sprite {

		// ---------------------------------------

		// UTILS

		public var scaled: Number;
		public var scaled2: Number;
		public var mustDelete: Boolean;

		// ---------------------------------------

		// DISPLAY

		public var display;

		// ---------------------------------------

		// STATS

		public var health: Number;
		public var healthOriginalValue: Number;

		public var attack: Number;
		public var attackOriginalValue: Number;

		public var defense: Number;
		public var defenseOriginalValue: Number;

		public var movementSpeed: Number;
		public var movementSpeedOriginalValue: Number;
		public var movementSpeedIncrement: Number;

		// ---------------------------------------

		// STATUS EFFECT

		// Knockback.

		public var knockback: Boolean;
		public var knockbackAngle: Number;
		public var knockbackSpeed: Number;
		public var knockbackSpeedIncrement: Number;

		// Slowed.

		public var slowed: Boolean;
		public var slowedDuration: int;
		public var slowedAmount: Number;

		// Poisoned.

		public var poisoned: Boolean;
		public var poisonedDuration: int;
		public var poisonedAmount: Number;

		// Stunned.

		public var stunned: Boolean;
		public var stunnedDuration: int;

		// ---------------------------------------

		public function Entity(scaled: Number, scaled2: Number) {

			mustDelete = false;
			slowedAmount = 0;

			this.scaled = scaled;
			this.scaled2 = scaled2;
		}

		// ---------------------------------------

		// UTILS

		public function tickDebuffs(): void {
			
			tickPoison();
			tickStun();
			
			if (stunned) return;
			
			tickKnockback();
			tickSlowed();
		}
		
		public function tickPoison(): void {
			
			// POISONED

			if (poisoned) {

				if (poisonedDuration % 60 == 0) {

					health -= poisonedAmount;
					if (health <= 0) mustDelete = true;
				}

				poisonedDuration--;

				if (poisonedDuration <= 0) poisoned = false;
			}
		}
		
		public function tickStun(): void {
			
			// STUN

			if (stunned) {

				stunnedDuration--;

				if (stunnedDuration <= 0) stunned = false;
			}
		}
		
		public function tickKnockback(): void {
			
				if (knockback) {

				knockbackSpeed -= knockbackSpeedIncrement;

				x -= Math.cos(knockbackAngle) * knockbackSpeed;
				y -= Math.sin(knockbackAngle) * knockbackSpeed;

				if (knockbackSpeed <= 0) {

					movementSpeed = 0;
					knockback = false;
				}
			}
		}
		
		private function tickSlowed(): void {
			
			// SLOWED

			if (slowed) {

				slowedDuration--;

				if (slowedDuration <= 0) {

					slowedAmount = 0;
					slowed = false;
				}
			}
		}

		public function addKnockback(angle: Number, speed: Number): void {

			knockback = true;
			knockbackAngle = angle;
			knockbackSpeed = speed * scaled2;
			knockbackSpeedIncrement = 0.25 * scaled2;
		}

		public function addSlowed(duration: int, amount: Number): void {

			slowed = true;
			slowedDuration = duration;
			slowedAmount = amount;
		}

		public function addPoisoned(duration: int, damage: Number): void {

			poisoned = true;
			poisonedDuration = duration;
			poisonedAmount = damage;
		}

		public function addStunned(duration: int): void {

			stunned = true;
			stunnedDuration = duration;
		}

		// ---------------------------------------

		// GET

		// Health.

		public function get getHealth(): Number {

			return health;
		}

		public function get getHealthOriginalValue(): Number {

			return healthOriginalValue;
		}

		// Attack.

		public function get getAttack(): Number {

			return attack;
		}

		public function get getAttackOriginalValue(): Number {

			return attackOriginalValue;
		}

		// Defense.

		public function get getDefense(): Number {

			return defense;
		}

		public function get getDefenseOriginalValue(): Number {

			return defenseOriginalValue;
		}

		// Movement Speed.

		public function get getMovementSpeed(): Number {

			return movementSpeed;
		}

		public function get getMovementSpeedOriginalValue(): Number {

			return movementSpeedOriginalValue;
		}

		public function get getMovementSpeedIncrement(): Number {

			return movementSpeedIncrement;
		}

		// Knockback.

		public function get getKnockback(): Boolean {

			return knockback;
		}

		public function get getKnockbackAngle(): Number {

			return knockbackAngle;
		}

		public function get getKnockbackSpeed(): Number {

			return knockbackSpeed;
		}

		public function get getKnockbackSpeedIncrement(): Number {

			return knockbackSpeedIncrement;
		}

		// Slow.

		public function get getSlowed(): Boolean {

			return slowed;
		}

		public function get getSlowedDuration(): int {

			return slowedDuration;
		}

		public function get getSlowedAmount(): Number {

			return slowedAmount;
		}

		// Poison.

		public function get getPoisoned(): Boolean {

			return poisoned;
		}

		public function get getPoisonedDuration(): int {

			return poisonedDuration;
		}

		public function get getPoisonedAmount(): Number {

			return poisonedAmount;
		}

		// Stun.

		public function get getStunned(): Boolean {

			return stunned;
		}

		public function get getStunnedDuration(): int {

			return stunnedDuration;
		}

		public function get getMustDelete(): Boolean {

			return mustDelete;
		}

		// ---------------------------------------

		// SET

		// Health.

		public function set setHealth(amount: Number): void {

			health = amount;

			if (health <= 0) {

				health = 0;
				mustDelete = true;
			}
		}

		public function set setHealthOriginalValue(amount: Number): void {

			healthOriginalValue = amount;
		}

		// Attack.

		public function set setAttack(amount: Number): void {

			attack = amount;
		}

		public function set setAttackOriginalValue(amount: Number): void {

			attackOriginalValue = amount;
		}

		// Defense.

		public function set setDefense(amount: Number): void {

			defense = amount;
		}

		public function set setDefenseOriginalValue(amount: Number): void {

			defenseOriginalValue = amount;
		}

		// Movement Speed.

		public function set setMovementSpeed(amount: Number): void {

			movementSpeed = amount;
		}

		public function set setMovementSpeedOriginalValue(amount: Number): void {

			movementSpeedOriginalValue = amount;
		}

		public function set setMovementSpeedIncrement(amount: Number): void {

			movementSpeedIncrement = amount;
		}

		// Knockback.

		public function set setKnockback(value: Boolean): void {

			knockback = value;
		}

		public function set setKnockbackAngle(angle: Number): void {

			knockbackAngle = angle;
		}

		public function set setKnockbackSpeed(amount: Number): void {

			knockbackSpeed = amount;
		}

		public function set setKnockbackSpeedIncrement(amount: Number): void {

			knockbackSpeedIncrement = amount;
		}

		// Slow.

		public function set setSlowed(value: Boolean): void {

			slowed = value;
		}

		public function set setSlowedDuration(duration: int): void {

			slowedDuration = duration;
		}

		public function set setSlowedAmount(amount: Number): void {

			slowedAmount = amount;
		}

		// Poison.

		public function set setPoisoned(value: Boolean): void {

			poisoned = value;
		}

		public function set setPoisonedDuration(duration: int): void {

			poisonedDuration = duration;
		}

		public function set setPoisonedAmount(amount: Number): void {

			poisonedAmount = amount;
		}

		// Stun.

		public function set setStunned(value: Boolean): void {

			stunned = value;
		}

		public function set setStunnedDuration(duration: int): void {

			stunnedDuration = duration;
		}

		public function set setMustDelete(value: Boolean): void {

			mustDelete = value;
		}

		// ---------------------------------------



	}
}