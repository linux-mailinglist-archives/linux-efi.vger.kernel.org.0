Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F312981F6
	for <lists+linux-efi@lfdr.de>; Sun, 25 Oct 2020 14:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416432AbgJYNuE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Oct 2020 09:50:04 -0400
Received: from foss.arm.com ([217.140.110.172]:46340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416426AbgJYNuD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 25 Oct 2020 09:50:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8AE430E;
        Sun, 25 Oct 2020 06:50:02 -0700 (PDT)
Received: from e123331-lin.nice.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A33C3F68F;
        Sun, 25 Oct 2020 06:50:01 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>, grub-devel@gnu.org,
        daniel.kiper@oracle.com, leif@nuviainc.com
Subject: [PATCH v2 6/8] efi: add definition of LoadFile2 protocol
Date:   Sun, 25 Oct 2020 14:49:39 +0100
Message-Id: <20201025134941.4805-7-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201025134941.4805-1-ard.biesheuvel@arm.com>
References: <20201025134941.4805-1-ard.biesheuvel@arm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Incorporate the EFI_LOAD_FILE2_PROTOCOL GUID and C types from the
UEFI spec.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
Reviewed-by: Leif Lindholm <leif@nuviainc.com>
---
 grub-core/commands/efi/lsefi.c |  1 +
 include/grub/efi/api.h         | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/grub-core/commands/efi/lsefi.c b/grub-core/commands/efi/lsefi.c
index d1ce99af4389..145cbfcdaf5c 100644
--- a/grub-core/commands/efi/lsefi.c
+++ b/grub-core/commands/efi/lsefi.c
@@ -55,6 +55,7 @@ struct known_protocol
     { GRUB_EFI_ABSOLUTE_POINTER_PROTOCOL_GUID, "absolute pointer" },
     { GRUB_EFI_DRIVER_BINDING_PROTOCOL_GUID, "EFI driver binding" },
     { GRUB_EFI_LOAD_FILE_PROTOCOL_GUID, "load file" },
+    { GRUB_EFI_LOAD_FILE2_PROTOCOL_GUID, "load file 2" },
     { GRUB_EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID, "simple FS" },
     { GRUB_EFI_TAPE_IO_PROTOCOL_GUID, "tape I/O" },
     { GRUB_EFI_UNICODE_COLLATION_PROTOCOL_GUID, "unicode collation" },
diff --git a/include/grub/efi/api.h b/include/grub/efi/api.h
index 1dcaa12f59e8..8bc040d9251b 100644
--- a/include/grub/efi/api.h
+++ b/include/grub/efi/api.h
@@ -149,6 +149,11 @@
     { 0x8E, 0x3F, 0x00, 0xA0, 0xC9, 0x69, 0x72, 0x3B } \
   }
 
+#define GRUB_EFI_LOAD_FILE2_PROTOCOL_GUID \
+  { 0x4006c0c1, 0xfcb3, 0x403e, \
+    { 0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d } \
+  }
+
 #define GRUB_EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID \
   { 0x0964e5b22, 0x6459, 0x11d2, \
     { 0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b } \
@@ -1694,6 +1699,16 @@ struct grub_efi_block_io
 };
 typedef struct grub_efi_block_io grub_efi_block_io_t;
 
+struct grub_efi_load_file2
+{
+  grub_efi_status_t (*load_file)(struct grub_efi_load_file2 *this,
+				 grub_efi_device_path_t *file_path,
+				 grub_efi_boolean_t boot_policy,
+				 grub_efi_uintn_t *buffer_size,
+				 void *buffer);
+};
+typedef struct grub_efi_load_file2 grub_efi_load_file2_t;
+
 #if (GRUB_TARGET_SIZEOF_VOID_P == 4) || defined (__ia64__) \
   || defined (__aarch64__) || defined (__MINGW64__) || defined (__CYGWIN__) \
   || defined(__riscv)
-- 
2.17.1

