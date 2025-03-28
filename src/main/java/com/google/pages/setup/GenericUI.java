package com.google.pages.setup;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class GenericUI {
	protected final Logger logger = LoggerFactory.getLogger(GenericUI.class);
	protected WebDriver driver;

	protected void initDriver() {
		logger.info("Initializing chromeDriver");
		WebDriverManager.chromedriver().clearDriverCache().setup();
		ChromeOptions options = new ChromeOptions();
		options.addArguments("--remote-allow-origins=*");
		options.addArguments("--no-sandbox");
		options.addArguments("--disable-dev-shm-usage");
		options.addArguments("--disable-gpu");
		options.addArguments("--start-maximized");
		driver = new ChromeDriver(options);
	}

	protected void quitDriver() {
		logger.info("Quit webDriver");
		if (driver != null) {
			driver.quit();
		}
	}

	public WebDriver getDriver() {
		return driver;
	}
}
