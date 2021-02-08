package se.magnus.api.core.recommendation;

import org.springframework.http.HttpHeaders;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;

public interface RecommendationService {

    Recommendation createRecommendation(@RequestBody Recommendation body);

    /**
     * Sample usage:
     * <p>
     * curl $HOST:$PORT/recommendation?productId=1
     *
     * @param productId
     * @return
     */
    @GetMapping(

            value = "/recommendation",
            produces = "application/json")
    Flux<Recommendation> getRecommendations(@RequestHeader HttpHeaders httpHeaders, @RequestParam(value = "productId", required = true) int productId);

    void deleteRecommendations(@RequestParam(value = "productId", required = true)  int productId);
}
