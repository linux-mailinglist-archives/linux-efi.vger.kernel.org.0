Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBC75A3606
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 10:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiH0Ijb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 04:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiH0Ija (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 04:39:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD65BFC6B
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 01:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D4796148C
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA988C433D7;
        Sat, 27 Aug 2022 08:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661589567;
        bh=PLrDugc7+Zaz4YT8cOzRpx3mFuXH9nqXFJyqIep1MMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQh0AgIvQR+dWYWNZ6CsDn2RPhz4QpdnxGpN+BzuuL4/jrYOW0FekktzQ8yXpIc9e
         12okyponpzBx/1iUU8oDp07EydDlAvsux4I039hg7SVPFUR4ahAxWLUjkZ3QEguZk+
         iDx15sER3PwOFIB1mWVh4bfOVIwqLv6Di+etXqRad1kGjw+aK4Jjo2B+se5NC3PQGA
         vKgpb8G2bMWYI22YrdDP0nCirAL2oV/evMiTne8ZFHhAsKIUmId5RnX9LhrcMYBVir
         B+c3neEIXM7ltgkoDBA9zIZzv+otqM4HmJJUhEpzAd2ioWFw5smNa/rJ4iOFy+K1Gv
         UmxX2c8NwHuXA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 5/9] efi/libstub: implement generic EFI zboot
Date:   Sat, 27 Aug 2022 10:38:46 +0200
Message-Id: <20220827083850.2702465-6-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827083850.2702465-1-ardb@kernel.org>
References: <20220827083850.2702465-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23492; i=ardb@kernel.org; h=from:subject; bh=PLrDugc7+Zaz4YT8cOzRpx3mFuXH9nqXFJyqIep1MMw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCdgTiAzTPxD66cGziz5QhZuuCG0u+lADNhHEWLti 360gQriJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwnYEwAKCRDDTyI5ktmPJKYYDA CbmjxhkCdCyL2CEKyFzvKpL+Bx4EIGCLSRAVom+WvXjBlQOzwlmQTbrpIaBz3lz2bR4ZPEuV4NkASE Ti2JI3DJ4003veZwmGL6iUA1LjIhJ+XYX7Hktnr6h8wGWMbVmVURBgubsYJGZP5Vtxb6zEvWu/qqYT 6fdeKhW1Haz5V3Fgk0aczMbqt1p/2mY37oG2SMFXYDZpmt2feaqPOhCxwekwiVFujgKukaolHr0C6I V8M3Fg7/7tJRpQNnmeHvOYAH/FrU3ArwIlATsSBN+wG4SP+1OFigfjfCI7pwASSOyMtbqFlb+jMYgp KOuzdZz/fArygznzYEHuA0kOhgq/bsGmms2TO5voGjCZtDw2+25obT3tkTk1vGmr2ShVrLkeoR9vF9 2D5c2vRxovgb1inB9/Y8qbflBeLwjBSejLiJUF9FzHoTqNJ6x2rcaNnZWNfMbGCKp3LKnRYzdXS4d0 pQTeIhCYwZDXuRwhO/CNjBE/E4MkeT5RKRJZQz7AQVD8Q=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Implement a minimal EFI app that decompresses the real kernel image and
launches it using the firmware's LoadImage and StartImage boot services.
This removes the need for any arch-specific hacks.

Note that on systems that have UEFI secure boot policies enabled,
LoadImage/StartImage require images to be signed, or their hashes known
a priori, in order to be permitted to boot.

There are various possible strategies to work around this requirement,
but they all rely either on overriding internal PI/DXE protocols (which
are not part of the EFI spec) or omitting the firmware provided
LoadImage() and StartImage() boot services, which is also undesirable,
given that they encapsulate platform specific policies related to secure
boot and measured boot, but also related to memory permissions (whether
or not and which types of heap allocations have both write and execute
permissions.)

The only generic and truly portable way around this is to simply sign
both the inner and the outer image with the same key/cert pair, so this
is what is implemented here.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig                |  29 ++
 drivers/firmware/efi/libstub/Makefile       |   9 +-
 drivers/firmware/efi/libstub/Makefile.zboot |  70 +++++
 drivers/firmware/efi/libstub/file.c         |  17 ++
 drivers/firmware/efi/libstub/zboot-header.S | 139 ++++++++++
 drivers/firmware/efi/libstub/zboot.c        | 289 ++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.lds      |  41 +++
 include/linux/efi.h                         |   1 +
 8 files changed, 592 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index cbf1c55dc224..5bdf3080e5da 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -105,6 +105,35 @@ config EFI_RUNTIME_WRAPPERS
 config EFI_GENERIC_STUB
 	bool
 
+config EFI_ZBOOT
+	def_bool y
+	depends on EFI_GENERIC_STUB && !ARM
+	select HAVE_KERNEL_GZIP
+	select HAVE_KERNEL_LZ4
+	select HAVE_KERNEL_LZMA
+	select HAVE_KERNEL_LZO
+	select HAVE_KERNEL_XZ
+	select HAVE_KERNEL_ZSTD
+
+config EFI_ZBOOT_SIGNED
+	bool "Sign the EFI decompressor for UEFI secure boot"
+	depends on EFI_ZBOOT
+	help
+	  Use the 'sbsign' command line tool (which must exist on the host
+	  path) to sign both the EFI decompressor PE/COFF image, as well as the
+	  encapsulated PE/COFF image, which is subsequently compressed and
+	  wrapped by the former image.
+
+config EFI_ZBOOT_SIGNING_CERT
+	string "Certificate to use for signing the compressed EFI boot image"
+	depends on EFI_ZBOOT_SIGNED
+	default ""
+
+config EFI_ZBOOT_SIGNING_KEY
+	string "Private key to use for signing the compressed EFI boot image"
+	depends on EFI_ZBOOT_SIGNED
+	default ""
+
 config EFI_ARMSTUB_DTB_LOADER
 	bool "Enable the DTB loader"
 	depends on EFI_GENERIC_STUB && !RISCV && !LOONGARCH
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index fbe1900f47c4..8931ed24379e 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -72,6 +72,12 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o fdt.o string.o intrinsics.o \
 lib-y				+= $(ARCH)-stub.o
 CFLAGS_arm-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
+zboot-obj-$(CONFIG_RISCV)	:= lib-clz_ctz.o lib-ashldi3.o
+lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o $(zboot-obj-y)
+
+extra-y				:= $(lib-y)
+lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
+
 # Even when -mbranch-protection=none is set, Clang will generate a
 # .note.gnu.property for code-less object files (like lib/ctype.c),
 # so work around this by explicitly removing the unwanted section.
@@ -111,9 +117,6 @@ STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
 # a verification pass to see if any absolute relocations exist in any of the
 # object files.
 #
-extra-y				:= $(lib-y)
-lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
-
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
 STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
new file mode 100644
index 000000000000..cfacbad0c28a
--- /dev/null
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# to be include'd by arch/$(ARCH)/boot/Makefile after setting
+# EFI_ZBOOT_PAYLOAD, EFI_ZBOOT_BFD_TARGET and EFI_ZBOOT_MACH_TYPE
+
+comp-type-$(CONFIG_KERNEL_GZIP)		:= gzip
+comp-type-$(CONFIG_KERNEL_LZ4)		:= lz4
+comp-type-$(CONFIG_KERNEL_LZMA)		:= lzma
+comp-type-$(CONFIG_KERNEL_LZO)		:= lzo
+comp-type-$(CONFIG_KERNEL_XZ)		:= xzkern
+comp-type-$(CONFIG_KERNEL_ZSTD)		:= zstd22
+
+# in GZIP, the appended le32 carrying the uncompressed size is part of the
+# format, but in other cases, we just append it at the end for convenience,
+# causing the original tools to complain when checking image integrity.
+# So disregard it when calculating the payload size in the zimage header.
+zboot-method-y				:= $(comp-type-y)_with_size
+zboot-size-len-y			:= 4
+
+zboot-method-$(CONFIG_KERNEL_GZIP)	:= gzip
+zboot-size-len-$(CONFIG_KERNEL_GZIP)	:= 0
+
+quiet_cmd_sbsign = SBSIGN  $@
+      cmd_sbsign = sbsign --out $@ $< \
+		   --key $(CONFIG_EFI_ZBOOT_SIGNING_KEY) \
+		   --cert $(CONFIG_EFI_ZBOOT_SIGNING_CERT)
+
+$(obj)/$(EFI_ZBOOT_PAYLOAD).signed: $(obj)/$(EFI_ZBOOT_PAYLOAD) FORCE
+	$(call if_changed,sbsign)
+
+ZBOOT_PAYLOAD-y				 := $(EFI_ZBOOT_PAYLOAD)
+ZBOOT_PAYLOAD-$(CONFIG_EFI_ZBOOT_SIGNED) := $(EFI_ZBOOT_PAYLOAD).signed
+
+$(obj)/vmlinuz: $(obj)/$(ZBOOT_PAYLOAD-y) FORCE
+	$(call if_changed,$(zboot-method-y))
+
+OBJCOPYFLAGS_vmlinuz.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) \
+			 --rename-section .data=.gzdata,load,alloc,readonly,contents
+$(obj)/vmlinuz.o: $(obj)/vmlinuz FORCE
+	$(call if_changed,objcopy)
+
+AFLAGS_zboot-header.o += -DMACHINE_TYPE=IMAGE_FILE_MACHINE_$(EFI_ZBOOT_MACH_TYPE) \
+			 -DZBOOT_EFI_PATH="\"$(realpath $(obj)/vmlinuz.efi.elf)\"" \
+			 -DZBOOT_SIZE_LEN=$(zboot-size-len-y) \
+			 -DCOMP_TYPE="\"$(comp-type-y)\""
+
+$(obj)/zboot-header.o: $(srctree)/drivers/firmware/efi/libstub/zboot-header.S FORCE
+	$(call if_changed_rule,as_o_S)
+
+ZBOOT_DEPS := $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/libstub/lib.a
+
+LDFLAGS_vmlinuz.efi.elf := -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds
+$(obj)/vmlinuz.efi.elf: $(obj)/vmlinuz.o $(ZBOOT_DEPS) FORCE
+	$(call if_changed,ld)
+
+ZBOOT_EFI-y				:= vmlinuz.efi
+ZBOOT_EFI-$(CONFIG_EFI_ZBOOT_SIGNED)	:= vmlinuz.efi.unsigned
+
+OBJCOPYFLAGS_$(ZBOOT_EFI-y) := -O binary
+$(obj)/$(ZBOOT_EFI-y): $(obj)/vmlinuz.efi.elf FORCE
+	$(call if_changed,objcopy)
+
+targets += zboot-header.o vmlinuz vmlinuz.o vmlinuz.efi.elf vmlinuz.efi
+
+ifneq ($(CONFIG_EFI_ZBOOT_SIGNED),)
+$(obj)/vmlinuz.efi: $(obj)/vmlinuz.efi.unsigned FORCE
+	$(call if_changed,sbsign)
+
+targets += $(EFI_ZBOOT_PAYLOAD).signed vmlinuz.efi.unsigned
+endif
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index dd95f330fe6e..42b3338273aa 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -66,10 +66,27 @@ static efi_status_t efi_open_file(efi_file_protocol_t *volume,
 static efi_status_t efi_open_volume(efi_loaded_image_t *image,
 				    efi_file_protocol_t **fh)
 {
+	struct efi_vendor_dev_path *dp = image->file_path;
+	efi_guid_t li_proto = LOADED_IMAGE_PROTOCOL_GUID;
 	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
 	efi_simple_file_system_protocol_t *io;
 	efi_status_t status;
 
+	// If we are using EFI zboot, we should look for the file system
+	// protocol on the parent image's handle instead
+	if (IS_ENABLED(CONFIG_EFI_ZBOOT) &&
+	    image->parent_handle != NULL &&
+	    dp->header.type == EFI_DEV_MEDIA &&
+	    dp->header.sub_type == EFI_DEV_MEDIA_VENDOR &&
+	    !efi_guidcmp(dp->vendorguid, LINUX_EFI_ZBOOT_MEDIA_GUID)) {
+		status = efi_bs_call(handle_protocol, image->parent_handle,
+				     &li_proto, (void *)&image);
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to locate parent image handle\n");
+			return status;
+		}
+	}
+
 	status = efi_bs_call(handle_protocol, image->device_handle, &fs_proto,
 			     (void **)&io);
 	if (status != EFI_SUCCESS) {
diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
new file mode 100644
index 000000000000..a7bcc7c6b16d
--- /dev/null
+++ b/drivers/firmware/efi/libstub/zboot-header.S
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/pe.h>
+
+#ifdef CONFIG_64BIT
+	.set		.Lextra_characteristics, 0x0
+	.set		.Lpe_opt_magic, PE_OPT_MAGIC_PE32PLUS
+#else
+	.set		.Lextra_characteristics, IMAGE_FILE_32BIT_MACHINE
+	.set		.Lpe_opt_magic, PE_OPT_MAGIC_PE32
+#endif
+
+	.section	".head", "a"
+	.globl		__efistub_efi_zboot_header
+__efistub_efi_zboot_header:
+.Ldoshdr:
+	.long		MZ_MAGIC
+	.ascii		"zimg"					// image type
+	.long		__efistub__gzdata_start - .Ldoshdr	// payload offset
+	.long		__efistub__gzdata_size - ZBOOT_SIZE_LEN	// payload size
+	.long		0, 0					// reserved
+	.asciz		COMP_TYPE				// compression type
+	.org		.Ldoshdr + 0x3c
+	.long		.Lpehdr - .Ldoshdr			// PE header offset
+
+.Lpehdr:
+	.long		PE_MAGIC
+	.short		MACHINE_TYPE
+	.short		.Lsection_count
+	.long		0
+	.long		0
+	.long		0
+	.short		.Lsection_table - .Loptional_header
+	.short		IMAGE_FILE_DEBUG_STRIPPED | \
+			IMAGE_FILE_EXECUTABLE_IMAGE | \
+			IMAGE_FILE_LINE_NUMS_STRIPPED |\
+			.Lextra_characteristics
+
+.Loptional_header:
+	.short		.Lpe_opt_magic
+	.byte		0, 0
+	.long		_etext - .Lefi_header_end
+	.long		__data_size
+	.long		0
+	.long		__efistub_efi_zboot_entry - .Ldoshdr
+	.long		.Lefi_header_end - .Ldoshdr
+
+#ifdef CONFIG_64BIT
+	.quad		0
+#else
+	.long		_etext - .Ldoshdr, 0x0
+#endif
+	.long		4096
+	.long		512
+	.short		0, 0
+	.short		LINUX_EFISTUB_MAJOR_VERSION	// MajorImageVersion
+	.short		LINUX_EFISTUB_MINOR_VERSION	// MinorImageVersion
+	.short		0, 0
+	.long		0
+	.long		_end - .Ldoshdr
+
+	.long		.Lefi_header_end - .Ldoshdr
+	.long		0
+	.short		IMAGE_SUBSYSTEM_EFI_APPLICATION
+	.short		0
+	.quad		0, 0, 0, 0
+	.long		0
+	.long		(.Lsection_table - .) / 8
+
+	.quad		0				// ExportTable
+	.quad		0				// ImportTable
+	.quad		0				// ResourceTable
+	.quad		0				// ExceptionTable
+	.quad		0				// CertificationTable
+	.quad		0				// BaseRelocationTable
+#ifdef CONFIG_DEBUG_EFI
+	.long		.Lefi_debug_table - .Ldoshdr	// DebugTable
+	.long		.Lefi_debug_table_size
+#endif
+
+.Lsection_table:
+	.ascii		".text\0\0\0"
+	.long		_etext - .Lefi_header_end
+	.long		.Lefi_header_end - .Ldoshdr
+	.long		_etext - .Lefi_header_end
+	.long		.Lefi_header_end - .Ldoshdr
+
+	.long		0, 0
+	.short		0, 0
+	.long		IMAGE_SCN_CNT_CODE | \
+			IMAGE_SCN_MEM_READ | \
+			IMAGE_SCN_MEM_EXECUTE
+
+	.ascii		".data\0\0\0"
+	.long		__data_size
+	.long		_etext - .Ldoshdr
+	.long		__data_rawsize
+	.long		_etext - .Ldoshdr
+
+	.long		0, 0
+	.short		0, 0
+	.long		IMAGE_SCN_CNT_INITIALIZED_DATA | \
+			IMAGE_SCN_MEM_READ | \
+			IMAGE_SCN_MEM_WRITE
+
+	.set		.Lsection_count, (. - .Lsection_table) / 40
+
+#ifdef CONFIG_DEBUG_EFI
+	.section	".rodata", "a"
+	.align		2
+.Lefi_debug_table:
+	// EFI_IMAGE_DEBUG_DIRECTORY_ENTRY
+	.long		0				// Characteristics
+	.long		0				// TimeDateStamp
+	.short		0				// MajorVersion
+	.short		0				// MinorVersion
+	.long		IMAGE_DEBUG_TYPE_CODEVIEW	// Type
+	.long		.Lefi_debug_entry_size		// SizeOfData
+	.long		0				// RVA
+	.long		.Lefi_debug_entry - .Ldoshdr	// FileOffset
+
+	.set		.Lefi_debug_table_size, . - .Lefi_debug_table
+	.previous
+
+.Lefi_debug_entry:
+	// EFI_IMAGE_DEBUG_CODEVIEW_NB10_ENTRY
+	.ascii		"NB10"				// Signature
+	.long		0				// Unknown
+	.long		0				// Unknown2
+	.long		0				// Unknown3
+
+	.asciz		ZBOOT_EFI_PATH
+
+	.set		.Lefi_debug_entry_size, . - .Lefi_debug_entry
+#endif
+
+	.p2align	12
+.Lefi_header_end:
+
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
new file mode 100644
index 000000000000..e6fdcc957275
--- /dev/null
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <linux/pe.h>
+#include <asm/efi.h>
+#include <asm/unaligned.h>
+
+#include "efistub.h"
+
+static unsigned char zboot_heap[SZ_256K] __aligned(64);
+static unsigned long free_mem_ptr, free_mem_end_ptr;
+
+#define STATIC static
+#if defined(CONFIG_KERNEL_GZIP)
+#include "../../../../lib/decompress_inflate.c"
+#elif defined(CONFIG_KERNEL_LZ4)
+#include "../../../../lib/decompress_unlz4.c"
+#elif defined(CONFIG_KERNEL_LZMA)
+#include "../../../../lib/decompress_unlzma.c"
+#elif defined(CONFIG_KERNEL_LZO)
+#include "../../../../lib/decompress_unlzo.c"
+#elif defined(CONFIG_KERNEL_XZ)
+#undef memcpy
+#define memcpy memcpy
+#undef memmove
+#define memmove memmove
+#include "../../../../lib/decompress_unxz.c"
+#elif defined(CONFIG_KERNEL_ZSTD)
+#include "../../../../lib/decompress_unzstd.c"
+#endif
+
+extern char efi_zboot_header[];
+extern char _gzdata_start[], _gzdata_end[];
+
+static void log(efi_char16_t str[])
+{
+	efi_call_proto(efi_table_attr(efi_system_table, con_out),
+		       output_string, L"EFI decompressor: ");
+	efi_call_proto(efi_table_attr(efi_system_table, con_out),
+		       output_string, str);
+	efi_call_proto(efi_table_attr(efi_system_table, con_out),
+		       output_string, L"\n");
+}
+
+static void error(char *x)
+{
+	log(L"error() called from decompressor library\n");
+}
+
+// Local version to avoid pulling in memcmp()
+static bool guids_eq(const efi_guid_t *a, const efi_guid_t *b)
+{
+	const u32 *l = (u32 *)a;
+	const u32 *r = (u32 *)b;
+
+	return l[0] == r[0] && l[1] == r[1] && l[2] == r[2] && l[3] == r[3];
+}
+
+static efi_status_t __efiapi
+load_file(efi_load_file_protocol_t *this, efi_device_path_protocol_t *rem,
+	  bool boot_policy, unsigned long *bufsize, void *buffer)
+{
+	struct efi_vendor_dev_path *vendor_dp;
+	bool decompress = false;
+	unsigned long size;
+	int ret;
+
+	if (rem == NULL || bufsize == NULL)
+		return EFI_INVALID_PARAMETER;
+
+	if (boot_policy)
+		return EFI_UNSUPPORTED;
+
+	// Look for our vendor media device node in the remaining file path
+	if (rem->type == EFI_DEV_MEDIA &&
+	    rem->sub_type == EFI_DEV_MEDIA_VENDOR) {
+		vendor_dp = container_of(rem, struct efi_vendor_dev_path, header);
+		if (!guids_eq(&vendor_dp->vendorguid, &LINUX_EFI_ZBOOT_MEDIA_GUID))
+			return EFI_NOT_FOUND;
+
+		decompress = true;
+		rem = (void *)(vendor_dp + 1);
+	}
+
+	if (rem->type != EFI_DEV_END_PATH ||
+	    rem->sub_type != EFI_DEV_END_ENTIRE)
+		return EFI_NOT_FOUND;
+
+	// The uncompressed size of the payload is appended to the raw bit
+	// stream, and may therefore appear misaligned in memory
+	size = decompress ? get_unaligned_le32(_gzdata_end - 4)
+			  : (_gzdata_end - _gzdata_start);
+	if (buffer == NULL || *bufsize < size) {
+		*bufsize = size;
+		return EFI_BUFFER_TOO_SMALL;
+	}
+
+	if (decompress) {
+		ret = __decompress(_gzdata_start, _gzdata_end - _gzdata_start,
+				   NULL, NULL, buffer, 0, NULL, error);
+		if (ret	< 0) {
+			log(L"Decompression failed");
+			return EFI_DEVICE_ERROR;
+		}
+	} else {
+		memcpy(buffer, _gzdata_start, size);
+	}
+
+	return EFI_SUCCESS;
+}
+
+// Return the length in bytes of the device path up to the first end node.
+static int device_path_length(const efi_device_path_protocol_t *dp)
+{
+	int len = 0;
+
+	while (dp->type != EFI_DEV_END_PATH) {
+		len += dp->length;
+		dp = (void *)((u8 *)dp + dp->length);
+	}
+	return len;
+}
+
+static void append_rel_offset_node(efi_device_path_protocol_t **dp,
+				   unsigned long start, unsigned long end)
+{
+	struct efi_rel_offset_dev_path *rodp = (void *)*dp;
+
+	rodp->header.type	= EFI_DEV_MEDIA;
+	rodp->header.sub_type	= EFI_DEV_MEDIA_REL_OFFSET;
+	rodp->header.length	= sizeof(struct efi_rel_offset_dev_path);
+	rodp->reserved		= 0;
+	rodp->starting_offset	= start;
+	rodp->ending_offset	= end;
+
+	*dp = (void *)(rodp + 1);
+}
+
+static void append_ven_media_node(efi_device_path_protocol_t **dp,
+				  efi_guid_t *guid)
+{
+	struct efi_vendor_dev_path *vmdp = (void *)*dp;
+
+	vmdp->header.type	= EFI_DEV_MEDIA;
+	vmdp->header.sub_type	= EFI_DEV_MEDIA_VENDOR;
+	vmdp->header.length	= sizeof(struct efi_vendor_dev_path);
+	vmdp->vendorguid	= *guid;
+
+	*dp = (void *)(vmdp + 1);
+}
+
+static void append_end_node(efi_device_path_protocol_t **dp)
+{
+	(*dp)->type		= EFI_DEV_END_PATH;
+	(*dp)->sub_type		= EFI_DEV_END_ENTIRE;
+	(*dp)->length		= sizeof(struct efi_generic_dev_path);
+
+	++*dp;
+}
+
+efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,
+				      efi_system_table_t *systab)
+{
+	efi_device_path_protocol_t *parent_dp, *dpp, *lf2_dp, *li_dp;
+	efi_load_file2_protocol_t zboot_load_file2;
+	efi_loaded_image_t *parent, *child;
+	unsigned long exit_data_size;
+	efi_handle_t child_handle;
+	efi_handle_t zboot_handle;
+	efi_char16_t *exit_data;
+	efi_status_t status;
+	void *dp_alloc;
+	int dp_len;
+
+	WRITE_ONCE(efi_system_table, systab);
+
+	free_mem_ptr = (unsigned long)&zboot_heap;
+	free_mem_end_ptr = free_mem_ptr + sizeof(zboot_heap);
+
+	exit_data = NULL;
+	exit_data_size = 0;
+
+	status = efi_bs_call(handle_protocol, handle,
+			     &LOADED_IMAGE_PROTOCOL_GUID, (void **)&parent);
+	if (status != EFI_SUCCESS) {
+		log(L"Failed to locate parent's loaded image protocol");
+		return status;
+	}
+
+	status = efi_bs_call(handle_protocol, handle,
+			     &LOADED_IMAGE_DEVICE_PATH_PROTOCOL_GUID,
+			     (void **)&parent_dp);
+	if (status != EFI_SUCCESS) {
+		log(L"Failed to locate parent's loaded image device path protocol");
+		return status;
+	}
+
+	// Allocate some pool memory for device path protocol data
+	dp_len = parent_dp ? device_path_length(parent_dp) : 0;
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+			     2 * (dp_len + sizeof(struct efi_rel_offset_dev_path) +
+			          sizeof(struct efi_generic_dev_path)) +
+			     sizeof(struct efi_vendor_dev_path),
+			     (void **)&dp_alloc);
+	if (status != EFI_SUCCESS) {
+		log(L"Failed to allocate device path pool memory");
+		return status;
+	}
+
+	// Create a device path describing the compressed payload in this image
+	// <...parent_dp...>/Offset(<start>, <end>)
+	lf2_dp = memcpy(dp_alloc, parent_dp, dp_len);
+	dpp = (void *)((u8 *)lf2_dp + dp_len);
+	append_rel_offset_node(&dpp,
+			       (unsigned long)(_gzdata_start - efi_zboot_header),
+			       (unsigned long)(_gzdata_end - efi_zboot_header - 1));
+	append_end_node(&dpp);
+
+	// Create a device path describing the decompressed payload in this image
+	// <...parent_dp...>/Offset(<start>, <end>)/VenMedia(ZBOOT_MEDIA_GUID)
+	dp_len += sizeof(struct efi_rel_offset_dev_path);
+	li_dp = memcpy(dpp, lf2_dp, dp_len);
+	dpp = (void *)((u8 *)li_dp + dp_len);
+	append_ven_media_node(&dpp, &LINUX_EFI_ZBOOT_MEDIA_GUID);
+	append_end_node(&dpp);
+
+	zboot_handle = NULL;
+	zboot_load_file2.load_file = load_file;
+	status = efi_bs_call(install_multiple_protocol_interfaces,
+			     &zboot_handle,
+			     &EFI_DEVICE_PATH_PROTOCOL_GUID, lf2_dp,
+			     &EFI_LOAD_FILE2_PROTOCOL_GUID, &zboot_load_file2,
+			     NULL);
+	if (status != EFI_SUCCESS) {
+		log(L"Failed to install LoadFile2 protocol and device path");
+		goto free_dpalloc;
+	}
+
+	status = efi_bs_call(load_image, false, handle, li_dp, NULL, 0,
+			     &child_handle);
+	if (status != EFI_SUCCESS) {
+		log(L"Failed to load image");
+		goto uninstall_lf2;
+	}
+
+	status = efi_bs_call(handle_protocol, child_handle,
+			     &LOADED_IMAGE_PROTOCOL_GUID, (void **)&child);
+	if (status != EFI_SUCCESS) {
+		log(L"Failed to locate child's loaded image protocol");
+		goto unload_image;
+	}
+
+	// Copy the kernel command line
+	child->load_options = parent->load_options;
+	child->load_options_size = parent->load_options_size;
+
+	status = efi_bs_call(start_image, child_handle, &exit_data_size,
+			     &exit_data);
+	if (status != EFI_SUCCESS) {
+		log(L"StartImage() returned with error");
+		if (exit_data_size > 0)
+			log(exit_data);
+
+		// If StartImage() returns EFI_SECURITY_VIOLATION, the image is
+		// not unloaded so we need to do it by hand.
+		if (status == EFI_SECURITY_VIOLATION)
+unload_image:
+			efi_bs_call(unload_image, child_handle);
+	}
+
+uninstall_lf2:
+	efi_bs_call(uninstall_multiple_protocol_interfaces,
+		    zboot_handle,
+		    &EFI_DEVICE_PATH_PROTOCOL_GUID, lf2_dp,
+		    &EFI_LOAD_FILE2_PROTOCOL_GUID, &zboot_load_file2,
+		    NULL);
+
+free_dpalloc:
+	efi_bs_call(free_pool, dp_alloc);
+
+	efi_bs_call(exit, handle, status, exit_data_size, exit_data);
+
+	// Free ExitData in case Exit() returned with a failure code,
+	// but return the original status code.
+	log(L"Exit() returned with failure code");
+	if (exit_data != NULL)
+		efi_bs_call(free_pool, exit_data);
+	return status;
+}
diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
new file mode 100644
index 000000000000..509996988a9b
--- /dev/null
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+ENTRY(__efistub_efi_zboot_header);
+
+SECTIONS
+{
+	.text : ALIGN(4096) {
+		*(.head)
+		*(.text* .init.text*)
+	}
+
+	.rodata : ALIGN(8) {
+		__efistub__gzdata_start = .;
+		*(.gzdata)
+		__efistub__gzdata_end = .;
+		*(.rodata* .init.rodata* .srodata*)
+		_etext = ALIGN(4096);
+		. = _etext;
+	}
+
+	.data : ALIGN(4096) {
+		*(.data* .init.data*)
+		_edata = ALIGN(512);
+		. = _edata;
+	}
+
+	.bss : {
+		*(.bss* .init.bss*)
+		_end = ALIGN(512);
+		. = _end;
+	}
+
+	/DISCARD/ : {
+		*(.modinfo .init.modinfo)
+	}
+}
+
+PROVIDE(__efistub__gzdata_size = ABSOLUTE(. - __efistub__gzdata_start));
+
+PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
+PROVIDE(__data_size = ABSOLUTE(_end - _etext));
diff --git a/include/linux/efi.h b/include/linux/efi.h
index af90f7989f80..5efc3105f8e0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -411,6 +411,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_TPM_FINAL_LOG_GUID		EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
 #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
 #define LINUX_EFI_INITRD_MEDIA_GUID		EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
+#define LINUX_EFI_ZBOOT_MEDIA_GUID		EFI_GUID(0xe565a30d, 0x47da, 0x4dbd,  0xb3, 0x54, 0x9b, 0xb5, 0xc8, 0x4f, 0x8b, 0xe2)
 #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
 #define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
 
-- 
2.35.1

