import React, { useState, useEffect } from "react";
import http from "../api/http";
import "../styles/pages/SurveyPage.css";

function QuestionCard({ question, onSelect, selected }) {
    if (!question) return null;
    const answers = question.availableAnswers || question.answers || question.options || [];
    const questionText = question.title || question.text || question.question || "";
    return (
        <div className="question-card">
            <div className="question-text">{questionText}</div>
            <div className="answers">
                {answers.map((a, i) => (
                    <button
                        key={a.id || i}
                        type="button"
                        className={"answer-btn " + (selected === i ? "selected" : "")}
                        onClick={() => onSelect(i, a)}
                    >
                        {a.imageLink ? (
                            <img className="answer-img" src={a.imageLink} alt={a.text || 'answer image'} />
                        ) : null}
                        <div className="answer-text">{a.text || a.title || JSON.stringify(a)}</div>
                        <div className="answer-meta">{a.id ? '' : ''}</div>
                    </button>
                ))}
            </div>
        </div>
    );
}

export default function FirstPage() {

    const [loading, setLoading] = useState(false);
    const [question, setQuestion] = useState(null);
    const [error, setError] = useState(null);
    const [noQuestions, setNoQuestions] = useState(false);
    const [selectedIndex, setSelectedIndex] = useState(null);

    async function doQuery(e) {
        e && e.preventDefault();
        setError(null);
        setNoQuestions(false);
        setQuestion(null);
        setSelectedIndex(null);
        setLoading(true);
        try {
            const res = await http.get("/questions/general/next");
            const payload = res && res.data ? res.data : res;
            // API can return a string message when no new questions
            if (typeof payload === "string") {
                const txt = payload || '';
                if (txt.toLowerCase().includes('нет новых вопросов')) {
                    setNoQuestions(true);
                } else {
                    setError(payload);
                }
            } else {
                setQuestion(payload);
            }
        } catch (err) {
            setNoQuestions(false);
            setError(err?.response?.data || err?.response?.data?.message || err.message || "Fetch failed");
        } finally {
            setLoading(false);
        }
    }

    // Auto-fetch when component mounts
    useEffect(() => {
        doQuery();
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, []);

    function handleSelect(i, a) {
        setSelectedIndex(i);
    }

    return (
        <div className="firstpage-container">
            <div className="query-column">

                {loading && <div className="spinner" aria-label="loading" />}

                {error && <div className="error">{error}</div>}

                {question && (
                    <QuestionCard question={question} onSelect={handleSelect} selected={selectedIndex} />
                )}
            </div>

            {noQuestions && (
                <div className="no-questions-overlay" role="status" aria-live="polite">
                    <div className="no-questions-text">На данный момент нет новых вопросов</div>
                </div>
            )}
        </div>
    );
}
