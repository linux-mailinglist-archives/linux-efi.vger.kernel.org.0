Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AC555E3D1
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiF1Mx7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 08:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346021AbiF1Mx7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 08:53:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 359AB2ED5B;
        Tue, 28 Jun 2022 05:53:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AAFC1758;
        Tue, 28 Jun 2022 05:53:58 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CADB73F5A1;
        Tue, 28 Jun 2022 05:53:56 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 3/4] ACPI: Enable Platform Runtime Mechanism(PRM) support on ARM64
Date:   Tue, 28 Jun 2022 13:53:45 +0100
Message-Id: <20220628125346.693304-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220628125346.693304-1-sudeep.holla@arm.com>
References: <20220628125346.693304-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There is interest to make use of PRM(Platform Runtime Mechanism) even on
ARM64 ACPI platforms. Allow PRM to be enabled on ARM64 platforms. It will
be enabled by default as on x86_64.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1e34f846508f..d08b7408f0a5 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -592,7 +592,7 @@ config X86_PM_TIMER
 
 config ACPI_PRMT
 	bool "Platform Runtime Mechanism Support"
-	depends on EFI && X86_64
+	depends on EFI && (X86_64 || ARM64)
 	default y
 	help
 	  Platform Runtime Mechanism (PRM) is a firmware interface exposing a
-- 
2.37.0

