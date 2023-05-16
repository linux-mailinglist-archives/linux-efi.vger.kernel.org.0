Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0ED70532E
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjEPQIK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 12:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbjEPQIA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 12:08:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055E09034;
        Tue, 16 May 2023 09:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7417063BF6;
        Tue, 16 May 2023 16:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43964C433A0;
        Tue, 16 May 2023 16:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253252;
        bh=WPczk00OnpL1jBgj+JlXAzNsUnny+CNOuArcW/QKCBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVh/kACFXxSUhb2GvaZfJcYCsV1OAcUsDa98Md9OyqxoBN+DV6mSHnef4tb8cixO2
         gctazSfuTB4U8OHHKFglnRncd2qHo7IKswAfvrilK3P8jow5hWJwoRev7xYNuzQ3AS
         ZVmT+yj39izt3BQcn/afpHMkoaz90Jgdg0SB2WK5U7FDNaKIcGwoYYbIG11X9c2MfF
         nQ+0QxwCWv0yg39Imc0JuzbkEXe9NZrud6M2QpVT0w14kMd3JteIQs+wjspdKbwQ0O
         jECfT/apdnuJVxrW+H9HlclqHlvGQj1KNdHnCQcMNeTQm55JmNsoGR686m4AEbv0zY
         kP31/f3NcVtfA==
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
Subject: [PATCH 09/15] arm64: hide unused is_valid_bugaddr()
Date:   Tue, 16 May 2023 18:06:36 +0200
Message-Id: <20230516160642.523862-10-arnd@kernel.org>
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

When generic BUG() support is disabled, this function has no declaration
and no callers but causes a W=1 warning:

arch/arm64/kernel/traps.c:950:5: error: no previous prototype for 'is_valid_bugaddr' [-Werror=missing-prototypes]

Add an #ifdef that matches the one around the declaration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/traps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 98898c3108b8..3f5a21e5968e 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -946,7 +946,7 @@ void do_serror(struct pt_regs *regs, unsigned long esr)
 }
 
 /* GENERIC_BUG traps */
-
+#ifdef CONFIG_GENERIC_BUG
 int is_valid_bugaddr(unsigned long addr)
 {
 	/*
@@ -958,6 +958,7 @@ int is_valid_bugaddr(unsigned long addr)
 	 */
 	return 1;
 }
+#endif
 
 static int bug_handler(struct pt_regs *regs, unsigned long esr)
 {
-- 
2.39.2

