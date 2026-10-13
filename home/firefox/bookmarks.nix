# Firefox bookmarks for Home Manager.
# IMPORTANT: `toolbar = true` designates the special Firefox toolbar ROOT.
# Put individual folders INSIDE its `bookmarks` list so they appear as buttons.
# All 80 original unique URLs are retained; duplicated links are consolidated.
let
  link = name: url: { inherit name url; };
  folder = name: bookmarks: { inherit name bookmarks; };
in
[
  {
    name = "Bookmarks Toolbar";
    toolbar = true;
    bookmarks = [
      (link "YouTube" "https://www.youtube.com/")
      (link "YouTube Music" "https://music.youtube.com/")
      (link "ChatGPT" "https://chat.openai.com/chat")
      (link "Gmail — Account 0" "https://mail.google.com/mail/u/0/#inbox")
      (link "Google Images" "https://images.google.com.br/")
      (link "Google Translate" "https://translate.google.com.br/?hl=pt-BR")

      # The folders below appear directly on the Firefox bookmarks toolbar.
      "separator"

      (folder "Dev" [
        (folder "GitHub & Discord" [
          (link "GitHub — Rodrigo-Matuz" "https://github.com/Rodrigo-Matuz")
          (link "DiscordDB — Repository" "https://github.com/weibeu/DiscordDB")
          (link "DiscordDB — API Reference" "https://discorddb.readthedocs.io/en/latest/api.html")
          (link "Pycord — Application Commands" "https://docs.pycord.dev/en/stable/api/application_commands.html#discord.SlashCommandGroup.name")
          (link "Discord Developer Portal" "https://discord.com/developers/applications")
        ])

        (folder "Documentation & Reference" [
          (link "JavaScript — MDN" "https://developer.mozilla.org/pt-BR/docs/Web/JavaScript#guia_do_javascript")
          (link "W3Schools" "https://www.w3schools.com/")
          (link "Backend Developer Roadmap" "https://roadmap.sh/backend")
          (link "Vim Cheat Sheet" "https://vim.rtorr.com/")
        ])

        (folder "Tools & Practice" [
          (link "Online C Compiler" "https://www.onlinegdb.com/online_c_compiler")
          (link "LeetCode" "https://leetcode.com/")
          (link "QuickType" "https://app.quicktype.io/")
          (link "StackEdit" "https://stackedit.io/app#")
          (link "Eraser — Dashboard" "https://app.eraser.io/dashboard/all")
          (link "Eraser — Python Project Workspace" "https://app.eraser.io/workspace/nHSqnX7Ng9OHistPoG7V")
        ])
      ])

      (folder "Creative" [
        (folder "Anime" [
          (link "AniList — Matuz" "https://anilist.co/user/Matuz0117/")
          (link "MyAnimeList" "https://myanimelist.net/")
          (link "Danbooru" "https://danbooru.donmai.us/")
          (link "Anime Reactor" "https://anime.reactor.cc/")
        ])

        (folder "Design & Image Discovery" [
          (link "Yandex Images" "https://yandex.com/images/")
          (link "DaFont" "https://www.dafont.com/pt/")
          (link "Civitai" "https://civitai.com/")
        ])

        (folder "Media Tools" [
          (link "EZGIF" "https://ezgif.com/")
          (link "Online Video Cutter" "https://online-video-cutter.com/pt/add-music-to-video")
          (link "JuxtaposeJS" "https://juxtapose.knightlab.com/")
        ])

        (folder "Entertainment" [
          (link "Hulu" "https://www.hulu.com/")
          (link "Vivaldia Games" "https://vivaldi.com/games/vivaldia/")
        ])
      ])

      (folder "Security" [
        (link "GTFOBins" "https://gtfobins.github.io/")
        (link "TryHackMe" "https://tryhackme.com/dashboard")
        (link "MITRE ATT&CK" "https://attack.mitre.org/")
        (link "MITRE D3FEND" "https://d3fend.mitre.org/")
        (link "Ports 1–1024" "https://www.vmaxx.net/techinfo/ports.htm")
      ])

      (folder "Learning" [
        (link "TypingClub" "https://www.typingclub.com/")
        (link "Danki Code — My Courses" "https://cursos.dankicode.com/campus/meus-cursos")
        (link "Studeo Unicesumar" "https://studeo.unicesumar.edu.br/#!/app/home")
        (link "EBAC" "https://lms.ebaconline.com.br/dashboard")
      ])

      (folder "Accounts" [
        (folder "Google" [
          (link "Gmail — Account 1" "https://mail.google.com/mail/u/1/#inbox")
        ])

        (folder "Microsoft" [
          (link "Microsoft 365" "https://www.office.com/?auth=1")
          (link "OneDrive" "https://onedrive.live.com/?id=root&cid=1C022A973FAC7E2C")
        ])

        (folder "Vivaldi" [
          (link "Features" "https://vivaldi.com/features/")
          (link "Webmail" "https://webmail.vivaldi.net/")
          (link "Help" "https://help.vivaldi.com/")
        ])
      ])

      (folder "Shopping" [
        (folder "PC Building" [
          (link "PCPartPicker" "https://pcpartpicker.com/list/")
        ])

        (folder "Stores & Marketplaces" [
          (link "Amazon Brazil" "https://www.amazon.com.br/")
          (link "AliExpress" "https://www.aliexpress.com/")
          (link "eBay" "https://www.ebay.com/")
          (link "Eneba" "https://www.eneba.com/")
          (link "SHEIN" "https://www.shein.com/")
          (link "Macy's" "https://www.macys.com/")
          (link "Overstock" "https://www.overstock.com/")
          (link "Target" "https://www.target.com/")
          (link "Americanas" "https://www.americanas.com.br/")
          (link "Submarino" "https://www.submarino.com.br/")
        ])

        (folder "Shopping Services" [
          (link "Instacart" "https://www.instacart.com/")
          (link "Rakuten" "https://www.rakuten.com/")
        ])
      ])

      (folder "Travel" [
        (folder "Hotels" [
          (link "Booking.com" "https://www.booking.com/")
          (link "Hotels.com" "https://www.hotels.com/")
          (link "Expedia" "https://www.expedia.com/")
        ])

        (folder "Flights" [
          (link "Kayak" "https://www.kayak.com/")
          (link "Skyscanner" "https://www.skyscanner.com/")
          (link "Trip.com" "https://www.trip.com/")
        ])

        (folder "Places & Activities" [
          (link "GetYourGuide" "https://www.getyourguide.com/")
          (link "Tripadvisor" "https://www.tripadvisor.com/")
          (link "Yelp" "https://www.yelp.com/")
        ])
      ])

      (folder "Personal" [
        (folder "Profiles" [
          (link "Twitter — MatuZ_0117" "https://twitter.com/MatuZ_0117")
          (link "Stack Overflow — Matuz" "https://pt.stackoverflow.com/users/301006/matuz?tab=questions")
        ])

        (folder "Work & Projects" [
          (link "Heroku — Assistant" "https://dashboard.heroku.com/apps/assistant-matuz")
          (link "Assistant Site" "https://assistentesite.herokuapp.com/")
          (link "OBS — Launch Parameters" "https://obsproject.com/kb/launch-parameters")
        ])

        (folder "Productivity" [
          (link "Pomofocus" "https://pomofocus.io/app")
          (link "Start.me" "https://start.me/")
        ])

        (folder "Job Search" [
          (link "LinkedIn — Saved Job" "https://www.linkedin.com/jobs/view/4339192557/")
        ])
      ])

      (folder "Read Later" [
        (link "NIST FIPS 204" "https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.204.pdf")
        (link "Introduction to Buddhism" "https://cms.sgi-usa.org/wp-content/uploads/2022/08/AnIntroductionToBuddhism-1.pdf")
      ])
    ];
  }
]
