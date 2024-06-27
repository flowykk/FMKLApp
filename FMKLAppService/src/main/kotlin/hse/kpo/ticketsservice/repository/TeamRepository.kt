package hse.kpo.ticketsservice.repository

import hse.kpo.authorizationservice.models.Team
import org.springframework.data.repository.CrudRepository

interface TeamRepository: CrudRepository<Team, Int> {

}