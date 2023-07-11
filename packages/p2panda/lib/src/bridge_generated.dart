// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.78.0.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, unnecessary_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member, prefer_is_empty, unnecessary_const

import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';

import 'dart:ffi' as ffi;

abstract class P2Panda {
  /// Create, sign and encode a p2panda entry.
  Future<Uint8List> signAndEncodeEntry(
      {required int logId,
      required int seqNum,
      String? skiplinkHash,
      String? backlinkHash,
      required Uint8List payload,
      required KeyPair keyPair,
      dynamic hint});

  FlutterRustBridgeTaskConstMeta get kSignAndEncodeEntryConstMeta;

  /// Encode a p2panda operation parsed from JSON input.
  Future<Uint8List> encodeOperation({required String json, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kEncodeOperationConstMeta;

  /// Generates a new key pair using the systems random number generator (CSPRNG) as a seed.
  Future<KeyPair> newStaticMethodKeyPair({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kNewStaticMethodKeyPairConstMeta;

  /// Derives a key pair from a private key.
  Future<KeyPair> fromPrivateKeyStaticMethodKeyPair(
      {required Uint8List bytes, dynamic hint});

  FlutterRustBridgeTaskConstMeta
      get kFromPrivateKeyStaticMethodKeyPairConstMeta;

  /// Returns the private half of the key pair.
  Future<Uint8List> privateKeyMethodKeyPair(
      {required KeyPair that, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kPrivateKeyMethodKeyPairConstMeta;

  /// Returns the public half of the key pair.
  Future<Uint8List> publicKeyMethodKeyPair(
      {required KeyPair that, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kPublicKeyMethodKeyPairConstMeta;

  DropFnType get dropOpaquePandaKeyPair;
  ShareFnType get shareOpaquePandaKeyPair;
  OpaqueTypeFinalizer get PandaKeyPairFinalizer;
}

@sealed
class PandaKeyPair extends FrbOpaque {
  final P2Panda bridge;
  PandaKeyPair.fromRaw(int ptr, int size, this.bridge)
      : super.unsafe(ptr, size);
  @override
  DropFnType get dropFn => bridge.dropOpaquePandaKeyPair;

  @override
  ShareFnType get shareFn => bridge.shareOpaquePandaKeyPair;

  @override
  OpaqueTypeFinalizer get staticFinalizer => bridge.PandaKeyPairFinalizer;
}

/// Ed25519 key pair for authors to sign p2panda entries with.
class KeyPair {
  final P2Panda bridge;
  final PandaKeyPair field0;

  const KeyPair({
    required this.bridge,
    required this.field0,
  });

  /// Generates a new key pair using the systems random number generator (CSPRNG) as a seed.
  static Future<KeyPair> newKeyPair({required P2Panda bridge, dynamic hint}) =>
      bridge.newStaticMethodKeyPair(hint: hint);

  /// Derives a key pair from a private key.
  static Future<KeyPair> fromPrivateKey(
          {required P2Panda bridge, required Uint8List bytes, dynamic hint}) =>
      bridge.fromPrivateKeyStaticMethodKeyPair(bytes: bytes, hint: hint);

  /// Returns the private half of the key pair.
  Future<Uint8List> privateKey({dynamic hint}) =>
      bridge.privateKeyMethodKeyPair(
        that: this,
      );

  /// Returns the public half of the key pair.
  Future<Uint8List> publicKey({dynamic hint}) => bridge.publicKeyMethodKeyPair(
        that: this,
      );
}

class P2PandaImpl implements P2Panda {
  final P2PandaPlatform _platform;
  factory P2PandaImpl(ExternalLibrary dylib) =>
      P2PandaImpl.raw(P2PandaPlatform(dylib));

  /// Only valid on web/WASM platforms.
  factory P2PandaImpl.wasm(FutureOr<WasmModule> module) =>
      P2PandaImpl(module as ExternalLibrary);
  P2PandaImpl.raw(this._platform);
  Future<Uint8List> signAndEncodeEntry(
      {required int logId,
      required int seqNum,
      String? skiplinkHash,
      String? backlinkHash,
      required Uint8List payload,
      required KeyPair keyPair,
      dynamic hint}) {
    var arg0 = _platform.api2wire_u64(logId);
    var arg1 = _platform.api2wire_u64(seqNum);
    var arg2 = _platform.api2wire_opt_String(skiplinkHash);
    var arg3 = _platform.api2wire_opt_String(backlinkHash);
    var arg4 = _platform.api2wire_uint_8_list(payload);
    var arg5 = _platform.api2wire_box_autoadd_key_pair(keyPair);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_sign_and_encode_entry(
          port_, arg0, arg1, arg2, arg3, arg4, arg5),
      parseSuccessData: _wire2api_uint_8_list,
      constMeta: kSignAndEncodeEntryConstMeta,
      argValues: [logId, seqNum, skiplinkHash, backlinkHash, payload, keyPair],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kSignAndEncodeEntryConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "sign_and_encode_entry",
        argNames: [
          "logId",
          "seqNum",
          "skiplinkHash",
          "backlinkHash",
          "payload",
          "keyPair"
        ],
      );

  Future<Uint8List> encodeOperation({required String json, dynamic hint}) {
    var arg0 = _platform.api2wire_String(json);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_encode_operation(port_, arg0),
      parseSuccessData: _wire2api_uint_8_list,
      constMeta: kEncodeOperationConstMeta,
      argValues: [json],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kEncodeOperationConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "encode_operation",
        argNames: ["json"],
      );

  Future<KeyPair> newStaticMethodKeyPair({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_new__static_method__KeyPair(port_),
      parseSuccessData: (d) => _wire2api_key_pair(d),
      constMeta: kNewStaticMethodKeyPairConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kNewStaticMethodKeyPairConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "new__static_method__KeyPair",
        argNames: [],
      );

  Future<KeyPair> fromPrivateKeyStaticMethodKeyPair(
      {required Uint8List bytes, dynamic hint}) {
    var arg0 = _platform.api2wire_uint_8_list(bytes);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner
          .wire_from_private_key__static_method__KeyPair(port_, arg0),
      parseSuccessData: (d) => _wire2api_key_pair(d),
      constMeta: kFromPrivateKeyStaticMethodKeyPairConstMeta,
      argValues: [bytes],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta
      get kFromPrivateKeyStaticMethodKeyPairConstMeta =>
          const FlutterRustBridgeTaskConstMeta(
            debugName: "from_private_key__static_method__KeyPair",
            argNames: ["bytes"],
          );

  Future<Uint8List> privateKeyMethodKeyPair(
      {required KeyPair that, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_key_pair(that);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_private_key__method__KeyPair(port_, arg0),
      parseSuccessData: _wire2api_uint_8_list,
      constMeta: kPrivateKeyMethodKeyPairConstMeta,
      argValues: [that],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kPrivateKeyMethodKeyPairConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "private_key__method__KeyPair",
        argNames: ["that"],
      );

  Future<Uint8List> publicKeyMethodKeyPair(
      {required KeyPair that, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_key_pair(that);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_public_key__method__KeyPair(port_, arg0),
      parseSuccessData: _wire2api_uint_8_list,
      constMeta: kPublicKeyMethodKeyPairConstMeta,
      argValues: [that],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kPublicKeyMethodKeyPairConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "public_key__method__KeyPair",
        argNames: ["that"],
      );

  DropFnType get dropOpaquePandaKeyPair =>
      _platform.inner.drop_opaque_PandaKeyPair;
  ShareFnType get shareOpaquePandaKeyPair =>
      _platform.inner.share_opaque_PandaKeyPair;
  OpaqueTypeFinalizer get PandaKeyPairFinalizer =>
      _platform.PandaKeyPairFinalizer;

  void dispose() {
    _platform.dispose();
  }
// Section: wire2api

  PandaKeyPair _wire2api_PandaKeyPair(dynamic raw) {
    return PandaKeyPair.fromRaw(raw[0], raw[1], this);
  }

  KeyPair _wire2api_key_pair(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 1)
      throw Exception('unexpected arr length: expect 1 but see ${arr.length}');
    return KeyPair(
      bridge: this,
      field0: _wire2api_PandaKeyPair(arr[0]),
    );
  }

  int _wire2api_u8(dynamic raw) {
    return raw as int;
  }

  Uint8List _wire2api_uint_8_list(dynamic raw) {
    return raw as Uint8List;
  }
}

// Section: api2wire

@protected
int api2wire_u8(int raw) {
  return raw;
}

// Section: finalizer

class P2PandaPlatform extends FlutterRustBridgeBase<P2PandaWire> {
  P2PandaPlatform(ffi.DynamicLibrary dylib) : super(P2PandaWire(dylib));

// Section: api2wire

  @protected
  wire_PandaKeyPair api2wire_PandaKeyPair(PandaKeyPair raw) {
    final ptr = inner.new_PandaKeyPair();
    _api_fill_to_wire_PandaKeyPair(raw, ptr);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_String(String raw) {
    return api2wire_uint_8_list(utf8.encoder.convert(raw));
  }

  @protected
  ffi.Pointer<wire_KeyPair> api2wire_box_autoadd_key_pair(KeyPair raw) {
    final ptr = inner.new_box_autoadd_key_pair_0();
    _api_fill_to_wire_key_pair(raw, ptr.ref);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_opt_String(String? raw) {
    return raw == null ? ffi.nullptr : api2wire_String(raw);
  }

  @protected
  int api2wire_u64(int raw) {
    return raw;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_uint_8_list(Uint8List raw) {
    final ans = inner.new_uint_8_list_0(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }
// Section: finalizer

  late final OpaqueTypeFinalizer _PandaKeyPairFinalizer =
      OpaqueTypeFinalizer(inner._drop_opaque_PandaKeyPairPtr);
  OpaqueTypeFinalizer get PandaKeyPairFinalizer => _PandaKeyPairFinalizer;
// Section: api_fill_to_wire

  void _api_fill_to_wire_PandaKeyPair(
      PandaKeyPair apiObj, wire_PandaKeyPair wireObj) {
    wireObj.ptr = apiObj.shareOrMove();
  }

  void _api_fill_to_wire_box_autoadd_key_pair(
      KeyPair apiObj, ffi.Pointer<wire_KeyPair> wireObj) {
    _api_fill_to_wire_key_pair(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_key_pair(KeyPair apiObj, wire_KeyPair wireObj) {
    wireObj.field0 = api2wire_PandaKeyPair(apiObj.field0);
  }
}

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_positional_boolean_parameters, annotate_overrides, constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint

/// generated by flutter_rust_bridge
class P2PandaWire implements FlutterRustBridgeWireBase {
  @internal
  late final dartApi = DartApiDl(init_frb_dart_api_dl);

  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  P2PandaWire(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  P2PandaWire.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void store_dart_post_cobject(
    DartPostCObjectFnType ptr,
  ) {
    return _store_dart_post_cobject(
      ptr,
    );
  }

  late final _store_dart_post_cobjectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(DartPostCObjectFnType)>>(
          'store_dart_post_cobject');
  late final _store_dart_post_cobject = _store_dart_post_cobjectPtr
      .asFunction<void Function(DartPostCObjectFnType)>();

  Object get_dart_object(
    int ptr,
  ) {
    return _get_dart_object(
      ptr,
    );
  }

  late final _get_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Handle Function(ffi.UintPtr)>>(
          'get_dart_object');
  late final _get_dart_object =
      _get_dart_objectPtr.asFunction<Object Function(int)>();

  void drop_dart_object(
    int ptr,
  ) {
    return _drop_dart_object(
      ptr,
    );
  }

  late final _drop_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.UintPtr)>>(
          'drop_dart_object');
  late final _drop_dart_object =
      _drop_dart_objectPtr.asFunction<void Function(int)>();

  int new_dart_opaque(
    Object handle,
  ) {
    return _new_dart_opaque(
      handle,
    );
  }

  late final _new_dart_opaquePtr =
      _lookup<ffi.NativeFunction<ffi.UintPtr Function(ffi.Handle)>>(
          'new_dart_opaque');
  late final _new_dart_opaque =
      _new_dart_opaquePtr.asFunction<int Function(Object)>();

  int init_frb_dart_api_dl(
    ffi.Pointer<ffi.Void> obj,
  ) {
    return _init_frb_dart_api_dl(
      obj,
    );
  }

  late final _init_frb_dart_api_dlPtr =
      _lookup<ffi.NativeFunction<ffi.IntPtr Function(ffi.Pointer<ffi.Void>)>>(
          'init_frb_dart_api_dl');
  late final _init_frb_dart_api_dl = _init_frb_dart_api_dlPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  void wire_sign_and_encode_entry(
    int port_,
    int log_id,
    int seq_num,
    ffi.Pointer<wire_uint_8_list> skiplink_hash,
    ffi.Pointer<wire_uint_8_list> backlink_hash,
    ffi.Pointer<wire_uint_8_list> payload,
    ffi.Pointer<wire_KeyPair> key_pair,
  ) {
    return _wire_sign_and_encode_entry(
      port_,
      log_id,
      seq_num,
      skiplink_hash,
      backlink_hash,
      payload,
      key_pair,
    );
  }

  late final _wire_sign_and_encode_entryPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64,
              ffi.Uint64,
              ffi.Uint64,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_KeyPair>)>>('wire_sign_and_encode_entry');
  late final _wire_sign_and_encode_entry =
      _wire_sign_and_encode_entryPtr.asFunction<
          void Function(
              int,
              int,
              int,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_KeyPair>)>();

  void wire_encode_operation(
    int port_,
    ffi.Pointer<wire_uint_8_list> json,
  ) {
    return _wire_encode_operation(
      port_,
      json,
    );
  }

  late final _wire_encode_operationPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_uint_8_list>)>>('wire_encode_operation');
  late final _wire_encode_operation = _wire_encode_operationPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_new__static_method__KeyPair(
    int port_,
  ) {
    return _wire_new__static_method__KeyPair(
      port_,
    );
  }

  late final _wire_new__static_method__KeyPairPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_new__static_method__KeyPair');
  late final _wire_new__static_method__KeyPair =
      _wire_new__static_method__KeyPairPtr.asFunction<void Function(int)>();

  void wire_from_private_key__static_method__KeyPair(
    int port_,
    ffi.Pointer<wire_uint_8_list> bytes,
  ) {
    return _wire_from_private_key__static_method__KeyPair(
      port_,
      bytes,
    );
  }

  late final _wire_from_private_key__static_method__KeyPairPtr = _lookup<
          ffi.NativeFunction<
              ffi.Void Function(ffi.Int64, ffi.Pointer<wire_uint_8_list>)>>(
      'wire_from_private_key__static_method__KeyPair');
  late final _wire_from_private_key__static_method__KeyPair =
      _wire_from_private_key__static_method__KeyPairPtr
          .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_private_key__method__KeyPair(
    int port_,
    ffi.Pointer<wire_KeyPair> that,
  ) {
    return _wire_private_key__method__KeyPair(
      port_,
      that,
    );
  }

  late final _wire_private_key__method__KeyPairPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_KeyPair>)>>('wire_private_key__method__KeyPair');
  late final _wire_private_key__method__KeyPair =
      _wire_private_key__method__KeyPairPtr
          .asFunction<void Function(int, ffi.Pointer<wire_KeyPair>)>();

  void wire_public_key__method__KeyPair(
    int port_,
    ffi.Pointer<wire_KeyPair> that,
  ) {
    return _wire_public_key__method__KeyPair(
      port_,
      that,
    );
  }

  late final _wire_public_key__method__KeyPairPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_KeyPair>)>>('wire_public_key__method__KeyPair');
  late final _wire_public_key__method__KeyPair =
      _wire_public_key__method__KeyPairPtr
          .asFunction<void Function(int, ffi.Pointer<wire_KeyPair>)>();

  wire_PandaKeyPair new_PandaKeyPair() {
    return _new_PandaKeyPair();
  }

  late final _new_PandaKeyPairPtr =
      _lookup<ffi.NativeFunction<wire_PandaKeyPair Function()>>(
          'new_PandaKeyPair');
  late final _new_PandaKeyPair =
      _new_PandaKeyPairPtr.asFunction<wire_PandaKeyPair Function()>();

  ffi.Pointer<wire_KeyPair> new_box_autoadd_key_pair_0() {
    return _new_box_autoadd_key_pair_0();
  }

  late final _new_box_autoadd_key_pair_0Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_KeyPair> Function()>>(
          'new_box_autoadd_key_pair_0');
  late final _new_box_autoadd_key_pair_0 = _new_box_autoadd_key_pair_0Ptr
      .asFunction<ffi.Pointer<wire_KeyPair> Function()>();

  ffi.Pointer<wire_uint_8_list> new_uint_8_list_0(
    int len,
  ) {
    return _new_uint_8_list_0(
      len,
    );
  }

  late final _new_uint_8_list_0Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_uint_8_list> Function(
              ffi.Int32)>>('new_uint_8_list_0');
  late final _new_uint_8_list_0 = _new_uint_8_list_0Ptr
      .asFunction<ffi.Pointer<wire_uint_8_list> Function(int)>();

  void drop_opaque_PandaKeyPair(
    ffi.Pointer<ffi.Void> ptr,
  ) {
    return _drop_opaque_PandaKeyPair(
      ptr,
    );
  }

  late final _drop_opaque_PandaKeyPairPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>(
          'drop_opaque_PandaKeyPair');
  late final _drop_opaque_PandaKeyPair = _drop_opaque_PandaKeyPairPtr
      .asFunction<void Function(ffi.Pointer<ffi.Void>)>();

  ffi.Pointer<ffi.Void> share_opaque_PandaKeyPair(
    ffi.Pointer<ffi.Void> ptr,
  ) {
    return _share_opaque_PandaKeyPair(
      ptr,
    );
  }

  late final _share_opaque_PandaKeyPairPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('share_opaque_PandaKeyPair');
  late final _share_opaque_PandaKeyPair = _share_opaque_PandaKeyPairPtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  void free_WireSyncReturn(
    WireSyncReturn ptr,
  ) {
    return _free_WireSyncReturn(
      ptr,
    );
  }

  late final _free_WireSyncReturnPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(WireSyncReturn)>>(
          'free_WireSyncReturn');
  late final _free_WireSyncReturn =
      _free_WireSyncReturnPtr.asFunction<void Function(WireSyncReturn)>();
}

final class _Dart_Handle extends ffi.Opaque {}

final class wire_uint_8_list extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

final class wire_PandaKeyPair extends ffi.Struct {
  external ffi.Pointer<ffi.Void> ptr;
}

final class wire_KeyPair extends ffi.Struct {
  external wire_PandaKeyPair field0;
}

typedef DartPostCObjectFnType = ffi.Pointer<
    ffi.NativeFunction<
        ffi.Bool Function(DartPort port_id, ffi.Pointer<ffi.Void> message)>>;
typedef DartPort = ffi.Int64;
