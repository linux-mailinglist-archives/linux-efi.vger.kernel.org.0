Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C9A58D52F
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 10:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiHIILC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 04:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbiHIILB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 04:11:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C51B7D1
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 01:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61F55612F1
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 08:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CBAC433D7;
        Tue,  9 Aug 2022 08:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660032658;
        bh=Mgl35wQ7H8p5ni5yxawy0fLLMwxmayhU0ytRYFv/l2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZWRGxb2vJzbZNLqWVboJ1XuP/XzAFhxyjZuUOParK03bROC5xvf9UZ5eC1pzSJ4ln
         0FSd9RxWDOOY1vhYu4mrBQfQiLy2YDM0BZp7L+wY7mlUUhSqQboLTT/uTGPiBXv8ls
         hgo+amMU2CRV+p9jufXd0iR6YqMWSxo3MBNitM6m9p8FYnbq9vKC3kTdxE7E5/L78V
         R8tKEat9jSBkRrawXZKy0FlkEL+7kbWdSlHJsnqJIMP5f+xWr1K/Hxxs5/0nwsHaob
         mZ3sNOBLeDdth/2EipGmLdite429bGucw4Bft0ub2mHwgsnnhkzsMmgoVbjIfi2vWr
         5otnaLp4ok1EQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
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
        Lennart Poettering <lennart@poettering.net>
Subject: [PATCH v2 4/6] efi: stub: implement generic EFI zboot
Date:   Tue,  9 Aug 2022 10:09:42 +0200
Message-Id: <20220809080944.1119654-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220809080944.1119654-1-ardb@kernel.org>
References: <20220809080944.1119654-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16616; i=ardb@kernel.org; h=from:subject; bh=Mgl35wQ7H8p5ni5yxawy0fLLMwxmayhU0ytRYFv/l2k=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi8hZClJ9efS4J+RboJHQZ8uPgbipTw7gRfy4zTdU5 uHsJgo+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvIWQgAKCRDDTyI5ktmPJNDpDA CEUkbG22rdb0xsTeHusGurQvtJtGhtfinrXT9rsVm5m8asGP/VmWQMjar+f//URto+xrofuqmgK3rc l2vqp1oBU/tZQVwHI3gMJt/zgXLZTr5+cLcse3kriZPV587bFKrkyd9yUYM+PFKllYmHiMFCZxvD7o KzUkRRw8xORetksQ2JxPsjSCAdgzRQli8AW/UlSo7/U/mFperemkAVwZKJi/lrvs8NGm4uQjlV7pO3 ALklDG9CS7bXjv1Lx7vI+ESTC74eFfxRIR82a3DJUYyZLeDldUBZsp1/+3i/3mUCt0Oj44auDHQ6tj +hKkMoEj1RgbpD7uvq5KBNNSNk85gUgteRBhCk3GulXVXhr9stgMMkFMatVz/VkSeez3hvzEckjqF/ SPTfp5U5b62TL3M8Z0UFtw0W33Ne0rcTY2fkffl/Pj8p4WGAstfO9rBQSEvzkfSBxYvrwUNE0ceLLG N5R/BHS4G/TqaSPRZcSn7hNy+nsysGAfWkl0S7Sr3OGHw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
a priori, in order to be permitted to boot. We adopt the same approach
as the EFI shim used by the distros, which is to override the security
arch protocol implementations used internally by the firmware,
permitting the inner, compressed image to be loaded and started after
decompression. The outer PE/COFF image will be signed as usual in such
cases, preserving the chain of trust.

BZIP2 has been omitted from the set of supported compression algorithms,
given that its performance is mediocre both in speed and size, and it
uses a disproportionate amount of memory. For optimal compression, use
LZMA. For the fastest boot speed, use LZO.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig                |   9 +
 drivers/firmware/efi/libstub/Makefile       |   4 +
 drivers/firmware/efi/libstub/Makefile.zboot |  30 +++
 drivers/firmware/efi/libstub/zboot-header.S | 144 +++++++++++++++
 drivers/firmware/efi/libstub/zboot.c        | 191 ++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.lds      |  41 +++++
 include/linux/efi.h                         |   2 +
 7 files changed, 421 insertions(+)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 6cb7384ad2ac..9ee0944f80bf 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -105,6 +105,15 @@ config EFI_RUNTIME_WRAPPERS
 config EFI_GENERIC_STUB
 	bool
 
+config EFI_ZBOOT
+	bool "Enable the generic EFI decompressor"
+	depends on EFI_GENERIC_STUB
+	depends on !ARM && !X86
+	select HAVE_KERNEL_GZIP
+	select HAVE_KERNEL_LZ4
+	select HAVE_KERNEL_LZMA
+	select HAVE_KERNEL_LZO
+
 config EFI_ARMSTUB_DTB_LOADER
 	bool "Enable the DTB loader"
 	depends on EFI_GENERIC_STUB && !RISCV
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index a8e26d5a1d14..721f948950b8 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -112,8 +112,12 @@ STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
 # a verification pass to see if any absolute relocations exist in any of the
 # object files.
 #
+lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o
 extra-y				:= $(lib-y)
 lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
+lib-$(CONFIG_EFI_ZBOOT)		+= zboot-header.o
+AFLAGS_zboot-header.o		+= -DZIMAGE_EFI_PATH="\"$(realpath \
+				   $(objtree)/arch/$(ARCH)/boot/zImage.efi.elf)\""
 
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
new file mode 100644
index 000000000000..37d95d90db47
--- /dev/null
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# to be include'd by arch/$(ARCH)/boot/Makefile after setting
+# ZBOOT_PAYLOAD, ZBOOT_BFD_TARGET, ZBOOT_LD_FLAGS and ZBOOT_EXTRA_DEPS
+
+zimage-method-$(CONFIG_KERNEL_GZIP)	:= gzip
+zimage-method-$(CONFIG_KERNEL_LZ4)	:= lz4_with_size
+zimage-method-$(CONFIG_KERNEL_LZMA)	:= lzma_with_size
+zimage-method-$(CONFIG_KERNEL_LZO)	:= lzo_with_size
+
+$(obj)/zImage: $(ZBOOT_PAYLOAD) FORCE
+	$(call if_changed,$(zimage-method-y))
+
+OBJCOPYFLAGS_zImage.o := -I binary -O $(ZBOOT_BFD_TARGET) \
+			 --rename-section .data=.gzdata,load,alloc,readonly,contents
+$(obj)/zImage.o: $(obj)/zImage FORCE
+	$(call if_changed,objcopy)
+
+ZBOOT_DEPS := $(ZBOOT_EXTRA_DEPS) $(objtree)/drivers/firmware/efi/libstub/lib.a
+
+LDFLAGS_zImage.efi.elf := -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds \
+			  $(ZBOOT_LD_FLAGS)
+$(obj)/zImage.efi.elf: $(obj)/zImage.o $(ZBOOT_DEPS) FORCE
+	$(call if_changed,ld)
+
+OBJCOPYFLAGS_zImage.efi := -O binary
+$(obj)/zImage.efi: $(obj)/zImage.efi.elf FORCE
+	$(call if_changed,objcopy)
+
+targets += zImage zImage.o zImage.efi.elf zImage.efi
diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
new file mode 100644
index 000000000000..59ede6f253df
--- /dev/null
+++ b/drivers/firmware/efi/libstub/zboot-header.S
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/pe.h>
+
+#if defined(CONFIG_ARM64)
+	.set		.Lmachine_type, IMAGE_FILE_MACHINE_ARM64
+#elif defined(CONFIG_RISCV)
+#ifdef CONFIG_64BIT
+	.set		.Lmachine_type, IMAGE_FILE_MACHINE_RISCV64
+#else
+	.set		.Lmachine_type, IMAGE_FILE_MACHINE_RISCV32
+#endif
+#else
+#error
+#endif
+
+	.section	".head", "a"
+	.globl		__efistub_efi_zboot_header
+__efistub_efi_zboot_header:
+.Ldoshdr:
+	.long		MZ_MAGIC
+	.org		.Ldoshdr + 0x38
+
+	// GRUB wants this on arm64 but doesn't (and shouldn't!) care on other
+	// architectures so let's just put the arm64 magic signature here.
+	.ascii		"ARM\x64"
+
+	.long		.Lpehdr - .Ldoshdr
+
+.Lpehdr:
+	.long		PE_MAGIC
+	.short		.Lmachine_type
+	.short		.Lsection_count
+	.long		0
+	.long		0
+	.long		0
+	.short		.Lsection_table - .Loptional_header
+	.short		IMAGE_FILE_DEBUG_STRIPPED | \
+			IMAGE_FILE_EXECUTABLE_IMAGE | \
+			IMAGE_FILE_LINE_NUMS_STRIPPED
+
+.Loptional_header:
+#ifdef CONFIG_64BIT
+	.short		PE_OPT_MAGIC_PE32PLUS
+#else
+	.short		PE_OPT_MAGIC_PE32
+#endif
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
+	.long		_etext - .Lhead
+	.long		0
+#endif
+	.long		4096
+	.long		512
+	.short		0, 0, 0, 0, 0, 0
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
+	.asciz		ZIMAGE_EFI_PATH
+
+	.set		.Lefi_debug_entry_size, . - .Lefi_debug_entry
+#endif
+
+	.p2align	12
+.Lefi_header_end:
+
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
new file mode 100644
index 000000000000..31868b74d152
--- /dev/null
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <linux/pe.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+#define STATIC static
+
+static unsigned char zboot_heap[SZ_64K] __aligned(64);
+static unsigned long free_mem_ptr, free_mem_end_ptr;
+
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
+typedef struct efi_security_arch_protocol efi_security_arch_protocol_t;
+
+typedef	efi_status_t
+(* __efiapi file_auth_state_fn)(efi_security_arch_protocol_t *,
+				u32, efi_device_path_protocol_t *);
+
+struct efi_security_arch_protocol {
+	file_auth_state_fn file_auth_state;
+};
+
+
+typedef struct efi_security_arch2_protocol efi_security_arch2_protocol_t;
+
+typedef	efi_status_t
+(* __efiapi file_auth_fn)(efi_security_arch2_protocol_t *,
+		          efi_device_path_protocol_t *,
+		          void *, unsigned long, bool);
+
+struct efi_security_arch2_protocol {
+	file_auth_fn file_auth;
+};
+
+static file_auth_state_fn prev_file_auth_state;
+static file_auth_fn prev_file_auth;
+
+static efi_status_t __efiapi
+file_auth_state_override(efi_security_arch_protocol_t *this,
+			 u32 auth_state,
+			 efi_device_path_protocol_t *file)
+{
+	prev_file_auth_state(this, auth_state, file);
+	return EFI_SUCCESS;
+}
+
+static efi_status_t __efiapi
+file_auth_override(efi_security_arch2_protocol_t *this,
+		   efi_device_path_protocol_t *file,
+		   void *file_buffer, unsigned long file_size,
+		   bool boot_policy)
+{
+	prev_file_auth(this, file, file_buffer, file_size, boot_policy);
+	return EFI_SUCCESS;
+}
+
+static void error(char *x)
+{
+	efi_err("%s\n", x);
+}
+
+efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,
+				      efi_system_table_t *systab)
+{
+	efi_guid_t security_arch = EFI_SECURITY_ARCH_PROTOCOL_GUID;
+	efi_guid_t security_arch2 = EFI_SECURITY_ARCH2_PROTOCOL_GUID;
+	efi_guid_t loaded_image = LOADED_IMAGE_PROTOCOL_GUID;
+	struct efi_security_arch_protocol *sec_proto = NULL;
+	struct efi_security_arch2_protocol *sec2_proto = NULL;
+	efi_loaded_image_t *parent, *child;
+	efi_handle_t child_handle = NULL;
+	unsigned long image_buffer;
+	efi_status_t status;
+	int ret;
+
+	free_mem_ptr = (unsigned long)&zboot_heap;
+	free_mem_end_ptr = free_mem_ptr + sizeof(zboot_heap);
+
+	efi_system_table = systab;
+
+	efi_info("Entering EFI decompressor\n");
+
+	status = efi_bs_call(handle_protocol, handle, &loaded_image,
+			     (void **)&parent);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to locate parent's loaded image protocol\n");
+		return status;
+	}
+
+	status = efi_allocate_pages(uncompressed_size, &image_buffer, ULONG_MAX);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to allocate memory\n");
+		return status;
+	}
+
+	ret = __decompress(_gzdata_start, _gzdata_end - _gzdata_start, NULL,
+			   NULL, (unsigned char *)image_buffer, 0, NULL,
+			   error);
+	if (ret	< 0) {
+		efi_err("Decompression failed (ret == %d)\n", ret);
+		return EFI_LOAD_ERROR;
+	}
+
+	//
+	// This is where it becomes slightly nasty: when UEFI secure boot
+	// policies are in effect, LoadImage() and StartImage() will reject
+	// unsigned images, in a slightly peculiar and inconsistent way:
+	// Tiancore's reference implementation will return
+	// EFI_SECURITY_VIOLATION from LoadImage() if authentication fails, but
+	// will not unload the image from memory, potentially allowing the
+	// image to be invoked anyway, by branching to the right offset in the
+	// image. Other implementations exist that deviate from this behavior,
+	// and return a fatal error from LoadImage() that does not allow the
+	// above workaround. In any case, StartImage() only permits starting
+	// images for which LoadImage() returned EFI_SUCCESS.
+	//
+	// Let's take the shim approach here, and manipulate the underlying
+	// protocol that performs the file authentication. That way, we should
+	// be able to rely on LoadImage/StartImage on all firmware built from
+	// Tianocore or derived from it, without dealing with the individual
+	// quirks. For non-EDK2 based implementations, we really need some kind
+	// of protocol that can start an image after the signature check has
+	// failed.
+	//
+
+	// TODO the protocols below are defined in the PI spec and interoperate
+	// with the DXE foundation, which EFI firmware may not implement. So we
+	// need to define a protocol that the firmware will invoke which allows
+	// us to indicate that the image we are loading should be permitted
+	// regardless of secure boot restrictions.
+
+	status = efi_bs_call(locate_protocol, &security_arch, NULL,
+			     (void **)&sec_proto);
+	if (status == EFI_SUCCESS) {
+		prev_file_auth_state = sec_proto->file_auth_state;
+		sec_proto->file_auth_state = file_auth_state_override;
+	}
+
+	status = efi_bs_call(locate_protocol, &security_arch2, NULL,
+			     (void **)&sec2_proto);
+	if (status == EFI_SUCCESS) {
+		prev_file_auth = sec2_proto->file_auth;
+		sec2_proto->file_auth = file_auth_override;
+	}
+
+	status = efi_bs_call(load_image, true, handle, NULL,
+			     (void *)image_buffer, uncompressed_size,
+			     &child_handle);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to load image: %lx\n", status);
+		return status;
+	}
+
+	status = efi_bs_call(handle_protocol, child_handle, &loaded_image,
+			     (void **)&child);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to locate child's loaded image protocol\n");
+		return status;
+	}
+
+	// Copy the kernel command line
+	child->load_options = parent->load_options;
+	child->load_options_size = parent->load_options_size;
+
+	status = efi_bs_call(start_image, child_handle, NULL, NULL);
+	if (status != EFI_SUCCESS) {
+		efi_err("StartImage() return with error: %lx\n", status);
+		return status;
+	}
+
+	if (sec_proto != NULL)
+		sec_proto->file_auth_state = prev_file_auth_state;
+	if (sec2_proto != NULL)
+		sec2_proto->file_auth = prev_file_auth;
+
+	return EFI_SUCCESS;
+}
diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
new file mode 100644
index 000000000000..f7721b2c1e0e
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
+		*(__ksymtab_strings ___ksymtab+*)
+	}
+}
+
+PROVIDE(__efistub_uncompressed_size = __efistub__gzdata_end - 4);
+
+PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
+PROVIDE(__data_size = ABSOLUTE(_end - _etext));
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 75f16e9bc0c0..07f17e2c5f69 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -387,6 +387,8 @@ void efi_native_runtime_setup(void);
 #define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
 #define EFI_DXE_SERVICES_TABLE_GUID		EFI_GUID(0x05ad34ba, 0x6f02, 0x4214,  0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
 
+#define EFI_SECURITY_ARCH_PROTOCOL_GUID		EFI_GUID(0xA46423E3, 0x4617, 0x49f1,  0xB9, 0xFF, 0xD1, 0xBF, 0xA9, 0x11, 0x58, 0x39)
+#define EFI_SECURITY_ARCH2_PROTOCOL_GUID	EFI_GUID(0x94ab2f58, 0x1438, 0x4ef1,  0x91, 0x52, 0x18, 0x94, 0x1a, 0x3a, 0x0e, 0x68)
 #define EFI_IMAGE_SECURITY_DATABASE_GUID	EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
 #define EFI_SHIM_LOCK_GUID			EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
 
-- 
2.35.1

