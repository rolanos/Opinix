using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class QuestionMigration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Questions_Forms_FormId",
                table: "Questions");

            migrationBuilder.DropForeignKey(
                name: "FK_Questions_QeustionTypes_QuestionTypeId",
                table: "Questions");

            migrationBuilder.DropForeignKey(
                name: "FK_Questions_QuestionCategories_QuestionCategoryId",
                table: "Questions");

            migrationBuilder.DropForeignKey(
                name: "FK_Questions_User_CreatedById",
                table: "Questions");

            migrationBuilder.DropForeignKey(
                name: "FK_Report_Questions_ReportedQuestionId",
                table: "Report");

            migrationBuilder.DropForeignKey(
                name: "FK_Report_User_CreatedId",
                table: "Report");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Questions",
                table: "Questions");

            migrationBuilder.RenameTable(
                name: "Questions",
                newName: "Question");

            migrationBuilder.RenameColumn(
                name: "CreatedId",
                table: "Report",
                newName: "CreatedById");

            migrationBuilder.RenameIndex(
                name: "IX_Report_CreatedId",
                table: "Report",
                newName: "IX_Report_CreatedById");

            migrationBuilder.RenameColumn(
                name: "QuestionCategoryId",
                table: "Question",
                newName: "CategoryId");

            migrationBuilder.RenameIndex(
                name: "IX_Questions_QuestionTypeId",
                table: "Question",
                newName: "IX_Question_QuestionTypeId");

            migrationBuilder.RenameIndex(
                name: "IX_Questions_QuestionCategoryId",
                table: "Question",
                newName: "IX_Question_CategoryId");

            migrationBuilder.RenameIndex(
                name: "IX_Questions_FormId",
                table: "Question",
                newName: "IX_Question_FormId");

            migrationBuilder.RenameIndex(
                name: "IX_Questions_CreatedById",
                table: "Question",
                newName: "IX_Question_CreatedById");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Question",
                table: "Question",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Question_Forms_FormId",
                table: "Question",
                column: "FormId",
                principalTable: "Forms",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Question_QeustionTypes_QuestionTypeId",
                table: "Question",
                column: "QuestionTypeId",
                principalTable: "QeustionTypes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Question_QuestionCategories_CategoryId",
                table: "Question",
                column: "CategoryId",
                principalTable: "QuestionCategories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Question_User_CreatedById",
                table: "Question",
                column: "CreatedById",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Report_Question_ReportedQuestionId",
                table: "Report",
                column: "ReportedQuestionId",
                principalTable: "Question",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Report_User_CreatedById",
                table: "Report",
                column: "CreatedById",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Question_Forms_FormId",
                table: "Question");

            migrationBuilder.DropForeignKey(
                name: "FK_Question_QeustionTypes_QuestionTypeId",
                table: "Question");

            migrationBuilder.DropForeignKey(
                name: "FK_Question_QuestionCategories_CategoryId",
                table: "Question");

            migrationBuilder.DropForeignKey(
                name: "FK_Question_User_CreatedById",
                table: "Question");

            migrationBuilder.DropForeignKey(
                name: "FK_Report_Question_ReportedQuestionId",
                table: "Report");

            migrationBuilder.DropForeignKey(
                name: "FK_Report_User_CreatedById",
                table: "Report");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Question",
                table: "Question");

            migrationBuilder.RenameTable(
                name: "Question",
                newName: "Questions");

            migrationBuilder.RenameColumn(
                name: "CreatedById",
                table: "Report",
                newName: "CreatedId");

            migrationBuilder.RenameIndex(
                name: "IX_Report_CreatedById",
                table: "Report",
                newName: "IX_Report_CreatedId");

            migrationBuilder.RenameColumn(
                name: "CategoryId",
                table: "Questions",
                newName: "QuestionCategoryId");

            migrationBuilder.RenameIndex(
                name: "IX_Question_QuestionTypeId",
                table: "Questions",
                newName: "IX_Questions_QuestionTypeId");

            migrationBuilder.RenameIndex(
                name: "IX_Question_FormId",
                table: "Questions",
                newName: "IX_Questions_FormId");

            migrationBuilder.RenameIndex(
                name: "IX_Question_CreatedById",
                table: "Questions",
                newName: "IX_Questions_CreatedById");

            migrationBuilder.RenameIndex(
                name: "IX_Question_CategoryId",
                table: "Questions",
                newName: "IX_Questions_QuestionCategoryId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Questions",
                table: "Questions",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Questions_Forms_FormId",
                table: "Questions",
                column: "FormId",
                principalTable: "Forms",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Questions_QeustionTypes_QuestionTypeId",
                table: "Questions",
                column: "QuestionTypeId",
                principalTable: "QeustionTypes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Questions_QuestionCategories_QuestionCategoryId",
                table: "Questions",
                column: "QuestionCategoryId",
                principalTable: "QuestionCategories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Questions_User_CreatedById",
                table: "Questions",
                column: "CreatedById",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Report_Questions_ReportedQuestionId",
                table: "Report",
                column: "ReportedQuestionId",
                principalTable: "Questions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Report_User_CreatedId",
                table: "Report",
                column: "CreatedId",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
