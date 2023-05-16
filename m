Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586A6705321
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 18:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjEPQHe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 12:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjEPQHb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 12:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D660D1BF2;
        Tue, 16 May 2023 09:07:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E6F3633A4;
        Tue, 16 May 2023 16:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D293C433A0;
        Tue, 16 May 2023 16:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253236;
        bh=EHdgQS3JVDabaHQOJdS0gJKrLl6Cs3hgsTqLxLbiG+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oo9iUFG8feFpl5pKA57H04XS7oaoARqG7b5QnuM5PK3LjaDltlbCaFGctTg81C1a8
         ae5CCSt2RyeXYIHarFcUaPzVzc3ursJ85yCMZig+JC5wUXhs1ZI5+QJbUpvyk5Vcgr
         H6KoGu8XZAXrBmcO4T2+U3WglszuFpKfRp/GLOO6C0V8wg+rbZbhf8W2b84UngLIHI
         Hb2OQJ2+1gIeRDvw7cFwYBm8Q7OH/Jv/U6HF4Yr3og3O8Vi8RLj//f5KEBGOQegLQG
         5iC4CsVI/8lBKbMPJato932wBhCHlHjXynWxW1jIfoQr++1cD1PeMPj6zDcicuEPeX
         c49NXLQd5lv5Q==
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
Subject: [PATCH 05/15] arm64: spectre: provide prototypes for internal functions
Date:   Tue, 16 May 2023 18:06:32 +0200
Message-Id: <20230516160642.523862-6-arnd@kernel.org>
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

The helpers in proton-pack.c are called from assembler and have
no prototype in a header, which causes a W=1 warning:

arch/arm64/kernel/proton-pack.c:568:13: error: no previous prototype for 'spectre_v4_patch_fw_mitigation_enable' [-Werror=missing-prototypes]
arch/arm64/kernel/proton-pack.c:588:13: error: no previous prototype for 'smccc_patch_fw_mitigation_conduit' [-Werror=missing-prototypes]
arch/arm64/kernel/proton-pack.c:1064:14: error: no previous prototype for 'spectre_bhb_patch_loop_mitigation_enable' [-Werror=missing-prototypes]
arch/arm64/kernel/proton-pack.c:1075:14: error: no previous prototype for 'spectre_bhb_patch_fw_mitigation_enabled' [-Werror=missing-prototypes]

Add these to asm/spectre.h, which contains related declarations
already.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/spectre.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index db7b371b367c..9cc501450486 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -100,5 +100,21 @@ bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int sco
 u8 spectre_bhb_loop_affected(int scope);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr);
+
+void spectre_v4_patch_fw_mitigation_enable(struct alt_instr *alt, __le32 *origptr,
+					   __le32 *updptr, int nr_inst);
+void smccc_patch_fw_mitigation_conduit(struct alt_instr *alt, __le32 *origptr,
+				       __le32 *updptr, int nr_inst);
+void spectre_bhb_patch_loop_mitigation_enable(struct alt_instr *alt, __le32 *origptr,
+					      __le32 *updptr, int nr_inst);
+void spectre_bhb_patch_fw_mitigation_enabled(struct alt_instr *alt, __le32 *origptr,
+					     __le32 *updptr, int nr_inst);
+void spectre_bhb_patch_loop_iter(struct alt_instr *alt,
+				 __le32 *origptr, __le32 *updptr, int nr_inst);
+void spectre_bhb_patch_wa3(struct alt_instr *alt,
+			   __le32 *origptr, __le32 *updptr, int nr_inst);
+void spectre_bhb_patch_clearbhb(struct alt_instr *alt,
+				__le32 *origptr, __le32 *updptr, int nr_inst);
+
 #endif	/* __ASSEMBLY__ */
 #endif	/* __ASM_SPECTRE_H */
-- 
2.39.2

