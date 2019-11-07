Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A64CCF3249
	for <lists+linux-efi@lfdr.de>; Thu,  7 Nov 2019 16:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbfKGPK5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Nov 2019 10:10:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729854AbfKGPK5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 7 Nov 2019 10:10:57 -0500
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr [90.118.215.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA9ED21D79;
        Thu,  7 Nov 2019 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573139457;
        bh=zy8/oTWVp9pAU9Yw/5ShxGylu0BdMemczEEpuQoS5vQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cMBab5NQhJpSiAGMJ5dr6OYJkfykMx1hkWEWZ5G1UY0yreVLHj7vBI1PsxSqlRr9D
         nbGd1TVROvVhrmTH6QyLpaNUNRVVyLNEfbYHt4Ts6HVICpDJ6VakdP1DoPoIjPDxj2
         fdal657TSMAD2JOVGMTJMgsTeP0EZLJY2HBKKSXE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Zou Cao <zoucao@linux.alibaba.com>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>
Subject: [PATCH 1/4] MAINTAINERS: update Ard's email address to @kernel.org
Date:   Thu,  7 Nov 2019 16:10:33 +0100
Message-Id: <20191107151036.5586-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107151036.5586-1-ardb@kernel.org>
References: <20191107151036.5586-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Cc: Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 83d7e750c2fc..5d3b741a3f95 100644
--- a/.mailmap
+++ b/.mailmap
@@ -32,6 +32,7 @@ Andy Adamson <andros@citi.umich.edu>
 Antoine Tenart <antoine.tenart@free-electrons.com>
 Antonio Ospite <ao2@ao2.it> <ao2@amarulasolutions.com>
 Archit Taneja <archit@ti.com>
+Ard Biesheuvel <ardb@kernel.org> <ard.biesheuvel@linaro.org>
 Arnaud Patard <arnaud.patard@rtp-net.org>
 Arnd Bergmann <arnd@arndb.de>
 Axel Dyks <xl@xlsigned.net>
diff --git a/MAINTAINERS b/MAINTAINERS
index cba1095547fd..cc9f02ab9316 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6003,14 +6003,14 @@ F:	sound/usb/misc/ua101.c
 EFI TEST DRIVER
 L:	linux-efi@vger.kernel.org
 M:	Ivan Hu <ivan.hu@canonical.com>
-M:	Ard Biesheuvel <ard.biesheuvel@linaro.org>
+M:	Ard Biesheuvel <ardb@kernel.org>
 S:	Maintained
 F:	drivers/firmware/efi/test/
 
 EFI VARIABLE FILESYSTEM
 M:	Matthew Garrett <matthew.garrett@nebula.com>
 M:	Jeremy Kerr <jk@ozlabs.org>
-M:	Ard Biesheuvel <ard.biesheuvel@linaro.org>
+M:	Ard Biesheuvel <ardb@kernel.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
 L:	linux-efi@vger.kernel.org
 S:	Maintained
@@ -6189,7 +6189,7 @@ S:	Supported
 F:	security/integrity/evm/
 
 EXTENSIBLE FIRMWARE INTERFACE (EFI)
-M:	Ard Biesheuvel <ard.biesheuvel@linaro.org>
+M:	Ard Biesheuvel <ardb@kernel.org>
 L:	linux-efi@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
 S:	Maintained
@@ -15006,7 +15006,7 @@ F:	include/media/soc_camera.h
 F:	drivers/staging/media/soc_camera/
 
 SOCIONEXT SYNQUACER I2C DRIVER
-M:	Ard Biesheuvel <ard.biesheuvel@linaro.org>
+M:	Ard Biesheuvel <ardb@kernel.org>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-synquacer.c
-- 
2.17.1

