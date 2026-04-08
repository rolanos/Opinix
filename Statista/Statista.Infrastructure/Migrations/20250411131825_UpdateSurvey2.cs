using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class UpdateSurvey2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AdminGroup_Surveys_SurveyId",
                table: "AdminGroup");

            migrationBuilder.DropForeignKey(
                name: "FK_Answers_Surveys_SurveyId",
                table: "Answers");

            migrationBuilder.DropForeignKey(
                name: "FK_RespondentGroup_Surveys_SurveyId",
                table: "RespondentGroup");

            migrationBuilder.DropForeignKey(
                name: "FK_Surveys_Form_FormId",
                table: "Surveys");

            migrationBuilder.DropForeignKey(
                name: "FK_Surveys_User_CreatedById",
                table: "Surveys");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Surveys",
                table: "Surveys");

            migrationBuilder.DropIndex(
                name: "IX_Surveys_FormId",
                table: "Surveys");

            migrationBuilder.RenameTable(
                name: "Surveys",
                newName: "Survey");

            migrationBuilder.RenameIndex(
                name: "IX_Surveys_CreatedById",
                table: "Survey",
                newName: "IX_Survey_CreatedById");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Survey",
                table: "Survey",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_Form_SurveyId",
                table: "Form",
                column: "SurveyId",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_AdminGroup_Survey_SurveyId",
                table: "AdminGroup",
                column: "SurveyId",
                principalTable: "Survey",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Answers_Survey_SurveyId",
                table: "Answers",
                column: "SurveyId",
                principalTable: "Survey",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Form_Survey_SurveyId",
                table: "Form",
                column: "SurveyId",
                principalTable: "Survey",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_RespondentGroup_Survey_SurveyId",
                table: "RespondentGroup",
                column: "SurveyId",
                principalTable: "Survey",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Survey_User_CreatedById",
                table: "Survey",
                column: "CreatedById",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AdminGroup_Survey_SurveyId",
                table: "AdminGroup");

            migrationBuilder.DropForeignKey(
                name: "FK_Answers_Survey_SurveyId",
                table: "Answers");

            migrationBuilder.DropForeignKey(
                name: "FK_Form_Survey_SurveyId",
                table: "Form");

            migrationBuilder.DropForeignKey(
                name: "FK_RespondentGroup_Survey_SurveyId",
                table: "RespondentGroup");

            migrationBuilder.DropForeignKey(
                name: "FK_Survey_User_CreatedById",
                table: "Survey");

            migrationBuilder.DropIndex(
                name: "IX_Form_SurveyId",
                table: "Form");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Survey",
                table: "Survey");

            migrationBuilder.RenameTable(
                name: "Survey",
                newName: "Surveys");

            migrationBuilder.RenameIndex(
                name: "IX_Survey_CreatedById",
                table: "Surveys",
                newName: "IX_Surveys_CreatedById");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Surveys",
                table: "Surveys",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_Surveys_FormId",
                table: "Surveys",
                column: "FormId",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_AdminGroup_Surveys_SurveyId",
                table: "AdminGroup",
                column: "SurveyId",
                principalTable: "Surveys",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Answers_Surveys_SurveyId",
                table: "Answers",
                column: "SurveyId",
                principalTable: "Surveys",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_RespondentGroup_Surveys_SurveyId",
                table: "RespondentGroup",
                column: "SurveyId",
                principalTable: "Surveys",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Surveys_Form_FormId",
                table: "Surveys",
                column: "FormId",
                principalTable: "Form",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Surveys_User_CreatedById",
                table: "Surveys",
                column: "CreatedById",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
