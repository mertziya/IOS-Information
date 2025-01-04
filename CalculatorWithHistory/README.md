

# Calculator App UI Kit

  

This project demonstrates a ****calculator app** designed for the ****IOS platform*** utilizing the "Skeletal Interface Builder" approach.

  

---

  

## ***Project Highlights***

- ***Design Resource**: [Figma File](https://www.figma.com/community/file/1139564128546110522/calculator-app-ui-kit-with-dark-mode)

- ***Objective***: To create a modular and maintainable UI using a combination of Interface Builder and programmatic approaches.

<img src="https://parsefiles.back4app.com/SQ2eVuXYhk6rxCpfnPVNgMNeKMvQMFSiLL4eZrrQ/d6c74d932dbd527424a9126d2e02b0fc_Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202024-12-18%20at%2010.56.52%20Small.jpeg" alt="Alt text" width="150"/>     <img src="https://parsefiles.back4app.com/SQ2eVuXYhk6rxCpfnPVNgMNeKMvQMFSiLL4eZrrQ/f1bafe9529ac85cf0a5a2b1de5a1ea6a_Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202024-12-18%20at%2010.59.46.jpeg" alt="Alt text" width="150"/>      <img src="https://parsefiles.back4app.com/SQ2eVuXYhk6rxCpfnPVNgMNeKMvQMFSiLL4eZrrQ/b4ef092f0538f8b850c7c2986e19c079_Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202024-12-18%20at%2010.59.24%20Small.jpeg" alt="Alt text" width="150"/>      <img src="https://parsefiles.back4app.com/SQ2eVuXYhk6rxCpfnPVNgMNeKMvQMFSiLL4eZrrQ/f011457e1d47807fb070840a37d99f0a_Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202024-12-18%20at%2010.56.55%20Small.jpeg" alt="Alt text" width="150"/>       <video width="150" height="326" controls>
    <source src="https://your-cdn-link/demo.mp4" type="video/mp4">
    Your browser does not support the video tag.
</video>



---

  

## **Approach: Skeletal Interface Builder**

This approach strikes a balance between using Interface Builder and programmatic UI development:

- A ***XIB file*** is used to set constraints and basic attributes for UI ele.     ents.

- Where Interface Builder falls short, **reusable** `CustomView`**s** are implemented. These views leverage `@IBInspectable` properties, allowing additional customization directly from the Interface Builder.

  

---

  

### ***Advantages***

1. ***Hybrid Approach***: Combines the simplicity of storyboards with the flexibility of programmatic UI.

2. ***Reduced Code***: Less boilerplate code compared to a fully programmatic UI.

3. ***Simplified Workflow***: Easier to manage and less complex than a fully storyboard-driven design.

  

---

  

### ****Disadvantages****

1. ***XML Complexity***: XIB files can still be challenging to read and review during PRs (Pull Requests).

  

---

  

## ***Future Improvements***

- Explore options for better XML readability to improve PR workflow.

- Enhance support for dynamic theming beyond dark mode.

  

---

  

### ***Why This Approach?***

The Skeletal Interface Builder approach bridges the gap between two extremes: fully programmatic and fully storyboard-driven UI development. By using XIB files for layout and constraints and supplementing with programmatic customization, this approach offers:

- Scalability for larger projects.

- Maintainability through reusable views.

- Accessibility for teams with varying expertise in iOS development.


---
