<?xml version="1.0" encoding="UTF-8" ?>
<Package name="ChmnProject" format_version="4">
    <Manifest src="manifest.xml" />
    <BehaviorDescriptions>
        <BehaviorDescription name="behavior" src="thanksPreSpeech" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="endMeeting" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="allBehaviors" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="nextPresidentSpeech" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="checkSpeechTimeout" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="checkSectionEnd" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="loadAgenda" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="startMeeting" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="restTime" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="startNextPart" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="endPrePart" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="randomNextFrase" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="loadParts" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="startNextSpeech" xar="behavior.xar" />
    </BehaviorDescriptions>
    <Dialogs />
    <Resources>
        <File name="alert" src="alert.mp3" />
        <File name="ceremony" src="ceremony.mp3" />
        <File name="happybirthday" src="happybirthday.mp3" />
    </Resources>
    <Topics />
    <IgnoredPaths>
        <Path src="agenda.csv" />
        <Path src="LICENSE" />
        <Path src="README.md" />
        <Path src="sectionEndTest.txt" />
        <Path src="parts.csv" />
    </IgnoredPaths>
    <Translations auto-fill="ja_JP">
        <Translation name="translation_ja_JP" src="translations/translation_ja_JP.ts" language="ja_JP" />
    </Translations>
</Package>
