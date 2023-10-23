// js.js
function showMenu() {
    document.querySelector(".menu-container").style.display = "block";
}
class CraftingMenu {
    constructor() {
        this.recipes = [];
        this.currentPage = 0;
        this.numPages = 0;
        this.playerXP = 60;

        this.initializeEventListeners();
        this.requestCraftingRecipes();
    }

    initializeEventListeners() {
        window.addEventListener('message', this.handleMessageEvent.bind(this));
        document.getElementById("close-menu").addEventListener("click", () => {
            window.postMessage({ type: "closeCraftingMenu" }, "*");
        });
        document.getElementById("recipe-pages").addEventListener("click", this.handleCraftClick.bind(this));
        document.getElementById("next-page").addEventListener("click", this.handleNextPage.bind(this));
        document.getElementById("prev-page").addEventListener("click", this.handlePrevPage.bind(this));
    }

    handleMessageEvent(event) {
        switch (event.data.type) {
            case 'receiveRecipes':
                this.recipes = event.data.recipes;
                this.numPages = Math.ceil(this.recipes.length / 2);
                this.currentPage = 0;
                this.renderRecipes();
                this.updatePageButtons();
                break;
    
            case 'setPlayerXP':
                this.playerXP = event.data.xp;
                this.renderRecipes();
                break;
    
            case 'closeCraftingMenu':
                // Add your code here to handle the closeCraftingMenu event
                break;
    
            default:
                console.log("Unhandled message type:", event.data.type);
                break;
        }
    }
    

    handleCraftClick(event) {
        if (event.target.classList.contains("btn-craft")) {
            const recipeIndex = event.target.getAttribute("data-recipe-index");
            const recipe = this.recipes[recipeIndex];
            window.postMessage({ type: "craft", recipe: recipe.name }, "*");
        }
    }

    handleNextPage() {
        if (this.currentPage < this.numPages - 1) {
            this.currentPage++;
            this.renderRecipes();
            this.updatePageButtons();
        }
    }

    handlePrevPage() {
        if (this.currentPage > 0) {
            this.currentPage--;
            this.renderRecipes();
            this.updatePageButtons();
        }
    }

    generateRecipeHTML(recipe) {
        const canCraft = this.playerXP >= recipe.xpRequirement;
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
                <button class="${craftBtnClass}" data-recipe-index="${this.recipes.indexOf(recipe)}">Craft</button>
            </div>
        `;
    }

    renderRecipes() {
        const recipesContainer = document.getElementById("recipe-pages");
        recipesContainer.innerHTML = "";

        for (let i = this.currentPage * 2; i < Math.min((this.currentPage + 1) * 2, this.recipes.length); i++) {
            const recipe = this.recipes[i];
            recipesContainer.innerHTML += this.generateRecipeHTML(recipe);
        }
    }

    

    updatePageButtons() {
        const prevButton = document.getElementById("prev-page");
        const nextButton = document.getElementById("next-page");

        prevButton.disabled = this.currentPage === 0;
        nextButton.disabled = this.currentPage === this.numPages - 1;
    }

    requestCraftingRecipes() {
        window.postMessage({ type: "requestCraftingRecipes" }, "*");
    }
}

// Instantiate the CraftingMenu class
const craftingMenu = new CraftingMenu();
