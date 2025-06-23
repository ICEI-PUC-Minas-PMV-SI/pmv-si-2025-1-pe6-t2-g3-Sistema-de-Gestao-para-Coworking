package com.pucminas.conectabh_service.adapter;

import java.util.List;
import java.util.stream.Collectors;

public interface Adapter<T, S> {
    S convert(T t);

    default List<S> convert(List<T> list) {
        return list.stream().map(this::convert).collect(Collectors.toList());
    }
}
