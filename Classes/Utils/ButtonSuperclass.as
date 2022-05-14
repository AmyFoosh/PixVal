package {

	import flash.display.Sprite;
	import flash.events.TouchEvent;

	public class ButtonSuperclass extends Sprite {

		private var scaled: Number;

		private var idleBtn: AssetSuperclass;
		private var clickedBtn: AssetSuperclass;

		public function ButtonSuperclass(scaled, idle: Sprite, clicked: Sprite) {

			this.scaled = scaled;

			init(idle, clicked);
		}

		private function init(idle: Sprite, clicked: Sprite): void {

			clickedBtn = new AssetSuperclass(scaled, clicked);
			addChild(clickedBtn);

			idleBtn = new AssetSuperclass(scaled, idle);
			addChild(idleBtn);

			idleBtn.addEventListener(TouchEvent.TOUCH_BEGIN, idleBtnClicked, false, 0, true);
			clickedBtn.addEventListener(TouchEvent.TOUCH_END, clickedBtnClicked, false, 0, true);
			clickedBtn.addEventListener(TouchEvent.TOUCH_OUT, clickedBtnClicked, false, 0, true);
		}

		private function idleBtnClicked(event: TouchEvent): void {

			this.setChildIndex(clickedBtn, this.numChildren - 1);
		}

		private function clickedBtnClicked(event: TouchEvent): void {

			this.setChildIndex(idleBtn, this.numChildren - 1);
		}


	}
}