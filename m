Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DE7559D31
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiFXPX5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 11:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiFXPXt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 11:23:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C367A2F657;
        Fri, 24 Jun 2022 08:23:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B17C814BF;
        Fri, 24 Jun 2022 08:23:48 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5F5E03F534;
        Fri, 24 Jun 2022 08:23:47 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>
Subject: [PATCH 3/3] ACPI: Move PRM config option under the main ACPI config
Date:   Fri, 24 Jun 2022 16:23:31 +0100
Message-Id: <20220624152331.4009502-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624152331.4009502-1-sudeep.holla@arm.com>
References: <20220624152331.4009502-1-sudeep.holla@arm.com>
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

Currently PRM(Platform Runtime Mechanism) config options is list along
with the mainA CPI (Advanced Configuration and Power Interface) option
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
2.36.1

