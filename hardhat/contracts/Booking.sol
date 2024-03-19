// SPDX-License-identifier: MIT
pragma solidity ^0.8.20;

contract Booking {

    mapping(bytes32 => BookingInfo) public bookings;
    mapping(bytes32 => bytes32[]) public studioBookings;
    struct BookingInfo{
        bytes32 studioId;
        address user;
        uint8 instruments;
        uint256 totalCost;
        uint256 startTime;
        uint256 endTime;
        uint256 bookingCreatedAt;
    }

    

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function createBooking(bytes32 studioId, uint8 instruments, address user, uint256 startTime, uint256 endTime, bool isValid) public {
                bytes32 bookingId = generateBookingId(startTime, endTime);

        require(isValidBooking(isValid), "Invalid booking details");

        uint256 totalCost = calculateTotalCost(instruments, startTime, endTime);

       

        bookings[bookingId] = BookingInfo(studioId, user, instruments, totalCost, startTime, endTime, block.timestamp);
    }


    function isValidBooking(bool isValid) public view returns (bool) {
        return isValid;
    }

    function calculateTotalCost(uint256 instruments, uint256 startTime, uint256 endTime) public view returns(uint256) {
        uint256 totalCost = instruments * 75 + (endTime - startTime) * 250;
    }

    function generateBookingId(uint startTime, uint endTime) private returns (bytes32) {
        bytes32 bookingHash = keccak256(abi.encodePacked(block.timestamp, startTime, endTime));

        return bookingHash;
    }

     // Function to get studio availability within a time frame
    function getStudioAvailability(bytes32 studioId, uint256 startTime, uint256 endTime) public view returns (bool) {
        for (uint i = 0; i < studioBookings[studioId].length; i++) {
            bytes32 existingBookingId = studioBookings[studioId][i];
            BookingInfo memory existingBooking = bookings[existingBookingId];
            if (
                (startTime < existingBooking.endTime && startTime >= existingBooking.startTime) ||
                (endTime > existingBooking.startTime && endTime <= existingBooking.endTime) ||
                (startTime <= existingBooking.startTime && endTime >= existingBooking.endTime)
            ) {
                return false; // Overlap found, studio not available
            }
        }
        return true; // No overlap found, studio available
    }
}