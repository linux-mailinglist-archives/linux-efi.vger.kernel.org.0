Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4883070531B
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjEPQHM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 12:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbjEPQHK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 12:07:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962F37EEB;
        Tue, 16 May 2023 09:07:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 224F163BEE;
        Tue, 16 May 2023 16:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D8CC433A8;
        Tue, 16 May 2023 16:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253224;
        bh=zqB0t4DDPA88DPl56qCnn/B7aGxFkn0Y+6dWVn1tZq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uzED3MDYa+zRvydDUY5COe4o/Xb/voIkyoht5i0bOCAOtFsxgd+3vIaWBOhp5PLz8
         lMAX24iP0+kK2gm5TkYh1XFkeEqEvltopbJX/w1yHYPBS78PCGiOuMF63PFQ8UB7dy
         D/DffvS8p+49Qp9LYljB6QqoSQN0x8uHRu/bfTUofH9RLq8ayT60FCQf/l3Ro7YS5F
         G3wnwfaB9v7fTBXvfg5qE7XPBVfEGxuXVMsN8VZ9oHu+yJcK3pHJYJgtxmkpHaxihF
         OpbIs/t+R8s40SHXc2Wusw71dWT2zcff8hVIESQPVIGmb4qdMTrq4fDxJkl6nP/eGq
         Z/ozEBwlC7dTQ==
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
Subject: [PATCH 02/15] arm64: add scs_patch_vmlinux prototype
Date:   Tue, 16 May 2023 18:06:29 +0200
Message-Id: <20230516160642.523862-3-arnd@kernel.org>
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

scs_patch_vmlinux() is only called from assembler code, so there
is no prototype, but adding one avoids this warning:

arch/arm64/kernel/patch-scs.c:254:24: error: no previous prototype for function 'scs_patch_vmlinux' [-Werror,-Wmissing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/scs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
index 13df982a0808..3fdae5fe3142 100644
--- a/arch/arm64/include/asm/scs.h
+++ b/arch/arm64/include/asm/scs.h
@@ -73,6 +73,7 @@ static inline void dynamic_scs_init(void) {}
 #endif
 
 int scs_patch(const u8 eh_frame[], int size);
+asmlinkage void scs_patch_vmlinux(void);
 
 #endif /* __ASSEMBLY __ */
 
-- 
2.39.2

