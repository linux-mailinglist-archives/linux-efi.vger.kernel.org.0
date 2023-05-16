Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE78705334
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 18:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjEPQIc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 12:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbjEPQIL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 12:08:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C873155A6;
        Tue, 16 May 2023 09:07:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7F6F63BE7;
        Tue, 16 May 2023 16:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D877C433A0;
        Tue, 16 May 2023 16:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253269;
        bh=Y/kX7yQ/rkwRjov2P3rhuT9nIb3QQo194N1K1FzHQ6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kedr1NLZ1ZCY3DnJ3dxsFdY2+W0MGAEccULvE8FY4jEGNx4HDKeKuxc30G+7uwvGG
         wnR08MvLRzsPA6WRL6GJ0wMktvpTzlCKA5U8saVsLDduqGtGn73O8BGC6cCL7cTtAK
         y2nSsbvJ0q3eApquSZ48lZ1cFWbf+9f6yoU3LdVg5SGh/i69qU6ERcAkYREvNBs+UM
         7FTNfy+nxps2IK2AiA9mOB7PmxIURaByQc/jRTu6mObtnO/GmCxIHXJSN5QwQm1UYw
         0rMj30nsVdVXqSMEGdSfgXQ+LpxWk1ELY65Z/C5yKtHpe4zdTtoW/uFhpscPMo7Kwk
         QU7MnvrwgYS6A==
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
Subject: [PATCH 13/15] arm64: signal: include asm/exception.h
Date:   Tue, 16 May 2023 18:06:40 +0200
Message-Id: <20230516160642.523862-14-arnd@kernel.org>
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

The do_notify_resume() is in a header that is not included
for the definition, which causes a W=1 warning:

arch/arm64/kernel/signal.c:1280:6: error: no previous prototype for 'do_notify_resume' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 2cfc810d0a5b..3457906ba117 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -23,6 +23,7 @@
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/elf.h>
+#include <asm/exception.h>
 #include <asm/cacheflush.h>
 #include <asm/ucontext.h>
 #include <asm/unistd.h>
-- 
2.39.2

