Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503E15A3B19
	for <lists+linux-efi@lfdr.de>; Sun, 28 Aug 2022 04:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiH1CwI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 22:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiH1CwH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 22:52:07 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FB65FB8;
        Sat, 27 Aug 2022 19:52:06 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 020895C00A5;
        Sat, 27 Aug 2022 22:52:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 27 Aug 2022 22:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm1; t=1661655123; x=
        1661741523; bh=G8lfY+HnYPQ+yHzLmohUyXRmKIDZHR6G1hUMBfrHJO4=; b=F
        9sv+8hYma89nPnIBgqE14qajzvG2iT24p/XcACk8xtcIg2kyz263vPY37ewp84Yc
        EU3O9j5UH7Q43aEbQiDQkSwGQ7k3CiQVA7R22g1kvriR5Ssgz9lgPhW/pI8qDDcT
        8xA16j0bcmVweJYl25+VNPH5cdUT4bmFey4N8JBKYToR2Q84HksRhesC9metNF+I
        3m1BkbY7osFWjB+9AHQ0sOIL1B9ie/uS4KUwhn/VJQxng/3LRMAs0bdeYFABybrF
        hNtW9eDyfnsBySSfH0OtBAnwhe5392m4L6Y8jUcmlMeWSTixFnhNAMzxZFryaWGu
        4q3Gq7pidm+03hzUrQmTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1661655123; x=1661741523; bh=G8lfY+HnYPQ+yHzLmohUyXRmKIDZHR6G1hU
        MBfrHJO4=; b=yKesZYmxza4UdYJldlVths0Tj3MhSxCOxDHuaMib7E2ly+U7J3U
        MLF7f3d+mgitXPPyuCQEAd7QGlqptVR9MNQT0dzMEVmaGNfm/zTncLDC3I9ItKTD
        gJZI9LqUd9BvaoWpZiDHhqY+cSoKRr/kNlN21cAHQeaWdMDjwL2BD5g982RDUbwt
        SQ8uiECo4Pn5exJ0cWA+hP++58YTNaS1YUzW7a+HtQmlG78yFIwIVRhHUr1prM0d
        3GAoFC9vETaZtApC2x+U3xgAi7IUSV3AFtAtVtpVh/X4Dt3QwjhmV4sfl0nkuGnm
        V2KGsB1v8gKcelGhlDOGCkmceuU/iY50i3A==
X-ME-Sender: <xms:U9gKY0gZdOl7iv8oI0k0LvXRhgCNLPhkfNT7ZmgkgbIMnJeueFj9HQ>
    <xme:U9gKY9CPe7sXHpnetV76TZ17OrZ3l1V6-P3VvOxkEa9qQS5ELorEYOGJsmQuoHvxl
    KQt4KcdAT3EAzQ>
X-ME-Received: <xmr:U9gKY8Fz8cEPC2K0C1b_PT_3v9raqvF5tBIAZ1WU_4hKj56AyuC9FHnhfQslXYZFRA7NzHBEmhp_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejkedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgvmhhiucfo
    rghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhnghhslh
    grsgdrtghomheqnecuggftrfgrthhtvghrnhepvdefgeekvdekgfffgeekhfeijedtffek
    hefhleehfeejueetgfelgefgtdevieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgr
    sgdrtghomh
X-ME-Proxy: <xmx:U9gKY1Qbndr5VGvk6z2sVLY-XkgSAZMWNUqjn4rKPNsjyhWXwb2LHA>
    <xmx:U9gKYxzfJYESviD3mUJaDHuo-goheHNoGBl0BvHx5Uwz1dMx4EiudA>
    <xmx:U9gKYz7DSXoyWMidDzmfAtoMyZDSqOE_4ZgR2nPsEZo5fmKMNVUxbw>
    <xmx:U9gKY0rsPdIXTVuCyYOX5_9fkTLhBUU07YBb7_Vjs72y4op4CSEMhQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Aug 2022 22:52:03 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH v2] Add support for ESRT loading under Xen
Date:   Sat, 27 Aug 2022 22:51:58 -0400
Message-Id: <20220828025158.1455-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is needed for fwupd to work in Qubes OS.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
Changes since v1:

- Use a different type (struct xen_efi_mem_info) for memory information
  provided by Xen, as Xen reports it in a different way than the
  standard Linux functions do.

 drivers/firmware/efi/esrt.c | 49 +++++++++++++++++++++++++++----------
 drivers/xen/efi.c           | 32 ++++++++++++++++++++++++++
 include/linux/efi.h         | 18 ++++++++++++++
 3 files changed, 86 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index 2a2f52b017e736dd995c69e8aeb5fbd7761732e5..c0fc149a838044cc16bb08a374a0c8ea6b7dcbff 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -243,27 +243,50 @@ void __init efi_esrt_init(void)
 	void *va;
 	struct efi_system_resource_table tmpesrt;
 	size_t size, max, entry_size, entries_size;
-	efi_memory_desc_t md;
-	int rc;
 	phys_addr_t end;
-
-	if (!efi_enabled(EFI_MEMMAP))
-		return;
+	uint32_t type;
 
 	pr_debug("esrt-init: loading.\n");
 	if (!esrt_table_exists())
 		return;
 
-	rc = efi_mem_desc_lookup(efi.esrt, &md);
-	if (rc < 0 ||
-	    (!(md.attribute & EFI_MEMORY_RUNTIME) &&
-	     md.type != EFI_BOOT_SERVICES_DATA &&
-	     md.type != EFI_RUNTIME_SERVICES_DATA)) {
-		pr_warn("ESRT header is not in the memory map.\n");
+	if (efi_enabled(EFI_MEMMAP)) {
+		efi_memory_desc_t md;
+
+		if (efi_mem_desc_lookup(efi.esrt, &md) < 0 ||
+		    (!(md.attribute & EFI_MEMORY_RUNTIME) &&
+		     md.type != EFI_BOOT_SERVICES_DATA &&
+		     md.type != EFI_RUNTIME_SERVICES_DATA)) {
+			pr_warn("ESRT header is not in the memory map.\n");
+			return;
+		}
+
+		type = md.type;
+		max = efi_mem_desc_end(&md);
+	} else if (IS_ENABLED(CONFIG_XEN_EFI) && efi_enabled(EFI_PARAVIRT)) {
+		struct xen_efi_mem_info info;
+
+		if (!xen_efi_mem_info_query(efi.esrt, &info)) {
+			pr_warn("Failed to lookup ESRT header in Xen memory map\n");
+			return;
+		}
+
+		type = info.type;
+		max = info.addr + info.size;
+
+		/* Recent Xen versions relocate the ESRT to memory of type
+		 * EfiRuntimeServicesData, which Xen will not reuse.  If the ESRT
+		 * is not in EfiRuntimeServicesData memory, it has not been reserved
+		 * by Xen and might be allocated to other guests, so it cannot
+		 * safely be used. */
+		if (type != EFI_RUNTIME_SERVICES_DATA) {
+			pr_warn("Xen did not reserve ESRT, ignoring it\n");
+			return;
+		}
+	} else {
 		return;
 	}
 
-	max = efi_mem_desc_end(&md);
 	if (max < efi.esrt) {
 		pr_err("EFI memory descriptor is invalid. (esrt: %p max: %p)\n",
 		       (void *)efi.esrt, (void *)max);
@@ -333,7 +356,7 @@ void __init efi_esrt_init(void)
 
 	end = esrt_data + size;
 	pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, &end);
-	if (md.type == EFI_BOOT_SERVICES_DATA)
+	if (type == EFI_BOOT_SERVICES_DATA)
 		efi_mem_reserve(esrt_data, esrt_data_size);
 
 	pr_debug("esrt-init: loaded.\n");
diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
index d1ff2186ebb48a7c0981ecb6d4afcbbb25ffcea0..b313f213822f0fd5ba6448f6f6f453cfda4c7e23 100644
--- a/drivers/xen/efi.c
+++ b/drivers/xen/efi.c
@@ -26,6 +26,7 @@
 
 #include <xen/interface/xen.h>
 #include <xen/interface/platform.h>
+#include <xen/page.h>
 #include <xen/xen.h>
 #include <xen/xen-ops.h>
 
@@ -40,6 +41,37 @@
 
 #define efi_data(op)	(op.u.efi_runtime_call)
 
+static_assert(XEN_PAGE_SHIFT == EFI_PAGE_SHIFT,
+              "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHIFT");
+
+bool xen_efi_mem_info_query(u64 phys_addr, struct xen_efi_mem_info *md)
+{
+	struct xen_platform_op op = {
+		.cmd = XENPF_firmware_info,
+		.u.firmware_info = {
+			.type = XEN_FW_EFI_INFO,
+			.index = XEN_FW_EFI_MEM_INFO,
+			.u.efi_info.mem.addr = phys_addr,
+			.u.efi_info.mem.size = ((u64)-1ULL) - phys_addr,
+		}
+	};
+	union xenpf_efi_info *info = &op.u.firmware_info.u.efi_info;
+	int rc;
+
+	memset(md, 0, sizeof(*md)); /* initialize md even on failure */
+	rc = HYPERVISOR_platform_op(&op);
+	if (rc) {
+		pr_warn("Could not obtain information on address %llu from Xen: "
+			"error %d\n", phys_addr, rc);
+		return false;
+	}
+	md->addr = info->mem.addr;
+	md->size = info->mem.size;
+	md->attr = info->mem.attr;
+	md->type = info->mem.type;
+	return true;
+}
+
 static efi_status_t xen_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 {
 	struct xen_platform_op op = INIT_EFI_OP(get_time);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d2b84c2fec39f0268324d1a38a73ed67786973c9..0598869cdc924aef0e2b9cacc4450b728e1a98c7 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1327,1 +1327,19 @@ struct linux_efi_coco_secret_area {
+/* Result of a XEN_FW_EFI_MEM_INFO query */
+struct xen_efi_mem_info {
+    uint64_t addr; /* address queried */
+    uint64_t size; /* remaining bytes in memory region */
+    uint64_t attr; /* attributes */
+    uint32_t type; /* type */
+};
+
+#if IS_ENABLED(CONFIG_XEN_EFI)
+extern bool xen_efi_mem_info_query(u64 phys_addr, struct xen_efi_mem_info *out_md);
+#else
+static inline bool xen_efi_mem_info_query(u64 phys_addr, struct xen_efi_mem_info *out_md)
+{
+	BUILD_BUG();
+	return false;
+}
+#endif
+
 #endif /* _LINUX_EFI_H */
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
