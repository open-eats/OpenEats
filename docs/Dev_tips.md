 Dev Tips

All of the data (excluding recipes) can be added to the DB using the Django REST GUI. The following is the CURL post I use to add recipes to the DB quickly for testing. You'll will need to either add your auth token as a header or disable the auth check in `api/v1/recipe/seralizers.py`.

```bash
curl -X POST -H "Content-Type: application/json" http://localhost:8000/api/v1/recipe/recipes/ --data '{"info":"hi", "cook_time":"12", "title":"hi", "directions":[{"title":"do this first", "step":"1"}], "servings":"12", "cuisine":"1", "ingredients":[{"title":"first", "quantity":"2", "measurement":"tsp"}], "prep_time":"123", "course":"1", "tags":[{"author":"1", "title":"chicken"}]}'
```

Apps can access there API roots via there app names:
* Recipes - http://localhost:8000/api/v1/recipe
* Ingredients - http://localhost:8000/api/v1/ingredient/
* Recipe groups - http://localhost:8000/api/v1/recipe_groups/
* News - http://localhost:8000/api/v1/news/
* Lists - http://localhost:8000/api/v1/list/