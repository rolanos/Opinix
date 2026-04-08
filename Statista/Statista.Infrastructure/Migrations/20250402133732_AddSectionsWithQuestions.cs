using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddSectionsWithQuestions : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Question_Section_SectionId",
                table: "Question");

            migrationBuilder.DropForeignKey(
                name: "FK_Section_Forms_FormId",
                table: "Section");

            migrationBuilder.DropForeignKey(
                name: "FK_Section_Section_ParentSectonId",
                table: "Section");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Section",
                table: "Section");

            migrationBuilder.RenameTable(
                name: "Section",
                newName: "Sections");

            migrationBuilder.RenameIndex(
                name: "IX_Section_ParentSectonId",
                table: "Sections",
                newName: "IX_Sections_ParentSectonId");

            migrationBuilder.RenameIndex(
                name: "IX_Section_FormId",
                table: "Sections",
                newName: "IX_Sections_FormId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Sections",
                table: "Sections",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Question_Sections_SectionId",
                table: "Question",
                column: "SectionId",
                principalTable: "Sections",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Sections_Forms_FormId",
                table: "Sections",
                column: "FormId",
                principalTable: "Forms",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Sections_Sections_ParentSectonId",
                table: "Sections",
                column: "ParentSectonId",
                principalTable: "Sections",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Question_Sections_SectionId",
                table: "Question");

            migrationBuilder.DropForeignKey(
                name: "FK_Sections_Forms_FormId",
                table: "Sections");

            migrationBuilder.DropForeignKey(
                name: "FK_Sections_Sections_ParentSectonId",
                table: "Sections");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Sections",
                table: "Sections");

            migrationBuilder.RenameTable(
                name: "Sections",
                newName: "Section");

            migrationBuilder.RenameIndex(
                name: "IX_Sections_ParentSectonId",
                table: "Section",
                newName: "IX_Section_ParentSectonId");

            migrationBuilder.RenameIndex(
                name: "IX_Sections_FormId",
                table: "Section",
                newName: "IX_Section_FormId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Section",
                table: "Section",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Question_Section_SectionId",
                table: "Question",
                column: "SectionId",
                principalTable: "Section",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Section_Forms_FormId",
                table: "Section",
                column: "FormId",
                principalTable: "Forms",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Section_Section_ParentSectonId",
                table: "Section",
                column: "ParentSectonId",
                principalTable: "Section",
                principalColumn: "Id");
        }
    }
}
