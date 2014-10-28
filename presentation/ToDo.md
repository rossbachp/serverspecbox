# Comeing soon

  * Hinzufügen der Graffle-Dokumente
    * Update der Bilder auf das Format der Präsentation (Kleiner)
    * Fix Bild mit dem Zeitstempel!
  * Rechte an den Bildern!
    * Herkunft im Abspann erwähnen (Regina)
  * Apache Lizenz Einstellen
    * auf in der Containerbereitstellung
  * Slides WebTechConf 2014
    * JavaScript Beispiel
    * Abgrenzung des Themas
      * Kein Integrationstest
      * Kein Loadtest
      * Kein Check at Runtime
    * Erwartung klären
      * Fokus auf Docker geht aber natürlich auch für alle andere Infrastruktur
      * Fokus auf entstehen eines Docker-Images
      * Fokus auf Bereitstellung eines Docker-Containers
      * Fokus auf Test des Docker Hosts, Images und Container
  * Slides WJAX 2014
    * Einleitung in des Thema
    * Mehr auf serverspec eingehen
    * Role based specs vs. host based
    * Nutzung von Konfigurationen => Properties
  * Erzeugen von *Printable Slidedecks*
  * Integration von Butterfly

## Ideen für mehr

  * Deployment der Test in einem Container
    * Test as a service
    * Prüfen von Guidelines (Sicherheit, Konventionen (Kein Start mit Nutzer Root, Deticated priv Container))
  * docker exec statt nsenter
  * deployment in einen Webserver, automatische Registierung auf index.html!
    * Container referenz
    * Detect new version at Docker hub...
      * Use a Service discovery vor that
      * registrator detect start and then you get it!
    * Nutze Data Container (--volume-from && scratch container)
  * Integration in das Maven Plugin von Roland
	  * Diskussion auf der WJAX
