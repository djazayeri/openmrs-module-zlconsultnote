<%
    def pmh = [
            [label: "Asthme", extra: false],
            [label: "Cardiopathie", extra: false],
            [label: "Chirurgie/Trauma", extra: true],
            [label: "Epilepsie", extra: false],
            [label: "Hémoglobinopathie", extra: true],
            [label: "HTA", extra: false],
            [label: "IST", extra: true],
            [label: "Malf. Congénitales", extra: true],
            [label: "Malnutrition/Perte de poids", extra: false],
            [label: "Rougeole", extra: false],
            [label: "Tuberculose", extra: false],
            [label: "Varicelle", extra: false],
            [label: "Diphtérie", extra: false],
            [label: "RAA", extra: false],
            [label: "Diabète", extra: false],
            [label: "Prématuré", extra: false],
            [label: "Autre", extra: true]
    ]
    def systems = [
            'Géneral', 'Etat mental', 'Peau/muquese', 'Tête / Cou / ORL', 'Cardiovasculaire',
            'Pulmonaire', 'GI / Abdomen', 'GU / Rectal', 'Musculosquelettique'
    ]
%>

<h4>Motifs de consultation</h4>
<textarea rows="3" cols="80"></textarea>

<h4>Antecedents personnels / Habitudes</h4>
<table>
    <tbody>
        <% pmh.each { %>
            <tr>
                <td>
                    <input type="checkbox"/>${it.label}
                    <% if (it.extra) { %> <input type="text" size="40" placeholder="Préciser"/> <% } %>
                </td>
            </tr>
        <% } %>
    </tbody>
</table>

<form>
<p>
    <label>Médicaments actuels:</label>
    <input type="text" size="80"/>
</p>

<p>
    <label>Examens paracliniques déjà effectués</label>
    <textarea rows="3" cols="60"></textarea>
</p>

<p>
    <label>Hospitalisation antérieure</label>
    <div style="display:inline-block"><input type="checkbox"/>Oui</div>
    <div style="display:inline-block"><input type="checkbox"/>Non</div>
    <div style="display:inline-block"><input type="checkbox"/>Inconnu</div>
    <div style="display:inline-block">
        ... Si oui, cause: <input type="text" size="40" style="display: inline; min-width: 0%"/>
    </div>
</p>
</form>

<img src="${ ui.resourceLink("zlconsultnote", "images/Family History.png") }"/><br/>
<img src="${ ui.resourceLink("zlconsultnote", "images/Feeding.png") }"/><br/>

<table>
    <tbody>
        <% systems.each { %>
            <tr>
                <td>${it}</td>
                <td><input type="checkbox"/>Normal</td>
                <td><input type="checkbox"/>Anormal</td>
                <td><input type="text" size="40" placeholder="Description des conclusions anormales"/></td>
            </tr>
        <% } %>
    </tbody>
</table>

<label>Autres trouvailles a l'examen physique</label><br/>
<textarea rows="4" cols="80">
</textarea>

<img src="${ ui.resourceLink("zlconsultnote", "images/Psychomotor.png") }"/>
