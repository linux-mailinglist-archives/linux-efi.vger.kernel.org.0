Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FF55405EC
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jun 2022 19:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346961AbiFGRcU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jun 2022 13:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348139AbiFGRbg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jun 2022 13:31:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455EB115A63
        for <linux-efi@vger.kernel.org>; Tue,  7 Jun 2022 10:29:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n18so15387695plg.5
        for <linux-efi@vger.kernel.org>; Tue, 07 Jun 2022 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=N3t7nBtuA6n4h/YIL27rG7gyQfymuBDEbOLKIwjNZ2A=;
        b=hvbZ+ZCVhiE5hHfYP5gWQ1v/4S4MlYJxLHYAsy8P74VeM0gzXKyE1ukxouqQ6Afof9
         zMQ0un6S8/6Gq6nKCRDWfBJO0CnfcPDDtHWUSbJaS87DlMMidKiOu/k7/1jgRBqwf82/
         XDlBgW15oo/Ms6vHJ8tSekqI8DBsLYbB8LZx4dvdjQUHSuC8yOz4EMSWm3oukgU2vRsl
         ZBcf1eGI4V/ZUUDuBiyr3XbeVp36H9042O6xJEpoNyjj36cHukbGQgTwnrQTF4dc081A
         FQq2EXivUc17K8XtMLiPssENnXOtYHNTNQ1DAFzeUln41ZhhJPYi4rs1XAHxBDFIrw2q
         /GeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=N3t7nBtuA6n4h/YIL27rG7gyQfymuBDEbOLKIwjNZ2A=;
        b=5qpSL6ghQAQEGHYK0722eri7CXVmtZ2FiS6ZiNgR53UlAoZPow9+rTe1bsU9H4Umhi
         ccjECEIkSAEO1QpXHpeKaIZJgYynVUuIZV1IrhAgLxGAiu629NMN1ajt9zsJjVUEmb+3
         bGlVy4hYv56keTKF/sIjskRS3WSwZfm8/lS0JGGvFXsnBT8LXCw+eDI2VkHoLILMPOfI
         Mi/raaqPV0/wyuUGCERdVUGaKJOSVLmKiDlbCwsFohzmZsctTliZoj/+TJ+1+Z5nOj4k
         vVHIBM3ItFXeBlHqkO5sNLBcGVxDOFHt8+BNpncWSO0eRKZ8NVWcmZKjY6pwKTVx5y8N
         USTA==
X-Gm-Message-State: AOAM532G6Mxa7801acTpAjV4uo/m9oqfJkwuGixu1qOYLfj1Oe3x30LP
        loKN08LpckkXCs15aJRd4B/KQHI3c1TaTw==
X-Google-Smtp-Source: ABdhPJxl4wepo99YTguaSEQ5Bvp0anZJhDyTJQOG9BBSfoO3DZrucBvTFsM7uZlAnT+zk4kJSvFLNw==
X-Received: by 2002:a17:902:f353:b0:167:7bc1:b1b9 with SMTP id q19-20020a170902f35300b001677bc1b1b9mr11874498ple.117.1654622974632;
        Tue, 07 Jun 2022 10:29:34 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id n10-20020a63970a000000b003fdc7e490a6sm4439366pge.20.2022.06.07.10.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:29:34 -0700 (PDT)
Date:   Tue, 7 Jun 2022 10:29:29 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH] firmware/efi: Add write mutex to prevent uaf
Message-ID: <20220607172929.GA394061@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If the user calls close() in the middle of copy operation in
copy_from_user() of efi_capsule_write(),
the user buffer may be copied to the released page.
This is because ->flush is called unconditionally regardless
of f_count, unlike ->release.
This driver is not a security vulnerability, as only
root privileges can write to it.
However, you need to add a mutex to efi_capsule_write()
and efi_capsule_flush() as root can accidentally break
the page while in use.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/firmware/efi/capsule-loader.c | 12 ++++++++++
 include/linux/efi.h                   | 33 ++++-----------------------
 2 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 4dde8edd53b6..e50ede51ef38 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -177,6 +177,8 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
 	if (count == 0)
 		return 0;
 
+	mutex_lock(&cap_info->write_lock);
+
 	/* Return error while NO_FURTHER_WRITE_ACTION is flagged */
 	if (cap_info->index < 0)
 		return -EIO;
@@ -233,12 +235,16 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
 			goto failed;
 	}
 
+	mutex_unlock(&cap_info->write_lock);
+
 	return write_byte;
 
 fail_unmap:
 	kunmap(page);
 failed:
 	efi_free_all_buff_pages(cap_info);
+	mutex_unlock(&cap_info->write_lock);
+
 	return ret;
 }
 
@@ -256,12 +262,16 @@ static int efi_capsule_flush(struct file *file, fl_owner_t id)
 	int ret = 0;
 	struct capsule_info *cap_info = file->private_data;
 
+	mutex_lock(&cap_info->write_lock);
+
 	if (cap_info->index > 0) {
 		pr_err("capsule upload not complete\n");
 		efi_free_all_buff_pages(cap_info);
 		ret = -ECANCELED;
 	}
 
+	mutex_unlock(&cap_info->write_lock);
+
 	return ret;
 }
 
@@ -315,6 +325,8 @@ static int efi_capsule_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
+	mutex_init(&cap_info->write_lock);
+
 	file->private_data = cap_info;
 
 	return 0;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7d9b0bb47eb3..523f64df8529 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -204,6 +204,7 @@ struct efi_image_auth {
 struct capsule_info {
 	efi_capsule_header_t	header;
 	efi_capsule_header_t	*capsule;
+	struct mutex		write_lock;
 	int			reset_type;
 	long			index;
 	size_t			count;
@@ -213,8 +214,6 @@ struct capsule_info {
 	size_t			page_bytes_remain;
 };
 
-int efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
-                           size_t hdr_bytes);
 int __efi_capsule_setup_info(struct capsule_info *cap_info);
 
 /*
@@ -385,7 +384,6 @@ void efi_native_runtime_setup(void);
 #define EFI_LOAD_FILE_PROTOCOL_GUID		EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
 #define EFI_LOAD_FILE2_PROTOCOL_GUID		EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
 #define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
-#define EFI_DXE_SERVICES_TABLE_GUID		EFI_GUID(0x05ad34ba, 0x6f02, 0x4214,  0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
 
 #define EFI_IMAGE_SECURITY_DATABASE_GUID	EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
 #define EFI_SHIM_LOCK_GUID			EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
@@ -393,7 +391,6 @@ void efi_native_runtime_setup(void);
 #define EFI_CERT_SHA256_GUID			EFI_GUID(0xc1c41626, 0x504c, 0x4092, 0xac, 0xa9, 0x41, 0xf9, 0x36, 0x93, 0x43, 0x28)
 #define EFI_CERT_X509_GUID			EFI_GUID(0xa5c059a1, 0x94e4, 0x4aa7, 0x87, 0xb5, 0xab, 0x15, 0x5c, 0x2b, 0xf0, 0x72)
 #define EFI_CERT_X509_SHA256_GUID		EFI_GUID(0x3bd2a492, 0x96c0, 0x4079, 0xb4, 0x20, 0xfc, 0xf9, 0x8e, 0xf1, 0x03, 0xed)
-#define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
 
 /*
  * This GUID is used to pass to the kernel proper the struct screen_info
@@ -409,20 +406,6 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
 #define LINUX_EFI_INITRD_MEDIA_GUID		EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
 #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
-#define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
-
-#define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
-
-/*
- * This GUID may be installed onto the kernel image's handle as a NULL protocol
- * to signal to the stub that the placement of the image should be respected,
- * and moving the image in physical memory is undesirable. To ensure
- * compatibility with 64k pages kernels with virtually mapped stacks, and to
- * avoid defeating physical randomization, this protocol should only be
- * installed if the image was placed at a randomized 128k aligned address in
- * memory.
- */
-#define LINUX_EFI_LOADED_IMAGE_FIXED_GUID	EFI_GUID(0xf5a37b6d, 0x3344, 0x42a5,  0xb6, 0xbb, 0x97, 0x86, 0x48, 0xc1, 0x89, 0x0a)
 
 /* OEM GUIDs */
 #define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
@@ -453,7 +436,6 @@ typedef struct {
 } efi_config_table_type_t;
 
 #define EFI_SYSTEM_TABLE_SIGNATURE ((u64)0x5453595320494249ULL)
-#define EFI_DXE_SERVICES_TABLE_SIGNATURE ((u64)0x565245535f455844ULL)
 
 #define EFI_2_30_SYSTEM_TABLE_REVISION  ((2 << 16) | (30))
 #define EFI_2_20_SYSTEM_TABLE_REVISION  ((2 << 16) | (20))
@@ -615,7 +597,6 @@ extern struct efi {
 	unsigned long			tpm_log;		/* TPM2 Event Log table */
 	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
 	unsigned long			mokvar_table;		/* MOK variable config table */
-	unsigned long			coco_secret;		/* Confidential computing secret table */
 
 	efi_get_time_t			*get_time;
 	efi_set_time_t			*set_time;
@@ -1349,14 +1330,10 @@ static inline struct efi_mokvar_table_entry *efi_mokvar_entry_find(
 }
 #endif
 
+#ifdef CONFIG_SYSFB
 extern void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
-
-struct linux_efi_coco_secret_area {
-	u64	base_pa;
-	u64	size;
-};
-
-/* Header of a populated EFI secret area */
-#define EFI_SECRET_TABLE_HEADER_GUID	EFI_GUID(0x1e74f542, 0x71dd, 0x4d66,  0x96, 0x3e, 0xef, 0x42, 0x87, 0xff, 0x17, 0x3b)
+#else
+static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt) { }
+#endif
 
 #endif /* _LINUX_EFI_H */
-- 
2.25.1

