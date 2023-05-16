Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF95C70532B
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 18:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjEPQH4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 12:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjEPQHs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 12:07:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F68EA271;
        Tue, 16 May 2023 09:07:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6144863BE7;
        Tue, 16 May 2023 16:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC90C433A1;
        Tue, 16 May 2023 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253248;
        bh=sgkiqqqqA8+9eb3Dgel5ketA1Ml0WAGFOlqXJkNUjw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7wApvnm4Y80nrgtT6TInyxuw6OxnXJUv1/2O2vn1woz7HNAJXOYYApw7kNNsH9yQ
         Zt3sf3N2/vjQHZpO1OddhDW41LmD8mGdLwXNui0WLbEfJL0PHHFipo9tDTuy0nxLUr
         NrPvMTL7WVBX3o9roK7/baG4LKv5EYd1ZrxbNAwBgEslON/WIUWXhneHvQMZ0+tEfQ
         bC5lfIsMuwVzS/Vj8aq7XPOlabHuVyl5gI1hz+e4OWv+aoPddnZkOLzFsKl3s8nP54
         ZIZ1pLG4d/DrxUTAtgVLEpAoynRpx5TOFLmsj9LlHJVFS0TVV2AOw0fw73vYqkDDzB
         hbb1GBpxuRd4g==
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
Subject: [PATCH 08/15] arm64: efi: add efi_handle_corrupted_x18 prototype
Date:   Tue, 16 May 2023 18:06:35 +0200
Message-Id: <20230516160642.523862-9-arnd@kernel.org>
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

This functions is only called from assembler and lacks a prototype,
which is seen from this W=1 warning:

arch/arm64/kernel/efi.c:155:25: error: no previous prototype for 'efi_handle_corrupted_x18' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/efi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index f86b157a5da3..ef46f2daca62 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -166,4 +166,6 @@ static inline void efi_capsule_flush_cache_range(void *addr, int size)
 	dcache_clean_inval_poc((unsigned long)addr, (unsigned long)addr + size);
 }
 
+efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f);
+
 #endif /* _ASM_EFI_H */
-- 
2.39.2

