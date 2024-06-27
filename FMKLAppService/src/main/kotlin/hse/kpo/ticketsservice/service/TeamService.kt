package hse.kpo.ticketsservice.service

import hse.kpo.ticketsservice.repository.TeamRepository
import org.springframework.http.HttpEntity
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import kotlin.io.encoding.ExperimentalEncodingApi

@Service
@ExperimentalEncodingApi
class TeamService(
    private val teamRepository: TeamRepository
) {
    @Transactional
    fun getTeams() : ResponseEntity<Any> {
        return ResponseEntity.status(HttpStatus.OK).body(teamRepository.findAll())
    }
}