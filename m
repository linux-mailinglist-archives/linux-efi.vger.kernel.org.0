Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B6D62DEEB
	for <lists+linux-efi@lfdr.de>; Thu, 17 Nov 2022 16:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiKQPAy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Nov 2022 10:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239310AbiKQPAv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Nov 2022 10:00:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857E45F54
        for <linux-efi@vger.kernel.org>; Thu, 17 Nov 2022 07:00:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22DF261F9D
        for <linux-efi@vger.kernel.org>; Thu, 17 Nov 2022 15:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01571C433D7;
        Thu, 17 Nov 2022 15:00:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Q9mTpXJ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668697246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y6khYu+l0edl3UAhyKwZOWnii/UWxRJfQvz1C//tV6s=;
        b=Q9mTpXJ41jtP1jIxl3s1/8I6BPisnKWkPznaDq7uULUwKhHjAhkiRWra+KubVR2q8Lk4a4
        35VU4yVS965aMr3iZZfvzQZgJ4DmhSOC/dYRvwi4n7VnfB0lr12l2T4hCuOsLQdekilVCn
        5qdgoqbJkF6ve0rVWZqeWjwrqMdXgIk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 257a457e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Nov 2022 15:00:45 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org, ardb@kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] efi: random: remove extraneous dmesg notice
Date:   Thu, 17 Nov 2022 16:00:40 +0100
Message-Id: <20221117150040.2175965-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

No other providers of bootloader randomness print like this, and the rng
will already print when it's initialized, so you can already see the
correlation between EFI initializing and the rng becoming ready. So just
remove this line.

Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/firmware/efi/efi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index a0bbecd57ee3..218c02f40e58 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -639,7 +639,6 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 			seed = early_memremap(efi_rng_seed,
 					      sizeof(*seed) + size);
 			if (seed != NULL) {
-				pr_notice("seeding entropy pool\n");
 				add_bootloader_randomness(seed->bits, size);
 				memzero_explicit(seed->bits, size);
 				early_memunmap(seed, sizeof(*seed) + size);
-- 
2.38.1

