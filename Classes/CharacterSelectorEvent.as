package {

	import flash.events.Event;

	public class CharacterSelectorEvent extends Event {

		public static const CHARACTER_SELECTED: String = "CharacterSelected";

		public function CharacterSelectorEvent(type: String) {

			super(type);
		}


	}
}