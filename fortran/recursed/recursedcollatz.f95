program collatz
    implicit none

    ! object to hold integer/length pairs
    type tuple              
        integer(kind=8)    :: num
        integer(kind=8)    :: length
    end type tuple

    ! declare necessary variables
    !integer(kind=8)       :: n     
    integer(kind=8)       :: count_collatz ! function variable
    type(tuple)            :: tup, tmp
    type(tuple), dimension(10)  :: collatz_list
    integer               :: j, offset, temp
    integer(kind=8)       :: i, max_value = 10000
    integer               :: lsup, bubble

    ! zero the array
    do j = 1, 10
        tmp%num = 0
        tmp%length = 0
        collatz_list(j) = tmp 
    end do

    !allocate(collatz_list(max_value))

    do i = 1, max_value          ! compute the collatz sequence lengths and store them
        tup%num = i
        tup%length = count_collatz(i)
        if (tup%length .gt. collatz_list(10)%length) then   ! check if the new collatz sequence length is a max
            offset = 0                                      ! variable to track where the new max should go in the list
            do while (tup%length .lt. collatz_list(offset)%length)  ! find where the new max should go
                offset = offset + 1
            end do

            ! move values of list into correct position 
            temp = offset
            offset = 10
            do while (offset > temp)
                collatz_list(offset) = collatz_list(offset-1)
                offset = offset - 1
            end do  
            collatz_list(temp) = tup    ! insert the integer/length pair into the list
        end if      
    end do

    ! print the list of 10 largest collatz sequence lengths sorted by length
    print *, "The 10 largest collatz sequence lengths sorted by length: "
    do i = 1, 10
        print *, collatz_list(i)
    end do

    ! sort by magnitude, bubblesort
    lsup = size(collatz_list)
    do while(lsup .gt. 1)
        bubble = 0 
        do j = 1, (lsup - 1)
            if (collatz_list(j)%num .lt. collatz_list(j+1)%num) then
                tmp = collatz_list(j)
                collatz_list(j) = collatz_list(j+1)
                collatz_list(j+1) = tmp
                bubble = j
            end if
        end do
        lsup = bubble
    end do

    ! print the list of 10 largest collatz sequence lengths sorted by length
    print *, "The 10 largest collatz sequence lengths sorted by magnitude: "
    do i = 1, 10
        print *, collatz_list(i)
    end do
end program collatz

recursive function count_collatz(in) result(count)    ! functions that computes the collatz sequence length for a given n
    integer(kind=8), intent(in)    :: in   ! the integer to be evaluated
    integer(kind=8)                :: count
    integer(kind=8)                :: n    ! function variable so we can manipulate the value of the input

    n = in
    
    if (n .eq. 1) then  ! if n is 1, stop recurring and return
        count = 0
        return
    end if
    if (mod(n, int(2, 16)) .eq. int(1, 16)) then    ! if n is odd
        n = 3*n + 1
        count = 1 + count_collatz(n)                ! increment count and recur
    else                                            ! if n is even
        n = n / 2
        count = 1 + count_collatz(n)                ! increment count and recur
    end if
end function count_collatz