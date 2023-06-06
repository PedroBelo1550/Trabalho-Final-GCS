package com.ViverBemApp.viverBem;

import com.ViverBemApp.viverBem.controller.SendNotificationEmailController;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

@WebMvcTest(SendNotificationEmailTests.class)
public class SendNotificationEmailTests {

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void sendNotificationEmailEndpointExistsTest() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.post("/send-email"))
                .andExpect(MockMvcResultMatchers.status().isNotFound());

    }
}
