Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC7B4FB859
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbiDKJwZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344731AbiDKJv5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDA34132A
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1A4061179
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28460C385A3;
        Mon, 11 Apr 2022 09:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670549;
        bh=F3be8Bl2OWrM+QxnbwAWqaDIE8d9sl2JmSobwHloz2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G819WruuA9Y9oawya7YT7CWi7+BAX/8v2AuMI/JlC7oVvqE2pgJe4N9Bn9x+6S6/K
         wQ772tpK6gTTLpJRik5Cjf0wJ+mjcvuL2HgUSMEiyuVPEm3NIHyp56MojF8waPAZo+
         VYXpMco1y9857aUZkZaFXuDBjq64Cj0RJHE3bmyeLGCFhJLgFcJydr4yC5FLumkLAI
         Vw2X+FGUIAaPF52NY0qSz5KYFg0jCQePAsppi775B3O33IxRrQHF9Jyj7a9EAtj6GY
         ziMOsjDo/tGbbVjBrKxBpRi0aA9Af5TBLtVXQFgXfreWmXkBK5vm1Nky/GiAiV/4XB
         HNMY2wx6k62+Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 11/30] arm64: head: add helper function to remap regions in early page tables
Date:   Mon, 11 Apr 2022 11:48:05 +0200
Message-Id: <20220411094824.4176877-12-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2095; h=from:subject; bh=F3be8Bl2OWrM+QxnbwAWqaDIE8d9sl2JmSobwHloz2Q=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lHRuF5psCGBCvTqubIc33ylcXyPLqTFqMroy5z 4YTK4gSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5RwAKCRDDTyI5ktmPJB5YC/ oClu5IeEtRKbfo2BZ7Cy8kmZ9lseFgFG36j3po4xZgFIcueDxqY46svaMfrSYeV/mgBiBkc9sNfklC L7daOcb4W1XFe5O4PEPPaVod1IsQZuDZv5OHzCITmzGIMBKdVcCW8tInJUA7NJH7PkbdOKETg6IDuh BxnYnbA1YiBLvlwYbMmPfnhaeYnCeKkJOc7Slw6cEAGJbPHPWOHlbEWr3GebsEIkbrHjO0HeA1i+bZ HsBrvX2RQRBH1yhgnY+9mhQOIqyFLPeK8roKWNx+hHU7O+K2hwjTvZuSbos9AdIgqGTVlVDQxzHqgl A3ngODVoIqWls3AsM11D56no16yOTYYQSvt6x7xOEKoGrSeHXM9YSJLstnAO1JI3ZFJqf4CV8rIBCE c7reuUXNYjRBK+OxQJOSi/4imPYv4SOtlL46Pv1SYfLv0t1z6IlXh73NYkXh/T1u8pDv7NivhO/BQ1 Qxj+RP4HN4rfdWBTYYOq1EQr7nk9S65cnO4d5xS3v9Pyw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The asm macros used to create the initial ID map and kernel mappings
don't support randomly remapping parts of the address space after it has
been populated. What we can do, however, given that all block or page
mappings are created at the final level, is take a subset of the mapped
range and update its attributes or output address. This will permit us
to make parts of these page tables read-only, or remap a part of it to
cover the device tree.

So add a helper that encapsulates this.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 70c462bbd6bf..6fc8f7f88a1a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -263,6 +263,37 @@ SYM_FUNC_END(clear_page_tables)
 	populate_entries \tbl, \rtbl, \istart, \iend, \flags, #SWAPPER_BLOCK_SIZE, \tmp
 	.endm
 
+/*
+ * Remap a subregion created with the map_memory macro with modified attributes
+ * or output address. The entire remapped region must have been covered in the
+ * invocation of map_memory.
+ *
+ * x0: last level table address (returned in first argument to map_memory)
+ * x1: start VA of the existing mapping
+ * x2: start VA of the region to update
+ * x3: end VA of the region to update (inclusive)
+ * x4: start PA associated with the region to update
+ * x5: attributes to set on the updated region
+ * x6: order of the last level mappings
+ */
+SYM_FUNC_START_LOCAL(remap_region)
+	// Get the index offset for the start of the last level table
+	lsr	x1, x1, x6
+	bfc	x1, #0, #PAGE_SHIFT - 3
+
+	// Derive the start and end indexes into the last level table
+	// associated with the provided region
+	lsr	x2, x2, x6
+	lsr	x3, x3, x6
+	sub	x2, x2, x1
+	sub	x3, x3, x1
+
+	mov	x1, #1
+	lsl	x6, x1, x6		// block size at this level
+
+	populate_entries x0, x4, x2, x3, x5, x6, x7
+	ret
+SYM_FUNC_END(remap_region)
 
 SYM_FUNC_START_LOCAL(create_idmap)
 	adrp	x0, idmap_pg_dir
-- 
2.30.2

