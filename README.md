# FileVaultV1 Solidity Contract

This is a Solidity contract named `FileVaultV1` which is used for managing files on the Ethereum blockchain. The contract provides functionalities for uploading, accessing, and managing the privacy of files.


## Contract Structure
The contract has a `File` structure which represents a file and contains the following fields:
- fileName: Name of the file.
- hashValue: Hash value of the file.
- fileDescription: Description of the file.
- fileType: Type of the file.
- fileSize: Size of the file.
- uploadTime: The timestamp when the file was uploaded.
- lastUpdated: The timestamp when the file was last updated.
- owner: The owner of the file.
- isPrivate: A boolean indicating if the file is private or not.
The contract also contains a mapping `allFiles` which maps a `uint` to a `File` structure, representing all the files in the contract.


## Contract Functions
- `uploadFile`: This function is used to upload a file to the contract. It emits a `FileUploaded` event after a successful upload.
- `toggleIsPrivate`: This function is used to toggle the privacy of a file. It requires the caller to be the owner of the contract.
- `getTotalFilesCount`: This function returns the total count of files in the contract.
- `getAllFiles`: This function returns all the files in the contract.
- `getFilesByOwnerAddress`: This function returns all the files owned by a specific address.
- `getFileById`: This function returns a file by its ID.
- `transferOwnership`: This function is used to transfer the ownership of the contract to another address. It requires the caller to be the current owner of the contract.


# contract address 
0xeC58fC513F3f5F444d7CC7527Bf913EaC70CF83B