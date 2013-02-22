package site;

import static org.junit.Assert.*;

import org.junit.Test;

public class AccountManagerTest {

	@Test
	public void test() {
		AccountManager manager = new AccountManager();
		//assertFalse(manager.isExistingAccount("isaac"));
		manager.createNewAccount("isaac", "madan");
		assertTrue(manager.isExistingAccount("isaac"));
		assertFalse(manager.isExistingAccount("aojia"));
		assertFalse(manager.isPasswordCorrect("aojia", "anything"));
		assertFalse(manager.isPasswordCorrect("isaac", "wrong"));
		assertTrue(manager.isPasswordCorrect("isaac", "madan"));
	}

}
