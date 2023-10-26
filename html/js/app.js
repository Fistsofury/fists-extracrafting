class CraftingMenu {
    constructor() {
        this.recipes = [];
        this.currentPage = 0;
        this.numPages = 0;
        this.playerXP = 60;

        this.initializeEventListeners();
    }

    showMenu() {
        document.querySelector(".menu-container").style.display = "block";
    }

    hideMenu() {
        document.querySelector(".menu-container").style.display = "none";
    }

    initializeEventListeners() {
        window.addEventListener('message', this.handleMessageEvent.bind(this));
        document.getElementById("close-menu").addEventListener("click", () => {
            this.hideMenu();
            fetch(`https://${GetParentResourceName()}/fists_crafting:closeCraftingMenu`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({})
            });
        });
    
        document.getElementById("recipe-pages").addEventListener("click", this.handleCraftClick.bind(this));
        document.getElementById("next-page").addEventListener("click", this.handleNextPage.bind(this));
        document.getElementById("prev-page").addEventListener("click", this.handlePrevPage.bind(this));
    }
    

    handleMessageEvent(event) {
        switch (event.data.type) {
            case 'fists_crafting:receiveRecipes':
                this.recipes = event.data.recipes;
                this.numPages = Math.ceil(this.recipes.length / 2);
                this.currentPage = 0;
                this.renderRecipes();
                this.updatePageButtons();
                break;
    
            case 'fists_crafting:setPlayerXP':
                this.playerXP = event.data.xp;
                this.renderRecipes();
                break;
    
            case 'fists_crafting:closeCraftingMenu':
                this.hideMenu();
                break;
    
            case 'fists_crafting:showMenu':
                this.showMenu();
                break;
    
            case 'fists_crafting:craft':
                this.handleCraft(event.data.recipe);
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
    
            // Start crafting animation
            const recipeElement = event.target.closest('.recipe');
            const loadingBar = recipeElement.querySelector('.loading-bar');
            const loadingProgress = recipeElement.querySelector('.loading-progress');
    
            // Show the loading bar
            loadingBar.style.display = 'block';
    
            // Reset loading bar in case it's been used before
            loadingProgress.style.width = '0%';
    
            // Example crafting time in seconds
            const craftingTime = recipe.craftingTime; // Use the crafting time from the recipe
            const interval = 10; // Update every 10 milliseconds
            const increment = (interval / (craftingTime * 1000)) * 100; // Calculate the increment for each update
    
            let progress = 0;
            const progressInterval = setInterval(() => {
                progress += increment;
                loadingProgress.style.width = `${progress}%`;
    
                if (progress >= 100) {
                    clearInterval(progressInterval);
                    // Hide the loading bar when crafting is complete
                    loadingBar.style.display = 'none';
                    // Add any additional actions to take when crafting is complete
                }
            }, interval);
    
            // Send craft request to server
            fetch(`https://${GetParentResourceName()}/fists_crafting:craft`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    recipe: recipe.name
                })
            });
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
                <h2>${recipe.label}</h2>
                <ul>
                    <li>Required Items:</li>
                    ${recipe.requiredItems.map(item => `<li>${item.quantity}x ${item.label}</li>`).join('')}
                </ul>
                <p>XP Requirement: ${recipe.xpRequirement}</p>
                <p>Crafting XP Reward: ${recipe.xpReward}</p>
                <p>Crafting Time: ${recipe.craftingTime} seconds</p>
                <button class="${craftBtnClass}" data-recipe-index="${this.recipes.indexOf(recipe)}">Craft</button>
                <div class="loading-bar">
                    <div class="loading-progress"></div>
                </div>
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
}

const craftingMenu = new CraftingMenu();
