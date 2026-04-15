import { test, expect } from "@playwright/test";

test("hello is visible", async ({ page }) => {
  await page.goto("/");
  await expect(page.getByText("hello")).toBeVisible();
});
