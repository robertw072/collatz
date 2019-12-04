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
    integer                :: i, lsup, bubble, count

    interface 
        recursive function count_collatz(in, count)
            integer(kind=16), intent(in)    :: in
            integer, intent(in)             :: count
            integer                         :: out
        end function count_collatz

    end interface

    allocate(collatz_list(10000))

    n = 1
    do i = 1, 10000          ! compute the collatz sequence lengths and store them
        count = 0
        tup%num = n
        tup%length = count_collatz(n, count)
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

recursive function count_collatz(in, count) result(out)    ! functions that computes the collatz sequence length for a given n
    integer(kind=16), intent(in)    :: in   ! the integer to be evaluated
    integer, intent(in)             :: count
    integer(kind=16)                :: n    ! function variable so we can manipulate the value of the input
    integer                         :: out

    n = in
    out = count
    if (n .eq. 1) then
        out = count
    end if
    if (mod(n, int(2, 16)) .eq. int(1, 16)) then
        n = 3*n + 1
        out = count_collatz(n, out + 1)
    else
        n = n / 2
        out = count_collatz(n, out + 1)
    end if
end function count_collatz