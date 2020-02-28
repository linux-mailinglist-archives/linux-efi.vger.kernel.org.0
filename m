Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13AA31736FE
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2020 13:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgB1MO3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Feb 2020 07:14:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgB1MO1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Feb 2020 07:14:27 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB2A246B0;
        Fri, 28 Feb 2020 12:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582892067;
        bh=yTXR/aWTRf31QuLVSWpsZDTg2cGIQ6ZDOSL3SMzock8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w07DWlvLoPCwL0fRxHx/IgzLfCPPIjb58njjlVnP5imFJV5GIi/s5SG2dtLxv+4Ia
         EAvM20IQCwbRDgKgIFLFJ7/BXJwGZ3n0ZUbIbHbTUA6tgzDMXZMUoYS3ONFUW9RLWg
         w/5pAX4gy8MS1RYnbpZY6CNt6dvRQ9R5aMoCSng8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 6/6] efi: mark all EFI runtime services as unsupported on non-EFI boot
Date:   Fri, 28 Feb 2020 13:14:08 +0100
Message-Id: <20200228121408.9075-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228121408.9075-1-ardb@kernel.org>
References: <20200228121408.9075-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Recent changes to the way we deal with EFI runtime services that
are marked as unsupported by the firmware resulted in a regression
for non-EFI boot. The problem is that all EFI runtime services are
marked as available by default, and any non-NULL checks on the EFI
service function pointers (which will be non-NULL even for runtime
services that are unsupported on an EFI boot) were replaced with
checks against the mask stored in efi.runtime_supported_mask.

When doing a non-EFI boot, this check against the mask will return
a false positive, given the fact that all runtime services are
marked as enabled by default. Since we dropped the non-NULL check
of the runtime service function pointer in favor of the mask check,
we will now unconditionally dereference the function pointer, even
if it is NULL, and go boom.

So let's ensure that the mask reflects reality on a non-EFI boot,
which is that all EFI runtime services are unsupported.

Reported-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 41269a95ff85..d1746a579c99 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -300,12 +300,12 @@ static int __init efisubsys_init(void)
 {
 	int error;
 
-	if (!efi_enabled(EFI_BOOT))
-		return 0;
-
 	if (!efi_enabled(EFI_RUNTIME_SERVICES))
 		efi.runtime_supported_mask = 0;
 
+	if (!efi_enabled(EFI_BOOT))
+		return 0;
+
 	if (efi.runtime_supported_mask) {
 		/*
 		 * Since we process only one efi_runtime_service() at a time, an
-- 
2.17.1

