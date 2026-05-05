mediafilesegmenter man page
$ man mediafilesegmenter
mediafilesegmenter(1)     BSD General Commands Manual    mediafilesegmenter(1)

NAME
     mediafilesegmenter -- Create segments for HTTP Live Streaming from media
     files.

SYNOPSIS
     mediafilesegmenter [-b | -base-url <url>]
                        [-t | -target-duration duration]
                        [-f | -file-base path] [-F | -meta-file file]
                        [-y | -meta-type [picture | text | id3]]
                        [-M | -meta-macro-file file]
                        [-i | -index-file fileName]
                        [-I | -generate-variant-plist]
                        [-B | -base-media-file-name name]
                        [-k | -encrypt-key-file file-or-path]
                        [-K | -encrypt-key-url <url>] [-S | -stream-encrypt]
                        [-P | -streaming-key-delivery]
                        [-J | -encrypt-iv [random | sequence]]
                        [-key-rotation-period period]
                        [-encrypt-rotate-iv-mbytes numberMBytes]
                        [-n | -base-encrypt-key-name name]
                        [-H | -hdcp-level level] [-l | -log-file file]
                        [-q | -quiet] [-a | -audio-only] [-A | -video-only]
                        [-no-floating-point-duration] [-V | -validate-files]
                        [-z | -iframe-index-file name] [-r | -iso-fragmented]
                        [-s | -output-single-file]
                        [-start-segments-with-iframe] [-v | -version]
                        [-h | --help] [file]

DESCRIPTION
     The mediafilesegmenter is a command-line tool that segments media for
     deployment using HTTP Live Streaming.  The mediafilesegmenter takes media
     from the specified file, multiplexes it into MPEG-2 Tranport streams or
     elementary streams, and divides it into a series of small media files of
     approximately equal duration. The mediafilesegmenter also creates an
     index (or playlist) file containing references to the individual media
     files.  The index file and media files can then be deployed as a video-
     on-demand (VOD) stream using common web server infrastructure.

     The mediafilesegmenter will generate media files for the complete pro-
     gram, an index file that contains all of the media files, and an index
     file that contains information for fast forward/reverse playback.  This
     kind of stream allows the client access to the entire program at once.

     The mediafilesegmenter can encrypt the segments using AES-128 encryption.
     There are 2 encryption modes; Sequence mode generates an IV based on the
     media sequence number and is compatible with iPhone OS 3.0 or greater.
     Random mode generates a random IV every 50 megabytes and is compatible
     with iPhone OS 3.2 or greater and Mac OS X 10.7 or greater. Random mode
     is more secure and allows encrypted segments to be added to multiple
     playlists.  If random mode is chosen and a static key is not specified,
     the keys will be automatically rotated every 4 hours.

     To end a session, use control-C.  An end of file tag will be added to the
     index file.

     The mediafilesegmenter command accepts the following arguments:

     -b | -base-url <url>
           Specifies a base url to add to the media file name when written
           into the index file.

     -t | -target-duration duration
           Specifies a target duration for the media files.  The default dura-
           tion is 10 seconds. The duration is calculated by looking at the
           PTS/DTS in the source file.

     -f | -file-base path
           Directory to store the media and index files.

     -F | -meta-file file
           Reads the specified file and writes it's contents as metadata at
           the start of each media file.  If the specified file doesn't exist,
           no metadata will be written.

     -y | -meta-type [picture | text | id3]
           Specifies the metadata type.  If picture, expects a JPEG or PNG.
           If id3, expects a complete ID3 frame.   To inject images into an
           audio only stream, use picture as the argument.

    -M | -meta-macro-file file
           Specifies the macro file to be used to insert timed metadata into
           the stream.

    -i | -index-file fileName
           This option defines the index file name.  The default is
           prog_index.m3u8.  It is recommended that the index file have an
           extension of .m3u8 or .m3u.

    -I | -generate-variant-plist
           DEPRECATED - This option is no longer required. An output plist
           file will be generated for information to pass to
           variantplaylistcreator(1).  The plist file name will be the source
           file name, with the extension removed, and .plist added.  So, if
           the file name is /Users/apple/content/myContent.m4v, the plist name
           will be /Users/apple/content/myContent.plist.

    -B | -base-media-file-name name
           This option defines the base name of the media files.  The default
           is fileSequence.  The current sequence number of the file is
           appended, and an extension added.  For example, specifying name as
           AppleMediaFile will generate file names that look like AppleMediaFile12.ts.

    -k | -encrypt-key-file file-or-path
           Specifies the directory or file to store the encryption keys.  If a
           file is specified, that static key will be used for the entire ses-
           sion.  It is not recommended to use a static key.

    -K | -encrypt-key-url <url>
           HTTP base URL for the encrypt key file to write into the index
           file.  If a static key is specified, the URL should be the URL for
           the static file.

    -S | -stream-encrypt
           The -stream-encrypt option indicates that sample based encryption
           is to be used instead of file based encryption.  If a key is speci-
           fied, it MUST contain a 16 byte key and a 16 byte IV.

    -P | -streaming-key-delivery
           The -streaming-key-delivery option is required to support FairPlay
           Streaming. Adds KEYFORMAT="com.apple.streamingkeydelivery"
           attribute to EXT-X-KEY tag.

    -J | -encrypt-iv
           The -encrypt-iv option indicates which method should be used to
           generate the IV.  The possible values are random or sequence.

    -key-rotation-period period
           The -key-rotation-period option will generate an encryption key and
           rotate the key every period media files.  The -key-rotation-period
           option requires a -encrypt-key-file option.  If the -encrypt-iv
           sequence (or backward-compatible) option is not specified, the
           default for the -key-rotation-period will be to rotated keys every
           4 hours.

    -encrypt-rotate-iv-mbytes numberMBytes
           The -encrypt-rotate-iv-mbytes option controls the rotation of the
           encrypt IV.  It specifies the number of megabytes between IV rota-
           tions.  The default is 50.

    -n | -base-encrypt-key-name name
           This option defines the base name of the crypt key files.  The
           default is crypt.  The current sequence number of the file is
           appended, and an extension added.  For example, specifying name as
           AppleCrypt will generate file names that look like Apple-
           Crypt12.key.

    -H | -hdcp-level level
           This option defines the HDCP level. Possible values are none or
           type-0 or type-1.

    -l | -log-file file
           Writes console messages to file

    -q | -quiet
           Only outputs error messages.

    -a | -audio-only
           Strips the audio stream (AAC/ADTS or MP3) and writes it into the
           media file.

    -A | -video-only
           Creates a video-only transport stream and writes it into the media
           file.  This can be used with the alternate media feature in iOS
           5.0.

    -no-floating-point-duration
           Will generate an index file with integer duration for segment
           files.  Use this along with the -iframe-index-file none option to
           create streams that are compatible with releases earlier than iOS
           4.2 or OS X version 10.7.

    -V | -validate-files
           Will prevalidate the file specified.

    -z | -iframe-index-file name
           Specifies the name for the iframe index file.  To not generate an
           iframe index file, or to generate playlists that do not use float-
           ing-point durations, use none as the name

    -r | -iso-fragmented
           This feature will output all segments in ISO fragmented format
           instead of the default transport stream format.

    -s | -output-single-file
           This feature will output all segments into a single file.  This is
           compatible with iOS 5.0 or later.

    -start-segments-with-iframe
           This feature will start all segments with an I-Frame.  Depending on
           your encoding settings, this may increase your target duration.

    -h | --help
           Show help

METADATA MACRO FILE
     The mediafilesegmenter can insert metadata entries at different times in
     the stream. A metadata macro file is used to define these entries. Each
     line of a macro file defines a metadata entry and has the structure:
         <entry time offset> [repeat] <metadata type> <path to ID3 frame>
     For instance a macro file containing
         1.2 id3 /tmp/title.id3
         10 repeat picture /tmp/picture.jpg
     will cause the segmenter to inject the ID3 tag in /tmp/title.id3 at time
     1.2s, and the picture tag in /tmp/picture.jpg at time 10s and repeat
     every segment until the end.

COMPATIBILITY
     The mediafilesegmenter will only work with source media files containing
     H.264 video or AAC/HE-AAC, AC-3 or MP3 audio.

     The mediafilesegmenter will by default generate streams that are compati-
     ble with iOS version 4.2 or later, or Mac OS X 10.7 or greater.  To gen-
     erate compatible streams with earlier release, use the
     -no-floating-point-duration option and the -iframe-index-file none
     option.

EXAMPLES
     mediafilesegmenter -b http://foo.com/stream -f
     /Library/WebServer/Documents/stream myFile.mov

     Creates a VOD at /Library/WebServer/Documents/stream.  The index file can
     be downloaded at http://foo.com/stream/prog_index.m3u8.

     mediafilesegmenter -b http://bar.com/hiRes -f
     /Library/WebServer/Documents/hiRes -g -key-rotation-period 15 -k
     /Volumes/SecureServer/Protected -K
     https://foo.bar.com/login/key.php?streamname=hiRes
     myContentThatIWantProtected.mp4

     Creates an encrypted VOD stream that is backward compatible.  The encryp-
     tion key is on a different server, and is accessible via https.

     mediafilesegmenter -b http://bar.com/hiRes -f
     /Library/WebServer/Documents/hiRes -k /Volumes/SecureServer/Protected -K
     https://foo.bar.com/login/key.php?streamname=hiRes
     myContentThatIWantProtected.mp4

     Creates the encrypted VOD stream that has the recommended encryption
     scheme.  The encryption key is on a different server, and is accessible
     via https.

     mediafilesegmenter --audio-only --meta-file inject.jpg --meta-type
     picture myFile.mov

     Creates an audio-only VOD by taking the audio stream from myFile.mov and
     injects "inject.jpg" into each media file, if it exists.  The media file
     created will have the tags required to allow stream switching

SEE ALSO
     variantplaylistcreator(1), mediastreamsegmenter(1)

OS X                            March 02, 2017                            OS X

==============================================================================

$ mediafilesegmenter -help
Usage:mediafilesegmenter [options] <file> where options are:
    -b <url>  | --base-url=<url>         : Base url (omit for relative URLs)
    -t <dur>  | --target-duration=<dur>  : Target duration for each segment
    -f <path> | --file-base=<path>       : Path at which to store index and media files
    -F <file> | --meta-file=<file>       : Meta data file to load for each segment
    -y <type> | --meta-type=<type>       : Meta data format (id3, private, picture) for metadata file to
                                           lead for each segment
    -M <file> | --meta-macro-file=<file> : Macro file containing the list of metadata entries to inject in the stream
    -i <name> | --index-file=<name>      : Index file name (default prog_index.m3u8)
    -I        | --generate-variant-plist : DEPRECATED - Option no longer required, plist file will be generated without specifying this option
    -B <name> | --base-media-file-name   : Base media file name (default fileSequence)
    -k <path> | --encrypt-key-file=<path>: Encryption key location.  If this is a file, only this key will be used
    -K <url>  | --encrypt-key-url=<url>  : URL to insert into playlist.  Should point at -encrypt-key path
    -S        | --stream-encrypt         : Use elementary stream encryption
    -P        | --streaming-key-delivery : Use FairPlay Streaming key format
    -J <value>| --encrypt-iv=<value>     : Specify method of generation of IV for encryption. Possible
                                           values are 'random' or 'sequence'. For compatibility, use 'sequence'.
                                           The default is 'random'
    -key-rotation-period=<period>        : Rotates key every <period> segments. Default is 4 hours
    -encrypt-rotate-iv-mbytes=<num>      : Number of megabytes to rotate the IV. Default 50
    -n <name> | --base-encrypt-key-name=<name> : Crypt key file name (default crypt)
    -H <level>| --hdcp-level=<level>     : Signaling HDCP level. Possible values are 'none' or 'type-0'
    -l <file> | --log-file=<file>        : Enable log file
    -q        | --quiet                  : Only output errors
    -a        | --audio-only             : Only use audio from the stream
    -A        | --video-only             : Only use video/closed caption tracks
    --no-floating-point-duration         : Do not use float point durations
    -V        | --validate-files         : Validate input file
    -z <name> | --iframe-index-file=<name> : Create I-frame index file with name (default iframe_index.m3u8)
                                           Use "none" to not generate
    -r        | --iso-fragmented         : Output ISO fragmented format instead of transport stream
    -s        | --output-single-file     : Output all segments contained in 1 file (base media file 
                                           name default is main)
    -start-segments-with-iframe          : Start all segments with I-frames
    -v        | --version                : Show version number
    -h        | --help                   : Show help
