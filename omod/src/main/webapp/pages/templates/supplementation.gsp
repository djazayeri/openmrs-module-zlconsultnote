<%
    def list = [
            "Vitamine A", "Fer", "Iode", "Deparasitage", "Zinc"
    ]
%>

<disable-img src="${ ui.resourceLink("zlconsultnote", "images/Supplementation.png") }"/>

<% list.each { %>
    <input type="checkbox"/>
    <div style="display: inline-block; width: 150px;">
        ${it}
    </div>
    Age (en mois ou en année): <input type="text" size="5"/>
    <br/>
<% } %>
