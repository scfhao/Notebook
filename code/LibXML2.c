/**
 scfhao 摘自 Apple 示例工程《XMLPerformance》。
 libxml 文档在 http://www.xmlsoft.org
 */

#import <libxml/tree.h>

int main() {
    xmlParserCtxtPtr context;
    // This creates a context for "push" parsing in which chunks of data that are not "well balanced" can be passed
    // to the context for streaming parsing. The handler structure defined above will be used for all the parsing.
    // The second argument, self, will be passed as user data to each of the SAX handlers. The last three arguments
    // are left blank to avoid creating a tree in memory.
    context = xmlCreatePushParserCtxt(&simpleSAXHandlerStruct, (__bridge void *)(self), NULL, 0, NULL);
    // Process the downloaded chunk of data.
    xmlParseChunk(_context, (const char *)data.bytes, (int)data.length, 0);
    // Signal the context that parsing is complete by passing "1" as the last parameter.
    xmlParseChunk(_context, NULL, 0, 1);
}

static xmlSAXHandler simpleSAXHandlerStruct = {
    NULL,                       /* internalSubset */
    NULL,                       /* isStandalone   */
    NULL,                       /* hasInternalSubset */
    NULL,                       /* hasExternalSubset */
    NULL,                       /* resolveEntity */
    NULL,                       /* getEntity */
    NULL,                       /* entityDecl */
    NULL,                       /* notationDecl */
    NULL,                       /* attributeDecl */
    NULL,                       /* elementDecl */
    NULL,                       /* unparsedEntityDecl */
    NULL,                       /* setDocumentLocator */
    NULL,                       /* startDocument */
    NULL,                       /* endDocument */
    NULL,                       /* startElement*/
    NULL,                       /* endElement */
    NULL,                       /* reference */
    charactersFoundSAX,         /* characters */
    NULL,                       /* ignorableWhitespace */
    NULL,                       /* processingInstruction */
    NULL,                       /* comment */
    NULL,                       /* warning */
    errorEncounteredSAX,        /* error */
    NULL,                       /* fatalError //: unused error() get all the errors */
    NULL,                       /* getParameterEntity */
    NULL,                       /* cdataBlock */
    NULL,                       /* externalSubset */
    XML_SAX2_MAGIC,             //
    NULL,
    startElementSAX,            /* startElementNs */
    endElementSAX,              /* endElementNs */
    NULL,                       /* serror */
};

#pragma mark SAX Parsing Callbacks

// The following constants are the XML element names and their string lengths for parsing comparison.
// The lengths include the null terminator, to ensure exact matches.
static const char *kName_Item = "item";
static const NSUInteger kLength_Item = 5;
static const char *kName_Title = "title";
static const NSUInteger kLength_Title = 6;
static const char *kName_Category = "category";
static const NSUInteger kLength_Category = 9;
static const char *kName_Itms = "itms";
static const NSUInteger kLength_Itms = 5;
static const char *kName_Artist = "artist";
static const NSUInteger kLength_Artist = 7;
static const char *kName_Album = "album";
static const NSUInteger kLength_Album = 6;
static const char *kName_ReleaseDate = "releasedate";
static const NSUInteger kLength_ReleaseDate = 12;

/*
 This callback is invoked when the parser finds the beginning of a node in the XML. For this application,
 our parsing needs are relatively modest - we need only match the node name. An "item" node is a record of
 data about a song. In that case we create a new Song object. The other nodes of interest are several of the
 child nodes of the Song currently being parsed. For those nodes we want to accumulate the character data
 in a buffer. Some of the child nodes use a namespace prefix.
 */
static void startElementSAX(void *ctx, const xmlChar *localname, const xmlChar *prefix, const xmlChar *URI,
                            int nb_namespaces, const xmlChar **namespaces, int nb_attributes, int nb_defaulted, const xmlChar **attributes) {
    
    LibXMLParser *parser = (__bridge LibXMLParser *)ctx;
    // The second parameter to strncmp is the name of the element, which we known from the XML schema of the feed.
    // The third parameter to strncmp is the number of characters in the element name, plus 1 for the null terminator.
    if (prefix == NULL && !strncmp((const char *)localname, kName_Item, kLength_Item)) {
        Song *newSong = [[Song alloc] init];
        parser.currentSong = newSong;
        parser.parsingASong = YES;
    } else if (parser.parsingASong && ( (prefix == NULL && (!strncmp((const char *)localname, kName_Title, kLength_Title) || !strncmp((const char *)localname, kName_Category, kLength_Category))) || ((prefix != NULL && !strncmp((const char *)prefix, kName_Itms, kLength_Itms)) && (!strncmp((const char *)localname, kName_Artist, kLength_Artist) || !strncmp((const char *)localname, kName_Album, kLength_Album) || !strncmp((const char *)localname, kName_ReleaseDate, kLength_ReleaseDate))) )) {
        parser.storingCharacters = YES;
    }
}

/*
 This callback is invoked when the parser encounters character data inside a node. The parser class determines how to use the character data.
 */
static void	charactersFoundSAX(void *ctx, const xmlChar *ch, int len) {
    
    LibXMLParser *parser = (__bridge LibXMLParser *)ctx;
    // A state variable, "storingCharacters", is set when nodes of interest begin and end.
    // This determines whether character data is handled or ignored.
    if (parser.storingCharacters == NO) return;
    [parser appendCharacters:(const char *)ch length:len];
}

/*
 This callback is invoked when the parse reaches the end of a node. At that point we finish processing that node,
 if it is of interest to us. For "item" nodes, that means we have completed parsing a Song object. We pass the song
 to a method in the superclass which will eventually deliver it to the delegate. For the other nodes we
 care about, this means we have all the character data. The next step is to create an NSString using the buffer
 contents and store that with the current Song object.
 */
static void	endElementSAX(void *ctx, const xmlChar *localname, const xmlChar *prefix, const xmlChar *URI) {
    
    LibXMLParser *parser = (__bridge LibXMLParser *)ctx;
    if (parser.parsingASong == NO) return;
    if (prefix == NULL) {
        if (!strncmp((const char *)localname, kName_Item, kLength_Item)) {
            [parser finishedCurrentSong];
            parser.parsingASong = NO;
        } else if (!strncmp((const char *)localname, kName_Title, kLength_Title)) {
            parser.currentSong.title = [parser currentString];
        } else if (!strncmp((const char *)localname, kName_Category, kLength_Category)) {
            parser.currentSong.category = [parser currentString];
        }
    } else if (!strncmp((const char *)prefix, kName_Itms, kLength_Itms)) {
        if (!strncmp((const char *)localname, kName_Artist, kLength_Artist)) {
            parser.currentSong.artist = [parser currentString];
        } else if (!strncmp((const char *)localname, kName_Album, kLength_Album)) {
            parser.currentSong.album = [parser currentString];
        } else if (!strncmp((const char *)localname, kName_ReleaseDate, kLength_ReleaseDate)) {
            NSString *dateString = [parser currentString];
            parser.currentSong.releaseDate = [parser.parseFormatter dateFromString:dateString];
        }
    }
    parser.storingCharacters = NO;
}

/*
 A production application should include robust error handling as part of its parsing implementation.
 The specifics of how errors are handled depends on the application.
 */
static void errorEncounteredSAX(void *ctx, const char *msg, ...) {
    // Handle errors as appropriate for your application.
    NSCAssert(NO, @"Unhandled error encountered during SAX parse.");
}

