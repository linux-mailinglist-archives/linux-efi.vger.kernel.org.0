Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B982A596D4D
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 13:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbiHQLER (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 07:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239133AbiHQLEK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 07:04:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4CF558CF
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 04:04:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41369614AB
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 11:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC098C433D7;
        Wed, 17 Aug 2022 11:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660734247;
        bh=vyu+y3QYaG/i9NAqPJZ9e5xOVp4RiGzO5QMphfS/v5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdC3v8CSBpPmguXMem61RYiUSS//aeTxs+SghHm0g4O9XMjjGFkEWCG0YvIYQHl8v
         JzQst84QF1rvqsVds+oVwMlcbVftcsEt/kjAnJf/rpSy4MYhmpy3F3MNvjPhI6MdTG
         AVWr4sJ981y9ql2KUNY3/KHz0di1lHtdEVa4CzFzspVS9t7X16sUnA505BnjPyx+f4
         pOT0ljRu5dIY3FfgKeef2KWkRsoTKMJVYdbv9qe/wpwlSElIlRrXSwE7eVMzL0/EAx
         ydyfreuBDQ7Td3fXjNbuYBayJbwD4MBPNvIKHl+s2i3Tv1GO+NxPO3UbAC8JcoMOEF
         6DSoZ6z7rA7aQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 4/6] efi/libstub: implement generic EFI zboot
Date:   Wed, 17 Aug 2022 13:03:43 +0200
Message-Id: <20220817110345.1771267-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220817110345.1771267-1-ardb@kernel.org>
References: <20220817110345.1771267-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15554; i=ardb@kernel.org; h=from:subject; bh=vyu+y3QYaG/i9NAqPJZ9e5xOVp4RiGzO5QMphfS/v5E=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/MsLNDt7XiQULbmTVApvwFOiZrZ4lhV1NEECzPHg UWI5ULCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvzLCwAKCRDDTyI5ktmPJEA1C/ 426jt1CZq1DnnJhJ5wdjDWA88jXC/1oFpIQWOjXDhN0oU36r6sT99Bnb/XTpVS0E8QjizaId5bmyAK u0tiqLSzAnyRkutajSUe9+VwkxzGdKVsr9GTeefaggJNA8zQ838fxNdXBekagLtMr6VEH/Eb/m/G5s fvvT+OHsBkJnWks4hey08gBPSrW8ZP6LO0OLBLudi6BiymDu9pOs/4nWW68My4sWnmpoXLaX4bpO7A sbiEdbE4XjbQ8dz+/Di52ON2a2NLmsFRVYR/bpWmiHnPeaYE+neinxczr4nZ6UBDYtQBnFRc7w0rVW O71A7wxAVBPHFru33FoOlIDhugy4h4Yll/U66B/gZdf71IUoK33J241yCR1N/0125koGZabmlm1QPo aVAVskuDH3u//avGbDZG/ytWDu9HGuVA5RMRWzwJ5oeNb9dM1caPySN4zi7T0hvOtWKSxVZMJCyuec w+uSbCI/DZarSyTobnOk1gnsgGmukmyS3175wCmG+1cQM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

BZIP2 has been omitted from the set of supported compression algorithms,
given that its performance is mediocre both in speed and size, and it
uses a disproportionate amount of memory. For optimal compression, use
LZMA. For the fastest boot speed, use LZO.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig                |  31 ++++-
 drivers/firmware/efi/libstub/Makefile       |   8 +-
 drivers/firmware/efi/libstub/Makefile.zboot |  69 ++++++++++
 drivers/firmware/efi/libstub/zboot-header.S | 139 ++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.c        | 101 ++++++++++++++
 drivers/firmware/efi/libstub/zboot.lds      |  39 ++++++
 6 files changed, 382 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 6cb7384ad2ac..0c7beb8e3633 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -105,9 +105,36 @@ config EFI_RUNTIME_WRAPPERS
 config EFI_GENERIC_STUB
 	bool
 
+config EFI_ZBOOT
+	bool "Enable the generic EFI decompressor"
+	depends on EFI_GENERIC_STUB && !ARM
+	select HAVE_KERNEL_GZIP
+	select HAVE_KERNEL_LZ4
+	select HAVE_KERNEL_LZMA
+	select HAVE_KERNEL_LZO
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
-	depends on EFI_GENERIC_STUB && !RISCV
+	depends on EFI_GENERIC_STUB && !RISCV && !EFI_ZBOOT
 	default y
 	help
 	  Select this config option to add support for the dtb= command
@@ -124,7 +151,7 @@ config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
 	bool "Enable the command line initrd loader" if !X86
 	depends on EFI_STUB && (EFI_GENERIC_STUB || X86)
 	default y if X86
-	depends on !RISCV
+	depends on !RISCV && !EFI_ZBOOT
 	help
 	  Select this config option to add support for the initrd= command
 	  line parameter, allowing an initrd that resides on the same volume
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 1406dc78edaa..a3d3d38d5afd 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -73,6 +73,11 @@ lib-$(CONFIG_X86)		+= x86-stub.o
 lib-$(CONFIG_RISCV)		+= riscv-stub.o
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
+lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o
+
+extra-y				:= $(lib-y)
+lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
+
 # Even when -mbranch-protection=none is set, Clang will generate a
 # .note.gnu.property for code-less object files (like lib/ctype.c),
 # so work around this by explicitly removing the unwanted section.
@@ -112,9 +117,6 @@ STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
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
index 000000000000..38dee29103ae
--- /dev/null
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# to be include'd by arch/$(ARCH)/boot/Makefile after setting
+# EFI_ZBOOT_PAYLOAD, EFI_ZBOOT_BFD_TARGET and EFI_ZBOOT_MACH_TYPE
+
+comp-type-$(CONFIG_KERNEL_GZIP)		:= gzip
+comp-type-$(CONFIG_KERNEL_LZ4)		:= lz4
+comp-type-$(CONFIG_KERNEL_LZMA)		:= lzma
+comp-type-$(CONFIG_KERNEL_LZO)		:= lzo
+
+# in GZIP, the appended le32 carrying the uncompressed size is part of the
+# format, but in other cases, we just append it at the end for convenience,
+# causing the original tools to complain when checking image integrity.
+# So disregard it when calculating the payload size in the zimage header.
+zimage-method-y				:= $(comp-type-y)_with_size
+zimage-size-len-y			:= 4
+
+zimage-method-$(CONFIG_KERNEL_GZIP)	:= gzip
+zimage-size-len-$(CONFIG_KERNEL_GZIP)	:= 0
+
+quiet_cmd_sbsign = SBSIGN  $@
+      cmd_sbsign = sbsign --out $@ $< \
+		   --key $(CONFIG_EFI_ZBOOT_SIGNING_KEY) \
+		   --cert $(CONFIG_EFI_ZBOOT_SIGNING_CERT) \
+		   2>/dev/null
+
+$(obj)/Image.signed: $(EFI_ZBOOT_PAYLOAD) FORCE
+	$(call if_changed,sbsign)
+
+ZBOOT_PAYLOAD-y				 := $(EFI_ZBOOT_PAYLOAD)
+ZBOOT_PAYLOAD-$(CONFIG_EFI_ZBOOT_SIGNED) := $(obj)/Image.signed
+
+$(obj)/zImage: $(ZBOOT_PAYLOAD-y) FORCE
+	$(call if_changed,$(zimage-method-y))
+
+OBJCOPYFLAGS_zImage.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) \
+			 --rename-section .data=.gzdata,load,alloc,readonly,contents
+$(obj)/zImage.o: $(obj)/zImage FORCE
+	$(call if_changed,objcopy)
+
+AFLAGS_zboot-header.o += -DMACHINE_TYPE=IMAGE_FILE_MACHINE_$(EFI_ZBOOT_MACH_TYPE) \
+			 -DZIMG_EFI_PATH="\"$(realpath $(obj)/zImage.efi.elf)\"" \
+			 -DZIMG_SIZE_LEN=$(zimage-size-len-y) \
+			 -DCOMP_TYPE="\"$(comp-type-y)\""
+
+$(obj)/zboot-header.o: $(srctree)/drivers/firmware/efi/libstub/zboot-header.S FORCE
+	$(call if_changed_rule,as_o_S)
+
+ZBOOT_DEPS := $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/libstub/lib.a
+
+LDFLAGS_zImage.efi.elf := -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds
+$(obj)/zImage.efi.elf: $(obj)/zImage.o $(ZBOOT_DEPS) FORCE
+	$(call if_changed,ld)
+
+ZIMAGE_EFI-y				:= zImage.efi
+ZIMAGE_EFI-$(CONFIG_EFI_ZBOOT_SIGNED)	:= zImage.efi.unsigned
+
+OBJCOPYFLAGS_$(ZIMAGE_EFI-y) := -O binary
+$(obj)/$(ZIMAGE_EFI-y): $(obj)/zImage.efi.elf FORCE
+	$(call if_changed,objcopy)
+
+targets += zboot-header.o zImage zImage.o zImage.efi.elf zImage.efi
+
+ifneq ($(CONFIG_EFI_ZBOOT_SIGNED),)
+$(obj)/zImage.efi: $(obj)/zImage.efi.unsigned FORCE
+	$(call if_changed,sbsign)
+
+targets += Image.signed zImage.efi.unsigned
+endif
diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
new file mode 100644
index 000000000000..ee6a3cd69773
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
+	.long		__efistub__gzdata_size - ZIMG_SIZE_LEN	// payload size
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
+	.asciz		ZIMG_EFI_PATH
+
+	.set		.Lefi_debug_entry_size, . - .Lefi_debug_entry
+#endif
+
+	.p2align	12
+.Lefi_header_end:
+
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
new file mode 100644
index 000000000000..9cf968e90775
--- /dev/null
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <linux/pe.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+static unsigned char zboot_heap[SZ_64K] __aligned(64);
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
+#endif
+
+extern char _gzdata_start[], _gzdata_end[];
+extern u32 uncompressed_size __aligned(1);
+
+static void log(efi_char16_t str[])
+{
+	efi_call_proto(efi_table_attr(efi_system_table, con_out),
+		       output_string, L"EFI decompressor: ");
+	efi_call_proto(efi_table_attr(efi_system_table, con_out),
+		       output_string, str);
+}
+
+static void error(char *x)
+{
+	log(L"error() called from decompressor library\n");
+}
+
+efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,
+				      efi_system_table_t *systab)
+{
+	static efi_guid_t loaded_image = LOADED_IMAGE_PROTOCOL_GUID;
+	efi_loaded_image_t *parent, *child;
+	unsigned long image_buffer;
+	efi_handle_t child_handle;
+	efi_status_t status;
+	int ret;
+
+	WRITE_ONCE(efi_system_table, systab);
+
+	free_mem_ptr = (unsigned long)&zboot_heap;
+	free_mem_end_ptr = free_mem_ptr + sizeof(zboot_heap);
+
+	status = efi_bs_call(handle_protocol, handle, &loaded_image,
+			     (void **)&parent);
+	if (status != EFI_SUCCESS) {
+		log(L"Failed to locate parent's loaded image protocol\n");
+		return status;
+	}
+
+	status = efi_allocate_pages(uncompressed_size, &image_buffer, ULONG_MAX);
+	if (status != EFI_SUCCESS) {
+		log(L"Failed to allocate memory\n");
+		return status;
+	}
+
+	ret = __decompress(_gzdata_start, _gzdata_end - _gzdata_start, NULL,
+			   NULL, (unsigned char *)image_buffer, 0, NULL,
+			   error);
+	if (ret	< 0) {
+		log(L"Decompression failed\n");
+		return EFI_LOAD_ERROR;
+	}
+
+	status = efi_bs_call(load_image, false, handle, NULL,
+			     (void *)image_buffer, uncompressed_size,
+			     &child_handle);
+	if (status != EFI_SUCCESS) {
+		log(L"Failed to load image\n");
+		return status;
+	}
+
+	status = efi_bs_call(handle_protocol, child_handle, &loaded_image,
+			     (void **)&child);
+	if (status != EFI_SUCCESS) {
+		log(L"Failed to locate child's loaded image protocol\n");
+		return status;
+	}
+
+	// Copy the kernel command line
+	child->load_options = parent->load_options;
+	child->load_options_size = parent->load_options_size;
+
+	status = efi_bs_call(start_image, child_handle, NULL, NULL);
+	if (status != EFI_SUCCESS) {
+		log(L"StartImage() returned with error\n");
+		return status;
+	}
+
+	return EFI_SUCCESS;
+}
diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
new file mode 100644
index 000000000000..d6ba89a0c294
--- /dev/null
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -0,0 +1,39 @@
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
+}
+
+PROVIDE(__efistub__gzdata_size = ABSOLUTE(. - __efistub__gzdata_start));
+
+PROVIDE(__efistub_uncompressed_size = __efistub__gzdata_end - 4);
+
+PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
+PROVIDE(__data_size = ABSOLUTE(_end - _etext));
-- 
2.35.1

