<details>
<summary>💡 Tipp 1: Erst lesen, dann vertrauen</summary>

Ein installierter Skill besteht aus Anweisungen, denen der Agent folgt. Überfliegt seine `SKILL.md`
so, wie ihr die README einer Dependency überfliegt – was sagt sie dem Agenten, zu tun? Wer pflegt
sie?

</details>

<details>
<summary>💡 Tipp 2: Kein automatischer Aufruf?</summary>

Vergleicht euren Prompt mit der Beschreibung des Skills. Der automatische Aufruf passiert, wenn die
Aufgabe zur Formulierung der Beschreibung passt – formuliert um, oder ruft ihn explizit auf und
haltet den Unterschied fest.

</details>

<details>
<summary>💡 Tipp 3: Die Cover erscheinen nicht?</summary>

Schaut nach, was das Feld `cover` tatsächlich enthält und worauf es zeigt. Das `<Image>` von Next.js
lädt nur Remote-Hosts, die ihr in der `next.config` erlaubt – ein einfaches `<img>` ist für diesen
Workshop genauso in Ordnung. Die Cover kommen von `localhost:4730`, und Next.js optimiert keine Bilder
von privaten Adressen, daher braucht ihr mit `<Image>` zusätzlich `unoptimized`.

</details>
