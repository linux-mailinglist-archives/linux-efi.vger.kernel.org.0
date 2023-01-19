Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA95E67422C
	for <lists+linux-efi@lfdr.de>; Thu, 19 Jan 2023 20:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjASTG0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Jan 2023 14:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjASTGC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Jan 2023 14:06:02 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914539AA9A;
        Thu, 19 Jan 2023 11:05:13 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5AC755C012C;
        Thu, 19 Jan 2023 14:04:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 19 Jan 2023 14:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674155064; x=1674241464; bh=8PYQybIKzM
        nd5SaK8XAMo1/w4rYl0IXWtI6aXKByBc0=; b=qi7cBv5E9SIfaud39/XzKFXIxD
        5nPPEFnNFTBw7jL7O16ZBFmVHhmhhd8boL2ZbeWGOB4LmkaIgNG8BUs/Q9sSmTp3
        4lJu7bOw19nmmHrAm+/qaO2M1qjeP9AWuVBPniwpeFAtgkgprTqsgmL3Bl8zdBZ3
        GVMWPkSjy9nCXrEUiXu1igMZLomlw4SqAeJqdXjK99boz3GWqcfgTZSat7txJwRJ
        U1jmP1pp8yikBTqkfRpTkqxD372hvpmUM8fTD99wBB9QD5dz4fViyRC8yTHqoLMJ
        x9RIbmtClFTKUeo6wYe1gKPz/cMAXi9AenQgkYYMBIl4MS7RnYKjkQcJbTaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674155064; x=
        1674241464; bh=8PYQybIKzMnd5SaK8XAMo1/w4rYl0IXWtI6aXKByBc0=; b=C
        sKXlpUlQAbhoM2+EutaCiLm/EGDsPb83Z41Y+tYAFg8Zk+cr3SHKe9elKRKcjVol
        E3lUjsbD/trhTbqTh6mzduGHGx8XVc3lgqIgT6QRra2xr/k0Mu8xoFNQshL4j2Ek
        ajLpvfQn4WIZkZBULzSTJsL8rS02hY/dqndJyc5Fj64HgHBBHvo/fIQzIMS+nKap
        oK3q39R/B6iMzfps7gySEySpQc2raAceEPniAnP90k1S5n5bATreSgFvaud7h7lb
        wSsLWuZRRJRURssuaj1S0xwC1dEu9iGGfMb1iYRE8wHPZ3UN5QAj/u+QCGOkVdGT
        Uc+fMoMn06Soc0Yv50hww==
X-ME-Sender: <xms:OJTJYx76B6VkTbca4nXjqT_sINe1INdC0A-J9pJA6IsbYMrbX__kvQ>
    <xme:OJTJY-6Ouk4pivadRM5qniYeS6QKY2wUwkEC7FkEiLpe8Te2o2WLori-wDo3rf76M
    ZMkZbapXWif_fA>
X-ME-Received: <xmr:OJTJY4cHoUBh9lF-f7f5j_xnAbPNLvSLfEzl5UnwWrmLSzIk5jjThWrr16eQlvicK7hm1o5UGNmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddutddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepffgv
    mhhiucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhih
    hnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepledukeelleejkeevkeefgefh
    ffegvdeigeelieegjefffeeiveeivdejgeevteeinecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhn
    ghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:OJTJY6Lqqng0V_GCGRqhiHnMlmlfWcCIPnynGmLW4NZSQqlUHJ-lZQ>
    <xmx:OJTJY1I3L_UtAFcGl2xCcfmgNRboA5LJyWvFePANCcWVyUVUsWuodg>
    <xmx:OJTJYzzWTG1MpFvdI66o5Aoy2HRTCwjPkIajNW8Bgm7QmYLHRzV0EA>
    <xmx:OJTJY8UcF5g9uzUIflLPPlciWo1BwsR7o1Zrlk0pTw04uGcN6S20lA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jan 2023 14:04:23 -0500 (EST)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] efi: memmap: Disregard bogus entries instead of returning them
Date:   Thu, 19 Jan 2023 14:03:56 -0500
Message-Id: <b18879e0329c785d35f2aa2164413bb56419c684.1669264419.git.demi@invisiblethingslab.com>
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

The ESRT code currently contains two consistency checks on the memory
descriptor it obtains, but one of them is both incomplete and can only
trigger on invalid descriptors.

So let's drop these checks, and instead disregard descriptors entirely
if the start address is misaligned, or if the number of pages reaches
to or beyond the end of the address space.  Note that the memory map as
a whole could still be inconsistent: multiple entries might cover the
same area, or the address could be outside of the addressable PA space,
but validating that goes beyond the scope of these helpers.  Also note
that since the physical address space is never 64-bits wide, a
descriptor that includes the last page of memory is not valid.  This is
fortunate, since it means that a valid physical address will never be an
error pointer and that the length of a memory descriptor in bytes will
fit in a 64-bit unsigned integer.

Co-developed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 drivers/firmware/efi/efi.c  | 6 ++++++
 drivers/firmware/efi/esrt.c | 9 +--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index a06decee51e064d78a39752436487279d0660609..780caea594e0ffce30abb69bddcccf3bacf25382 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -474,6 +474,12 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
 		u64 size;
 		u64 end;
 
+		/* skip bogus entries (including empty ones) */
+		if ((md->phys_addr & (EFI_PAGE_SIZE - 1)) ||
+		    (md->num_pages <= 0) ||
+		    (md->num_pages > (U64_MAX - md->phys_addr) >> EFI_PAGE_SHIFT))
+			continue;
+
 		size = md->num_pages << EFI_PAGE_SHIFT;
 		end = md->phys_addr + size;
 		if (phys_addr >= md->phys_addr && phys_addr < end) {
diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index 2a2f52b017e736dd995c69e8aeb5fbd7761732e5..fb9fb70e1004132eff50c712c6fca05f7aeb1d57 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -263,15 +263,8 @@ void __init efi_esrt_init(void)
 		return;
 	}
 
-	max = efi_mem_desc_end(&md);
-	if (max < efi.esrt) {
-		pr_err("EFI memory descriptor is invalid. (esrt: %p max: %p)\n",
-		       (void *)efi.esrt, (void *)max);
-		return;
-	}
-
+	max = efi_mem_desc_end(&md) - efi.esrt;
 	size = sizeof(*esrt);
-	max -= efi.esrt;
 
 	if (max < size) {
 		pr_err("ESRT header doesn't fit on single memory map entry. (size: %zu max: %zu)\n",
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
