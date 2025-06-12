package com.GolfStore.backend.annotations;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

import java.util.Set;

public class ActionValidator implements ConstraintValidator<com.GolfStore.backend.annotations.ActionConstraint, String> {

    private static final Set<String> ALLOWED_ACTIONS = Set.of("add", "subtract", "delete");

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        return value != null && ALLOWED_ACTIONS.contains(value);
    }
}
