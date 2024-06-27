package hse.kpo.authorizationservice.models

import org.springframework.data.annotation.Id
import org.springframework.data.relational.core.mapping.Column
import org.springframework.data.relational.core.mapping.Table

@Table("teams")
class Team(
    @Id @Column("id")
    val id: Int? = null,
    @Column("shortname")
    private val shortname: String,
    @Column("fullname")
    private val fullname: String,
    @Column("points")
    private val points: Int,
    @Column("wins")
    private val wins: Int,
    @Column("loses")
    private val loses: Int,
    @Column("goalsscored")
    private val goalsscored: Int,
    @Column("goalsmissed")
    private val goalsmissed: Int,
) {
    fun getShortname(): String = shortname
    fun getFullname(): String = fullname
    fun getPoints(): Int = points
    fun getWins(): Int = wins
    fun getLoses(): Int = loses
    fun getGoalsscored(): Int = goalsscored
    fun getGoalsmissed(): Int = goalsmissed
}