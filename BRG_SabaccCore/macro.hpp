#define ANYONE 0
#define CLIENT 1
#define SERVER 2

#define F(NAME) \
    class NAME  \
    {           \
    };

#define F_PostInit(NAME) \
    class NAME           \
    {                    \
        postInit = 1     \
    };

#define RemoteExec(NAME, TARGET) \
    class NAME                   \
    {                            \
        allowedTargets = TARGET; \
    };

#define RemoteExecJIP(NAME, TARGET) \
    class NAME                      \
    {                               \
        allowedTargets = TARGET;    \
        jip = 1;                    \
    };