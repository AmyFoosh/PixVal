package {

	public class Player extends Entity {

		// ---------------------------------------

		// -- UTILS --

		private var display: AssetSuperclass;
		public var playerName: String;

		// ---------------------------------------

		// -- DASH --

		public var dashOnCooldown: Boolean;
		public var dashCooldownCurrentTime: int;
		public var dashCooldownOriginalTime: int;

		public var isDashing: Boolean;
		public var dashAngle: Number;
		public var dashSpeedCurrent: Number;
		public var dashSpeedIncrement: Number;
		public var dashSpeedOriginal: Number;

		// ---------------------------------------

		public function Player(scaled: Number, speed: Number) {

			// ---------------------------------------
			
			// -- UTILS --

			super(scaled, speed);

			playerName = "Neal";

			switch (playerName) {

				case "Neal":
					display = new AssetSuperclass(scaled, new Neal);
					addChild(display);
					break;
			}

			// ---------------------------------------
			
			// -- DASH --

			dashOnCooldown = false;
			dashCooldownCurrentTime = 0;
			dashCooldownOriginalTime = 120;

			isDashing = false;
			dashAngle = 0;
			dashSpeedCurrent = 0;
			dashSpeedIncrement = 0.5 * speed;
			dashSpeedOriginal = 15 * speed;

			// ---------------------------------------
		}

		// ---------------------------------------

		// -- MOVEMENT --

		override public function move(angle: Number): void {

			if (isDashing) return;

			super.move(angle);
		}

		override public function unmove(angle: Number): void {

			if (isDashing) return;

			super.unmove(angle);
		}

		// ---------------------------------------

		// -- DASH -- 

		public function addDash(angle: Number): void {

			// ---------------------------------------

			if (dashOnCooldown) return;
			if (isDashing) return;
			if (isOnWater) return;
			if (isKnockbacked) return;
			if (isStunned) return;

			// ---------------------------------------

			isDashing = true;
			dashAngle = angle;
			dashSpeedCurrent = dashSpeedOriginal;

			movementSpeedCurrent = 0;
			canReceiveDamage = false;

			// ---------------------------------------
		}

		public function dashTick(): void {

			// ---------------------------------------

			if (dashOnCooldown) {

				dashCooldownCurrentTime--;

				if (dashCooldownCurrentTime <= 0) dashOnCooldown = false;
			}

			// ---------------------------------------

			if (isDashing) {

				x -= Math.cos(dashAngle) * dashSpeedCurrent;
				y -= Math.sin(dashAngle) * dashSpeedCurrent;

				dashSpeedCurrent -= dashSpeedIncrement;

				if (dashSpeedCurrent <= 0) {

					dashOnCooldown = true;
					dashCooldownCurrentTime = dashCooldownOriginalTime;

					isDashing = false;
					canReceiveDamage = true;
				}
			}

			// ---------------------------------------
		}

		// ---------------------------------------

		// -- KNOCKBACK --

		override public function addKnockback(angle: Number, strength: Number): void {

			super.addKnockback(angle, strength);

			if (isDashing) {

				isDashing = false;
				dashOnCooldown = true;
				dashCooldownCurrentTime = dashCooldownOriginalTime;
			}
		}

		// ---------------------------------------
		
		// -- UTILS --
		
		override public function ticks(): void {
			
			dashTick();
			
			super.ticks();
		}
		
		// ---------------------------------------





	}
}