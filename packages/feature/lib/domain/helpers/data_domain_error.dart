/// Stablishs the base status for all domain errors.
enum DataDomainError {
  /// Status when the cache is not available.
  notFound,

  /// Status when a register is already in the cache.
  alreadyExists,

  /// Status whe the register is not possible to save.
  unsaved,

  /// Status when the register is not possible to delete.
  unexpected,

  /// Non Error status.
  none,
}
