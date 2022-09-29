Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9945F0127
	for <lists+linux-efi@lfdr.de>; Fri, 30 Sep 2022 01:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiI2XDB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 29 Sep 2022 19:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiI2XC4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 29 Sep 2022 19:02:56 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4F912EDBC;
        Thu, 29 Sep 2022 16:02:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E6E2C5C003D;
        Thu, 29 Sep 2022 19:02:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 29 Sep 2022 19:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1664492568; x=1664578968; bh=mbINTmtX+Y203Gs79+//9ThUmGM7WPRVX3Y
        jlp+Pb+E=; b=vxd3Go1eRAYVPxf7nsO+YRDw1szNfJ8CzuPTeQNfwTfgiJlFIxI
        VvgDFfpaW5wMgxgS3D83epM+1HAHUJZGhZ9SFUZ6SSMI5p3FME/rjK0D/8IA3fKw
        0h1itKzOloZ7akksTAd+m2krDesB5O5VqO3fgQScFXQH4fJx9BabnCSoduDqk1Rc
        wlMwY09jMfwZKKvn9dgSEDWudIqFS95I8JV6F4uUa/Sy+t8Cnwf4/xgHyy5dA9mI
        SDyG+W+hB5cUxOfHHsUSxmb0ufoDyitGCSejg0L5Ys4fqF+XWfE9gsUKmrjQj4/d
        lH1KjM+GJAqKXkWfwmN6bMcgnzekVLcfLWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1664492568; x=1664578968; bh=mbINTmtX+Y203
        Gs79+//9ThUmGM7WPRVX3Yjlp+Pb+E=; b=wG00Lo+VdSJSoiPuNxmPp/TGitdWe
        6j6Ow3nEs7qDSSQ7r7av1J88lp+ABlJIKhc2EnPTKsgZ7fhYyaLqUgChpB4jVSJh
        KqT5bJSBPUXdJ8OU4mROTF4/R40c6TB+DIurEaTILCPrNi1ml/lfXqa2X0rOGPYT
        zHWU8M8zbXu6y5Benrbom8ZEEl6EN6nSer8C51hkr4bMuV37ii/QNDF+BJpAXjri
        yP0qFq3x++pbVvWrG29YYhfD38sqt/j8yNekJY3Gomz0AXCrDLpwPx78RLGatbec
        2BaXzhOenHhP/Ll7mISZtmKOz2W5kqNqaQlORr/nKD1gZU4M9K64HrlrA==
X-ME-Sender: <xms:GCQ2Y-2tLyajOv6VpzJYzpDtKT6s8z_cCqQ_SajUEwrnot43rfZRIQ>
    <xme:GCQ2YxEYAj2WlK-gVbH6UP2mI2RkOvtHpJWCsNXogJa0-K2U1NOwYBcjoa58VGZdx
    SuPks3r4CmGETs>
X-ME-Received: <xmr:GCQ2Y27dj8DYJAOVPaSy9tNzIUi9SKXfhzKncZMVxJ9D3Pl4Qqz_iVEx08jHeGFzQ9MNtAvvx92d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehuddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:GCQ2Y_2HfQg7_eOxp0tSU_zGhJDwSMz0JQtm2yYA9M4mIbxF-_Qshw>
    <xmx:GCQ2YxH5H2XiEzjpw6QXwPY8iWctDnyPoV_2mNH0q3oim0ZdGa7UiA>
    <xmx:GCQ2Y4_u9KI85k_f7l4TIy0REYwDNZ-7PocmzE7NQky4pgPwZoEQMA>
    <xmx:GCQ2Y5_xKrmDFQVlaBs7j1xCaDVpYkJYa0zZNARXeOmUr54H2X_Vgw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Sep 2022 19:02:47 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered
Date:   Thu, 29 Sep 2022 19:02:03 -0400
Message-Id: <f3b624e99adfdbbfc1976a60a73a6b5950e1840d.1664298147.git.demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664298147.git.demi@invisiblethingslab.com>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Memory of type EFI_CONVENTIONAL_MEMORY, EFI_LOADER_CODE, EFI_LOADER_DATA,
EFI_BOOT_SERVICES_CODE, and EFI_BOOT_SERVICES_DATA may be clobbered by
Xen before Linux gets to start using it.  Therefore, Linux under Xen
must not use EFI tables from such memory.  Most of the remaining EFI
memory types are not suitable for EFI tables, leaving only
EFI_ACPI_RECLAIM_MEMORY, EFI_RUNTIME_SERVICES_DATA, and
EFI_RUNTIME_SERVICES_CODE.  When running under Xen, Linux should only
use tables that are located in one of these types of memory.

This patch ensures this, and also adds a function
(xen_config_table_memory_region_max()) that will be used later to
replace the usage of the EFI memory map in esrt.c when running under
Xen.  This function can also be used in mokvar-table.c and efi-bgrt.c,
but I have not implemented this.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/firmware/efi/efi.c |  8 +++++---
 drivers/xen/efi.c          | 35 +++++++++++++++++++++++++++++++++++
 include/linux/efi.h        |  9 +++++++++
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index e4080ad96089abd7f84745dd8461c548bcbb7685..d344f3ff73d1c5ed0c67e3251a9502e66719741d 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -574,7 +574,6 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 	unsigned long table;
 	int i;
 
-	pr_info("");
 	for (i = 0; i < count; i++) {
 		if (!IS_ENABLED(CONFIG_X86)) {
 			guid = &config_tables[i].guid;
@@ -585,7 +584,6 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 
 			if (IS_ENABLED(CONFIG_X86_32) &&
 			    tbl64[i].table > U32_MAX) {
-				pr_cont("\n");
 				pr_err("Table located above 4GB, disabling EFI.\n");
 				return -EINVAL;
 			}
@@ -594,10 +592,14 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 			table = tbl32[i].table;
 		}
 
+#ifdef CONFIG_XEN_EFI
+		if (efi_enabled(EFI_PARAVIRT) && !xen_config_table_memory_region_max(table))
+			continue;
+#endif
+
 		if (!match_config_table(guid, table, common_tables) && arch_tables)
 			match_config_table(guid, table, arch_tables);
 	}
-	pr_cont("\n");
 	set_bit(EFI_CONFIG_TABLES, &efi.flags);
 
 	if (efi_rng_seed != EFI_INVALID_TABLE_ADDR) {
diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
index d1ff2186ebb48a7c0981ecb6d4afcbbb25ffcea0..c2274ddfcc63304008ef0fd78fd9fa416f75d073 100644
--- a/drivers/xen/efi.c
+++ b/drivers/xen/efi.c
@@ -28,6 +28,7 @@
 #include <xen/interface/platform.h>
 #include <xen/xen.h>
 #include <xen/xen-ops.h>
+#include <xen/page.h>
 
 #include <asm/page.h>
 
@@ -271,6 +272,40 @@ static void xen_efi_reset_system(int reset_type, efi_status_t status,
 	}
 }
 
+__init u64 xen_config_table_memory_region_max(u64 addr)
+{
+	static_assert(XEN_PAGE_SHIFT == EFI_PAGE_SHIFT,
+		      "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHIFT");
+	struct xen_platform_op op = {
+		.cmd = XENPF_firmware_info,
+		.u.firmware_info = {
+			.type = XEN_FW_EFI_INFO,
+			.index = XEN_FW_EFI_MEM_INFO,
+			.u.efi_info.mem.addr = addr,
+			.u.efi_info.mem.size = U64_MAX - addr,
+		}
+	};
+	union xenpf_efi_info *info = &op.u.firmware_info.u.efi_info;
+	int rc = HYPERVISOR_platform_op(&op);
+
+	if (rc) {
+		pr_warn("Failed to lookup header %llu in Xen memory map: error %d\n",
+			(unsigned long long)addr, rc);
+		return 0;
+	}
+
+	switch (info->mem.type) {
+	case EFI_RUNTIME_SERVICES_CODE:
+	case EFI_RUNTIME_SERVICES_DATA:
+	case EFI_ACPI_RECLAIM_MEMORY:
+		return info->mem.addr + info->mem.size;
+	default:
+		pr_warn("Table %llu is in memory of type %d, ignoring it\n",
+			(unsigned long long)addr, info->mem.type);
+		return 0;
+	}
+}
+
 /*
  * Set XEN EFI runtime services function pointers. Other fields of struct efi,
  * e.g. efi.systab, will be set like normal EFI.
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d2b84c2fec39f0268324d1a38a73ed67786973c9..fc81e4b984398cdb399e7886b2cae7f33bf91613 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1324,4 +1324,13 @@ struct linux_efi_coco_secret_area {
 /* Header of a populated EFI secret area */
 #define EFI_SECRET_TABLE_HEADER_GUID	EFI_GUID(0x1e74f542, 0x71dd, 0x4d66,  0x96, 0x3e, 0xef, 0x42, 0x87, 0xff, 0x17, 0x3b)
 
+#ifdef CONFIG_XEN_EFI
+/*
+ * Returns the end of the memory region containing the given config table,
+ * or 0 if the given address does not reside in memory that can validly
+ * contain EFI configuration tables.
+ */
+__init u64 xen_config_table_memory_region_max(u64 addr);
+#endif
+
 #endif /* _LINUX_EFI_H */
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

