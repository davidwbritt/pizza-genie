# Feature Specification: Pizza Genie Application

**Feature Branch**: `001-pizza-genie-app`  
**Created**: 2024-11-14  
**Status**: Draft  
**Input**: User description: "We are to create a mobile application called 'pizza-genie' that will provide tools for the home pizza chef. As a beginning, we will create a dough calculator that will help to guide the home chef toward creating dough to support different styles of pizza. We want to have a main page, a settings page (where we will support both a light and a dark theme); we will have an about page, and a privacy policy page. Please create the framework of our application."

## Clarifications

### Session 2024-11-14

- Q: How should crust thickness be defined and controlled? → A: 5-point scale where 1=very thin, 2=NY style, 3=Neapolitan, 4=Grandma, 5=Sicilian
- Q: How should proving time input be handled? → A: Hours-based input (whole numbers) with contextual text messages updating to guide yeast quantity and flavor development
- Q: What input validation rules should be applied? → A: Strict limits: 1-48 hours proving time, diameter must be from list (10,12,14,16), thickness scale 1-5 only
- Q: What measurement units system should be used? → A: Dual display: Always show both metric (grams for flour, ml for water) and imperial side-by-side to support both scale and no-scale home chefs
- Q: What calculation algorithm source should be used? → A: Style-specific formulas based on established culinary principles without using proprietary recipes, allowing variance by pizza style

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Calculate Pizza Dough Recipe (Priority: P1)

A home pizza chef wants to calculate the proper dough ingredients and quantities needed to make pizza dough based on pizza diameter, crust thickness, and proving time preferences.

**Why this priority**: This is the core value proposition of the application - providing accurate dough calculations is the primary reason users will download and use Pizza Genie.

**Independent Test**: Can be fully tested by selecting pizza diameter, adjusting thickness and proving time, and receiving a complete ingredient list with measurements, delivering immediate practical value for pizza making.

**Acceptance Scenarios**:

1. **Given** the app is open, **When** user accesses the dough calculator, **Then** they see input options for pizza diameter (10, 12, 14, 16 inches), crust thickness, and dough proving time
2. **Given** the dough calculator is open, **When** user selects diameter and adjusts thickness/proving time, **Then** the app displays calculated quantities for flour, water, salt, yeast, sugar, and olive oil
3. **Given** calculated results are displayed, **When** user views the ingredient list, **Then** all measurements are provided in common kitchen units (grams, cups, teaspoons, etc.)

---

### User Story 2 - Customize App Appearance (Priority: P2)

A user wants to customize the visual appearance of the app to match their preference for light or dark themes, improving their visual comfort during use.

**Why this priority**: Enhances user experience and accessibility, making the app more comfortable to use in different lighting conditions, but not essential for core functionality.

**Independent Test**: Can be tested by navigating to settings and toggling between light and dark themes, with the change immediately visible throughout the app.

**Acceptance Scenarios**:

1. **Given** the user is on any screen, **When** they navigate to settings, **Then** they see theme selection options for light and dark modes
2. **Given** the user is in settings, **When** they select a different theme, **Then** the app appearance changes immediately to reflect the new theme
3. **Given** a theme is selected, **When** user closes and reopens the app, **Then** the app remembers and applies the previously selected theme

---

### User Story 3 - Access App Information (Priority: P3)

A user wants to learn more about the Pizza Genie app, understand its privacy policies, and access general information about the application for transparency and compliance purposes.

**Why this priority**: Important for app store compliance and user trust, but not required for core pizza-making functionality.

**Independent Test**: Can be tested by navigating to about and privacy policy sections and verifying all required information is accessible.

**Acceptance Scenarios**:

1. **Given** the user is in the app, **When** they navigate to the about page, **Then** they see app information including version, purpose, and general details
2. **Given** the user is in the app, **When** they access the privacy policy, **Then** they can view the complete privacy policy text
3. **Given** the user is viewing app information, **When** they navigate back, **Then** they return to their previous location in the app

---

### Edge Cases

- What happens when user enters values outside strict limits (proving time <1 or >48 hours, invalid diameter, thickness outside 1-5 scale)?
- How does the app handle theme switching while actively using the dough calculator?
- What happens when the app is force-closed during recipe calculation and reopened?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST provide a dough calculator that accepts pizza diameter selection (10, 12, 14, 16 inches)
- **FR-002**: System MUST allow user to select crust thickness on a 5-point scale (1=very thin, 2=NY style, 3=Neapolitan, 4=Grandma, 5=Sicilian)
- **FR-003**: System MUST allow user to specify dough proving time in whole hours with contextual guidance messages about yeast quantity and flavor development
- **FR-004**: System MUST calculate ingredient quantities for flour, water, salt, yeast, sugar, and olive oil using style-specific formulas that vary based on pizza type without using proprietary recipes
- **FR-005**: Users MUST be able to access a main navigation interface to reach all app sections
- **FR-006**: System MUST provide a settings interface where users can select between light and dark visual themes
- **FR-007**: System MUST persist user theme preference between app sessions
- **FR-008**: System MUST provide an about page displaying app information and details
- **FR-009**: System MUST provide access to privacy policy information
- **FR-010**: System MUST display ingredient measurements in dual format showing both metric (grams for flour, ml for water) and imperial (cups, teaspoons) side-by-side
- **FR-011**: System MUST validate user input with strict limits (1-48 hours proving time, diameter from preset list only, thickness scale 1-5) and reject invalid entries with clear error messages
- **FR-012**: System MUST maintain consistent visual appearance across all screens when theme is applied

### Key Entities

- **Pizza Dough Recipe**: Contains calculated quantities for flour, water, salt, yeast, sugar, and olive oil based on diameter, thickness, and proving time
- **Calculator Parameters**: Stores pizza diameter (10, 12, 14, 16 inches), crust thickness level, and proving time duration
- **User Preferences**: Stores user's theme selection and other customizable settings
- **App Information**: Contains version details, descriptions, and policy content for display

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Users can complete a dough calculation from app launch to results display in under 30 seconds
- **SC-002**: App maintains consistent visual appearance across all screens when theme changes are applied
- **SC-003**: 95% of valid dough calculator inputs produce accurate ingredient calculations within 2 seconds
- **SC-004**: Users can successfully navigate between all main app sections (calculator, settings, about, privacy) without errors
- **SC-005**: App remembers user theme preference with 100% reliability across app restarts
- **SC-006**: All app information and privacy policy content is accessible and readable on standard mobile device screen sizes
- **SC-007**: Calculator displays all six ingredient types (flour, water, salt, yeast, sugar, olive oil) with appropriate quantities for every valid input combination

## Assumptions

- Dual measurement display (metric: grams for flour/ml for water, imperial: cups/teaspoons) supports both scale-equipped and traditional home chefs
- Four pizza diameter options (10, 12, 14, 16 inches) cover the most common home pizza sizes
- Crust thickness is represented as a 5-point scale with named pizza styles (1=very thin, 2=NY style, 3=Neapolitan, 4=Grandma, 5=Sicilian)
- Proving time is input in whole hours and affects yeast calculations with contextual guidance for flavor development vs. quick preparation
- Light and dark themes cover the primary visual accessibility needs for most users
- Users will primarily use the app during active pizza preparation sessions
- App will be distributed through standard mobile app stores requiring standard compliance information