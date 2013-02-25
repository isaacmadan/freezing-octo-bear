package site;

import static org.junit.Assert.*;

import org.junit.Test;

public class AccountManagerTest {

	@Test
	public void test() {
		AccountManager manager = new AccountManager();
		manager.createNewAccount("isaac", "madan", false);
		assertTrue(manager.isExistingAccount("isaac"));
		//assertFalse(manager.isExistingAccount("aojia"));
		assertFalse(manager.isPasswordCorrect("aojia", "anything"));
		assertFalse(manager.isPasswordCorrect("isaac", "wrong"));
		assertTrue(manager.isPasswordCorrect("isaac", "madan"));
		
		assertTrue(manager.areFriends(1, 1));
		assertFalse(manager.areFriends(1, 3));
		
		manager.addFriend(1, 5);
		manager.addFriend(1, 7);
		manager.addFriend(1, 9);
		manager.addFriend(1, 11);
		
		manager.addFriend(5, 1);
		manager.addFriend(7, 1);
		manager.addFriend(9, 1);
		
		System.out.println(manager.getFriends(1));
	}

}
