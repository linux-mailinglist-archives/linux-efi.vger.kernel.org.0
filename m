Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0813955E3D3
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 15:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346046AbiF1MyE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 08:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345212AbiF1MyA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 08:54:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 897DE2F398;
        Tue, 28 Jun 2022 05:53:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FAEB175A;
        Tue, 28 Jun 2022 05:53:59 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 352A53F5A1;
        Tue, 28 Jun 2022 05:53:58 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 4/4] ACPI: Move PRM config option under the main ACPI config
Date:   Tue, 28 Jun 2022 13:53:46 +0100
Message-Id: <20220628125346.693304-5-sudeep.holla@arm.com>
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

Currently PRM(Platform Runtime Mechanism) config option is listed along
with the main ACPI (Advanced Configuration and Power Interface) option
at the same level. On ARM64 platforms unlike x86, ACPI option is listed
at the topmost level of configuration menu. It is rather very confusing
to see PRM option also listed along with ACPI in the topmost level.

Move the same under ACPI config option. No functional change, just changes
the level of visibility of this option under the configuration menu.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/Kconfig | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index d08b7408f0a5..218b5b59df31 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -572,6 +572,21 @@ source "drivers/acpi/pmic/Kconfig"
 config ACPI_VIOT
 	bool
 
+config ACPI_PRMT
+	bool "Platform Runtime Mechanism Support"
+	depends on EFI && (X86_64 || ARM64)
+	default y
+	help
+	  Platform Runtime Mechanism (PRM) is a firmware interface exposing a
+	  set of binary executables that can be called from the AML interpreter
+	  or directly from device drivers.
+
+	  Say Y to enable the AML interpreter to execute the PRM code.
+
+	  While this feature is optional in principle, leaving it out may
+	  substantially increase computational overhead related to the
+	  initialization of some server systems.
+
 endif	# ACPI
 
 config X86_PM_TIMER
@@ -589,18 +604,3 @@ config X86_PM_TIMER
 
 	  You should nearly always say Y here because many modern
 	  systems require this timer.
-
-config ACPI_PRMT
-	bool "Platform Runtime Mechanism Support"
-	depends on EFI && (X86_64 || ARM64)
-	default y
-	help
-	  Platform Runtime Mechanism (PRM) is a firmware interface exposing a
-	  set of binary executables that can be called from the AML interpreter
-	  or directly from device drivers.
-
-	  Say Y to enable the AML interpreter to execute the PRM code.
-
-	  While this feature is optional in principle, leaving it out may
-	  substantially increase computational overhead related to the
-	  initialization of some server systems.
-- 
2.37.0

