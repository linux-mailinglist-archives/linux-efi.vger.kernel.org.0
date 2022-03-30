Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DCB4EC8AA
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348369AbiC3Poc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348366AbiC3Poc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67B633EAA
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8522C6171D
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82931C34110;
        Wed, 30 Mar 2022 15:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654965;
        bh=1qxefU9ioI70as0lbJZH1S8z3I47C60UFcTZFTnl2os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQpbG6wAf1Y+2TkJ17a2RaeTjcaAX4wQCX1r6fXNxylo6JXzNg6WJDBsOIKvar4YN
         pUd6Y+tdX0piUnFPaPfk96c66dtv3AIBa92r52NKyGCY6kFZ1BAlY65CICgpD3RxEI
         y87O8YJfowgfRmkrxjcqtd6UIpPICRKccTPyyuBYcysdqLoj96/u1Nhr7h62wgm7JC
         z7vWdX2u97+VhYsPj1K2OwSSpJVZHQaG7BEmTMDKo90kNjf6XaY9yoHPm6URnFLQUM
         309q7CCdswN1RtT0Fxx8xNGytye7yKadTx3HdQBQBIYYTNYDof2YNifz9swwghSnG8
         L+Nj6tPaI6RmQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 18/18] arm64: efi/libstub: enter with the MMU on if executing in place
Date:   Wed, 30 Mar 2022 17:42:05 +0200
Message-Id: <20220330154205.2483167-19-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; h=from:subject; bh=1qxefU9ioI70as0lbJZH1S8z3I47C60UFcTZFTnl2os=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHpMFUYaEzHCp/GnbA810DD+iTSzsBU687E/JIft 4fc53xCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6TAAKCRDDTyI5ktmPJMJ1C/ 9Pn0FG6yE49YV29JzIda9LD1UOGYUceCeQm4DrgQolHodl4SFK6Xf3UYSvs/rhNLC2mB1DMHmjxvcf mqkziZrRCEHwOxS6ynhFwg7CsfSjq2Miu9G0EsElHZhZMNWoum7j0WwrrFn7EJFTEWhrJ1rfIyl3Ml wikaxRtD01GpGghHcJNSTZMo/bfQtOt+K0C5zV3PIk1H5orLw97IyAInKwgYQIrQIGTTWiAvvNXDWX R1dhrtJ7hVqkguKaGOZ0PZ5fN7NITPXZHOdn4PHNJq1yWCmtLvfR3My9zNAt+8/ieshKPX+7fYY3e1 T962DvMlHOCX4IRkWESxryuxyX5y8MAF46whdyQ12Jj1IkvlX4RgcS17tC107Tbrl369yO+LAlwIb1 +fV/SM1+pYfjWiY05G3L7yh0nBQHthlVUvdwAZNm9zKIRlKIdDr400yQNIZXVhRCBtfJuJZxokfBua Iw4iNXLGK3aE2nbAn2fUZlyjD2MAAi6jIkXXcBXbI+BnU=
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

If the kernel image has not been moved from the place where it was
loaded by the firmware, just call the kernel entrypoint directly, and
keep the MMU and caches enabled. This removes the need for any cache
invalidation in the entry path.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi-entry.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
index 61a87fa1c305..0da0b373cf32 100644
--- a/arch/arm64/kernel/efi-entry.S
+++ b/arch/arm64/kernel/efi-entry.S
@@ -23,6 +23,10 @@ SYM_CODE_START(efi_enter_kernel)
 	add	x19, x0, x2		// relocated Image entrypoint
 	mov	x20, x1			// DTB address
 
+	adrp	x3, _text		// just call the entrypoint
+	cmp	x0, x3			// directly if the image was
+	b.eq	2f			// not moved around in memory
+
 	/*
 	 * Clean the copied Image to the PoC, and ensure it is not shadowed by
 	 * stale icache entries from before relocation.
-- 
2.30.2

