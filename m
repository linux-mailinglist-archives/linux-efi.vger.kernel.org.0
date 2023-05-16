Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87192705325
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 18:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjEPQHs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 12:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjEPQHi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 12:07:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142289EFB;
        Tue, 16 May 2023 09:07:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AA3C63BEE;
        Tue, 16 May 2023 16:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C3EC4339E;
        Tue, 16 May 2023 16:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253244;
        bh=WY9mojz+JxIIIHLIpP7M6rnup7jdrKDCKG5lg/lRrUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=miKZNnEOuFMfFKgqtXtnLdXEddmtAYwAiv29ed3jdSODBJwbxl6Fs7ZQDvMgQxO+Y
         etl4RPkmcS1afZZaQZIJOUc18hMC965eJWmtQ4uh6ttAYVTDo9iZRA8yqB8PkTHvws
         tMg23uiRs3ElJMGkxPbWP+ulqME7o0DG1Asyl19PpY5itIhFgIrbl5WSQ20tY1r7jW
         3AwfMxQGO2yJZ9AGYkXJawnRmQ0C6i8lD2CFscr4qr/KFuJovWFDfRVy45wTZiiaXV
         AQhRHUPeewT9p/wWPmtpbto93lum9PE8rGEz/dgz5GCusjmQvUJN/ePhR+H9F2VFV5
         tyamiqLBLrEXg==
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
Subject: [PATCH 07/15] arm64: cpuidle: fix #ifdef for acpi functions
Date:   Tue, 16 May 2023 18:06:34 +0200
Message-Id: <20230516160642.523862-8-arnd@kernel.org>
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

The acpi_processor_ffh_lpi_* functions are defined whenever CONFIG_ACPI
is enabled, but only called and declared when CONFIG_ACPI_PROCESSOR_IDLE
is also enabled. Without that, a W=1 build triggers missing-prototope
warnings, so the #ifdef needs to be adapted:

arch/arm64/kernel/cpuidle.c:60:5: error: no previous prototype for 'acpi_processor_ffh_lpi_probe' [-Werror=missing-prototypes]
arch/arm64/kernel/cpuidle.c:65:15: error: no previous prototype for 'acpi_processor_ffh_lpi_enter' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/cpuidle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index 42e19fff40ee..d1f68599c29f 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -13,7 +13,7 @@
 #include <linux/of_device.h>
 #include <linux/psci.h>
 
-#ifdef CONFIG_ACPI
+#ifdef CONFIG_ACPI_PROCESSOR_IDLE
 
 #include <acpi/processor.h>
 
-- 
2.39.2

