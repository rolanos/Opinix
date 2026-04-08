using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddAswers : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Answer_EnumPosition_AnswerValueId",
                table: "Answer");

            migrationBuilder.DropForeignKey(
                name: "FK_Question_Section_SectionId",
                table: "Question");

            migrationBuilder.DropForeignKey(
                name: "FK_Section_Section_SectionId",
                table: "Section");

            migrationBuilder.DropTable(
                name: "EnumPosition");

            migrationBuilder.RenameColumn(
                name: "SectionId",
                table: "Section",
                newName: "ParentSectonId");

            migrationBuilder.RenameIndex(
                name: "IX_Section_SectionId",
                table: "Section",
                newName: "IX_Section_ParentSectonId");

            migrationBuilder.AlterColumn<Guid>(
                name: "SectionId",
                table: "Question",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uuid",
                oldNullable: true);

            migrationBuilder.AlterColumn<Guid>(
                name: "AnswerValueId",
                table: "Answer",
                type: "uuid",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uuid");

            migrationBuilder.CreateTable(
                name: "AvailableAnswer",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Text = table.Column<string>(type: "text", nullable: true),
                    imageLink = table.Column<string>(type: "text", nullable: true),
                    QuestionId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AvailableAnswer", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AvailableAnswer_Question_QuestionId",
                        column: x => x.QuestionId,
                        principalTable: "Question",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_AvailableAnswer_QuestionId",
                table: "AvailableAnswer",
                column: "QuestionId");

            migrationBuilder.AddForeignKey(
                name: "FK_Answer_AvailableAnswer_AnswerValueId",
                table: "Answer",
                column: "AnswerValueId",
                principalTable: "AvailableAnswer",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Question_Section_SectionId",
                table: "Question",
                column: "SectionId",
                principalTable: "Section",
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
                name: "FK_Answer_AvailableAnswer_AnswerValueId",
                table: "Answer");

            migrationBuilder.DropForeignKey(
                name: "FK_Question_Section_SectionId",
                table: "Question");

            migrationBuilder.DropForeignKey(
                name: "FK_Section_Section_ParentSectonId",
                table: "Section");

            migrationBuilder.DropTable(
                name: "AvailableAnswer");

            migrationBuilder.RenameColumn(
                name: "ParentSectonId",
                table: "Section",
                newName: "SectionId");

            migrationBuilder.RenameIndex(
                name: "IX_Section_ParentSectonId",
                table: "Section",
                newName: "IX_Section_SectionId");

            migrationBuilder.AlterColumn<Guid>(
                name: "SectionId",
                table: "Question",
                type: "uuid",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uuid");

            migrationBuilder.AlterColumn<Guid>(
                name: "AnswerValueId",
                table: "Answer",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uuid",
                oldNullable: true);

            migrationBuilder.CreateTable(
                name: "EnumPosition",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    ClassifierId = table.Column<Guid>(type: "uuid", nullable: false),
                    ImageLink = table.Column<string>(type: "text", nullable: true),
                    Text = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_EnumPosition", x => x.Id);
                    table.ForeignKey(
                        name: "FK_EnumPosition_Classifier_ClassifierId",
                        column: x => x.ClassifierId,
                        principalTable: "Classifier",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_EnumPosition_ClassifierId",
                table: "EnumPosition",
                column: "ClassifierId");

            migrationBuilder.AddForeignKey(
                name: "FK_Answer_EnumPosition_AnswerValueId",
                table: "Answer",
                column: "AnswerValueId",
                principalTable: "EnumPosition",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Question_Section_SectionId",
                table: "Question",
                column: "SectionId",
                principalTable: "Section",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Section_Section_SectionId",
                table: "Section",
                column: "SectionId",
                principalTable: "Section",
                principalColumn: "Id");
        }
    }
}
