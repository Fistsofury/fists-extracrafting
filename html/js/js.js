// js.js

let recipes = [];
let currentPage = 0;
let numPages = 0;

window.addEventListener('message', function(event) {
    switch (event.data.type) {
        case 'receiveRecipes':
            recipes = event.data.recipes;
            numPages = Math.ceil(recipes.length / 2);
            currentPage = 0;
            renderRecipes();
            updatePageButtons();
            break;

        case 'setPlayerXP':
            playerXP = event.data.xp;
            renderRecipes();
            break;

        default:
            console.log("Unhandled message type:", event.data.type);
            break;
    }
});

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

function renderRecipes() {
    const recipesContainer = document.getElementById("recipe-pages");
    recipesContainer.innerHTML = "";

    for (let i = currentPage * 2; i < Math.min((currentPage + 1) * 2, recipes.length); i++) {
        const recipe = recipes[i];
        recipesContainer.innerHTML += generateRecipeHTML(recipe);
    }
}

function updatePageButtons() {
    const prevButton = document.getElementById("prev-page");
    const nextButton = document.getElementById("next-page");

    prevButton.disabled = currentPage === 0;
    nextButton.disabled = currentPage === numPages - 1;
}

document.getElementById("close-menu").addEventListener("click", function() {
    window.postMessage({ type: "closeCraftingMenu" }, "*");
});

document.addEventListener("click", (event) => {
    if (event.target.classList.contains("btn-craft")) {
        const recipeIndex = event.target.getAttribute("data-recipe-index");
        const recipe = recipes[recipeIndex];
        window.postMessage({ type: "craft", recipe: recipe.name }, "*");
    }
});

document.getElementById("next-page").addEventListener("click", () => {
    if (currentPage < numPages - 1) {
        currentPage++;
        renderRecipes();
        updatePageButtons();
    }
});

document.getElementById("prev-page").addEventListener("click", () => {
    if (currentPage > 0) {
        currentPage--;
        renderRecipes();
        updatePageButtons();
    }
});

let playerXP = 60;

// Request the recipes when the crafting menu opens:
window.postMessage({ type: "requestCraftingRecipes" }, "*");
