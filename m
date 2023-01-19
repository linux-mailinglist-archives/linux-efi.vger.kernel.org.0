Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA8F674231
	for <lists+linux-efi@lfdr.de>; Thu, 19 Jan 2023 20:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjASTGh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Jan 2023 14:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjASTGH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Jan 2023 14:06:07 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA8766033;
        Thu, 19 Jan 2023 11:05:29 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A24985C0127;
        Thu, 19 Jan 2023 14:04:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 19 Jan 2023 14:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674155068; x=1674241468; bh=iAve/Gqvno
        UrklJx76JsPi9tOXPhkOndFsIm/wBRVc0=; b=B9VLgkfAr/7249QjOT39QtxfRv
        APPspvfWvL6fuDe6zW3+pifMYFXwfEI+IGcd6gUisGfx3fFR6zwpKDMaFcGsDYjd
        E313x+xuAnRGczFIKTKMOChtctBXqmc7KzKo3eKA+re/WmlYCYEzxZMxfdJMugF7
        L6E5Oue7bH6z436+4IafefMY9ZYIdXrm0a0pjGxxf0FPEakxFQctWRIES4eWxWu2
        Yf1bT/5jTCGixgfl+wcrkXCnFrY+jh+29T2rd3PMNmGcXJAPEtDpj/vYpx7p38Kx
        Av4Co/J/ZoABgjw6cChO5T5eVpQcHljE6yFPj5cg52HtU5FY7DpLpMkBhwug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674155068; x=
        1674241468; bh=iAve/GqvnoUrklJx76JsPi9tOXPhkOndFsIm/wBRVc0=; b=Z
        udXHlylSgOZXsETO57hjNC/qoXFauOzCK1dNKjA2XSqYPrBllsHZT6ntMGWz2V8u
        BelrZMZiHOMJQ0s3hJEJLbFbg+ykRhWquY4QvBAisG5ELnH/6GAlzN7+u2BVTbjR
        FbQLjKCRdbVKbpASVWSl/TuT2wrbynC0GVo/e2T6+3ochP6KfXKvdw834ANEN9Xq
        wCuAdFe0k7K1XJVZSm6u9yL9wmGhdEj6s7F4PIkR3tc3qMjyZFxzQckvE2JnmyCM
        P7CYrNEsfzLupOPL+ruGD75A8cP8an4BLDTbCfW7i70MXTQ03Q7sxs/OCKAcrkPE
        yMSHDZ9+TMNlllnRUou0g==
X-ME-Sender: <xms:PJTJY_zuzXYRodxycES-1yHCoQVY_E-n56Ft67-UXy6yk7-4piKsaA>
    <xme:PJTJY3RFq7qLgmAgHECoOEaGwjpJBfDw_SbU9rNm24aRQ6dZ69wOZYuKP_xdQZkaE
    rrL9IpbHdjQruQ>
X-ME-Received: <xmr:PJTJY5Uio_FtDb9GTvtKgmylTuWFjOJiaCwVVMgFuKmUM1usPVb3MqzeMdVuYzlbrwsLhRLqk_uT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddutddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepffgv
    mhhiucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhih
    hnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepledukeelleejkeevkeefgefh
    ffegvdeigeelieegjefffeeiveeivdejgeevteeinecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhn
    ghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:PJTJY5gDx88SFiFrhr4xC9pF-OoySYrpDeD9-o3p2ucJHNZP1FjgrA>
    <xmx:PJTJYxDcWqEH881XZ1H_C2JAhcqVC1tNqsaXSkFyN3L019FCxApJ1A>
    <xmx:PJTJYyKvDJWKAQEoQYNWHJOx-6BqdbdWtwsDzUG8FiRHYpwbEaJ8bQ>
    <xmx:PJTJYz0LxTt6btYPWmix9P1j-8Yckpu9atABFe-bV4wfbMe21L12wA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jan 2023 14:04:27 -0500 (EST)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v3 4/5] efi: Actually enable the ESRT under Xen
Date:   Thu, 19 Jan 2023 14:03:59 -0500
Message-Id: <26938d59bb398bea7e8f43d03a9c75189fa3b4cc.1669264419.git.demi@invisiblethingslab.com>
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

The ESRT can be parsed if EFI_PARAVIRT is enabled, even if EFI_MEMMAP is
not.  Also allow the ESRT to be in reclaimable memory, as that is where
future Xen versions will put it.

Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 drivers/firmware/efi/esrt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index fb9fb70e1004132eff50c712c6fca05f7aeb1d57..87729c365be1a804bb84e0b1ab874042848327b4 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -247,7 +247,7 @@ void __init efi_esrt_init(void)
 	int rc;
 	phys_addr_t end;
 
-	if (!efi_enabled(EFI_MEMMAP))
+	if (!efi_enabled(EFI_MEMMAP) && !efi_enabled(EFI_PARAVIRT))
 		return;
 
 	pr_debug("esrt-init: loading.\n");
@@ -258,7 +258,9 @@ void __init efi_esrt_init(void)
 	if (rc < 0 ||
 	    (!(md.attribute & EFI_MEMORY_RUNTIME) &&
 	     md.type != EFI_BOOT_SERVICES_DATA &&
-	     md.type != EFI_RUNTIME_SERVICES_DATA)) {
+	     md.type != EFI_RUNTIME_SERVICES_DATA &&
+	     md.type != EFI_ACPI_RECLAIM_MEMORY &&
+	     md.type != EFI_ACPI_MEMORY_NVS)) {
 		pr_warn("ESRT header is not in the memory map.\n");
 		return;
 	}
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
