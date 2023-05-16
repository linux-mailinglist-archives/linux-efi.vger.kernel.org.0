Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8BC705330
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjEPQIN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 12:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjEPQIF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 12:08:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E96A5D1;
        Tue, 16 May 2023 09:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A27263BED;
        Tue, 16 May 2023 16:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5741CC4339E;
        Tue, 16 May 2023 16:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253256;
        bh=lW1KqzMPkO/9T0wNrsyzNB3eSEl+jR1P98K2oHwWTq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwY9shC03I2AynWTfn1puaMzrCGSX7be430QTqTWOKNohXLe5ggwr6JHKP7O2nN2g
         qiCEnugST0BGF47rkojJaxUkfdfPRlQ5mzv0KZhIq12lRPSVrtupbwbmVGHWpWYJrb
         ehiZYCgqEpEQiAqr6EKwDxql8aysv8TeanMehyUnvUsth2z8fch/JYXJBEtTolk2+N
         /GfwGQgP6o8mmjMavYp8tWYirmjyFfcePqV7bxvJO24FpXMEXW/MsfU3KWMBSM+7yT
         X4lPBPJhmkn0fpqSaq/30tF6ssHl4K81bUEbNDAeq8lbENAQvVi5pBVJMGofVDJPfr
         c6BeSkW9umwiA==
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
Subject: [PATCH 10/15] arm64: module-plts: inline linux/moduleloader.h
Date:   Tue, 16 May 2023 18:06:37 +0200
Message-Id: <20230516160642.523862-11-arnd@kernel.org>
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

module_frob_arch_sections() is declared in moduleloader.h, but
that is not included before the definition:

arch/arm64/kernel/module-plts.c:286:5: error: no previous prototype for 'module_frob_arch_sections' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/module-plts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 543493bf924d..ad02058756b5 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -7,6 +7,7 @@
 #include <linux/ftrace.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <linux/sort.h>
 
 static struct plt_entry __get_adrp_add_pair(u64 dst, u64 pc,
-- 
2.39.2

