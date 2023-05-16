Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDE3705335
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 18:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjEPQIf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 12:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbjEPQIL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 12:08:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70712869A;
        Tue, 16 May 2023 09:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9466D632E4;
        Tue, 16 May 2023 16:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B98AC4339E;
        Tue, 16 May 2023 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253265;
        bh=UcWVdIx6eUNRqB58lvyqa00FuN14YMlQl7kvQIYp62I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwck9pxebUmJ5elwV8JbBowvzYFpqDcwvO+VjLC6ovtT5Zh8jbQn59jRACTo+f4Y/
         7l0M8zxg2Np+BaiSbNSH14j2nYQP/XRbMAn93yj7xQ3SkvKIuntJt8KoZfrVTT9IU/
         MrUn/2xa8+GbgCJmL4EeOBlFYppKePkdIq+DGQVbhNF9sV3i3DvsgPCXWTSQ3132uP
         U9qPFdkImKIqjVSrHZY9q2gitN64HJoDSwj18p/c6zu6y7Xt91mTG1f26mBIVvC4MW
         BwCIVuj2VVBxhDnJK+je2EjtBEQR6sCFizppprMVkDM36HeKFb3xDDRpH89RmhM2hJ
         Ps4L3KXuhyDNw==
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
Subject: [PATCH 12/15] arm64: kaslr: add kaslr_early_init() declaration
Date:   Tue, 16 May 2023 18:06:39 +0200
Message-Id: <20230516160642.523862-13-arnd@kernel.org>
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

kaslr_early_init() is called from assembler code and does not
need a declaration to work, but adding one anyway shuts up
this W=1 warning:

arch/arm64/kernel/pi/kaslr_early.c:88:16: error: no previous prototype for 'kaslr_early_init' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/archrandom.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
index 2f5f3da34782..b0abc64f86b0 100644
--- a/arch/arm64/include/asm/archrandom.h
+++ b/arch/arm64/include/asm/archrandom.h
@@ -129,4 +129,6 @@ static inline bool __init __early_cpu_has_rndr(void)
 	return (ftr >> ID_AA64ISAR0_EL1_RNDR_SHIFT) & 0xf;
 }
 
+u64 kaslr_early_init(void *fdt);
+
 #endif /* _ASM_ARCHRANDOM_H */
-- 
2.39.2

