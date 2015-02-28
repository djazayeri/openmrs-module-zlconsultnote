angular.module('visit', [ 'ngDialog' ])
    .controller('VisitCtrl', [ '$scope', 'ngDialog', function($scope, ngDialog) {

        $scope.mode = "sidebar"; // vs "sidebar"
        $scope.switchMode = function() {
            $scope.mode = $scope.mode == 'flow' ? 'sidebar' : 'flow';
        }

        $scope.selectedSection = "Overview";
        $scope.isSelected = function(section) {
            console.log(section.id + " " + $scope.selectedSection + " -> " + (section.id == $scope.selectedSection));
            return section != null && section.id == $scope.selectedSection;
        }
        $scope.selectSection = function(section) {
            if (typeof section == 'string') {
                $scope.selectedSection = section;
            }
            else {
                $scope.selectedSection = section.id;
            }
        }

        $scope.pageLoaded = new Date();

        $scope.sections = [
            {
                id: "checkin",
                label: "Section pre-consultation",
                short: "Pre-consultation",
                type: "form",
                template: "templates/checkin.page",
                summary: "templates/checkinSummary.page"
            },
            {
                id: "vaccine",
                label: "Vaccin",
                short: "Vaccin",
                type: "longitudinal",
                template: "templates/vaccination.page"
            },
            {
                id: "supplementation",
                label: "Supplementation en vitamine A, Fer, Iode, Deparasitage",
                short: "Supplementation",
                type: "form",
                template: "templates/supplementation.page",
                summary: "templates/supplementationSummary.page"
            },
            {
                id: "vitals",
                label: "Signes vitaux et mesures anthropometriques",
                short: "Signes et mesures",
                type: "form",
                template: "templates/vitals.page"
            },
            {
                id: "allergies",
                label: "Allergies",
                short: "Allergies",
                type: "longitudinal",
                template: "templates/allergies.page",
                summary: "templates/allergiesSummary.page"
            },
            {
                id: "consult",
                label: "Consultation medicale",
                short: "Consultation medicale",
                type: "form",
                template: "templates/medicalConsult.page",
                summary: "templates/medicalConsultSummary.page"
            },
            {
                id: "impressions",
                label: "Impression clinique/Diagnostique et Conduite a tenir",
                short: "Impression et Conduite",
                type: "form",
                template: "templates/impressionAndPlan.page"
            }
        ];

        _.each($scope.sections, function(it) {
            it.filled = false;
            it.displayMode = it.summary ? 'summary' : 'full';
        });

        $scope.toggleDisplayMode = function(section) {
            if (section.displayMode == 'full' && section.summary) {
                section.displayMode = 'summary';
            }
            else {
                section.displayMode = 'full';
            }
        }

        $scope.fillSection = function(section) {
            ngDialog.openConfirm({
                showClose: false,
                closeByEscape: false,
                closeByDocument: false,
                data: angular.toJson({
                    title: section.label,
                    type: section.type,
                    template: section.template
                }),
                template: 'fillFormDialogTemplate'
            }).then(function() {
                $scope.filledSection(section);
            });

            //$scope.filledSection(section);
        }
        $scope.filledSection = function(section) {
            if (section.type == 'form') {
                section.filled = {
                    who: "User's name",
                    when: new Date()
                };
            }
            goToNextSection();
        }

        function goToNextSection() {
            var i = 0;
            for (i = 0; i < $scope.sections.length; ++i) {
                if ($scope.isSelected($scope.sections[i])) {
                    break;
                }
            }
            i += 1;
            if (i >= $scope.sections.length) {
                $scope.selectSection('Overview');
            } else {
                $scope.selectSection($scope.sections[i]);
            }
        }

        $scope.isFilled = function(section) {
            return section.type == 'longitudinal' || section.filled;
        }
    }]);