package com.example.demo.controllers;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HealthCheckController {
    protected final Log logger = LogFactory.getLog(this.getClass());

    @GetMapping("/healthCheck")
    public String healthCheck(@RequestParam("name") String name, Model model) {
        model.addAttribute("name", name);
        logger.debug("name: " + name);
        return "healthCheck";
    }
}
