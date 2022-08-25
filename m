Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342555A1BAB
	for <lists+linux-efi@lfdr.de>; Thu, 25 Aug 2022 23:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiHYVwr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Aug 2022 17:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiHYVwq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Aug 2022 17:52:46 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EAF10B0;
        Thu, 25 Aug 2022 14:52:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B0EDE5C00CC;
        Thu, 25 Aug 2022 17:52:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 25 Aug 2022 17:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm1; t=1661464362; x=
        1661550762; bh=eBngPYnfwnG7xoaliE8DTL2MsPUwU79rcGpexwV7yhc=; b=I
        Qv+VEfqWoMJSeXEJKz9mlw+liRX+kwS0KfUwr//FEqHDRFOqqXoq9HfvDU7BCD1l
        jvDVyRXuD+6AtdHrVVbvwByaRfNt02T39TZPdKYGmVYLYciUax7qM8ymMgPVSoGr
        hk2ithZtmxxGbccUjqmBPbumYsghNpjXNbeWfxZNa3XIPGrQztu3h5BYcu5PZsf+
        au72SEgMvM9M8vGJepWKiMsulIXUzalXI6m3gcA9f6vQ4zG39FbZFAXrthEdaqI7
        TqQb99KZf5JduQq4+Zm6Jr8CyiDXlk4nnLrrqRhG3FnUrxsOBt/DSc25stRNp3/h
        RW0ZCeDqrQPPhuKUW6Nkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1661464362; x=1661550762; bh=eBngPYnfwnG7xoaliE8DTL2MsPUwU79rcGp
        exwV7yhc=; b=mmC5tWwroJgSQYu2gkGeMV/y51x3OfwAamKO4j4HCo0vcVTudC/
        cIZiNoD4Uf27/wKCEvVMFFx8YtePSwtA2EtgB5DtoqsdmvCEtwq0GFZMIeqHtDCm
        Mr2RhS1yhF3xFd2sGoLUQf6ptVgVxIctM3VnM/tp1kBm67pcF4KWJY8+LMc5+kUg
        0n0NG2NM+K7sJyo6cdaAPgL+kYyD6KkeU8fluXtLDqQed1awrJYtAD9QruDuf948
        OV+sOtGZYJexoCCe5NDxXvg66yA9jzNpGhKaWWGTBtCis96C3mf15R1F7uiW9+4n
        IsQcZjhRekFOb6o/Dhp5BvigAmsRlb3yO/w==
X-ME-Sender: <xms:Ku8HY4gj65wKTqjemlajD_Ebj4vytPzJ0dsaaDxXCvmBkhjXb2Cmyw>
    <xme:Ku8HYxBtYAsoSnaLu6ajPQSbBI-tHWG6_bmQBe9lU6pjhfTKzY2LC5_FaWdoknD3q
    Q7rpC-aaqKY_js>
X-ME-Received: <xmr:Ku8HYwEoK9yftMbiTDydef6DHDhF9CwzCgCk2SY4KkkGX0Opogi6Pghm-cUJpIhDeLQJT3TfG9jU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgvmhhiucfo
    rghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhnghhslh
    grsgdrtghomheqnecuggftrfgrthhtvghrnhepvdefgeekvdekgfffgeekhfeijedtffek
    hefhleehfeejueetgfelgefgtdevieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgr
    sgdrtghomh
X-ME-Proxy: <xmx:Ku8HY5RaIIiChllvjYcE9wmb7n0BRLJGuHeQ5YBIpwhJf5JcnynSBg>
    <xmx:Ku8HY1xN2xv8rl6MdQz4PW0JJ0UkRv8N_igbAmjBadi9dHO3CWU7Eg>
    <xmx:Ku8HY340l31EG99I5ec2oQF-cg43TIpBfvsr-TjS5hcjBVD3v-zi3Q>
    <xmx:Ku8HY4oHwYGzrxb6opYh1x49lls8TWNIyzOTpLVVHS6sVQKTpOy4UQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Aug 2022 17:52:41 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH] Add support for ESRT loading under Xen
Date:   Thu, 25 Aug 2022 17:52:18 -0400
Message-Id: <20220825215218.1606-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is needed for fwupd to work in Qubes OS.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/firmware/efi/esrt.c | 34 ++++++++++++++++++++++++----------
 drivers/xen/efi.c           | 33 +++++++++++++++++++++++++++++++++
 include/linux/efi.h         | 10 ++++++++++
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index 2a2f52b017e736dd995c69e8aeb5fbd7761732e5..c0fc149a838044cc16bb08a374a0c8ea6b7dcbff 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -244,22 +244,36 @@ void __init efi_esrt_init(void)
 	struct efi_system_resource_table tmpesrt;
 	size_t size, max, entry_size, entries_size;
 	efi_memory_desc_t md;
-	int rc;
 	phys_addr_t end;
 
-	if (!efi_enabled(EFI_MEMMAP))
-		return;
-
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
+		if (efi_mem_desc_lookup(efi.esrt, &md) < 0 ||
+		    (!(md.attribute & EFI_MEMORY_RUNTIME) &&
+		     md.type != EFI_BOOT_SERVICES_DATA &&
+		     md.type != EFI_RUNTIME_SERVICES_DATA)) {
+			pr_warn("ESRT header is not in the memory map.\n");
+			return;
+		}
+	} else if (IS_ENABLED(CONFIG_XEN_EFI) && efi_enabled(EFI_PARAVIRT)) {
+		if (!xen_efi_mem_desc_lookup(efi.esrt, &md)) {
+			pr_warn("Failed to lookup ESRT header in Xen memory map\n");
+			return;
+		}
+
+		/* Recent Xen versions relocate the ESRT to memory of type
+		 * EfiRuntimeServicesData, which Xen will not reuse.  If the ESRT
+		 * is not in EfiRuntimeServicesData memory, it has not been reserved
+		 * by Xen and might be allocated to other guests, so it cannot
+		 * safely be used. */
+		if (md.type != EFI_RUNTIME_SERVICES_DATA) {
+			pr_warn("Xen did not reserve ESRT, ignoring it\n");
+			return;
+		}
+	} else {
 		return;
 	}
 
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
 
@@ -40,6 +41,38 @@
 
 #define efi_data(op)	(op.u.efi_runtime_call)
 
+static_assert(XEN_PAGE_SHIFT == EFI_PAGE_SHIFT,
+              "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHIFT");
+
+bool xen_efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *md)
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
+
+	md->attribute = info->mem.attr;
+	md->type = info->mem.type;
+	md->num_pages = info->mem.size >> XEN_PAGE_SHIFT;
+	md->phys_addr = info->mem.addr;
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
@@ -1327,1 +1327,11 @@ struct linux_efi_coco_secret_area {
+#if IS_ENABLED(CONFIG_XEN_EFI)
+extern bool xen_efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md);
+#else
+static inline bool xen_efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
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
