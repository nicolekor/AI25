// p564 arraylist 랑 linkedlist 비교

package sec01.exam03;

import java.util.*;

public class LinkedListExample {

	public static void main(String[] args) {
		List<String> list1 = new ArrayList<String>();
		List<String> list2 = new LinkedList<String>();
		
		long startTime;
		long endTime;
		
		startTime = System.nanoTime();
		for(int i=0; i<10000; i++) {
			list1.add(0, String.valueOf(i));
		}
		endTime =  System.nanoTime();
		System.out.println("ArrayList 걸릴시간: " + (endTime-startTime) + "ns");
		
		startTime = System.nanoTime();
		for(int i=0; i<10000; i++) {
			list2.add(0, String.valueOf(i));
		}
		
		endTime =  System.nanoTime();
		System.out.println("LinkedList 걸릴시간: " + (endTime-startTime) + "ns");
	}
}
