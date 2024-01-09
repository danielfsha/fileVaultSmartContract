// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

contract FileVaultV1 {
    uint256 private totalFilesCount;
    address public owner;

    mapping(uint => File) public allFiles;

    struct File {
        string fileName;
        string hashValue;
        string fileDescription;
        string fileType;
        uint fileSize;
        uint uploadTime;
        uint lastUpdated;
        address owner; // person who uploaded
        bool isPrivate;
    }

    constructor() {
        totalFilesCount = 0;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner have the permission!");
        _;
    }

    event FileUploaded(
        string fileName,
        string hashValue,
        string fileDescription,
        string fileType,
        uint fileSize,
        uint uploadTime,
        uint lastUpdated,
        address owner,
        bool isPrivate
    );

    function uploadFile(
        string memory _fileName,
        string memory _hashValue,
        string memory _fileDescription,
        string memory _fileType,
        uint _fileSize,
        bool _isPrivate
    ) public onlyOwner {
        totalFilesCount++;
        uint256 _newFileId = totalFilesCount;

        File storage newFile = allFiles[_newFileId];

        newFile.fileName = _fileName;
        newFile.hashValue = _hashValue;
        newFile.fileDescription = _fileDescription;
        newFile.fileType = _fileType;
        newFile.fileSize = _fileSize;
        newFile.uploadTime = block.timestamp;
        newFile.lastUpdated = block.timestamp;
        newFile.owner = msg.sender;
        newFile.isPrivate = _isPrivate;

        emit FileUploaded(
            _fileName,
            _hashValue,
            _fileDescription,
            _fileType,
            _fileSize,
            block.timestamp,
            block.timestamp,
            msg.sender,
            _isPrivate
        );
    }

    function toggleIsPrivate(uint _id) public onlyOwner {
        require(allFiles[_id].owner != address(0), "File does not exist");

        allFiles[_id].isPrivate = !allFiles[_id].isPrivate;
    }

    function getTotalFilesCount() public view returns (uint256) {
        return totalFilesCount;
    }

    function getAllFiles() public view returns (File[] memory) {
        File[] memory files = new File[](totalFilesCount);
        for (uint256 i = 0; i < totalFilesCount; i++) {
            files[i] = allFiles[i];
        }

        return files;
    }

    function getFilesByOwnerAddress(
        address _owner
    ) public view returns (File[] memory) {
        uint counter = 0;
        uint currentIndex = 0;

        for (uint i = 0; i < totalFilesCount; i++) {
            if (allFiles[i].owner == _owner) counter++;
        }

        File[] memory files = new File[](counter);
        for (uint i = 0; i < totalFilesCount; i++) {
            if (allFiles[i].owner == _owner) {
                files[currentIndex] = allFiles[i];
                currentIndex++;
            }
        }

        return files;
    }

    function getFileById(uint _id) public view returns (File memory) {
        return allFiles[_id];
    }

    function transferOwnership(address _to) public onlyOwner {
        owner = _to;
    }
}
