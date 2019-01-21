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
    </BehaviorDescriptions>
    <Dialogs />
    <Resources>
        <File name="agenda" src="agenda.csv" />
        <File name="LICENSE" src="LICENSE" />
        <File name="README" src="README.md" />
    </Resources>
    <Topics />
    <IgnoredPaths />
    <Translations auto-fill="en_US">
        <Translation name="translation_en_US" src="translations/translation_en_US.ts" language="en_US" />
    </Translations>
</Package>
