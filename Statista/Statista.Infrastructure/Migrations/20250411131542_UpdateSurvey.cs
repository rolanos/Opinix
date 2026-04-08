using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class UpdateSurvey : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Forms_Surveys_SurveyId",
                table: "Forms");

            migrationBuilder.DropForeignKey(
                name: "FK_Forms_User_CreatedById",
                table: "Forms");

            migrationBuilder.DropForeignKey(
                name: "FK_Sections_Forms_FormId",
                table: "Sections");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Forms",
                table: "Forms");

            migrationBuilder.DropIndex(
                name: "IX_Forms_SurveyId",
                table: "Forms");

            migrationBuilder.RenameTable(
                name: "Forms",
                newName: "Form");

            migrationBuilder.RenameIndex(
                name: "IX_Forms_CreatedById",
                table: "Form",
                newName: "IX_Form_CreatedById");

            migrationBuilder.AddColumn<DateTime>(
                name: "CreatedDate",
                table: "Surveys",
                type: "timestamp with time zone",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<Guid>(
                name: "FormId",
                table: "Surveys",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddPrimaryKey(
                name: "PK_Form",
                table: "Form",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_Surveys_FormId",
                table: "Surveys",
                column: "FormId",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Form_User_CreatedById",
                table: "Form",
                column: "CreatedById",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Sections_Form_FormId",
                table: "Sections",
                column: "FormId",
                principalTable: "Form",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Surveys_Form_FormId",
                table: "Surveys",
                column: "FormId",
                principalTable: "Form",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Form_User_CreatedById",
                table: "Form");

            migrationBuilder.DropForeignKey(
                name: "FK_Sections_Form_FormId",
                table: "Sections");

            migrationBuilder.DropForeignKey(
                name: "FK_Surveys_Form_FormId",
                table: "Surveys");

            migrationBuilder.DropIndex(
                name: "IX_Surveys_FormId",
                table: "Surveys");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Form",
                table: "Form");

            migrationBuilder.DropColumn(
                name: "CreatedDate",
                table: "Surveys");

            migrationBuilder.DropColumn(
                name: "FormId",
                table: "Surveys");

            migrationBuilder.RenameTable(
                name: "Form",
                newName: "Forms");

            migrationBuilder.RenameIndex(
                name: "IX_Form_CreatedById",
                table: "Forms",
                newName: "IX_Forms_CreatedById");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Forms",
                table: "Forms",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_Forms_SurveyId",
                table: "Forms",
                column: "SurveyId",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Forms_Surveys_SurveyId",
                table: "Forms",
                column: "SurveyId",
                principalTable: "Surveys",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Forms_User_CreatedById",
                table: "Forms",
                column: "CreatedById",
                principalTable: "User",
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
    }
}
