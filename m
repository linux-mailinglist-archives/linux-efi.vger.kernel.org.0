Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79368674230
	for <lists+linux-efi@lfdr.de>; Thu, 19 Jan 2023 20:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjASTGd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Jan 2023 14:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjASTGG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Jan 2023 14:06:06 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BF194326;
        Thu, 19 Jan 2023 11:05:27 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B288E5C00D8;
        Thu, 19 Jan 2023 14:04:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 19 Jan 2023 14:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674155066; x=1674241466; bh=JNxIP18FJG
        MNUYBP65b84d6ync2Tzl5LK9xIO36ews4=; b=V9s7TGR9vSl2qHXadvBQ5jANqT
        YsH5gcQlEJ4qUFFblcTOwTDCkjYBGMTnhzWrvyP4wUxzF9P6ReX071u7Zb48fNln
        9F+erC7wwWxgelTnZ45UxgcZXeIT+nRxk0JHttjDPwkpt3l5oqb7nbPi3WYNE/1F
        yFd76iqa2KtykXVk3IhbB08edyNj7SA1wavzMY3Kwckjvzo+dCdCsMYrcRETWzWE
        cSw+wqGejNlAcusrsPK1S1xXsN3HhKiXHa7JGxPmHDyruZJibrhV/bXcPk1vUcRe
        IJcBMsAFnb/w50ABar0rBJv0QFRh4M012F+pACaYSzQi9qNQClxGy7Y0pYFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674155066; x=
        1674241466; bh=JNxIP18FJGMNUYBP65b84d6ync2Tzl5LK9xIO36ews4=; b=J
        yFsovdtn/rPqbJClnCW1NgOy8ebOXt8SCkihjpMPPf9x7G9ZOQk+5xgZw8Ebed32
        nzn2Izk8PB9HN0hf4zwIiqi3L8W2cRDiYfye1ed8QadLqMbq4eIXkFg+GUJu2DCH
        Sy9IDdfOM3FgggnNEIOfoe9xdvEEGhcV2ATpZD4y/L/sWF7PYfOeiVohtYaCXR+H
        Kjm/7xuK3iAe1xGkjKdkqx2O3FkokQw//hA7Q2breO9MP4A8rzxTbopzdY/7GGB2
        B/WRxIk2PnP2Q6kaDkwhGeeyEfXf0cZAxobx/IfCGbQeZcd4ws8JRirIv8xHkMXi
        NWWMcKT0h8WiQfokCsQvQ==
X-ME-Sender: <xms:OpTJYz5DUUpMrz1Dur0MLyDT7uTJawS8WOL6m-vcG-RiIiYAsN-QLg>
    <xme:OpTJY45xIbDMttCiDuEBGEK2fjnPzOaInVP4TWcbUqxjyJO3-hCa-BzQ40ItovfrP
    zJUXnLoqKScpqs>
X-ME-Received: <xmr:OpTJY6dFi9QhhR-44F7nQFulDsjlpbg6vVy7IQNKk9oB4kGJL26iqdEdfLrPPTbwdNOOHIwpG7BX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddutddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepffgv
    mhhiucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhih
    hnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepledukeelleejkeevkeefgefh
    ffegvdeigeelieegjefffeeiveeivdejgeevteeinecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhn
    ghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:OpTJY0IeuOz5X_yZJp5w-lcaawIxfTKO7JmMMJmyeR55YjylT27NFQ>
    <xmx:OpTJY3Lyr5JflduQ8P-HoNIqNk7HEfTG7s9A6i3HPN5wLO3OKCcnGQ>
    <xmx:OpTJY9xCu2ZAZkumpUAKi3ghISqHIYYf3GLWM6DegJlVrTloAbCyzA>
    <xmx:OpTJY__zreQyAQfy1-bsR7NGxJqlrTH4k20OEKYvOGQNYBWgRLtcSA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jan 2023 14:04:25 -0500 (EST)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v3 2/5] efi: xen: Implement memory descriptor lookup based on hypercall
Date:   Thu, 19 Jan 2023 14:03:57 -0500
Message-Id: <cca4ad8a7d034e207bf1cb1f0571c6491eae9faf.1669264419.git.demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <b18879e0329c785d35f2aa2164413bb56419c684.1674153153.git.demi@invisiblethingslab.com>
References: <b18879e0329c785d35f2aa2164413bb56419c684.1674153153.git.demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Xen on x86 boots dom0 in EFI mode but without providing a memory map.
This means that some consistency checks we would like to perform on
configuration tables or other data structures in memory are not
currently possible.  Xen does, however, expose EFI memory descriptor
info via a Xen hypercall, so let's wire that up instead.  It turns out
that the returned information is not identical to what Linux's
efi_mem_desc_lookup would return: the address returned is the address
passed to the hypercall, and the size returned is the number of bytes
remaining in the configuration table.  However, none of the callers of
efi_mem_desc_lookup() currently care about this.  In the future, Xen may
gain a hypercall that returns the actual start address, which can be
used instead.

Co-developed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 drivers/firmware/efi/efi.c |  5 ++++-
 drivers/xen/efi.c          | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/efi.h        |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 780caea594e0ffce30abb69bddcccf3bacf25382..bcb848e44e7b1350b10b7c0479c0b38d980fe37d 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -456,7 +456,7 @@ void __init efi_find_mirror(void)
  * and if so, populate the supplied memory descriptor with the appropriate
  * data.
  */
-int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
+int __efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
 {
 	efi_memory_desc_t *md;
 
@@ -490,6 +490,9 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
 	return -ENOENT;
 }
 
+extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
+	__weak __alias(__efi_mem_desc_lookup);
+
 /*
  * Calculate the highest address of an efi memory descriptor.
  */
diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
index d1ff2186ebb48a7c0981ecb6d4afcbbb25ffcea0..3c792353b7308f9c2bf0a888eda9f827aa9177f8 100644
--- a/drivers/xen/efi.c
+++ b/drivers/xen/efi.c
@@ -26,6 +26,7 @@
 
 #include <xen/interface/xen.h>
 #include <xen/interface/platform.h>
+#include <xen/page.h>
 #include <xen/xen.h>
 #include <xen/xen-ops.h>
 
@@ -292,3 +293,38 @@ void __init xen_efi_runtime_setup(void)
 	efi.get_next_high_mono_count	= xen_efi_get_next_high_mono_count;
 	efi.reset_system		= xen_efi_reset_system;
 }
+
+int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
+{
+	static_assert(XEN_PAGE_SHIFT == EFI_PAGE_SHIFT,
+	              "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHIFT");
+	struct xen_platform_op op;
+	union xenpf_efi_info *info = &op.u.firmware_info.u.efi_info;
+	int rc;
+
+	if (!efi_enabled(EFI_PARAVIRT) || efi_enabled(EFI_MEMMAP))
+		return __efi_mem_desc_lookup(phys_addr, out_md);
+	phys_addr &= ~(u64)(EFI_PAGE_SIZE - 1);
+	op = (struct xen_platform_op) {
+		.cmd = XENPF_firmware_info,
+		.u.firmware_info = {
+			.type = XEN_FW_EFI_INFO,
+			.index = XEN_FW_EFI_MEM_INFO,
+			.u.efi_info.mem.addr = phys_addr,
+			.u.efi_info.mem.size = U64_MAX - phys_addr,
+		},
+	};
+
+	rc = HYPERVISOR_platform_op(&op);
+	if (rc) {
+		pr_warn("Failed to lookup header 0x%llx in Xen memory map: error %d\n",
+		        phys_addr, rc);
+	}
+
+	out_md->phys_addr	= info->mem.addr;
+	out_md->num_pages	= info->mem.size >> EFI_PAGE_SHIFT;
+	out_md->type    	= info->mem.type;
+	out_md->attribute	= info->mem.attr;
+
+	return 0;
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index f87b2f5db9f83db6f7488648fe99a8f8fc4fdf04..b407a302b730a6cc7481afa0f582360e59faf1e0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -724,6 +724,7 @@ extern u64 efi_mem_attribute (unsigned long phys_addr, unsigned long size);
 extern int __init efi_uart_console_only (void);
 extern u64 efi_mem_desc_end(efi_memory_desc_t *md);
 extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md);
+extern int __efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md);
 extern void efi_mem_reserve(phys_addr_t addr, u64 size);
 extern int efi_mem_reserve_persistent(phys_addr_t addr, u64 size);
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
