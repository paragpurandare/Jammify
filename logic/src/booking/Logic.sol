// SPDX-License-Identifier: MIT
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
pragma solidity ^0.8.19;


contract BookingLogic is Initializable, OwnableUpgradeable, UUPSUpgradeable {

    // Define storage variables for booking data
    mapping(bytes32 => Booking) public bookings;
    mapping(bytes32 => bytes32[]) public studioBookings;

    struct Booking {
        bytes32 studioId;
        uint startTime;
        uint endTime;
        address user;
    }

    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        // __Ownable_init();
        __UUPSUpgradeable_init();
    }

     // Event for creating a booking
  event BookingCreated(bytes32 bookingId, bytes32 studioId, uint startTime, uint endTime, address user);

   // Event for cancelling a booking
  event BookingCancelled(bytes32 bookingId);

    // Function to create a booking
    function createBooking(bytes32 studioId, uint startTime, uint endTime) public {
        require(isValidBooking(studioId, startTime, endTime), "Invalid booking details");

        bytes32 bookingId = generateBookingId(startTime, endTime);

        bookings[bookingId] = Booking(studioId, startTime, endTime, msg.sender);
        studioBookings[studioId].push(bookingId);

        // Additional logic for handling payments, notifications, etc. can be added here
    }

    // Function to check if a booking is valid
    function isValidBooking(bytes32 studioId, uint startTime, uint endTime) public view returns (bool) {
        // Implement logic to check booking validity based on studio availability, timing conflicts, user permissions, etc.
        // This is a placeholder for the actual implementation.
        return true; // Replace with your actual validation logic
    }

    // Function to generate a unique booking ID
    function generateBookingId(uint startTime, uint endTime) private returns (bytes32) {
        // Implement logic to generate a unique booking ID.
        bytes32 bookingHash = keccak256(abi.encodePacked(block.timestamp, startTime, endTime));
        // This is a placeholder for the actual implementation.
        return bookingHash; // Replace with your actual ID generation logic
    }

    // Function to cancel a booking
    function cancelBooking(bytes32 bookingId) public {
        Booking storage booking = bookings[bookingId];
        require(booking.user == msg.sender, "Unauthorized to cancel booking");

        // Remove booking from studio's list
        bytes32[] storage studioList = studioBookings[booking.studioId];
        uint index = 0;
        bool found = false;
        for (uint i = 0; i < studioList.length; i++) {
            if (studioList[i] == bookingId) {
                found = true;
                break;
            }
            index++;
        }
        require(found, "Booking not found for the studio");

        studioList[index] = studioList[studioList.length - 1];
        studioList.pop();

        // Update booking status or remove it (implementation depends on your logic)
        // In this example, we just set the end time to 0 to mark it cancelled
        booking.endTime = 0;
    }

    // Function to get booking details
    function getBookingDetails(bytes32 bookingId) public view returns (Booking memory) {
        return bookings[bookingId];
    }

    // Function to get studio availability within a time frame
    function getStudioAvailability(bytes32 studioId, uint startTime, uint endTime) public view returns (bool) {
        for (uint i = 0; i < studioBookings[studioId].length; i++) {
            bytes32 existingBookingId = studioBookings[studioId][i];
            Booking memory existingBooking = bookings[existingBookingId];
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
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
    
}
