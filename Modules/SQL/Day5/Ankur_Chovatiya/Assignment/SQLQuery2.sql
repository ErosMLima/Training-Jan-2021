SELECT EMP.FIRST_NAME , SAL.INCENTIVE_AMOUNT 
FROM Employee AS EMP
LEFT JOIN Incentive AS SAL
ON EMP.EMPLOYEE_ID = SAL.EMPLOYEE_REF_ID
WHERE SAL.INCENTIVE_AMOUNT  > 3000