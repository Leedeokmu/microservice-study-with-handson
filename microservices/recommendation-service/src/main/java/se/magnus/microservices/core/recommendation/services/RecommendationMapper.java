package se.magnus.microservices.core.recommendation.services;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import se.magnus.api.core.recommendation.Recommendation;
import se.magnus.microservices.core.recommendation.persistence.RecommendationEntity;

import java.util.List;

@Mapper(componentModel = "spring")
public interface RecommendationMapper {

    @Mappings({
            @Mapping(source="entity.rating", target = "rate"),
            @Mapping(target = "serviceAddress", ignore = true)
    })
    Recommendation entityToApi(RecommendationEntity entity);

    @Mappings({
            @Mapping(source="api.rate", target = "rating"),
            @Mapping(target = "id", ignore = true),
            @Mapping(target = "version", ignore = true)
    })
    RecommendationEntity apiToEntity(Recommendation api);

    List<Recommendation> entityListToApiList(List<RecommendationEntity> entity);
    List<RecommendationEntity> apiListToEntityList(List<Recommendation> api);
}