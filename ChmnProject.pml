<?xml version="1.0" encoding="UTF-8" ?>
<Package name="ChmnProject" format_version="4">
    <Manifest src="manifest.xml" />
    <BehaviorDescriptions>
        <BehaviorDescription name="behavior" src="startmeeting" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="startNextSpeech" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="thanksLastSpeech" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="endMeeting" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="allBehaviors" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="nextPresidentSpeech" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="checkSpeechTimeout" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="checkSpeechEnd" xar="behavior.xar" />
        <BehaviorDescription name="behavior" src="loadAgenda" xar="behavior.xar" />
    </BehaviorDescriptions>
    <Dialogs />
    <Resources />
    <Topics />
    <IgnoredPaths>
        <Path src="README.md" />
        <Path src="speechEndTest.txt" />
        <Path src="agenda.csv" />
        <Path src="LICENSE" />
    </IgnoredPaths>
    <Translations auto-fill="en_US">
        <Translation name="translation_en_US" src="translations/translation_en_US.ts" language="en_US" />
    </Translations>
</Package>
