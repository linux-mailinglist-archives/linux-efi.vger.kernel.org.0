Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA21DD2AD
	for <lists+linux-efi@lfdr.de>; Sat, 19 Oct 2019 00:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389360AbfJRWJw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Oct 2019 18:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389317AbfJRWJv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 18 Oct 2019 18:09:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2C522478;
        Fri, 18 Oct 2019 22:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436589;
        bh=7SOk7tiTVGhBb6vH7JX2MPjaoKS77atUxG4Pvnesje8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qiuniB1JomZTru8yoP6UAPYkzLPBmLKTdscXKGc80hIrK34zqY0qNYD2ey2JwnJr4
         PiQLF5m2Q7V0u2u6F+s2XYLEDoK51uvUjy5ghyYFOMBccfRYRVaBCtItDsW9XducHe
         1l2CIyREShGmmF5vG3RH7zv/iKB1FawjIpNZJutk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Scott Talbert <swt@techie.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 17/29] efi/cper: Fix endianness of PCIe class code
Date:   Fri, 18 Oct 2019 18:09:08 -0400
Message-Id: <20191018220920.10545-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220920.10545-1-sashal@kernel.org>
References: <20191018220920.10545-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 6fb9367a15d1a126d222d738b2702c7958594a5f ]

The CPER parser assumes that the class code is big endian, but at least
on this edk2-derived Intel Purley platform it's little endian:

    efi: EFI v2.50 by EDK II BIOS ID:PLYDCRB1.86B.0119.R05.1701181843
    DMI: Intel Corporation PURLEY/PURLEY, BIOS PLYDCRB1.86B.0119.R05.1701181843 01/18/2017

    {1}[Hardware Error]:   device_id: 0000:5d:00.0
    {1}[Hardware Error]:   slot: 0
    {1}[Hardware Error]:   secondary_bus: 0x5e
    {1}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x2030
    {1}[Hardware Error]:   class_code: 000406
                                       ^^^^^^ (should be 060400)

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Dave Young <dyoung@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Matthew Garrett <mjg59@google.com>
Cc: Octavian Purdila <octavian.purdila@intel.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Scott Talbert <swt@techie.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Link: https://lkml.kernel.org/r/20191002165904.8819-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/cper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index f40f7df4b7344..c0e54396f2502 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -375,7 +375,7 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
 		printk("%s""vendor_id: 0x%04x, device_id: 0x%04x\n", pfx,
 		       pcie->device_id.vendor_id, pcie->device_id.device_id);
 		p = pcie->device_id.class_code;
-		printk("%s""class_code: %02x%02x%02x\n", pfx, p[0], p[1], p[2]);
+		printk("%s""class_code: %02x%02x%02x\n", pfx, p[2], p[1], p[0]);
 	}
 	if (pcie->validation_bits & CPER_PCIE_VALID_SERIAL_NUMBER)
 		printk("%s""serial number: 0x%04x, 0x%04x\n", pfx,
-- 
2.20.1

