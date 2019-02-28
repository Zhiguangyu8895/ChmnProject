<?xml version="1.0" encoding="UTF-8" ?>
<Package name="ChmnProject" format_version="4">
    <Manifest src="manifest.xml" />
    <BehaviorDescriptions>
        <BehaviorDescription name="behavior" src="thanksPreSpeech" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="endMeeting" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="allBehaviors" xar="behavior.xar" />
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
    <Resources />
    <Topics />
    <IgnoredPaths>
        <Path src="README.md" />
        <Path src="agenda.csv" />
        <Path src="LICENSE" />
        <Path src="test1.csv" />
        <Path src="parts.csv" />
        <Path src="sectionEnd.txt" />
    </IgnoredPaths>
    <Translations auto-fill="en_US">
        <Translation name="translation_en_US" src="translations/translation_en_US.ts" language="en_US" />
    </Translations>
</Package>
