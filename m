Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C323A22D6C6
	for <lists+linux-efi@lfdr.de>; Sat, 25 Jul 2020 12:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGYKdE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Jul 2020 06:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgGYKdE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 25 Jul 2020 06:33:04 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C07C0619D3;
        Sat, 25 Jul 2020 03:33:03 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id bm28so8750295edb.2;
        Sat, 25 Jul 2020 03:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hRZl84CVfBdDYQ3uAOwBDEzGLpGcFseA/B1kwUwXoTg=;
        b=VWoPL5rhZHn9PUMkyNajZMnhLQeNJuLPm5vqjgMaKkhP+sQL3XNecdCZXpWHMjNEVl
         ctJMVWOFQtIuIdpNWFHOkkzwOP6YKUo7DV1s81AO6hld8xwYZOi3NyK24SYtlhF17eDI
         UwIdyd2sW5V9CRdMhnotJikSE76lWlS3o9jiE4e6dnikYThNGm5AmakW/rZGB+kZneOO
         2rRM2GHy+Udi1ZF17oeu955IPQcZuGmAfo2LiR4rJhG9Xa/Aqv9FHcg4k1Vaz7hlFa0d
         P9jr2ybq7qGLpPJZ1vnbvZi6oKwTP7DU8KQ7ZXzFhcrMaqfj1Jb5Ujx6ml2CwGpaarSd
         cjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=hRZl84CVfBdDYQ3uAOwBDEzGLpGcFseA/B1kwUwXoTg=;
        b=nOGdaxPg5k55d8cJupuXOXxSITawhbjmqcFnqvJmguzdpUKcHFnDkky+LjuTSvNdOH
         fWCWivU59XTvKxOSGj64mNba5J0Icn6CiNhrsumTgCEH0fEkRI65edlaUZ7SCAE7zVvF
         ms5SU5NmD0H2VSSG7ZYhzi3HYhM4OXbnNfBurrNeX63eRI6H5ci+mNL2dCXTArGLh6m1
         TxX4W7CN+LyEjzTe4Wp/eV7kYONZQULi0wutKHl/mgqwrHWuDcLTzQ+B0KjvGhpZkX3x
         d0yylWFQZ1dlNHYZwWqkEJvS+gqmHKTxwbcHslhy9YmX0X/3WxCS4n+xPB/na33tnNsJ
         9TtA==
X-Gm-Message-State: AOAM533Dtbgw+1jkocyFO1GWSBr8lB4wX28Om+uo5g54NFfwlnw9UgLy
        3kucPkl07Srs7VCP/NGYqq0=
X-Google-Smtp-Source: ABdhPJwypfqbG748bPUoK58nnkKMuAlrdt2ol+ZECwLBTf1e+eSXjnXDp+S+FoRzKV0ss6o8q6UdIQ==
X-Received: by 2002:a05:6402:1841:: with SMTP id v1mr12900418edy.198.1595673182081;
        Sat, 25 Jul 2020 03:33:02 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id mj22sm2589637ejb.118.2020.07.25.03.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 03:33:01 -0700 (PDT)
Date:   Sat, 25 Jul 2020 12:32:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org
Subject: [GIT PULL] EFI fixes
Message-ID: <20200725103259.GA823698@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Linus,

Please pull the latest efi/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2020-07-25

   # HEAD: 74f85551666fe40bd739e95b5ecb20f53f8ad4df Merge tag 'efi-urgent-for-v5.8-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/urgent

Various EFI fixes:

  - Fix the layering violation in the use of the EFI runtime services
    availability mask in users of the 'efivars' abstraction

  - Revert build fix for GCC v4.8 which is no longer supported

  - Clean up some x86 EFI stub details, some of which are borderline bugs
    that copy around garbage into padding fields - let's fix these
    out of caution.

  - Fix build issues while working on RISC-V support

  - Avoid --whole-archive when linking the stub on arm64

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (2):
      efi/efivars: Expose RT service availability via efivars abstraction
      efi: Revert "efi/x86: Fix build with gcc 4"

Arvind Sankar (2):
      efi/x86: Remove unused variables
      efi/x86: Only copy upto the end of setup_header

Atish Patra (2):
      efi/libstub: Fix gcc error around __umoddi3 for 32 bit builds
      efi/libstub: Move the function prototypes to header file

Masahiro Yamada (1):
      efi/libstub/arm64: link stub lib.a conditionally


 arch/arm64/Makefile                       |  2 +-
 drivers/firmware/efi/efi-pstore.c         |  5 +----
 drivers/firmware/efi/efi.c                | 12 ++++++++----
 drivers/firmware/efi/efivars.c            |  5 +----
 drivers/firmware/efi/libstub/Makefile     |  3 +--
 drivers/firmware/efi/libstub/alignedmem.c |  2 +-
 drivers/firmware/efi/libstub/efi-stub.c   | 17 -----------------
 drivers/firmware/efi/libstub/efistub.h    | 16 ++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c   |  8 ++++----
 drivers/firmware/efi/vars.c               |  6 ++++++
 fs/efivarfs/super.c                       |  6 +++---
 include/linux/efi.h                       |  1 +
 12 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 76359cfb328a..4621fb690d9c 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -143,7 +143,7 @@ export	TEXT_OFFSET
 
 core-y		+= arch/arm64/
 libs-y		:= arch/arm64/lib/ $(libs-y)
-core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 # Default target when executing plain make
 boot		:= arch/arm64/boot
diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index c2f1d4e6630b..feb7fe6f2da7 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -356,10 +356,7 @@ static struct pstore_info efi_pstore_info = {
 
 static __init int efivars_pstore_init(void)
 {
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
-		return 0;
-
-	if (!efivars_kobject())
+	if (!efivars_kobject() || !efivar_supports_writes())
 		return 0;
 
 	if (efivars_pstore_disable)
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5114cae4ec97..fdd1db025dbf 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -176,11 +176,13 @@ static struct efivar_operations generic_ops;
 static int generic_ops_register(void)
 {
 	generic_ops.get_variable = efi.get_variable;
-	generic_ops.set_variable = efi.set_variable;
-	generic_ops.set_variable_nonblocking = efi.set_variable_nonblocking;
 	generic_ops.get_next_variable = efi.get_next_variable;
 	generic_ops.query_variable_store = efi_query_variable_store;
 
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
+		generic_ops.set_variable = efi.set_variable;
+		generic_ops.set_variable_nonblocking = efi.set_variable_nonblocking;
+	}
 	return efivars_register(&generic_efivars, &generic_ops, efi_kobj);
 }
 
@@ -382,7 +384,8 @@ static int __init efisubsys_init(void)
 		return -ENOMEM;
 	}
 
-	if (efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES)) {
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
+				      EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME)) {
 		efivar_ssdt_load();
 		error = generic_ops_register();
 		if (error)
@@ -416,7 +419,8 @@ static int __init efisubsys_init(void)
 err_remove_group:
 	sysfs_remove_group(efi_kobj, &efi_subsys_attr_group);
 err_unregister:
-	if (efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
+				      EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME))
 		generic_ops_unregister();
 err_put:
 	kobject_put(efi_kobj);
diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index 26528a46d99e..dcea137142b3 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -680,11 +680,8 @@ int efivars_sysfs_init(void)
 	struct kobject *parent_kobj = efivars_kobject();
 	int error = 0;
 
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
-		return -ENODEV;
-
 	/* No efivars has been registered yet */
-	if (!parent_kobj)
+	if (!parent_kobj || !efivar_supports_writes())
 		return 0;
 
 	printk(KERN_INFO "EFI Variables Facility v%s %s\n", EFIVARS_VERSION,
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 4cce372edaf4..75daaf20374e 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -6,8 +6,7 @@
 # enabled, even if doing so doesn't break the build.
 #
 cflags-$(CONFIG_X86_32)		:= -march=i386
-cflags-$(CONFIG_X86_64)		:= -mcmodel=small \
-				   $(call cc-option,-maccumulate-outgoing-args)
+cflags-$(CONFIG_X86_64)		:= -mcmodel=small
 cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar \
diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmware/efi/libstub/alignedmem.c
index cc89c4d6196f..1de9878ddd3a 100644
--- a/drivers/firmware/efi/libstub/alignedmem.c
+++ b/drivers/firmware/efi/libstub/alignedmem.c
@@ -44,7 +44,7 @@ efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
 	*addr = ALIGN((unsigned long)alloc_addr, align);
 
 	if (slack > 0) {
-		int l = (alloc_addr % align) / EFI_PAGE_SIZE;
+		int l = (alloc_addr & (align - 1)) / EFI_PAGE_SIZE;
 
 		if (l) {
 			efi_bs_call(free_pages, alloc_addr, slack - l + 1);
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 3318ec3f8e5b..a5a405d8ab44 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -121,23 +121,6 @@ static unsigned long get_dram_base(void)
 	return membase;
 }
 
-/*
- * This function handles the architcture specific differences between arm and
- * arm64 regarding where the kernel image must be loaded and any memory that
- * must be reserved. On failure it is required to free all
- * all allocations it has made.
- */
-efi_status_t handle_kernel_image(unsigned long *image_addr,
-				 unsigned long *image_size,
-				 unsigned long *reserve_addr,
-				 unsigned long *reserve_size,
-				 unsigned long dram_base,
-				 efi_loaded_image_t *image);
-
-asmlinkage void __noreturn efi_enter_kernel(unsigned long entrypoint,
-					    unsigned long fdt_addr,
-					    unsigned long fdt_size);
-
 /*
  * EFI entry point for the arm/arm64 EFI stubs.  This is the entrypoint
  * that is described in the PE/COFF header.  Most of the code is the same
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 2c9d42264c29..85050f5a1b28 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -776,6 +776,22 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long *load_size,
 			     unsigned long soft_limit,
 			     unsigned long hard_limit);
+/*
+ * This function handles the architcture specific differences between arm and
+ * arm64 regarding where the kernel image must be loaded and any memory that
+ * must be reserved. On failure it is required to free all
+ * all allocations it has made.
+ */
+efi_status_t handle_kernel_image(unsigned long *image_addr,
+				 unsigned long *image_size,
+				 unsigned long *reserve_addr,
+				 unsigned long *reserve_size,
+				 unsigned long dram_base,
+				 efi_loaded_image_t *image);
+
+asmlinkage void __noreturn efi_enter_kernel(unsigned long entrypoint,
+					    unsigned long fdt_addr,
+					    unsigned long fdt_size);
 
 void efi_handle_post_ebs_state(void);
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 5a48d996ed71..3672539cb96e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -8,6 +8,7 @@
 
 #include <linux/efi.h>
 #include <linux/pci.h>
+#include <linux/stddef.h>
 
 #include <asm/efi.h>
 #include <asm/e820/types.h>
@@ -361,8 +362,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	int options_size = 0;
 	efi_status_t status;
 	char *cmdline_ptr;
-	unsigned long ramdisk_addr;
-	unsigned long ramdisk_size;
 
 	efi_system_table = sys_table_arg;
 
@@ -390,8 +389,9 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	hdr = &boot_params->hdr;
 
-	/* Copy the second sector to boot_params */
-	memcpy(&hdr->jump, image_base + 512, 512);
+	/* Copy the setup header from the second sector to boot_params */
+	memcpy(&hdr->jump, image_base + 512,
+	       sizeof(struct setup_header) - offsetof(struct setup_header, jump));
 
 	/*
 	 * Fill out some of the header fields ourselves because the
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 5f2a4d162795..973eef234b36 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -1229,3 +1229,9 @@ int efivars_unregister(struct efivars *efivars)
 	return rv;
 }
 EXPORT_SYMBOL_GPL(efivars_unregister);
+
+int efivar_supports_writes(void)
+{
+	return __efivars && __efivars->ops->set_variable;
+}
+EXPORT_SYMBOL_GPL(efivar_supports_writes);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 12c66f5d92dd..28bb5689333a 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -201,6 +201,9 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_d_op		= &efivarfs_d_ops;
 	sb->s_time_gran         = 1;
 
+	if (!efivar_supports_writes())
+		sb->s_flags |= SB_RDONLY;
+
 	inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
 	if (!inode)
 		return -ENOMEM;
@@ -252,9 +255,6 @@ static struct file_system_type efivarfs_type = {
 
 static __init int efivarfs_init(void)
 {
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
-		return -ENODEV;
-
 	if (!efivars_kobject())
 		return -ENODEV;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index bb35f3305e55..05c47f857383 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -994,6 +994,7 @@ int efivars_register(struct efivars *efivars,
 int efivars_unregister(struct efivars *efivars);
 struct kobject *efivars_kobject(void);
 
+int efivar_supports_writes(void);
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 		void *data, bool duplicates, struct list_head *head);
 
