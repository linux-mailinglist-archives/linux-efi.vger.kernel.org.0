Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB91F5BD53C
	for <lists+linux-efi@lfdr.de>; Mon, 19 Sep 2022 21:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiISTd2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Sep 2022 15:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISTd0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Sep 2022 15:33:26 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2644B44547;
        Mon, 19 Sep 2022 12:33:25 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6224732002D8;
        Mon, 19 Sep 2022 15:33:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 19 Sep 2022 15:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm2; t=1663616000; x=
        1663702400; bh=/wIED5ZiGUUNAQXfShqAlwSBTSaTfAqoWYXPaDLttnM=; b=h
        kgJ2ZUpFUNE/ZQE8nR28FjzCOVEuiYm5BYxbPBkgODqYWDnsj/NUC4X5ybuG/WZ6
        y/tRocPfez+HYk8xG4p3JkPIWg4C87kqbCoOWE+HlbfFlfMx1tuXb94FFdrdB570
        c7IwsCYk0Mj6vGlU6QOoSsxXBLIiZp44PLKiPCKco+6FNgHiVZx6rhNvBLkzrOtX
        kQsFbsLjCBw06pw4n4+qM1KenlOiVyl/egWTm+QWUvEkME30hErWQRBSUWvCEMWZ
        HKRFkO+xhoCvoF0zdsqUz2BfVU0EQRh+Z6a2au5oWVb6Eil/3wX8AN7mAAHRCdI+
        huCqplCSuPbN0wlj6yEUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1663616000; x=1663702400; bh=/wIED5ZiGUUNAQXfShqAlwSBTSaTfAqoWYX
        PaDLttnM=; b=AAEJAHuptd0YMViwiHVvpODaKlcUwqPwKy99WZfKt49l4Y6WgHI
        WLOtdD+Wkw9y79Q5u45HecJ2nWYG1JY0lJ/F/i5R/woJ1Wzynhsrv6JvgIdDbJOZ
        p5nn8lwV8/qiPWLU5yJ64+jyVc8Vc54jgO527H6Mdjim4qjTSj6ZLvOP28Q5O/mO
        flmL8F6zCjmTNrNXBL0+RGhxUpEhW1uOdq/2mKY+d4FW8RvVnCpVn4rW2GY11drx
        iIzQY2VmO5mWzVH7JS1kU1QdwwbydXGlezMTgSefxfJfoSM00HUQJ3CjzDa92xID
        V9y8TwftmQZBVtf8jPjyACEDNklcDLbzhlQ==
X-ME-Sender: <xms:AMQoY4_riylCUj0TzQ0e9OG3wCrq9MIx42whOsMlU2mrn9y4XttLmQ>
    <xme:AMQoYwvi_9dbJnxdRpTdy2fmoQ-z4_0qMu20K-DFAPOfWU_T92-jZYk_bcz5Jdxsr
    YjgwLFUNpH1wEU>
X-ME-Received: <xmr:AMQoY-B4jcD_YDbAtmktn__4PYpHCNOgpSZ6mASRa0oXNpm6WFvYi1TgCn00JjrKKXjuywliEjSY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvjedgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffvghmihcu
    ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvfeegkedvkefgffegkefhieejtdff
    keehhfelheefjeeutefgleeggfdtveeileenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhl
    rggsrdgtohhm
X-ME-Proxy: <xmx:AMQoY4cjOQpITLnyg7msgr4BaQQKG15UXPxdCtuO46R0ROj73utsZQ>
    <xmx:AMQoY9Mu9778mvwS1DBFsSccoS99Djm14-kadKRKErWqugQ9qGKZeA>
    <xmx:AMQoYykeuwiAOI2Ug_jA3MOCCkekaMUyReHlrgEnjASKwUIipfQmyg>
    <xmx:AMQoYw3u7Kipi2z-wnfnHXDLcjhwC1xO5n47gfJ7eova9pt1Vo8zmA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Sep 2022 15:33:20 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH v3] Support ESRT in Xen dom0
Date:   Mon, 19 Sep 2022 15:32:57 -0400
Message-Id: <20220919193257.2031-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

fwupd requires access to the EFI System Resource Table (ESRT) to
discover which firmware can be updated by the OS.  Currently, Linux does
not expose the ESRT when running as a Xen dom0.  Therefore, it is not
possible to use fwupd in a Xen dom0, which is a serious problem for e.g.
Qubes OS.

Before Xen 4.16, this was not fixable due to hypervisor limitations.
The UEFI specification requires the ESRT to be in EfiBootServicesData
memory, which Xen will use for whatever purposes it likes.  Therefore,
Linux cannot safely access the ESRT, as Xen may have overwritten it.

Starting with Xen 4.17, Xen checks if the ESRT is in EfiBootServicesData
or EfiRuntimeServicesData memory.  If the ESRT is in EfiBootServicesData
memory, Xen allocates some memory of type EfiRuntimeServicesData, copies
the ESRT to it, and finally replaces the ESRT pointer with a pointer to
the copy.  Since Xen will not clobber EfiRuntimeServicesData memory,
this ensures that the ESRT can safely be accessed by the OS.  It is safe
to access the ESRT under Xen if, and only if, it is in memory of type
EfiRuntimeServicesData.

When running as a Xen dom0, check if the ESRT is in memory of type
EfiRuntimeServicesData, and if it is, parse it as if not running under
Xen.  This allows programs such as fwupd which require the ESRT to run
under Xen, and so makes fwupd support in Qubes OS possible.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
Changes since v2:

- Massively updated commit message.
- Fetch the ESRT inline in drivers/firmware/efi/esrt.c, instead of using
  a single-use helper in drivers/xen/efi.c.

Changes since v1:

- Use a different type (struct xen_efi_mem_info) for memory information
  provided by Xen, as Xen reports it in a different way than the
  standard Linux functions do.

 drivers/firmware/efi/esrt.c | 71 ++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index 2a2f52b017e736dd995c69e8aeb5fbd7761732e5..378bf2ea770ad3bd747345a89258216919eb21bb 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -28,6 +28,11 @@
 #include <asm/io.h>
 #include <asm/early_ioremap.h>
 
+#ifdef CONFIG_XEN_EFI
+#include <asm/xen/hypercall.h>
+#include <xen/page.h>
+#endif
+
 struct efi_system_resource_entry_v1 {
 	efi_guid_t	fw_class;
 	u32		fw_type;
@@ -243,27 +248,67 @@ void __init efi_esrt_init(void)
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
+#ifdef CONFIG_XEN_EFI
+	} else if (efi_enabled(EFI_PARAVIRT)) {
+		static_assert(XEN_PAGE_SHIFT == EFI_PAGE_SHIFT,
+			      "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHIFT");
+
+		struct xen_platform_op op = {
+			.cmd = XENPF_firmware_info,
+			.u.firmware_info = {
+				.type = XEN_FW_EFI_INFO,
+				.index = XEN_FW_EFI_MEM_INFO,
+				.u.efi_info.mem.addr = efi.esrt,
+				.u.efi_info.mem.size = ((u64)-1ULL) - efi.esrt,
+			}
+		};
+		union xenpf_efi_info *info = &op.u.firmware_info.u.efi_info;
+		int rc = HYPERVISOR_platform_op(&op);
+
+		if (rc) {
+			pr_warn("Failed to lookup ESRT header %lu in Xen memory map: error %d\n",
+				efi.esrt, rc);
+			return;
+		}
+		type = info->mem.type;
+		max = info->mem.addr + info->mem.size;
+
+		/*
+		 * Recent Xen versions relocate the ESRT to memory of type
+		 * EfiRuntimeServicesData, which Xen will not reuse.  If the ESRT
+		 * is not in EfiRuntimeServicesData memory, it has not been reserved
+		 * by Xen and might be allocated to other guests, so it cannot
+		 * safely be used.
+		 */
+		if (type != EFI_RUNTIME_SERVICES_DATA) {
+			pr_warn("Xen did not reserve ESRT, ignoring it\n");
+			return;
+		}
+#endif
+	} else {
 		return;
 	}
 
-	max = efi_mem_desc_end(&md);
 	if (max < efi.esrt) {
 		pr_err("EFI memory descriptor is invalid. (esrt: %p max: %p)\n",
 		       (void *)efi.esrt, (void *)max);
@@ -333,7 +378,7 @@ void __init efi_esrt_init(void)
 
 	end = esrt_data + size;
 	pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, &end);
-	if (md.type == EFI_BOOT_SERVICES_DATA)
+	if (type == EFI_BOOT_SERVICES_DATA)
 		efi_mem_reserve(esrt_data, esrt_data_size);
 
 	pr_debug("esrt-init: loaded.\n");
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
