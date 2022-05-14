package {

	import flash.display.Sprite;

	public class Entity extends Sprite {

		// ---------------------------------------

		// -- UTILS -- 

		public var scaled: Number;
		public var speed: Number;
		public var isDead: Boolean;
		public var canReceiveDamage: Boolean;

		// ---------------------------------------

		// -- STATS --

		public var health: Number;
		
		public var canAttack: Boolean;
		public var attack: Number;
		public var attackSpeed: int;
		public var attackSpeedOriginal: int;
		
		public var defense: Number;

		// ---------------------------------------

		// -- MOVEMENT -- 

		public var movementSpeedCurrent: Number;
		public var movementSpeedIncrement: Number;
		public var movementSpeedMax: Number;
		public var movementSpeedOriginal: Number;

		// ---------------------------------------

		// -- ON WATER --

		public var isOnWater: Boolean;
		public var onWaterCurrentTime: int;
		public var onWaterMaxTime: int;

		// ---------------------------------------

		// -- KNOCKBACK -- 

		public var isKnockbacked: Boolean;
		public var knockbackAngle: Number;
		public var knockbackStrength: Number;
		public var knockbackIncrement: Number;

		// ---------------------------------------

		// -- STUN --

		public var isStunned: Boolean;
		public var stunTimeRemaining: int;

		// ---------------------------------------

		// -- SLOW -- 

		public var isSlowed: Boolean;
		public var slowTimeRemaining: int;
		public var slowAmount: Number;

		// ---------------------------------------

		// -- POISON --

		public var isPoisoned: Boolean;
		public var poisonTimeRemaining: int;
		public var poisonAmount: Number;

		// ---------------------------------------

		public function Entity(scaled: Number, speed: Number) {

			// ---------------------------------------

			// -- UTILS --

			this.scaled = scaled;
			this.speed = speed;
			isDead = false;
			canReceiveDamage = true;

			// ---------------------------------------

			// -- STATS --

			health = 10;
			canAttack = true;
			attack = 1;
			attackSpeed = 30;
			attackSpeedOriginal = attackSpeed;
			defense = 0;

			// ---------------------------------------

			// -- MOVEMENT --

			movementSpeedCurrent = 0;
			movementSpeedIncrement = 0.2 * speed;
			movementSpeedMax = 4 * speed;
			movementSpeedOriginal = movementSpeedMax;

			// ---------------------------------------

			// -- ON WATER --

			isOnWater = false;
			onWaterCurrentTime = 300;
			onWaterMaxTime = onWaterCurrentTime;

			// ---------------------------------------

			// -- KNOCKBACK -- 

			isKnockbacked = false;
			knockbackAngle = 0;
			knockbackStrength = 0;
			knockbackIncrement = 0.5 * speed;

			// ---------------------------------------

			// -- STUN -- 

			isStunned = false;
			stunTimeRemaining = 0;

			// ---------------------------------------

			// -- SLOW --

			isSlowed = false;
			slowTimeRemaining = 0;
			slowAmount = 0;

			// ---------------------------------------

			// -- POISON --

			isPoisoned = false;
			poisonTimeRemaining = 0;
			poisonAmount = 0;

			// ---------------------------------------
		}

		// ---------------------------------------

		// -- MOVEMENT --

		public function move(angle: Number): void {

			if (isKnockbacked) return;
			if (isStunned) return;

			x -= Math.cos(angle) * movementSpeedCurrent;
			y -= Math.sin(angle) * movementSpeedCurrent;

			movementSpeedCurrent += movementSpeedIncrement;

			if (movementSpeedCurrent >= movementSpeedMax) movementSpeedCurrent = movementSpeedMax;
		}

		public function unmove(angle: Number): void {

			if (isKnockbacked) return;
			if (isStunned) return;
			if (movementSpeedCurrent <= 0) return;

			x -= Math.cos(angle) * movementSpeedCurrent;
			y -= Math.sin(angle) * movementSpeedCurrent;

			movementSpeedCurrent -= movementSpeedIncrement;

			if (movementSpeedCurrent <= 0) movementSpeedCurrent = 0;
		}

		// ---------------------------------------

		// -- ON WATER --

		public function onWaterTick(): void {

			// ---------------------------------------

			if (isOnWater) {

				onWaterCurrentTime--;

				if (onWaterCurrentTime <= 0) isDead = true;
			}

			// ---------------------------------------

			if (!isOnWater) {

				onWaterCurrentTime++;

				if (onWaterCurrentTime >= onWaterMaxTime) onWaterCurrentTime = onWaterMaxTime;
			}

			// ---------------------------------------
		}

		// ---------------------------------------

		// -- KNOCKBACK --

		public function addKnockback(angle: Number, strength: Number): void {

			isKnockbacked = true;
			
			if (knockbackStrength <= strength) {
				
				knockbackAngle = angle;
				knockbackStrength = strength * speed;
			}

			movementSpeedCurrent = 0;
		}

		public function knockbackTick(): void {

			if (!isKnockbacked) return;

			x += Math.cos(knockbackAngle) * knockbackStrength;
			y += Math.sin(knockbackAngle) * knockbackStrength;

			knockbackStrength -= knockbackIncrement;

			if (knockbackStrength <= 0) isKnockbacked = false;
		}

		// ---------------------------------------

		// -- STUN -- 

		public function addStun(timeRemaining: int): void {

			isStunned = true;
			
			stunTimeRemaining = timeRemaining;

			movementSpeedCurrent = 0;
		}

		public function stunTick(): void {

			if (isStunned) {

				stunTimeRemaining--;

				if (stunTimeRemaining <= 0) isStunned = false;
			}
		}

		// ---------------------------------------

		// -- SLOW --

		public function addSlow(timeRemaining: int, amount: Number): void {

			isSlowed = true;

			if (slowAmount <= amount) {

				slowTimeRemaining = timeRemaining;
				slowAmount = amount;
			}
		}

		public function slowTick(): void {

			if (isSlowed) {

				slowTimeRemaining--;

				movementSpeedMax = movementSpeedOriginal * (1 - slowAmount);

				if (slowTimeRemaining <= 0) {

					isSlowed = false;
					movementSpeedMax = movementSpeedOriginal;
				}
			}
		}

		// ---------------------------------------

		// -- POISON -- 

		public function addPoison(timeRemaining: int, amount: Number): void {

			isPoisoned = true;

			if (poisonAmount <= amount) {

				poisonTimeRemaining = timeRemaining;
				poisonAmount = amount;
			}
		}

		public function poisonTick(): void {

			if (isPoisoned) {

				if (poisonTimeRemaining % 60 == 0) health -= poisonAmount;

				poisonTimeRemaining--;

				if (poisonTimeRemaining <= 0) isPoisoned = false;
			}
		}

		// ---------------------------------------

		// -- UTILS --

		public function ticks(): void {

			onWaterTick();
			poisonTick();

			knockbackTick();

			if (isKnockbacked) return;

			stunTick();

			if (isStunned) return;

			slowTick();
			attackTick();
		}

		// ---------------------------------------
		
		// -- ATTACK --
		
		public function attackTick(): void {
			
			if (!canAttack) {
				
				attackSpeed--;
				
				if (attackSpeed <= 0) {
					
					canAttack = true;
					attackSpeed = attackSpeedOriginal;
				}
			}
		}
		
		// ---------------------------------------


		

	}
}