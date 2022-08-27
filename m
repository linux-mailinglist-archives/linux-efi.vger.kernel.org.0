Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B2A5A360C
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 10:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiH0Ijl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiH0Ijk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 04:39:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15791C00D9
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 01:39:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF6E8B80E6F
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C3EC433D7;
        Sat, 27 Aug 2022 08:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661589577;
        bh=JJ62mwQRKOhojwaa2WD+JELwQTszUIIRFMzYE6TT7q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WG13pKz8qHZhdYtiYQAlF/xMtBO136Axd3jClNCDrE1ITrM9o3tLTS9WhIHO0rjJx
         /aal7XELnlXsDYxCKmBa5jAH3eGEqxgJlLAfStf8e07Mel0JcxVOFQh/WxA3c1lVAo
         KElkEx8lqgP1E1PxRCEiJWlmE+YaDTRCajccwY5UaNQWgJL0b5XX4hs17HYQU/Gpxh
         ZEQ9gnI1gfLl6fI+/KJH69HUQkPnSWSQNznwSZDiCnetuP6N3BpZSR/wlEEuWxXhYY
         to9BrJnD7Y1re7Lfzc4y9djkQ2ZvkH1dVGUhF4Xz46xSAt9vDRYNgoEFX6D1mlM+ox
         jK/y7JzzY05iQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 8/9] loongarch: avoid orphan input sections
Date:   Sat, 27 Aug 2022 10:38:49 +0200
Message-Id: <20220827083850.2702465-9-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827083850.2702465-1-ardb@kernel.org>
References: <20220827083850.2702465-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261; i=ardb@kernel.org; h=from:subject; bh=JJ62mwQRKOhojwaa2WD+JELwQTszUIIRFMzYE6TT7q0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCdgY/W0kg4XKg0dra/guhX0FcEV61muFkzdpmVKs mAUwR7GJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwnYGAAKCRDDTyI5ktmPJFa6C/ 9HYuy4CqWxM53SqNFHF+plJs4f/acUcqTQ45qKRPhTxS7mo12bma9v0Zc/hnnqomUHpmay7XzRdYyD BjcjT11dhpDmN/EvvAQvBZcRFbkx3dayppjVFnCqZokxuam/xnYWUzF1tdJoB5x+b3STIj0ci2bsCL tak96eO6KYxx3iczavU2Q+HLjEDNpHTg7DCi9Gm/gJEKi8WyBp8844xHqsyPzOlJhKSSu/pGN2jJJA v5EQ8GyKZ8a0PdgfHd0L33AxwilCA5kVwDnLsdpzoPD1xfudSA7j54QAhNw6fmqTm4bfhEG00qO0as x29Ps3kVBQLG3/2+8s3jxPFv+QPWVFnWQD64IrQOFsdgFQl57anp5BXPuN9mfpeprBvLCstG/VXj5v NLko79AVOVQlipWHAumqEz3EZ6oe6PldGy2GirkHerbftNwTV9h1U0yjQU9S4ozWfnR931l6fYkBDL pNn3RruNecffPip2Io2E7K34+efFFXoxx1R8UJHGW9dbE=
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

Ensure that all input sections are listed explicitly in the linker
script, and issue a warning otherwise. This ensures that the binary
image matches the PE/COFF and other image metadata exactly, which is
important for things like code signing.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/loongarch/Kconfig              | 1 +
 arch/loongarch/kernel/vmlinux.lds.S | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index fca106a8b8af..407502da4335 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -51,6 +51,7 @@ config LOONGARCH
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
+	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_NO_INSTR
 	select BUILDTIME_TABLE_SORT
 	select COMMON_CLK
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index 36d042739f3c..17d33308dfba 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -74,6 +74,8 @@ SECTIONS
 		EXIT_DATA
 	}
 
+	.rela.dyn : { *(.rela.dyn) *(.rela*) }
+
 #ifdef CONFIG_SMP
 	PERCPU_SECTION(1 << CONFIG_L1_CACHE_SHIFT)
 #endif
-- 
2.35.1

