package com.example.sweater.controllers;

import com.electronwill.nightconfig.core.conversion.Path;
import com.example.sweater.domain.Message;
import com.example.sweater.domain.User;
import com.example.sweater.repositories.MessageRepository;
import io.micrometer.common.util.StringUtils;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collector;
import java.util.stream.Collectors;

@Controller
public class MainController {

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    private MessageRepository messageRepository;
    @GetMapping("/")
    public String greeting() {
        return "greeting";
    }

    @GetMapping("/main")
    public String main(@RequestParam(required = false, defaultValue = "") String filter, Model model) {
        Iterable<Message> messages;
        if (filter != null && !filter.isEmpty()) {
            messages = messageRepository.findByTag(filter);
        } else {
            messages = messageRepository.findAll();
        }
        model.addAttribute("messages", messages);
        model.addAttribute("filter", filter);



        return "main";
    }

    @PostMapping("/main")
    public String add(@AuthenticationPrincipal User user,
                      @Valid Message message,
                      BindingResult bindingResult,
                      Model model,
                      @RequestParam("file") MultipartFile file) throws IOException {
        message.setAuthor(user);

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("message", message);
        } else {

            saveFile(message, file);

            model.addAttribute("message", null);

            messageRepository.save(message);
        }
        Iterable<Message> messages = messageRepository.findAll();
        model.addAttribute("messages", messages);
        return "main";
    }

    private void saveFile(Message message, MultipartFile file) throws IOException {
        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFilename));

            message.setFilename(resultFilename);
        }
    }

    @GetMapping("/user-messages/{user}")
    public String userMessages(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            Model model,
            @RequestParam(required = false) Message message
    ) {
        Set<Message> messages = user.getMessages();
        model.addAttribute("messages", messages);
        model.addAttribute("isCurrentUser", currentUser.equals(user));
        model.addAttribute("message", message);
        return "userMessages";
    }

    @PostMapping("/user-messages/{user}")
    public String updateMessage(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long user,
            @RequestParam("id") Message message,
            @RequestParam("text") String text,
            @RequestParam("tag") String tag,
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        if(message.getAuthor().equals(currentUser)) {
            if(!StringUtils.isEmpty(text)) {
                message.setText(text);
            }
            if(!StringUtils.isEmpty(tag)) {
                message.setTag(tag);
            }

            saveFile(message, file);
            messageRepository.save(message);
        }

        return "redirect:/user-messages/" + user;
    }


}
