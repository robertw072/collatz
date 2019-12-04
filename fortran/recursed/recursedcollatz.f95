program collatz
    implicit none

    ! object to hold integer/length pairs
    type tuple              
        integer(kind=8)    :: num
        integer(kind=8)    :: length
    end type tuple

    ! declare necessary variables
    integer(kind=8)       :: n     
    integer(kind=8)       :: count_collatz ! function variable
    type(tuple)            :: tup, tmp
    type(tuple), dimension(:), allocatable  :: collatz_list, small
    integer(kind=8)       :: i, lsup, bubble, count
    integer(kind=8)       :: max_value = 5e9

    !interface 
    !    recursive integer function count_collatz(in)
    !        integer(kind=16), intent(in)    :: in
    !        integer                         :: count
    !    end function count_collatz

    !end interface

    allocate(collatz_list(max_value))

    n = 1
    do i = 1, max_value          ! compute the collatz sequence lengths and store them
        count = 0
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

recursive function count_collatz(in) result(count)    ! functions that computes the collatz sequence length for a given n
    integer(kind=8), intent(in)    :: in   ! the integer to be evaluated
    integer(kind=8)                :: count
    integer(kind=8)                :: n    ! function variable so we can manipulate the value of the input

    n = in
    
    if (n .eq. 1) then
        count = 0
        return
    end if
    if (mod(n, int(2, 16)) .eq. int(1, 16)) then
        n = 3*n + 1
        count = 1 + count_collatz(n)
    else
        n = n / 2
        count = 1 + count_collatz(n)
    end if
end function count_collatz