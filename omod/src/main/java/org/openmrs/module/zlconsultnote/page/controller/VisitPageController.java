package org.openmrs.module.zlconsultnote.page.controller;

import org.openmrs.Patient;
import org.openmrs.api.PatientService;
import org.openmrs.ui.framework.annotation.SpringBean;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

public class VisitPageController {

    public void get(@RequestParam("patient") Patient patient,
                    PageModel model) {
        model.addAttribute("patient", patient);
    }

}
