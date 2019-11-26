program collatz
    implicit none

    ! object to hold integer/length pairs
    type tuple              
        integer(kind=16)    :: num
        integer             :: length
    end type tuple

    ! declare necessary variables
    integer(kind=16)       :: n     
    integer                :: count_collatz ! function variable
    type(tuple)            :: tup, tmp
    type(tuple), dimension(:), allocatable  :: collatz_list, small
    integer                :: i, lsup, bubble

    interface 
        function count_collatz(in)
            integer(kind=16), intent(in)    :: in
            integer                         :: count
        end function count_collatz

    end interface

    allocate(collatz_list(5000))

    n = 1
    do i = 1, 5000          ! compute the collatz sequence lengths and store them
        tup%num = n
        tup%length = count_collatz(n)
        collatz_list(i) = tup
        n = n + 1        
    end do

    ! sorting by length, bubble sort
    lsup = size(collatz_list)
    do while(lsup .gt. 1)
        bubble = 0 
        do i = 1, (lsup - 1)
            if (collatz_list(i)%length .lt. collatz_list(i+1)%length) then
                tmp = collatz_list(i)
                collatz_list(i) = collatz_list(i+1)
                collatz_list(i+1) = tmp
                bubble = i
            end if
        end do
        lsup = bubble
    end do

    allocate(small(10))

    print *, "The 10 integers with the longest collatz sequence lengths sorted by length: "
    do i = 1, 10
        print *, collatz_list(i)
        small(i) = collatz_list(i)       ! store the 10 longest lengths in the smaller vector for easy sort
    end do

    ! sort by magnitude, also bubblesort
    lsup = size(small)
    do while(lsup .gt. 1)
        bubble = 0 
        do i = 1, (lsup - 1)
            if (small(i)%num .lt. small(i+1)%num) then
                tmp = small(i)
                small(i) = small(i+1)
                small(i+1) = tmp
                bubble = i
            end if
        end do
        lsup = bubble
    end do

    print *, "The 10 integers with the longest collatz sequences sorted by magnitude: "
    do i = 1, 10
        print *, small(i)
    end do

    deallocate(collatz_list)
    deallocate(small)
end program collatz

function count_collatz(in) result(count)    ! functions that computes the collatz sequence length for a given n
    integer(kind=16), intent(in)    :: in   ! the integer to be evaluated
    integer                         :: count
    integer(kind=16)                :: n    ! function variable so we can manipulate the value of the input

    count = 1                               ! holds the length of the sequence
    n = in
    do while(n .ne. int(1, 16))
        if (mod(n, int(2, 16)) .eq. int(1, 16)) then    ! if even
            n = 3*n + 1
        else                                            ! if odd
            n = n / 2
        end if
        count = count + 1
    end do
end function count_collatz