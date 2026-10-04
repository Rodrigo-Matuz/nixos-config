{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.extraLuaFiles = {
    "apps/vesktop" = {
      content = ./vesktop.lua;
      autoLoad = true;
    };
  };

  programs.vesktop = {
    enable = true;

    vencord.settings = {
      BadgeAPI = {
        enabled = true;
      };
      ChatInputButtonAPI = {
        enabled = true;
      };
      CommandsAPI = {
        enabled = true;
      };
      ContextMenuAPI = {
        enabled = true;
      };
      MessageAccessoriesAPI = {
        enabled = true;
      };
      MessageEventsAPI = {
        enabled = true;
      };
      MessagePopoverAPI = {
        enabled = true;
      };
      NoticesAPI = {
        enabled = true;
      };
      NoTrack = {
        enabled = true;
        disableAnalytics = true;
      };
      Settings = {
        enabled = true;
        settingsLocation = "aboveNitro";
        includeVencordInfoWhenCopying = true;
      };
      SupportHelper = {
        enabled = true;
      };
      AnonymiseFileNames = {
        enabled = true;
        anonymiseByDefault = false;
        method = 0;
        randomisedLength = 20;
        consistent = "image";
      };
      BetterGifAltText = {
        enabled = true;
      };
      BetterNotesBox = {
        enabled = true;
        hide = false;
        noSpellCheck = false;
      };
      BetterRoleContext = {
        enabled = true;
      };
      BetterSessions = {
        enabled = true;
        backgroundCheck = false;
      };
      BetterSettings = {
        enabled = true;
        disableFade = true;
        eagerLoad = true;
        organizeMenu = true;
      };
      BetterUploadButton = {
        enabled = true;
      };
      CallTimer = {
        enabled = true;
        format = "stopwatch";
      };
      CopyUserURLs = {
        enabled = true;
      };
      CrashHandler = {
        enabled = true;
      };
      CustomRPC = {
        enabled = true;
        type = 0;
        timestampMode = 2;
        appID = "1337472828395753563";
        appName = "or Learning";
        imageBig = "pfp";
        imageSmall = "arch-logo";
        imageSmallTooltip = "I DON'T use Arch btw. (it's ilegal in brazil)";
        imageBigTooltip = "Rem is the best waifu <3";
        details = "Just a random developer.";
        state = "Local Time (UTC-3)";
        buttonOneText = "My Website";
        buttonOneURL = "https://matuz.me";
        buttonTwoText = "AniList";
        buttonTwoURL = "https://anilist.co/user/Matuz0117/";
      };
      Dearrow = {
        enabled = true;
        hideButton = true;
        replaceElements = 0;
        dearrowByDefault = true;
      };
      DisableCallIdle = {
        enabled = true;
      };
      FavoriteGifSearch = {
        enabled = true;
        searchOption = "hostandpath";
      };
      FixCodeblockGap = {
        enabled = true;
      };
      FixSpotifyEmbeds = {
        enabled = true;
      };
      FixYoutubeEmbeds = {
        enabled = true;
      };
      FriendsSince = {
        enabled = true;
      };
      GameActivityToggle = {
        enabled = true;
        oldIcon = false;
        location = "PANEL";
      };
      ImageZoom = {
        enabled = true;
        size = 445.83333333333337;
        zoom = 1.5333333333333328;
        nearestNeighbour = true;
        square = false;
        saveZoomValues = true;
        zoomSpeed = 0.5;
        invertScroll = true;
      };
      ImplicitRelationships = {
        enabled = true;
        sortByAffinity = true;
      };
      MutualGroupDMs = {
        enabled = true;
      };
      NewGuildSettings = {
        enabled = true;
        guild = true;
        everyone = true;
        role = true;
        events = true;
        highlights = true;
        messages = 3;
        showAllChannels = true;
      };
      NoMosaic = {
        enabled = true;
        inlineVideo = true;
      };
      NoReplyMention = {
        enabled = true;
        userList = "1234567890123445,1234567890123445";
        shouldPingListed = true;
        inverseShiftReply = false;
        roleList = "1234567890123445,1234567890123445";
      };
      NoTypingAnimation = {
        enabled = true;
      };
      NotificationVolume = {
        enabled = true;
        notificationVolume = 49.647887323943664;
      };
      OnePingPerDM = {
        enabled = true;
        channelToAffect = "both_dms";
        allowMentions = false;
        allowEveryone = false;
      };
      OverrideForumDefaults = {
        enabled = true;
        defaultLayout = 2;
        defaultSortOrder = 0;
      };
      PictureInPicture = {
        enabled = true;
        loop = true;
      };
      PinDMs = {
        enabled = true;
        pinOrder = 0;
        dmSectionCollapsed = true;
        canCollapseDmSection = false;
        userBasedCategoryList = {
          "584503954969198612" = [ {
            id = "a8iuiaaps8m";
            name = "IMPORTANT";
            color = 1992191;
            collapsed = false;
            channels = [ "765540086456254474" "594236879021539368" "1065254083621027882" "1310208025277104248" "972232839754039366" "1119381161970511963" "584616682647978016" "1065470901426077807" "1158400482843308142" "930132795651661826" "1407954804109611129" "1407171917030490232" ];
          } ];
          "1119379356633006090" = [ ];
          "778779982582251571" = [ ];
        };
      };
      QuickMention = {
        enabled = true;
      };
      ReplaceGoogleSearch = {
        enabled = true;
        customEngineName = "DuckDuckGO";
        customEngineURL = "https://duckduckgo.com/&kad=gd_GB";
        replacementEngine = "off";
      };
      RevealAllSpoilers = {
        enabled = true;
      };
      SendTimestamps = {
        enabled = true;
        replaceMessageContents = true;
      };
      ShikiCodeblocks = {
        enabled = true;
        theme = "https://raw.githubusercontent.com/shikijs/shiki/0b28ad8ccfbf2615f2d9d38ea8255416b8ac3043/packages/shiki/themes/monokai.json";
        tryHljs = "SECONDARY";
        useDevIcon = "GREYSCALE";
        bgOpacity = 100;
        customTheme = "https://raw.githubusercontent.com/LEFD/sweetdracula-monokai/refs/heads/main/themes/sweetdracula-monokai-color-theme.json";
      };
      ThemeAttributes = {
        enabled = true;
      };
      Translate = {
        enabled = true;
        autoTranslate = false;
        showChatBarButton = true;
        receivedInput = "auto";
        receivedOutput = "pt";
        sentInput = "auto";
        sentOutput = "en";
        service = "google";
        showAutoTranslateAlert = false;
      };
      TypingTweaks = {
        enabled = true;
        alternativeFormatting = true;
        showRoleColors = true;
        showAvatars = true;
      };
      Unindent = {
        enabled = true;
      };
      UnlockedAvatarZoom = {
        enabled = true;
        zoomMultiplier = 4;
      };
      ValidUser = {
        enabled = true;
      };
      VencordToolbox = {
        enabled = true;
      };
      ViewIcons = {
        enabled = true;
        format = "webp";
        imgSize = "1024";
      };
      ViewRaw = {
        enabled = true;
        clickMethod = "Left";
        messageContextMenu = false;
      };
      VoiceDownload = {
        enabled = true;
      };
      VoiceMessages = {
        enabled = true;
        echoCancellation = true;
        noiseSuppression = true;
      };
      WebContextMenus = {
        enabled = true;
        addBack = true;
      };
      WebKeybinds = {
        enabled = true;
      };
      WebScreenShareFixes = {
        enabled = true;
      };
      WhoReacted = {
        enabled = true;
      };
      DontRoundMyTimestamps = {
        enabled = true;
      };
      MaskedLinkPaste = {
        enabled = true;
      };
      ServerInfo = {
        enabled = true;
      };
      NoOnboardingDelay = {
        enabled = true;
      };
      SettingsStoreAPI = {
        enabled = true;
      };
      UserSettingsAPI = {
        enabled = true;
      };
      MentionAvatars = {
        enabled = true;
        showAtSymbol = true;
      };
      YoutubeAdblock = {
        enabled = true;
      };
      AlwaysExpandRoles = {
        enabled = true;
      };
      CopyFileContents = {
        enabled = true;
      };
      VolumeBooster = {
        enabled = true;
        multiplier = 2;
      };
      AccountPanelServerProfile = {
        enabled = true;
        prioritizeServerProfile = false;
      };
      FullSearchContext = {
        enabled = true;
      };
      DynamicImageModalAPI = {
        enabled = true;
      };
      FixImagesQuality = {
        enabled = true;
        originalImagesInChat = false;
      };
      ExpressionCloner = {
        enabled = true;
      };
      ConcatenatedComponentExtractor = {
        enabled = true;
      };
    };
  };
}
