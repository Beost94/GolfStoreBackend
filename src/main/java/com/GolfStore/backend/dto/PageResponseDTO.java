package com.GolfStore.backend.dto;

import lombok.Data;
import org.springframework.data.domain.Page;

import java.util.List;

@Data
public class PageResponseDTO<T> {
    private List<T> content;
    private int pageNumber;
    private int pageSize;
    private long totalElements;
    private int totalPages;
    private boolean last;

    public static <T> PageResponseDTO<T> of(Page<?> page, List<T> content) {
        PageResponseDTO<T> response = new PageResponseDTO<>();
        response.setContent(content);
        response.setPageNumber(page.getNumber());
        response.setPageSize(page.getSize());
        response.setTotalElements(page.getTotalElements());
        response.setTotalPages(page.getTotalPages());
        response.setLast(page.isLast());
        return response;
    }
}
