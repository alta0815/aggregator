package com.un1acker.aggregator.service;

import com.un1acker.aggregator.entity.Item;
import com.un1acker.aggregator.exception.RssException;
import com.un1acker.aggregator.rss.ObjectFactory;
import com.un1acker.aggregator.rss.TRss;
import com.un1acker.aggregator.rss.TRssChannel;
import com.un1acker.aggregator.rss.TRssItem;
import org.springframework.stereotype.Service;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@Service
public class RSSService {

    public List<Item> getItems(File file) throws RssException {
        return getItems(new StreamSource(file));
    }

    public List<Item> getItems(String url) throws RssException {
        return getItems(new StreamSource(url));
    }

    private List<Item> getItems(Source source) throws RssException {
        List<Item> itemList = new ArrayList<>();
        try {
            JAXBContext context = JAXBContext.newInstance(ObjectFactory.class);
            Unmarshaller unmarshaller = context.createUnmarshaller();
            JAXBElement<TRss> jaxbElement = unmarshaller.unmarshal(source, TRss.class);
            TRss rss = jaxbElement.getValue();
            List<TRssChannel> channels = rss.getChannel();
            for (TRssChannel channel : channels) {
                List<TRssItem> items = channel.getItem();
                for (TRssItem rssItem : items) {
                    Item item = new Item();
                    item.setTitle(rssItem.getTitle());
                    item.setDescription(rssItem.getDescription());
                    item.setLink(rssItem.getLink());
                    Date pubDate = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss Z", Locale.ENGLISH).parse(rssItem.getPubDate());
                    item.setPublishedDate(pubDate);
                    itemList.add(item);
                }
            }
        } catch (JAXBException | ParseException e) {
            throw new RssException(e);
        }

        return itemList;
    }
}
