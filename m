Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07E1705332
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 18:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjEPQIW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 12:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbjEPQIH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 12:08:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D55E7D81;
        Tue, 16 May 2023 09:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8829963982;
        Tue, 16 May 2023 16:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642E1C433A4;
        Tue, 16 May 2023 16:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253261;
        bh=lwbLM2icgKpKkO4IGpq+gV4Vi+dLkvFByZ0s3dmZn0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSLAJY0XnTiAmwVYnoGliY56cU9hQUxkW1tpiwPg1o/KG+Ngq2c5opKIk1AwXn5PO
         EXSt3oKxIS11dOgqD63RM5eXBSolsLG5TMso+ML8PCd8Z9uSVUiU1Ps/wdCZ8859ed
         ffqli+mKUmIU6urapJTAphhh9cf3uNVLRrBBszc44njQamfjh1yy2pctXivlpTKAtC
         1GqekmzV0bvS1EIYVM/xbwu79KXIbE11b533TA9NecaXU2zBP5o3CuozK/GfVXtKFq
         MgjQSifqruIhKMqr8Bf7VrhZwb7kaOv01ziNOGBOopYI0Pi2IRHL87S9jRlBHN5lry
         zQCSON3Js6jiA==
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
Subject: [PATCH 11/15] arm64: flush: include linux/libnvdimm.h
Date:   Tue, 16 May 2023 18:06:38 +0200
Message-Id: <20230516160642.523862-12-arnd@kernel.org>
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

The two cache management functions are declared in libnvdimm.h
but provided by architecture specific code. Without including
the header, this causes a W=1 warning:

arch/arm64/mm/flush.c:96:6: error: no previous prototype for 'arch_wb_cache_pmem' [-Werror=missing-prototypes]
arch/arm64/mm/flush.c:104:6: error: no previous prototype for 'arch_invalidate_pmem' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/mm/flush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 5f9379b3c8c8..4e6476094952 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -8,6 +8,7 @@
 
 #include <linux/export.h>
 #include <linux/mm.h>
+#include <linux/libnvdimm.h>
 #include <linux/pagemap.h>
 
 #include <asm/cacheflush.h>
-- 
2.39.2

