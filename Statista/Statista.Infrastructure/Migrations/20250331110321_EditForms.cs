using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class EditForms : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Surveys_Forms_formId",
                table: "Surveys");

            migrationBuilder.DropIndex(
                name: "IX_Surveys_formId",
                table: "Surveys");

            migrationBuilder.DropColumn(
                name: "formId",
                table: "Surveys");

            migrationBuilder.DropColumn(
                name: "AnswerId",
                table: "Answer");

            migrationBuilder.AddColumn<Guid>(
                name: "SectionId",
                table: "Question",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "SurveyId",
                table: "Forms",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateTable(
                name: "Section",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Title = table.Column<string>(type: "text", nullable: false),
                    order = table.Column<int>(type: "integer", nullable: true),
                    FormId = table.Column<Guid>(type: "uuid", nullable: true),
                    SectionId = table.Column<Guid>(type: "uuid", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Section", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Section_Forms_FormId",
                        column: x => x.FormId,
                        principalTable: "Forms",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Section_Section_SectionId",
                        column: x => x.SectionId,
                        principalTable: "Section",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Question_SectionId",
                table: "Question",
                column: "SectionId");

            migrationBuilder.CreateIndex(
                name: "IX_Forms_SurveyId",
                table: "Forms",
                column: "SurveyId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Section_FormId",
                table: "Section",
                column: "FormId");

            migrationBuilder.CreateIndex(
                name: "IX_Section_SectionId",
                table: "Section",
                column: "SectionId");

            migrationBuilder.AddForeignKey(
                name: "FK_Forms_Surveys_SurveyId",
                table: "Forms",
                column: "SurveyId",
                principalTable: "Surveys",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Question_Section_SectionId",
                table: "Question",
                column: "SectionId",
                principalTable: "Section",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Forms_Surveys_SurveyId",
                table: "Forms");

            migrationBuilder.DropForeignKey(
                name: "FK_Question_Section_SectionId",
                table: "Question");

            migrationBuilder.DropTable(
                name: "Section");

            migrationBuilder.DropIndex(
                name: "IX_Question_SectionId",
                table: "Question");

            migrationBuilder.DropIndex(
                name: "IX_Forms_SurveyId",
                table: "Forms");

            migrationBuilder.DropColumn(
                name: "SectionId",
                table: "Question");

            migrationBuilder.DropColumn(
                name: "SurveyId",
                table: "Forms");

            migrationBuilder.AddColumn<Guid>(
                name: "formId",
                table: "Surveys",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "AnswerId",
                table: "Answer",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_Surveys_formId",
                table: "Surveys",
                column: "formId");

            migrationBuilder.AddForeignKey(
                name: "FK_Surveys_Forms_formId",
                table: "Surveys",
                column: "formId",
                principalTable: "Forms",
                principalColumn: "Id");
        }
    }
}
