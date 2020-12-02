## Ideen für Plan merging

Es gibt zwei arten von Roboter-Roboter Kollisionen:
1. Mehrere Roboter befinden sich zur selben Zeit an der selben Stelle.
2. Zwei Roboter gehen ineinander vorbei.


**Fehler Behebung:** 

(Zu dem zweiten Punkt: Bei der Generierung der Pläne der einzelnen Roboter könnte man bei jeder Bewegung zu diesem Zeitpunkt ein Statement erstellen, welches die Bewegungsrichtung angibt. Wenn sich eine Roboter auf Position (1,1) zur Zeit t=2 nach rechts bewegt, wird das Statement mit diesen drei Parametern wahr. Alle Roboter dürfen nun nicht zur Zeit t=2 von der rechten Seite auf die Position (1,1) wandern.)

**Idee „Warten“:**
(Warten eines  Roboters bedeutet in diesem Fall, dass der Zeit Wert aller nachfolgenden Bewegungen des Roboters um einen Betrag erhöht wird.)

Falls eine Kollision auftritt könnte eines der Roboter warte. Dazu könnte man Prioritäten benutzen, die zum Beispiel von der ID abhängt. Gibt es also einen Konflikt zwischen zwei Robotern, wartet der mit der niedrigeren ID.
Eine andere Idee währe, dass der Roboter der näher an seinem Ziel ist (eine geringere Distanz zu seiner Picking Station hat) eine höhere Priorität hat. Die Idee dahinter ist, dass Roboter, die schon an ihrem Ziel sind andere Roboter nicht mehr so stark beeinträchtigen. Bei gleicher Distanz zum Ziel gilt wieder höhere ID = Priorität.


**Problem:** Zwei Roboter könnten gegenseitig unendlich lange aufeinander warten. Man müsste also den Pfad des Roboters mit höherer Priorität neu generieren.

**Idee:** Man generiert den Pfad dieses Roboters neu von der aktuellen Position und betrachtet den anderen, wartenden Roboter als eine Wand(als man löscht den Highway Knoten unter ihm.)
