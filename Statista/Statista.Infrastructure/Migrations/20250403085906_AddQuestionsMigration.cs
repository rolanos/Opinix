using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddQuestionsMigration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Answer_AvailableAnswer_AnswerValueId",
                table: "Answer");

            migrationBuilder.DropForeignKey(
                name: "FK_Answer_Surveys_SurveyId",
                table: "Answer");

            migrationBuilder.DropForeignKey(
                name: "FK_Answer_User_RespondentId",
                table: "Answer");

            migrationBuilder.DropForeignKey(
                name: "FK_AvailableAnswer_Question_QuestionId",
                table: "AvailableAnswer");

            migrationBuilder.DropForeignKey(
                name: "FK_Sections_Forms_FormId",
                table: "Sections");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AvailableAnswer",
                table: "AvailableAnswer");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Answer",
                table: "Answer");

            migrationBuilder.RenameTable(
                name: "AvailableAnswer",
                newName: "AvailableAnswers");

            migrationBuilder.RenameTable(
                name: "Answer",
                newName: "Answers");

            migrationBuilder.RenameColumn(
                name: "imageLink",
                table: "AvailableAnswers",
                newName: "ImageLink");

            migrationBuilder.RenameIndex(
                name: "IX_AvailableAnswer_QuestionId",
                table: "AvailableAnswers",
                newName: "IX_AvailableAnswers_QuestionId");

            migrationBuilder.RenameIndex(
                name: "IX_Answer_SurveyId",
                table: "Answers",
                newName: "IX_Answers_SurveyId");

            migrationBuilder.RenameIndex(
                name: "IX_Answer_RespondentId",
                table: "Answers",
                newName: "IX_Answers_RespondentId");

            migrationBuilder.RenameIndex(
                name: "IX_Answer_AnswerValueId",
                table: "Answers",
                newName: "IX_Answers_AnswerValueId");

            migrationBuilder.AlterColumn<Guid>(
                name: "FormId",
                table: "Sections",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uuid",
                oldNullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "PK_AvailableAnswers",
                table: "AvailableAnswers",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Answers",
                table: "Answers",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Answers_AvailableAnswers_AnswerValueId",
                table: "Answers",
                column: "AnswerValueId",
                principalTable: "AvailableAnswers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Answers_Surveys_SurveyId",
                table: "Answers",
                column: "SurveyId",
                principalTable: "Surveys",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Answers_User_RespondentId",
                table: "Answers",
                column: "RespondentId",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AvailableAnswers_Question_QuestionId",
                table: "AvailableAnswers",
                column: "QuestionId",
                principalTable: "Question",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Sections_Forms_FormId",
                table: "Sections",
                column: "FormId",
                principalTable: "Forms",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Answers_AvailableAnswers_AnswerValueId",
                table: "Answers");

            migrationBuilder.DropForeignKey(
                name: "FK_Answers_Surveys_SurveyId",
                table: "Answers");

            migrationBuilder.DropForeignKey(
                name: "FK_Answers_User_RespondentId",
                table: "Answers");

            migrationBuilder.DropForeignKey(
                name: "FK_AvailableAnswers_Question_QuestionId",
                table: "AvailableAnswers");

            migrationBuilder.DropForeignKey(
                name: "FK_Sections_Forms_FormId",
                table: "Sections");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AvailableAnswers",
                table: "AvailableAnswers");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Answers",
                table: "Answers");

            migrationBuilder.RenameTable(
                name: "AvailableAnswers",
                newName: "AvailableAnswer");

            migrationBuilder.RenameTable(
                name: "Answers",
                newName: "Answer");

            migrationBuilder.RenameColumn(
                name: "ImageLink",
                table: "AvailableAnswer",
                newName: "imageLink");

            migrationBuilder.RenameIndex(
                name: "IX_AvailableAnswers_QuestionId",
                table: "AvailableAnswer",
                newName: "IX_AvailableAnswer_QuestionId");

            migrationBuilder.RenameIndex(
                name: "IX_Answers_SurveyId",
                table: "Answer",
                newName: "IX_Answer_SurveyId");

            migrationBuilder.RenameIndex(
                name: "IX_Answers_RespondentId",
                table: "Answer",
                newName: "IX_Answer_RespondentId");

            migrationBuilder.RenameIndex(
                name: "IX_Answers_AnswerValueId",
                table: "Answer",
                newName: "IX_Answer_AnswerValueId");

            migrationBuilder.AlterColumn<Guid>(
                name: "FormId",
                table: "Sections",
                type: "uuid",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uuid");

            migrationBuilder.AddPrimaryKey(
                name: "PK_AvailableAnswer",
                table: "AvailableAnswer",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Answer",
                table: "Answer",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Answer_AvailableAnswer_AnswerValueId",
                table: "Answer",
                column: "AnswerValueId",
                principalTable: "AvailableAnswer",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Answer_Surveys_SurveyId",
                table: "Answer",
                column: "SurveyId",
                principalTable: "Surveys",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Answer_User_RespondentId",
                table: "Answer",
                column: "RespondentId",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AvailableAnswer_Question_QuestionId",
                table: "AvailableAnswer",
                column: "QuestionId",
                principalTable: "Question",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Sections_Forms_FormId",
                table: "Sections",
                column: "FormId",
                principalTable: "Forms",
                principalColumn: "Id");
        }
    }
}
