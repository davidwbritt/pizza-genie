# Tasks: Pizza Genie Application

**Input**: Design documents from `/specs/001-pizza-genie-app/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Tests are NOT included as they were not explicitly requested in the feature specification.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Flutter Mobile**: `lib/` for source code, `test/` for testing
- Paths are relative to repository root

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [ ] T001 Create Flutter project structure per implementation plan
- [ ] T002 Initialize Flutter project with required dependencies (provider, shared_preferences)
- [ ] T003 [P] Configure Flutter linting and formatting tools
- [ ] T004 [P] Create directory structure in lib/ (constants, models, services, screens, widgets, utils)
- [ ] T005 [P] Create test directory structure (unit, widget, integration)
- [ ] T006 Update pubspec.yaml with project dependencies from quickstart.md

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T007 [P] Create constants.dart file with app-wide constants in lib/constants/
- [ ] T008 [P] Create enums and value objects for ThicknessLevel, IngredientType, MeasurementSystem in lib/constants/
- [ ] T009 [P] Implement base app navigation structure in lib/main.dart
- [ ] T010 [P] Create ingredient measurement conversion factors in lib/utils/pizza_formulas.dart
- [ ] T011 [P] Setup Provider state management configuration in lib/main.dart
- [ ] T012 Create shared app theme configuration (light/dark themes) in lib/main.dart

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Calculate Pizza Dough Recipe (Priority: P1) 🎯 MVP

**Goal**: Users can calculate pizza dough ingredients based on diameter, thickness, and proving time with dual metric/imperial display

**Independent Test**: User can select pizza diameter (10,12,14,16"), thickness level (1-5), proving time (1-48h) and receive complete ingredient list with accurate measurements in both metric and imperial units

### Implementation for User Story 1

- [ ] T013 [P] [US1] Create CalculatorParameters model in lib/models/calculator_parameters.dart
- [ ] T014 [P] [US1] Create PizzaDoughRecipe model in lib/models/pizza_dough_recipe.dart
- [ ] T015 [P] [US1] Create IngredientMeasurement model in lib/models/ingredient_measurement.dart
- [ ] T016 [US1] Implement ValidationService in lib/services/validation_service.dart (depends on T013)
- [ ] T017 [US1] Implement MeasurementConverter in lib/utils/measurement_converter.dart (depends on T015)
- [ ] T018 [US1] Implement CalculationService in lib/services/calculation_service.dart (depends on T013, T014, T010)
- [ ] T019 [P] [US1] Create CalculatorProvider for state management in lib/providers/calculator_provider.dart
- [ ] T020 [US1] Create calculator form widget in lib/widgets/calculator_form.dart (depends on T016, T019)
- [ ] T021 [US1] Create ingredient display widget in lib/widgets/ingredient_display.dart (depends on T017, T014)
- [ ] T022 [US1] Create main calculator screen in lib/screens/main_screen.dart (depends on T020, T021)
- [ ] T023 [US1] Integrate calculator screen with navigation in lib/main.dart
- [ ] T024 [US1] Add input validation and error handling for calculator form
- [ ] T025 [US1] Add contextual proving time guidance messages per requirements

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Customize App Appearance (Priority: P2)

**Goal**: Users can switch between light and dark themes with persistent preference storage

**Independent Test**: User can navigate to settings, toggle between light/dark themes, see immediate visual changes, and have preference remembered across app restarts

### Implementation for User Story 2

- [ ] T026 [P] [US2] Create UserPreferences model in lib/models/user_preferences.dart
- [ ] T027 [P] [US2] Implement PreferenceService in lib/services/preference_service.dart
- [ ] T028 [US2] Create ThemeProvider for theme state management in lib/providers/theme_provider.dart (depends on T027)
- [ ] T029 [US2] Create theme selector widget in lib/widgets/theme_selector.dart (depends on T028)
- [ ] T030 [US2] Create settings screen in lib/screens/settings_screen.dart (depends on T029)
- [ ] T031 [US2] Integrate settings screen with navigation in lib/main.dart
- [ ] T032 [US2] Connect ThemeProvider to MaterialApp theme configuration
- [ ] T033 [US2] Add theme persistence using SharedPreferences
- [ ] T034 [US2] Ensure theme consistency across all existing screens

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Access App Information (Priority: P3)

**Goal**: Users can access app information, version details, and privacy policy for transparency and compliance

**Independent Test**: User can navigate to about page and privacy page, view complete content, and return to previous location successfully

### Implementation for User Story 3

- [ ] T035 [P] [US3] Create AppInformation model in lib/models/app_information.dart
- [ ] T036 [P] [US3] Create about screen in lib/screens/about_screen.dart
- [ ] T037 [P] [US3] Create privacy policy screen in lib/screens/privacy_screen.dart
- [ ] T038 [US3] Add app version and build information to AppInformation model
- [ ] T039 [US3] Create privacy policy content and about page content
- [ ] T040 [US3] Integrate about screen with navigation in lib/main.dart
- [ ] T041 [US3] Integrate privacy screen with navigation in lib/main.dart
- [ ] T042 [US3] Add navigation links to settings screen for about and privacy pages
- [ ] T043 [US3] Ensure proper back navigation from information screens

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories and final app preparation

- [ ] T044 [P] Add app icons and splash screen assets
- [ ] T045 [P] Optimize performance for <2 second calculation response time
- [ ] T046 [P] Verify input validation works across all forms
- [ ] T047 [P] Add error handling and loading states to all screens
- [ ] T048 [P] Test theme consistency across all screens and components
- [ ] T049 [P] Verify dual measurement display accuracy for all ingredients
- [ ] T050 [P] Add accessibility labels and semantic descriptions
- [ ] T051 [P] Configure app for Android release build settings
- [ ] T052 Run complete functional testing per acceptance scenarios in spec.md
- [ ] T053 Validate app meets all success criteria from specification
- [ ] T054 Prepare for Google Play Store compliance requirements

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Phase 6)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - Integrates with existing screens but independently testable
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - Adds navigation links to settings but independently testable

### Within Each User Story

- Models before services that use them
- Services before providers that use them  
- Providers before widgets that use them
- Widgets before screens that use them
- Screens before navigation integration
- Core functionality before polish features

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel
- All Foundational tasks marked [P] can run in parallel (within Phase 2)
- Once Foundational phase completes, all user stories can start in parallel (if team capacity allows)
- Models within a story marked [P] can run in parallel
- Different user stories can be worked on in parallel by different team members

---

## Parallel Example: User Story 1

```bash
# Launch all models for User Story 1 together:
Task: "Create CalculatorParameters model in lib/models/calculator_parameters.dart"  
Task: "Create PizzaDoughRecipe model in lib/models/pizza_dough_recipe.dart"
Task: "Create IngredientMeasurement model in lib/models/ingredient_measurement.dart"

# Launch other parallel tasks:
Task: "Create CalculatorProvider for state management in lib/providers/calculator_provider.dart"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1 
4. **STOP and VALIDATE**: Test User Story 1 independently
5. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 → Test independently → Deploy/Demo  
4. Add User Story 3 → Test independently → Deploy/Demo
5. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1 (Calculator functionality)
   - Developer B: User Story 2 (Theme system)
   - Developer C: User Story 3 (Information pages)
3. Stories complete and integrate independently

---

## Notes

- [P] tasks = different files, no dependencies  
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Tests were not included as they were not explicitly requested in specification
- Focus on core functionality first, polish features last
- All file paths must be exact as specified in tasks