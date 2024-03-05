# BitsoBookModule

The module that provides features related to `Book`.

## Features

This module contains two features:

- [Book List Screen](./Sources/Features/BookList): Displays the list of all available books 
- [Book Detail Screen](./Sources/Features/BookDetails): Display the details of a particular book

Note that the **Book List** feature is _public_, but the **Book Details** feature is not, and 
can only be accessed by the **BitsoBookModule**.

## Architecture

This module uses the **MVVM-C** (Model-View-ViewModel-Coordinator) architectural pattern,
using **SwiftUI** and **Combine**.

A small caveat is that the Coordinator components do not behave the same as in **UIKit** based apps.
These conform to **View**, since that is required to be pushed to the navigation. However, these 
were created to behave as the entry-point of the feature, determining the dependencies of the view
and handling navigation.

## Book List

![BookList](./Demo/BookList.png)

This screen provides the complete list of all available books, each book contains:

- Book Name in __Major Minor__ format
- Maximum Price
- Maximum Value and Minimum Value

## Book Details

![BookDetails](./Demo/BookDetails.png)

This screen provides details on a particular selected book. Displays:

- Book Name in __Major Minor__
- A section displaying Volume, High and Change
- Another section displaying Ask and Bid
