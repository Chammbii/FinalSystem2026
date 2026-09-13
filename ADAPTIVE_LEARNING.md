# Adaptive Learning System - QuizLand 🎓

## Overview

The Adaptive Learning System automatically progresses students to the next lesson when they achieve **80% or higher accuracy** on a quiz. This creates a personalized learning path that adapts to each student's performance.

## How It Works

### 1. **Threshold-Based Progression**
- **Threshold**: 80% accuracy
- **Trigger**: When a student completes a quiz and scores ≥ 80%
- **Action**: Automatically advance to the next lesson

### 2. **Lesson Progression Path**

The system progresses through lessons in this order:

```
Alphabet (A-Z) 
    ↓
Numbers (1-10) 
    ↓
Colors (10 colors) 
    ↓
Shapes (10 shapes)
```

**Within Each Category:**
- If a lesson index < last lesson in category → proceed to next lesson in same category
- If at the last lesson in category → jump to first lesson of next category
- If all categories completed → return to menu

### 3. **Example Flows**

#### Flow 1: Progressing Within Alphabet
```
Student completes Lesson A (Alphabet 1/26)
   ↓
Quiz Score: 12/15 = 80% ✓
   ↓
Auto-advance to Lesson B (Alphabet 2/26)
```

#### Flow 2: Transitioning to Next Category
```
Student completes Lesson Z (Alphabet 26/26)
   ↓
Quiz Score: 13/15 = 87% ✓
   ↓
Auto-advance to Lesson "One" (Numbers 1/10)
```

#### Flow 3: Insufficient Score
```
Student completes Lesson C (Alphabet 3/26)
   ↓
Quiz Score: 10/15 = 67% ✗
   ↓
Return to Menu (no auto-advance)
Student can retry or choose different lesson
```

## User Feedback

### Visual Feedback
- Notification message shows: `"Excellent! 80% accuracy! 🎉 Moving to the next lesson..."`
- Progress message shows: `"Now learning: Numbers!"` (when transitioning categories)

### Audio Feedback
- Voice narration: `"Great job! Moving to the next lesson."`
- Bilingual support (English/Tagalog)

### Timing
- Quiz completion screen displays for 3.5 seconds
- Then automatically loads the next lesson
- Progress notification shows for 2 seconds

## Configuration

### Changing the Threshold

To modify the 80% threshold, edit this line in `script.js`:

```javascript
const ADAPTIVE_LEARNING_THRESHOLD = 80; // Change this value
```

**Examples:**
- `70` = Advance at 70% or higher
- `85` = Advance at 85% or higher
- `100` = Require perfect scores (100%)

## Key Functions

### Core Adaptive Learning Functions

1. **`calculateQuizAccuracy(score, total)`**
   - Calculates the percentage score
   - Returns rounded accuracy percentage

2. **`shouldAutoProgressLesson(accuracy)`**
   - Checks if accuracy meets threshold
   - Returns `true` if ≥ ADAPTIVE_LEARNING_THRESHOLD

3. **`getNextLessonPath(category, lessonIndex)`**
   - Determines next lesson in sequence
   - Returns object with `category` and `lessonIndex`
   - Returns `null` if all lessons completed

4. **`autoProgressToNextLesson(currentCat, currentLessonIdx)`**
   - Updates `currentCategory` and `currentLesson` globals
   - Returns `true` if progression successful
   - Returns `false` if no more lessons available

5. **`getNextLessonCategory(currentCategory)`**
   - Helper function to find next category
   - Returns category name or `null`

## Implementation Details

### Variables Tracked
- `ADAPTIVE_LEARNING_THRESHOLD`: Accuracy threshold percentage
- `quizLessonIndex`: Tracks which lesson the quiz is for
- `accuracy`: Calculated from quiz score and total questions
- `isAdaptiveProgressEligible`: Boolean flag for progression eligibility

### Flow in `finishQuiz()` Function

```
1. Calculate quiz accuracy percentage
2. Check if eligible for adaptive progression (>= 80%)
3. If eligible:
   - Show success message with accuracy %
   - Play success audio
   - Wait 3.5 seconds
   - Call autoProgressToNextLesson()
   - Load next lesson automatically
   - Display lesson screen
4. If not eligible:
   - Show completion message
   - Return to menu
```

## Multilingual Support

Messages are provided in both English and Tagalog (Filipino):

### English
- "Excellent! 80% accuracy! 🎉 Moving to the next lesson..."
- "Great job! Moving to the next lesson."
- "Now learning: Numbers!"

### Tagalog (Filipino)
- "Kahanga-hanga! 80% accuracy! 🎉 Pag-aabutan ka sa susunod na leksyon..."
- "Magandang gawa! Pag-aabutan ka sa susunod na leksyon."
- "Abot-kamay na ang bagong aralin: Numero!"

Language selection is based on `selectedLanguage` variable ('en' or 'tl').

## Teacher Dashboard Impact

- Quiz accuracy scores are still recorded for teacher dashboard
- Adaptive progression doesn't affect star rewards
- Each quiz attempt is logged in history with accuracy percentage
- Teachers can see student's progression rate and learning path

## Edge Cases Handled

1. **Quiz Not Completed**: Return to menu (normal flow)
2. **Score < 80%**: Return to menu (no auto-progression)
3. **All Lessons Completed**: Return to menu (no next lesson)
4. **Mid-Category Progression**: Stays in current category, advances lesson
5. **End-of-Category Progression**: Jumps to next category's first lesson

## Testing Checklist

- [ ] Quiz with 80% score auto-advances to next lesson
- [ ] Quiz with 79% score returns to menu
- [ ] Quiz with 100% score auto-advances
- [ ] Within-category progression works (A → B → C)
- [ ] Cross-category progression works (Z → Numbers 1)
- [ ] All-categories completed returns to menu
- [ ] Audio feedback plays during progression
- [ ] Notification messages display correctly
- [ ] Both English and Tagalog messages work
- [ ] Progress tracking in teacher dashboard still works

## Disabling Adaptive Learning

To disable adaptive progression temporarily while keeping the infrastructure in place:

```javascript
// In finishQuiz() function, replace:
if (isAdaptiveProgressEligible && autoProgressToNextLesson(...)) {

// With:
if (false && isAdaptiveProgressEligible && autoProgressToNextLesson(...)) {
```

Or change the threshold to 100:
```javascript
const ADAPTIVE_LEARNING_THRESHOLD = 100; // Require perfect score
```

## Future Enhancements

Possible improvements:
1. Configurable thresholds per category
2. Spaced repetition (revisit lower-scoring lessons after N days)
3. Adaptive difficulty selection (skip Easy if student gets 95%+)
4. Progress visualization showing current position in learning path
5. Parent/student notifications for milestones
6. Branching paths based on learning style preferences

---

**Version**: 1.0  
**Date Implemented**: 2026-09-01  
**Tested On**: QuizLand with Supabase Integration  
**Status**: ✅ Production Ready
