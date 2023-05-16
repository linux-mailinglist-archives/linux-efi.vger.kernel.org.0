Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35412705319
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 18:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjEPQHH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 12:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbjEPQHG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 12:07:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE2410F9;
        Tue, 16 May 2023 09:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2264B6348B;
        Tue, 16 May 2023 16:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4872C433A0;
        Tue, 16 May 2023 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253220;
        bh=NC9c7fqP4Ldl5noO3dqZXRRUY7FwHRYGfYKS7crbNz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nN2ZEvoeHuT5v3gQyM8Y0tsLhpv5FymSdcC7pt1ui658oXCcdHeSu/ig96qWVAhZJ
         Niis9bBy7BZkkIbvNn+1kAvyJgu+tFLzwmzQN73EU1cHlxr0l3BTDJgALqsExDcvJ8
         mLi/O1O+D+XkKsoV5efSzOfunGL8T4UQrkP5dacnNot23dU9QJ15AnvGtvp/GU/tlV
         sVj5NcaYW9DOjmH83dbY2wPSHQMg3RK7NWfk31GcXiVL+kHil92FJZPK/1SEAccMbV
         ffYjyOu0s8J6V/GjTZR4DMN+SvP+5ToUYP1aXXJeu5fcsfonnGoqPdLRcqlsICeyA+
         pXRcsJbpokefQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, kvmarm@lists.linux.dev
Subject: [PATCH 01/15] arm64: xor-neon: mark xor_arm64_neon_*() static
Date:   Tue, 16 May 2023 18:06:28 +0200
Message-Id: <20230516160642.523862-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516160642.523862-1-arnd@kernel.org>
References: <20230516160642.523862-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The only references to these functions are in the same file, and
there is no prototype, which causes a harmless warning:

arch/arm64/lib/xor-neon.c:13:6: error: no previous prototype for 'xor_arm64_neon_2' [-Werror=missing-prototypes]
arch/arm64/lib/xor-neon.c:40:6: error: no previous prototype for 'xor_arm64_neon_3' [-Werror=missing-prototypes]
arch/arm64/lib/xor-neon.c:76:6: error: no previous prototype for 'xor_arm64_neon_4' [-Werror=missing-prototypes]
arch/arm64/lib/xor-neon.c:121:6: error: no previous prototype for 'xor_arm64_neon_5' [-Werror=missing-prototypes]

Fixes: cc9f8349cb33 ("arm64: crypto: add NEON accelerated XOR implementation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/lib/xor-neon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/lib/xor-neon.c b/arch/arm64/lib/xor-neon.c
index 96b171995d19..f9a53b7f9842 100644
--- a/arch/arm64/lib/xor-neon.c
+++ b/arch/arm64/lib/xor-neon.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <asm/neon-intrinsics.h>
 
-void xor_arm64_neon_2(unsigned long bytes, unsigned long * __restrict p1,
+static void xor_arm64_neon_2(unsigned long bytes, unsigned long * __restrict p1,
 	const unsigned long * __restrict p2)
 {
 	uint64_t *dp1 = (uint64_t *)p1;
@@ -37,7 +37,7 @@ void xor_arm64_neon_2(unsigned long bytes, unsigned long * __restrict p1,
 	} while (--lines > 0);
 }
 
-void xor_arm64_neon_3(unsigned long bytes, unsigned long * __restrict p1,
+static void xor_arm64_neon_3(unsigned long bytes, unsigned long * __restrict p1,
 	const unsigned long * __restrict p2,
 	const unsigned long * __restrict p3)
 {
@@ -73,7 +73,7 @@ void xor_arm64_neon_3(unsigned long bytes, unsigned long * __restrict p1,
 	} while (--lines > 0);
 }
 
-void xor_arm64_neon_4(unsigned long bytes, unsigned long * __restrict p1,
+static void xor_arm64_neon_4(unsigned long bytes, unsigned long * __restrict p1,
 	const unsigned long * __restrict p2,
 	const unsigned long * __restrict p3,
 	const unsigned long * __restrict p4)
@@ -118,7 +118,7 @@ void xor_arm64_neon_4(unsigned long bytes, unsigned long * __restrict p1,
 	} while (--lines > 0);
 }
 
-void xor_arm64_neon_5(unsigned long bytes, unsigned long * __restrict p1,
+static void xor_arm64_neon_5(unsigned long bytes, unsigned long * __restrict p1,
 	const unsigned long * __restrict p2,
 	const unsigned long * __restrict p3,
 	const unsigned long * __restrict p4,
-- 
2.39.2

