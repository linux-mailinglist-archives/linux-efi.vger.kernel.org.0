Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 497F712A1C2
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 14:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfLXN3s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 08:29:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfLXN3r (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 08:29:47 -0500
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net [91.167.84.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D52D2071A;
        Tue, 24 Dec 2019 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577194187;
        bh=3yArLPm9xn7NbsZ3PGpEN2FC7tb9hNH9R/yi2w90Beg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lqg24BTGu5VV9Vl7bM9h6ovHN1e1uYqv3XpILexGdgTzekndiA4Pl7ZQjhhaMPHiD
         ElBiydqam+xSiHnm5RKqnWv/onC7UrN1mIha2qepbtdV9hhxl40FoxjFtDSmCYvl9V
         3UeEvNhy76emoNS1yIMDNfb75plhe5G7CaEzcSkY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/3] efi/libstub/random: Initialize pointer variables to zero for mixed mode
Date:   Tue, 24 Dec 2019 14:29:08 +0100
Message-Id: <20191224132909.102540-3-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224132909.102540-1-ardb@kernel.org>
References: <20191224132909.102540-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

Commit 0d95981438c3 ("x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed the
UEFI RNG table"), causes the drivers/efi/libstub/random.c code to get used
on x86 for the first time.

But this code was not written with EFI mixed mode in mind (running a 64
bit kernel on 32 bit EFI firmware), this causes the kernel to crash during
early boot when running in mixed mode.

The problem is that in mixed mode pointers are 64 bit, but when running on
a 32 bit firmware, EFI calls which return a pointer value by reference only
fill the lower 32 bits of the passed pointer, leaving the upper 32 bits
uninitialized which leads to crashes.

This commit fixes this by initializing pointers which are passed by
reference to EFI calls to NULL before passing them, so that the upper 32
bits are initialized to 0.

Fixes: 0d95981438c3 ("x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/random.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 35edd7cfb6a1..97378cf96a2e 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -33,7 +33,7 @@ efi_status_t efi_get_random_bytes(efi_system_table_t *sys_table_arg,
 {
 	efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
 	efi_status_t status;
-	struct efi_rng_protocol *rng;
+	struct efi_rng_protocol *rng = NULL;
 
 	status = efi_call_early(locate_protocol, &rng_proto, NULL,
 				(void **)&rng);
@@ -162,8 +162,8 @@ efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg)
 	efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
 	efi_guid_t rng_algo_raw = EFI_RNG_ALGORITHM_RAW;
 	efi_guid_t rng_table_guid = LINUX_EFI_RANDOM_SEED_TABLE_GUID;
-	struct efi_rng_protocol *rng;
-	struct linux_efi_random_seed *seed;
+	struct efi_rng_protocol *rng = NULL;
+	struct linux_efi_random_seed *seed = NULL;
 	efi_status_t status;
 
 	status = efi_call_early(locate_protocol, &rng_proto, NULL,
-- 
2.20.1

