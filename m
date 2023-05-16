Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1751C70533C
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 18:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjEPQJR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 12:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbjEPQIq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 12:08:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB893A5ED;
        Tue, 16 May 2023 09:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C07D863BF7;
        Tue, 16 May 2023 16:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A42C433A4;
        Tue, 16 May 2023 16:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253277;
        bh=BD0ipDsRhl90CAL+14HC8Lct0XsReJC1pDRKPHzBMaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9U9QQ13YMvuuS3MR4tKUlFVWqrHShPb4YxuV4c9DePCQTYQuOI9FXxxmPVS7D8+J
         AsU/0T96sFcz8/dxoRYlEtc/Hw/hn4/bX0XBR8dNp0G+DXSdKqORbThsY4OyulDyaG
         dWM4BDDe/k+lyVgyOFJUYtYySqOvk9NphJ8PdC5dgyV0qkHPIXBCV9shrATK+OPB8W
         UMmN9syxC8AbMWkt2gEI7nIO0lvMdlD5fnrq00MbFabkq9nbKtO6V2DLsqKvN/yId/
         +/AkrzNCnISp28rRVsnvzJxB2c90G88oG/Xinuca3ToNwts5JQyHeKKDkxiPpMI+bi
         95EtkbG24LWqg==
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
Subject: [PATCH 15/15] arm64: add alt_cb_patch_nops prototype
Date:   Tue, 16 May 2023 18:06:42 +0200
Message-Id: <20230516160642.523862-16-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516160642.523862-1-arnd@kernel.org>
References: <20230516160642.523862-1-arnd@kernel.org>
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

alt_cb_patch_nops() is called through an inline asm macro, so
it does not need a prototype for the caller, but adding it
avoids this W=1 build warning:

arch/arm64/kernel/alternative.c:295:14: error: no previous prototype for 'alt_cb_patch_nops' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/alternative.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index a38b92e11811..55da3fedcfe2 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -31,5 +31,8 @@ void apply_alternatives_module(void *start, size_t length);
 static inline void apply_alternatives_module(void *start, size_t length) { }
 #endif
 
+void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
+		       __le32 *updptr, int nr_inst);
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ALTERNATIVE_H */
-- 
2.39.2

