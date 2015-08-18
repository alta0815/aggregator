package com.un1acker.aggregator.service;

import com.un1acker.aggregator.entity.Item;
import com.un1acker.aggregator.exception.RssException;
import org.junit.Before;
import org.junit.Test;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.List;

import static org.junit.Assert.*;

public class RSSServiceTest {

    private RSSService RSSService;

    @Before
    public void init() {
        RSSService = new RSSService();
    }

    @Test
    public void testGetItemsFile() throws RssException {
        List<Item> itemList = RSSService.getItems(new File(System.getProperty("user.dir"),"src/test/resource/testrss.xml"));
        assertEquals(itemList.size(), 10);
    }

    @Test
    public void testFirstItemFile() throws RssException {
        List<Item> itemList = RSSService.getItems(new File(System.getProperty("user.dir"),"src/test/resource/testrss.xml"));
        Item item = itemList.get(0);
        assertEquals("How to solve Source not found error during debug in Eclipse", item.getTitle());
        assertEquals("If you run your web application using embedded Java EE server in Maven (like Tomcat or Jetty) and try to run it in debug mode, once you hit some breakpoint, you will encounter this error: \"Source not found\".<img src=\"http://feeds.feedburner.com/~r/javavids/~4/CJQ8y5pkbzc\" height=\"1\" width=\"1\" alt=\"\"/>", item.getDescription());
        assertEquals("http://feedproxy.google.com/~r/javavids/~3/CJQ8y5pkbzc/how-to-solve-source-not-found-error-during-debug-in-eclipse.html", item.getLink());
        assertEquals("22 06 2014", new SimpleDateFormat("dd MM yyyy").format(item.getPublishedDate()));
    }
}
