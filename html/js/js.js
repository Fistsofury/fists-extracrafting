// Sample data for recipes (replace with your actual data)
let recipes = {};

window.addEventListener('message', function(event) {
    if (event.data.type === 'receiveRecipes') {
        // Update the recipes with the data received from the server
        recipes = event.data.recipes;
        // Re-render the recipes to update the crafting menu
        renderRecipes();
    }
});

let currentPage = 0;

// Function to generate recipe HTML
function generateRecipeHTML(recipe) {
    const canCraft = playerXP >= recipe.xpRequirement;
    const craftBtnClass = canCraft ? "btn-craft" : "btn-craft disabled";
    return `
        <div class="recipe">
            <h2>${recipe.name}</h2>
            <ul>
                <li>Required Items:</li>
                ${recipe.requiredItems.map(item => `<li>${item.quantity}x ${item.item}</li>`).join('')}
            </ul>
            <p>XP Requirement: ${recipe.xpRequirement}</p>
            <p>Crafting XP Reward: ${recipe.xpReward}</p>
            <p>Crafting Time: ${recipe.craftingTime} seconds</p>
            <button class="${craftBtnClass}" data-recipe-index="${recipes.indexOf(recipe)}">Craft</button>
        </div>
    `;
}

// Function to render recipes for the current page
function renderRecipes() {
    const recipesContainer = document.getElementById("recipe-pages");
    recipesContainer.innerHTML = "";

    for (let i = currentPage * 2; i < Math.min((currentPage + 1) * 2, recipes.length); i++) {
        const recipe = recipes[i];
        recipesContainer.innerHTML += generateRecipeHTML(recipe);
    }
}

// Event listener for craft button clicks
document.addEventListener("click", (event) => {
    if (event.target.classList.contains("btn-craft")) {
        const recipeIndex = event.target.getAttribute("data-recipe-index");
        const recipe = getRecipe(recipes[recipeIndex].name);
        // Send a message to your Lua script to initiate crafting
        window.postMessage({ type: "craft", recipe: recipe.name }, "*");
    }
});

// Event listener for next page button click
document.getElementById("next-page").addEventListener("click", () => {
    if (currentPage < numPages - 1) {
        currentPage++;
        renderRecipes();
        updatePageButtons();
    }
});

// Event listener for previous page button click
document.getElementById("prev-page").addEventListener("click", () => {
    if (currentPage > 0) {
        currentPage--;
        renderRecipes();
        updatePageButtons();
    }
});

// Function to update page navigation buttons
function updatePageButtons() {
    const prevButton = document.getElementById("prev-page");
    const nextButton = document.getElementById("next-page");

    prevButton.disabled = currentPage === 0;
    nextButton.disabled = currentPage === numPages - 1;
}

// Simulate player XP (replace with your actual player XP retrieval logic)
let playerXP = 60;

// Calculate the number of pages based on the total number of recipes
const numPages = Math.ceil(recipes.length / 2);

// Initial rendering
renderRecipes();
updatePageButtons();

// Listen for messages from your Lua script
window.addEventListener('message', function(event) {
    if (event.data.type === 'setPlayerXP') {
        // Update the player's XP
        playerXP = event.data.xp;
        // Re-render the recipes to update which ones can be crafted
        renderRecipes();
    }
});

// Function to get a recipe by item name
function getRecipe(itemName) {
    // Search for the recipe in the general recipes
    for (let i = 0; i < recipes.length; i++) {
        if (recipes[i].name === itemName) {
            return recipes[i];
        }
    }

    // If the recipe was not found in the general recipes, search for it in the job-specific recipes
    // You'll need to replace "playerJob" with your actual logic for getting the player's job
    const playerJobRecipes = Config.jobRecipes[playerJob];
    if (playerJobRecipes) {
        for (let i = 0; i < playerJobRecipes.length; i++) {
            if (playerJobRecipes[i].name === itemName) {
                return playerJobRecipes[i];
            }
        }
    }

    // If the recipe was not found, return null
    return null;
}
