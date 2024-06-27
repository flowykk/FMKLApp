package hse.kpo.ticketsservice.controller

import hse.kpo.ticketsservice.service.TeamService
import org.springframework.web.bind.annotation.*
import kotlin.io.encoding.ExperimentalEncodingApi

@RestController
@RequestMapping("teams")
@ExperimentalEncodingApi
class TeamsController(
    private val ticketService: TeamService
) {
    @GetMapping("get-teams")
    fun getTeams() = ticketService.getTeams()
}