<%
    ui.decorateWith("appui", "standardEmrPage")

    ui.includeJavascript("uicommons", "angular.min.js")
    ui.includeJavascript("uicommons", "angular-ui/ui-bootstrap-tpls-0.11.2.min.js")
    ui.includeJavascript("uicommons", "ngDialog/ngDialog.js")
    ui.includeJavascript("zlconsultnote", "visits.js")

    ui.includeCss("uicommons", "ngDialog/ngDialog.min.css")
%>

<style type="text/css">
    .visit-label {
        color: #003f5e;
        background: #f9f9f9;
        font-size: 0.9em;
        border: 1px solid black;
        padding: 5px;
        margin: 5px 0;
    }

    .visit-label span {
        display: inline-block;
        width: 23%;
    }

    .ngdialog-content {
        width: 1000px !important;
        height: 600px !important;
    }

    .card {
        border: 1px black solid;
        padding: 5px;
        margin: 10px 0;
    }

    .card-header {
        border-bottom: 1px black solid;
        padding-bottom: 5px;
        margin-bottom: 5px;
    }

    .card-header .label {
        display: inline-block;
        width: 350px;
    }

    .card-header .details {
        display: inline-block;
    }

    .card-header .icons {
        float: right;
    }

    .card-header .icons i {
        cursor: pointer;
    }

    .button.task {
        margin-right: 6px;
        margin-bottom: 4px;
    }

    ul#formBreadcrumb li.doing .question-legend .icon-user {
        font-size: 0.7em;
        margin-left: 4px;
    }

    #formContent section {
        margin-left: 220px;
        overflow: hidden;
    }
</style>

${ ui.includeFragment("coreapps", "patientHeader", [patient: patient]) }

<div id="visit-app" ng-controller="VisitCtrl">
    <div style="position: absolute; right: 0; top: 0;">
        <button ng-click="switchMode()">A / B</button>
    </div>

    <script type="text/ng-template" id="fillFormDialogTemplate">
        <div class="dialog-header">
            <h3>Fill out {{ ngDialogData.title }}</h3>
        </div>
        <div class="dialog-content">
            <em ng-show="ngDialogData.type == 'form'">This form will either be a new page, or else in-line; it won't be a popup dialog.</em>
            <em ng-show="ngDialogData.type == 'longitudinal'">Longitudinal data will be edited in its own separate page, not a popup.</em>
            <div ng-include="ngDialogData.template">
            </div>
            <div>
                <button class="confirm right" ng-click="confirm()">Save</button>
                <button class="cancel" ng-click="closeThisDialog()">Discard</button>
            </div>
        </div>
    </script>

    <div class="visit-label">
        <span><strong>Active visit</strong></span>
        <span>Start: {{ pageLoaded | date:'medium'}}</span>
        <span>Location: Thomonde</span>
        <span>Type: Peds Initial</span>

        <div class="right">
            <i class="icon-pencil"></i>
            <i class="icon-remove"></i>
        </div>
    </div>

    <div ng-if="mode == 'flow'">
        <div ng-repeat="section in sections">

            <div ng-if="section.type == 'form'">
                <div ng-show="section.filled">
                    <div class="card">
                        <div class="card-header">
                            <div class="icons">
                                <i class="icon-plus" ng-show="section.displayMode == 'summary'" ng-click="toggleDisplayMode(section)"></i>
                                <i class="icon-minus" ng-show="section.displayMode == 'full' && section.summary" ng-click="toggleDisplayMode(section)"></i>
                                <i class="icon-pencil"></i>
                                <i class="icon-remove" ng-click="section.filled = false"></i>
                            </div>
                            <div class="label">
                                <strong>{{ section.label }}</strong>
                            </div>
                            <div class="details">
                                {{ section.filled.when | date:'medium' }} by {{ section.filled.who }}
                            </div>
                        </div>

                        <div ng-include="section.displayMode == 'summary' ? section.summary : section.template"></div>
                    </div>
                </div>

                <div ng-hide="section.filled">
                    <button class="button task" ng-click="fillSection(section)">{{ section.short }}</button>
                </div>
            </div>

            <div ng-if="section.type == 'longitudinal'">
                <div class="card">
                    <div class="card-header">
                        <div class="icons">
                            <i class="icon-pencil" ng-click="fillSection(section)"></i>
                        </div>
                        <div class="label">
                            <strong>Review {{ section.label }}</strong>
                        </div>
                        <div class="details">
                            Longitudinal data, not just for this visit
                        </div>
                    </div>
                    <div ng-include="section.summary ? section.summary : section.template"></div>
                    <a ng-click="fillSection(section)">Edit {{ section.label }}</a>
                </div>
            </div>
        </div>
    </div>

    <div ng-if="mode == 'sidebar'">
        <form style="background: white">
            <ul id="formBreadcrumb">
                <li class="doing">
                    <span>Peds Initial Visit</span>
                    <ul>
                        <li class="question-legend" ng-class="{focused: selectedSection=='Overview'}" ng-click="selectSection('Overview')"><span>Overview</span></li>
                        <li ng-repeat="section in sections" class="question-legend" ng-class="{focused: isSelected(section), done: isFilled(section)}" ng-click="selectSection(section)">
                            <i ng-if="section.type == 'form'" class="icon-ok"></i>
                            <i ng-if="section.type == 'longitudinal'" class="icon-user"></i>
                            <span>{{ section.short }}</span>
                        </li>
                    </ul>
                </li>
            </ul>

            <div id="formContent">
                <section id="Overview" ng-show="selectedSection == 'Overview'">

                    <fieldset ng-repeat="section in sections">
                        <h3>{{ section.label }}</h3>
                        <div ng-include="section.summary ? section.summary : section.template"></div>
                    </fieldset>

                </section>
                <section ng-repeat="section in sections" ng-show="isSelected(section)" class="focused">
                    <fieldset class="focused">
                        <h3>{{section.label}}</h3>
                        <div ng-include="section.template"></div>

                        <div>
                            <button ng-show="section.type == 'form'" class="confirm right" ng-click="filledSection(section)">Save</button>
                            <button ng-show="section.type == 'longitudinal'" class="confirm right" ng-click="fillSection(section)">Edit</button>
                        </div>
                    </fieldset>
                </section>
            </div>
        </form>
    </div>

</div>

<script type="text/javascript">
    angular.bootstrap("#visit-app", [ 'visit' ]);
</script>