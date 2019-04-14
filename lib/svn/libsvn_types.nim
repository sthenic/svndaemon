import ../apr/libapr

const
   SVN_NO_ERROR* = nil
   SVN_TRUE* = 1
   SVN_FALSE* = 0

type
   SvnError* {.bycopy.} = object
      apr_err*: AprStatus
      message*: cstring
      child*: ptr SvnError
      pool*: ptr AprPool
      file*: cstring
      line*: clong

   SvnRevnum* = clong
   SvnBoolean* = cint
   SvnCancelFunc* = proc (cancel_baton: pointer): ptr SvnError {.cdecl.}
   SvnLogEntry* {.bycopy.} = object
      changed_paths*: ptr AprHash
      revision*: SvnRevnum
      revprops*: ptr AprHash
      has_children*: SvnBoolean
      changed_paths2*: ptr AprHash
      non_inheritable*: SvnBoolean
      subtractive_merge*: SvnBoolean
   SvnLogEntryReceiver* =
      proc (baton: pointer, log_entry: ptr SvnLogEntry, pool: ptr AprPool):
         ptr SvnError {.cdecl.}

const
   SVN_INVALID_REVNUM* = cast[SvnRevnum](-1)