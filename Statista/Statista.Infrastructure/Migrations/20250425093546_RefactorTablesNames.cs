using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class RefactorTablesNames : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AnaliticalFacts_Question_QuestionId",
                table: "AnaliticalFacts");

            migrationBuilder.DropForeignKey(
                name: "FK_AnaliticalFacts_UserInfo_UserInfoId",
                table: "AnaliticalFacts");

            migrationBuilder.DropForeignKey(
                name: "FK_Answers_AvailableAnswers_AnswerValueId",
                table: "Answers");

            migrationBuilder.DropForeignKey(
                name: "FK_Answers_Question_QuestionId",
                table: "Answers");

            migrationBuilder.DropForeignKey(
                name: "FK_Answers_Survey_SurveyId",
                table: "Answers");

            migrationBuilder.DropForeignKey(
                name: "FK_AvailableAnswers_Question_QuestionId",
                table: "AvailableAnswers");

            migrationBuilder.DropForeignKey(
                name: "FK_Question_Sections_SectionId",
                table: "Question");

            migrationBuilder.DropForeignKey(
                name: "FK_Sections_Classifier_SectionTypeId",
                table: "Sections");

            migrationBuilder.DropForeignKey(
                name: "FK_Sections_Form_FormId",
                table: "Sections");

            migrationBuilder.DropForeignKey(
                name: "FK_Sections_Sections_ParentSectonId",
                table: "Sections");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Sections",
                table: "Sections");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AvailableAnswers",
                table: "AvailableAnswers");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Answers",
                table: "Answers");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AnaliticalFacts",
                table: "AnaliticalFacts");

            migrationBuilder.RenameTable(
                name: "Sections",
                newName: "Section");

            migrationBuilder.RenameTable(
                name: "AvailableAnswers",
                newName: "AvailableAnswer");

            migrationBuilder.RenameTable(
                name: "Answers",
                newName: "Answer");

            migrationBuilder.RenameTable(
                name: "AnaliticalFacts",
                newName: "AnaliticalFact");

            migrationBuilder.RenameIndex(
                name: "IX_Sections_SectionTypeId",
                table: "Section",
                newName: "IX_Section_SectionTypeId");

            migrationBuilder.RenameIndex(
                name: "IX_Sections_ParentSectonId",
                table: "Section",
                newName: "IX_Section_ParentSectonId");

            migrationBuilder.RenameIndex(
                name: "IX_Sections_FormId",
                table: "Section",
                newName: "IX_Section_FormId");

            migrationBuilder.RenameIndex(
                name: "IX_AvailableAnswers_QuestionId",
                table: "AvailableAnswer",
                newName: "IX_AvailableAnswer_QuestionId");

            migrationBuilder.RenameIndex(
                name: "IX_Answers_SurveyId",
                table: "Answer",
                newName: "IX_Answer_SurveyId");

            migrationBuilder.RenameIndex(
                name: "IX_Answers_QuestionId",
                table: "Answer",
                newName: "IX_Answer_QuestionId");

            migrationBuilder.RenameIndex(
                name: "IX_Answers_AnswerValueId",
                table: "Answer",
                newName: "IX_Answer_AnswerValueId");

            migrationBuilder.RenameIndex(
                name: "IX_AnaliticalFacts_UserInfoId",
                table: "AnaliticalFact",
                newName: "IX_AnaliticalFact_UserInfoId");

            migrationBuilder.RenameIndex(
                name: "IX_AnaliticalFacts_QuestionId",
                table: "AnaliticalFact",
                newName: "IX_AnaliticalFact_QuestionId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Section",
                table: "Section",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_AvailableAnswer",
                table: "AvailableAnswer",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Answer",
                table: "Answer",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_AnaliticalFact",
                table: "AnaliticalFact",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_AnaliticalFact_Question_QuestionId",
                table: "AnaliticalFact",
                column: "QuestionId",
                principalTable: "Question",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AnaliticalFact_UserInfo_UserInfoId",
                table: "AnaliticalFact",
                column: "UserInfoId",
                principalTable: "UserInfo",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Answer_AvailableAnswer_AnswerValueId",
                table: "Answer",
                column: "AnswerValueId",
                principalTable: "AvailableAnswer",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Answer_Question_QuestionId",
                table: "Answer",
                column: "QuestionId",
                principalTable: "Question",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Answer_Survey_SurveyId",
                table: "Answer",
                column: "SurveyId",
                principalTable: "Survey",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_AvailableAnswer_Question_QuestionId",
                table: "AvailableAnswer",
                column: "QuestionId",
                principalTable: "Question",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Question_Section_SectionId",
                table: "Question",
                column: "SectionId",
                principalTable: "Section",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Section_Classifier_SectionTypeId",
                table: "Section",
                column: "SectionTypeId",
                principalTable: "Classifier",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Section_Form_FormId",
                table: "Section",
                column: "FormId",
                principalTable: "Form",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Section_Section_ParentSectonId",
                table: "Section",
                column: "ParentSectonId",
                principalTable: "Section",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AnaliticalFact_Question_QuestionId",
                table: "AnaliticalFact");

            migrationBuilder.DropForeignKey(
                name: "FK_AnaliticalFact_UserInfo_UserInfoId",
                table: "AnaliticalFact");

            migrationBuilder.DropForeignKey(
                name: "FK_Answer_AvailableAnswer_AnswerValueId",
                table: "Answer");

            migrationBuilder.DropForeignKey(
                name: "FK_Answer_Question_QuestionId",
                table: "Answer");

            migrationBuilder.DropForeignKey(
                name: "FK_Answer_Survey_SurveyId",
                table: "Answer");

            migrationBuilder.DropForeignKey(
                name: "FK_AvailableAnswer_Question_QuestionId",
                table: "AvailableAnswer");

            migrationBuilder.DropForeignKey(
                name: "FK_Question_Section_SectionId",
                table: "Question");

            migrationBuilder.DropForeignKey(
                name: "FK_Section_Classifier_SectionTypeId",
                table: "Section");

            migrationBuilder.DropForeignKey(
                name: "FK_Section_Form_FormId",
                table: "Section");

            migrationBuilder.DropForeignKey(
                name: "FK_Section_Section_ParentSectonId",
                table: "Section");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Section",
                table: "Section");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AvailableAnswer",
                table: "AvailableAnswer");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Answer",
                table: "Answer");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AnaliticalFact",
                table: "AnaliticalFact");

            migrationBuilder.RenameTable(
                name: "Section",
                newName: "Sections");

            migrationBuilder.RenameTable(
                name: "AvailableAnswer",
                newName: "AvailableAnswers");

            migrationBuilder.RenameTable(
                name: "Answer",
                newName: "Answers");

            migrationBuilder.RenameTable(
                name: "AnaliticalFact",
                newName: "AnaliticalFacts");

            migrationBuilder.RenameIndex(
                name: "IX_Section_SectionTypeId",
                table: "Sections",
                newName: "IX_Sections_SectionTypeId");

            migrationBuilder.RenameIndex(
                name: "IX_Section_ParentSectonId",
                table: "Sections",
                newName: "IX_Sections_ParentSectonId");

            migrationBuilder.RenameIndex(
                name: "IX_Section_FormId",
                table: "Sections",
                newName: "IX_Sections_FormId");

            migrationBuilder.RenameIndex(
                name: "IX_AvailableAnswer_QuestionId",
                table: "AvailableAnswers",
                newName: "IX_AvailableAnswers_QuestionId");

            migrationBuilder.RenameIndex(
                name: "IX_Answer_SurveyId",
                table: "Answers",
                newName: "IX_Answers_SurveyId");

            migrationBuilder.RenameIndex(
                name: "IX_Answer_QuestionId",
                table: "Answers",
                newName: "IX_Answers_QuestionId");

            migrationBuilder.RenameIndex(
                name: "IX_Answer_AnswerValueId",
                table: "Answers",
                newName: "IX_Answers_AnswerValueId");

            migrationBuilder.RenameIndex(
                name: "IX_AnaliticalFact_UserInfoId",
                table: "AnaliticalFacts",
                newName: "IX_AnaliticalFacts_UserInfoId");

            migrationBuilder.RenameIndex(
                name: "IX_AnaliticalFact_QuestionId",
                table: "AnaliticalFacts",
                newName: "IX_AnaliticalFacts_QuestionId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Sections",
                table: "Sections",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_AvailableAnswers",
                table: "AvailableAnswers",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Answers",
                table: "Answers",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_AnaliticalFacts",
                table: "AnaliticalFacts",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_AnaliticalFacts_Question_QuestionId",
                table: "AnaliticalFacts",
                column: "QuestionId",
                principalTable: "Question",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AnaliticalFacts_UserInfo_UserInfoId",
                table: "AnaliticalFacts",
                column: "UserInfoId",
                principalTable: "UserInfo",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Answers_AvailableAnswers_AnswerValueId",
                table: "Answers",
                column: "AnswerValueId",
                principalTable: "AvailableAnswers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Answers_Question_QuestionId",
                table: "Answers",
                column: "QuestionId",
                principalTable: "Question",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Answers_Survey_SurveyId",
                table: "Answers",
                column: "SurveyId",
                principalTable: "Survey",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_AvailableAnswers_Question_QuestionId",
                table: "AvailableAnswers",
                column: "QuestionId",
                principalTable: "Question",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Question_Sections_SectionId",
                table: "Question",
                column: "SectionId",
                principalTable: "Sections",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Sections_Classifier_SectionTypeId",
                table: "Sections",
                column: "SectionTypeId",
                principalTable: "Classifier",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Sections_Form_FormId",
                table: "Sections",
                column: "FormId",
                principalTable: "Form",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Sections_Sections_ParentSectonId",
                table: "Sections",
                column: "ParentSectonId",
                principalTable: "Sections",
                principalColumn: "Id");
        }
    }
}
