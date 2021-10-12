Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D419429FC5
	for <lists+linux-efi@lfdr.de>; Tue, 12 Oct 2021 10:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhJLI3V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Oct 2021 04:29:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42676 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbhJLI3U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Oct 2021 04:29:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A1BEC21F2C;
        Tue, 12 Oct 2021 08:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634027238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zD9QTV4WyXthA7N/2eYXkVzurQrRAnyA96sGjWbnf5A=;
        b=j5ZCZf6SyHkjCi5k0JocrOJfsP4v3eZUU9uNo1rxGQJn8ktR7Tt2ubUs0JfqtrY2iNlpec
        ETHMFEk73gM4gj74FUyTqsm0AipjlyOFV1YBu7fsDmm75SFH7s23MNqt5/fV47LFPBoRAC
        NMJvAiKQNl/6f4F6NM3dkqQ9q5C32MU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634027238;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zD9QTV4WyXthA7N/2eYXkVzurQrRAnyA96sGjWbnf5A=;
        b=aLWA8vxcED2t4X6I9/ThVRx7D02Hpg3kFw8dnxb6bTL6fDlOacqKqIzWCqFya2DaRN19y3
        udvxByOy2o86mVAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8792813AD5;
        Tue, 12 Oct 2021 08:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uHvPIOZGZWE+SQAAMHmgww
        (envelope-from <iivanov@suse.de>); Tue, 12 Oct 2021 08:27:18 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH] Revert "efi/random: Treat EFI_RNG_PROTOCOL output as bootloader randomness"
Date:   Tue, 12 Oct 2021 11:27:08 +0300
Message-Id: <20211012082708.121931-1-iivanov@suse.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This reverts commit 18b915ac6b0ac5ba7ded03156860f60a9f16df2b.

When CONFIG_RANDOM_TRUST_BOOTLOADER is enabled add_bootloader_randomness()
calls add_hwgenerator_randomness() which might sleep, but this is not
possible during early kernel initialization. This revert fixes following
NULL pointer deference:

[    0.000000] efi: seeding entropy pool
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
...
[    0.000000] pc : kthread_should_stop+0x2c/0x60
[    0.000000] lr : add_hwgenerator_randomness+0x58/0x178
...
[    0.000000] Call trace:
[    0.000000]  kthread_should_stop+0x2c/0x60
[    0.000000]  add_bootloader_randomness+0x2c/0x38
[    0.000000]  efi_config_parse_tables+0x120/0x250
[    0.000000]  efi_init+0x138/0x1e0
[    0.000000]  setup_arch+0x394/0x778
[    0.000000]  start_kernel+0x90/0x568

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 847f33ffc4ae..8aad3c524947 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -600,7 +600,7 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 					      sizeof(*seed) + size);
 			if (seed != NULL) {
 				pr_notice("seeding entropy pool\n");
-				add_bootloader_randomness(seed->bits, size);
+				add_device_randomness(seed->bits, size);
 				early_memunmap(seed, sizeof(*seed) + size);
 			} else {
 				pr_err("Could not map UEFI random seed!\n");
-- 
2.33.0

