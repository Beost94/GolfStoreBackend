package com.GolfStore.backend.annotations;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = ActionValidator.class)
@Target({ElementType.FIELD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
public @interface ActionConstraint {
    String message() default "Invalid action. Must be one of: Add, Subtract, Delete";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
