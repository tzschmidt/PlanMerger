##Ideen f�r Plan merging

Es gibt zwei arten von Roboter-Roboter Kollisionen:
1. Mehrere Roboter befinden sich zur selben Zeit an der selben Stelle.
2. Zwei Roboter gehen ineinander vorbei.


*Fehler Behebung:* 

(Zu dem zweiten Punkt: Bei der Generierung der Pl�ne der einzelnen Roboter k�nnte man bei jeder Bewegung zu diesem Zeitpunkt ein Statement erstellen, welches die Bewegungsrichtung angibt. Wenn sich eine Roboter auf Position (1,1) zur Zeit t=2 nach rechts bewegt, wird das Statement mit diesen drei Parametern wahr. Alle Roboter d�rfen nun nicht zur Zeit t=2 von der rechten Seite auf die Position (1,1) wandern.)

*Idee �Warten�:*
(Warten eines  Roboters bedeutet in diesem Fall, dass der Zeit Wert aller nachfolgenden Bewegungen des Roboters um einen Betrag erh�ht wird.)

Falls eine Kollision auftritt k�nnte eines der Roboter warte. Dazu k�nnte man Priorit�ten benutzen, die zum Beispiel von der ID abh�ngt. Gibt es also einen Konflikt zwischen zwei Robotern, wartet der mit der niedrigeren ID.
Eine andere Idee w�hre, dass der Roboter der n�her an seinem Ziel ist (eine geringere Distanz zu seiner Picking Station hat) eine h�here Priorit�t hat. Die Idee dahinter ist, dass Roboter, die schon an ihrem Ziel sind andere Roboter nicht mehr so stark beeintr�chtigen. Bei gleicher Distanz zum Ziel gilt wieder h�here ID = Priorit�t.


*Problem:* Zwei Roboter k�nnten gegenseitig unendlich lange aufeinander warten. Man m�sste also den Pfad des Roboters mit h�herer Priorit�t neu generieren.

*Idee:* Man generiert den Pfad dieses Roboters neu von der aktuellen Position und betrachtet den anderen, wartenden Roboter als eine Wand(als man l�scht den Highway Knoten unter ihm.)
