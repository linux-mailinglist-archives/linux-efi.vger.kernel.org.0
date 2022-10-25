Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4C660CEB8
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiJYOPW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiJYOOX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:14:23 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA90BB39C;
        Tue, 25 Oct 2022 07:14:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6D15940737BD;
        Tue, 25 Oct 2022 14:14:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6D15940737BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707260;
        bh=m9ik2uRc9OfPFbS/Zi3EYWXvx8CnVCtdriRP6lB3iYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZvOAUzg3lmwH9CmxcVY/CVM3lc9SgND7W2Y+ilNyztMy3xJKsIJKDD3RLjqaHW9+k
         kMbVgcy/ELW/PdEBPtK3R/eCF63muFlZp7KXGj9+6lHtZZgb5cknIUTyOKmpCdRo6r
         zSYOoN6adQWL1puZUS+E5tq2ZT9+sCfbrKBTKVvE=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 22/23] efi/libstub: Add memory attribute protocol definitions
Date:   Tue, 25 Oct 2022 17:13:00 +0300
Message-Id: <07cba0f78e90e26a3ec8e71c7854fe15767660c6.1666705333.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1666705333.git.baskov@ispras.ru>
References: <cover.1666705333.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

EFI_MEMORY_ATTRIBUTE_PROTOCOL servers as a better alternative to
DXE services for setting memory attributes in EFI Boot Services
environment. This protocol is better since it is a part of UEFI
specification itself and not UEFI PI specification like DXE
services.

Add EFI_MEMORY_ATTRIBUTE_PROTOCOL definitions.
Support mixed mode properly for its calls.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/include/asm/efi.h             |  7 +++++++
 drivers/firmware/efi/libstub/efistub.h | 22 ++++++++++++++++++++++
 include/linux/efi.h                    |  1 +
 3 files changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 233ae6986d6f..522ff2e443b3 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -325,6 +325,13 @@ static inline u32 efi64_convert_status(efi_status_t status)
 #define __efi64_argmap_set_memory_space_attributes(phys, size, flags) \
 	(__efi64_split(phys), __efi64_split(size), __efi64_split(flags))
 
+/* Memory Attribute Protocol */
+#define __efi64_argmap_set_memory_attributes(protocol, phys, size, flags) \
+	((protocol), __efi64_split(phys), __efi64_split(size), __efi64_split(flags))
+
+#define __efi64_argmap_clear_memory_attributes(protocol, phys, size, flags) \
+	((protocol), __efi64_split(phys), __efi64_split(size), __efi64_split(flags))
+
 /*
  * The macros below handle the plumbing for the argument mapping. To add a
  * mapping for a specific EFI method, simply define a macro
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 63f5157341fe..b9ea9e2c3010 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -39,6 +39,9 @@ extern const efi_system_table_t *efi_system_table;
 typedef union efi_dxe_services_table efi_dxe_services_table_t;
 extern const efi_dxe_services_table_t *efi_dxe_table;
 
+typedef union efi_memory_attribute_protocol efi_memory_attribute_protocol_t;
+extern efi_memory_attribute_protocol_t *efi_mem_attrib_proto;
+
 efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 				   efi_system_table_t *sys_table_arg);
 
@@ -415,6 +418,25 @@ union efi_dxe_services_table {
 	} mixed_mode;
 };
 
+union  efi_memory_attribute_protocol {
+	struct {
+		void *get_memory_attributes;
+		efi_status_t (__efiapi *set_memory_attributes)(efi_memory_attribute_protocol_t *,
+								efi_physical_addr_t,
+								u64,
+								u64);
+		efi_status_t (__efiapi *clear_memory_attributes)(efi_memory_attribute_protocol_t *,
+								  efi_physical_addr_t,
+								  u64,
+								  u64);
+	};
+	struct {
+		u32 get_memory_attributes;
+		u32 set_memory_attributes;
+		u32 clear_memory_attributes;
+	} mixed_mode;
+};
+
 typedef union efi_uga_draw_protocol efi_uga_draw_protocol_t;
 
 union efi_uga_draw_protocol {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 80f3c1c7827d..2d13c6eafc19 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -389,6 +389,7 @@ void efi_native_runtime_setup(void);
 #define EFI_LOAD_FILE2_PROTOCOL_GUID		EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
 #define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
 #define EFI_DXE_SERVICES_TABLE_GUID		EFI_GUID(0x05ad34ba, 0x6f02, 0x4214,  0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
+#define EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID	EFI_GUID(0xf4560cf6, 0x40ec, 0x4b4a,  0xa1, 0x92, 0xbf, 0x1d, 0x57, 0xd0, 0xb1, 0x89)
 
 #define EFI_IMAGE_SECURITY_DATABASE_GUID	EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
 #define EFI_SHIM_LOCK_GUID			EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
-- 
2.37.4

