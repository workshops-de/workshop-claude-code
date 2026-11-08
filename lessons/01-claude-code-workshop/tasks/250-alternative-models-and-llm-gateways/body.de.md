## Überblick

Untersucht, wie sich Claude Code gegen **andere Modelle und Endpoints als die Standard-Anthropic-API**
betreiben lässt – über Enterprise-Provider und LLM-Gateways – und wägt Vorteile, Einschränkungen
und Trade-offs ab.

> Das ist vor allem eine Recherche- und Diskussionsaufgabe; ihr braucht kein produktives Gateway,
> um sie zu lösen.

## Hintergrund

Claude Code spricht mit einer Anthropic-kompatiblen API. Diesen Verkehr könnt ihr umleiten:
Enterprise-Provider wie Amazon Bedrock, Google Vertex AI und Microsoft Foundry betreiben Claude in
eurem Cloud-Account; ein **LLM-Gateway** sitzt zwischen Claude Code und dem Provider und wird über
`ANTHROPIC_BASE_URL` gesetzt. Gateways bündeln Authentifizierung, erfassen und deckeln Kosten und
protokollieren Interaktionen – aber ihr betreibt weiterhin Claude hinter einer kompatiblen
Oberfläche, nicht beliebige Drittanbieter- oder lokale Modelle mit vollem Funktionsumfang.

## Schritte

1. Kartiert die Routen: Listet auf, auf welchen Wegen ihr die Anfragen von
   Claude Code umleiten könnt, und was jeder Weg erfordert.
2. Lest, wie ein LLM-Gateway konfiguriert wird, und fasst zusammen, was es einer Organisation
   bietet.
3. Benennt die **Einschränkung** klar: Warum ist das nicht dasselbe wie ein beliebiges
   OpenAI-kompatibles oder lokales Modell mit vollem Funktionsumfang anzuschließen?
4. Bewertet **Vorteile, Einschränkungen und Trade-offs** für eine konkrete Rahmenbedingung (zum
   Beispiel: „Wir müssen den gesamten Verkehr in unserem Cloud-Account halten und die Kosten pro
   Team erfassen“).
5. Schreibt eine kurze Empfehlung für diese Rahmenbedingung und nennt die passende Konfiguration.
6. Optional: Setzt, falls ihr Zugang habt, `ANTHROPIC_BASE_URL` auf ein freigegebenes Gateway und
   bestätigt, dass eine Session sich verbindet.

## Erfolgskriterien

- [ ] Ihr habt die wichtigsten Routing-Optionen (Enterprise-Provider vs. Gateway) aufgelistet und
      was jede erfordert
- [ ] Ihr könnt die zentrale Einschränkung von „alternativen Modellen“ in Claude Code erklären
- [ ] Ihr habt eine kurze, konkrete Empfehlung für eine vorgegebene organisatorische
      Rahmenbedingung geschrieben

## Referenzen

- Claude Code – LLM gateway configuration: https://code.claude.com/docs/en/llm-gateway
- Claude Code – Amazon Bedrock: https://code.claude.com/docs/en/amazon-bedrock
- Claude Code – Google Vertex AI: https://code.claude.com/docs/en/google-vertex-ai
- Claude Code – Enterprise deployment overview: https://code.claude.com/docs/en/third-party-integrations
