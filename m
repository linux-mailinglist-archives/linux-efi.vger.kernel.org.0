Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E9CF324E
	for <lists+linux-efi@lfdr.de>; Thu,  7 Nov 2019 16:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389327AbfKGPLB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Nov 2019 10:11:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388215AbfKGPLA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 7 Nov 2019 10:11:00 -0500
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr [90.118.215.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8473C21D7B;
        Thu,  7 Nov 2019 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573139459;
        bh=7T11RtN4dXAfLvwcDCgYIQmw0NTGKRuoKKREaMPYfh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mSlLkHJQ2gu/SNR+prRU/mM1VLOhaZCOQEiVSXV01acGatL584mJsW12o9bImKfO/
         hKu10rEuvr6P1dFqi5WjAhzzsexsPf/A+ZdgJI/jJSgkZ1LxymAycuQAQaWphJPRqN
         bEWdj4Vfju+ALWTeOxC+LgIqyOXwZPS0bBEmc+GE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Zou Cao <zoucao@linux.alibaba.com>
Subject: [PATCH 2/4] efi/random: use arch-independent efi_call_proto()
Date:   Thu,  7 Nov 2019 16:10:34 +0100
Message-Id: <20191107151036.5586-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107151036.5586-1-ardb@kernel.org>
References: <20191107151036.5586-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Dominik Brodowski <linux@dominikbrodowski.net>

To handle all arch-specific peculiarities when calling an EFI protocol
function, a wrapper efi_call_proto() exists on all relevant architectures.
On arm/arm64, this is merely a plain function call. On x86, a special EFI
entry stub needs to be used, however, as the calling convention differs.
To make the efi/random stub arch-independent, use efi_call_proto()
instead of the existing non-portable calls to the EFI get_rng protocol
function. This also requires the addition of some typedefs.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/random.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index b4b1d1dcb5fd..53f1466f7de6 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -9,6 +9,18 @@
 
 #include "efistub.h"
 
+typedef struct efi_rng_protocol efi_rng_protocol_t;
+
+typedef struct {
+	u32 get_info;
+	u32 get_rng;
+} efi_rng_protocol_32_t;
+
+typedef struct {
+	u64 get_info;
+	u64 get_rng;
+} efi_rng_protocol_64_t;
+
 struct efi_rng_protocol {
 	efi_status_t (*get_info)(struct efi_rng_protocol *,
 				 unsigned long *, efi_guid_t *);
@@ -28,7 +40,7 @@ efi_status_t efi_get_random_bytes(efi_system_table_t *sys_table_arg,
 	if (status != EFI_SUCCESS)
 		return status;
 
-	return rng->get_rng(rng, NULL, size, out);
+	return efi_call_proto(efi_rng_protocol, get_rng, rng, NULL, size, out);
 }
 
 /*
@@ -161,15 +173,16 @@ efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg)
 	if (status != EFI_SUCCESS)
 		return status;
 
-	status = rng->get_rng(rng, &rng_algo_raw, EFI_RANDOM_SEED_SIZE,
-			      seed->bits);
+	status = efi_call_proto(efi_rng_protocol, get_rng, rng, &rng_algo_raw,
+				 EFI_RANDOM_SEED_SIZE, seed->bits);
+
 	if (status == EFI_UNSUPPORTED)
 		/*
 		 * Use whatever algorithm we have available if the raw algorithm
 		 * is not implemented.
 		 */
-		status = rng->get_rng(rng, NULL, EFI_RANDOM_SEED_SIZE,
-				      seed->bits);
+		status = efi_call_proto(efi_rng_protocol, get_rng, rng, NULL,
+					 EFI_RANDOM_SEED_SIZE, seed->bits);
 
 	if (status != EFI_SUCCESS)
 		goto err_freepool;
-- 
2.17.1

