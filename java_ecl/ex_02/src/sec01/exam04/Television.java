package sec01.exam04;

import sec01.exam03.RemoteControl;

public class Television implements RemoteControl {
	private int volume;

	@Override
	public void turnOn() {
		// TODO Auto-generated method stub
		System.out.println("티비를 킴");
	}

	@Override
	public void turnOff() {
		// TODO Auto-generated method stub
		System.out.println("티비를 끔");
	}

	@Override
	public void setVolume(int volume) {
		// TODO Auto-generated method stub
		if(volume>RemoteControl.MAX_VOLUME) {
			this.volume = RemoteControl.MAX_VOLUME;
		} else if(volume < RemoteControl.MIN_VOLUME) {
			this.volume = RemoteControl.MIN_VOLUME;
		} else {
			this.volume = volume;
		}
		System.out.println("현재 tv 볼륨 : " + this.volume);
			
	}
}


