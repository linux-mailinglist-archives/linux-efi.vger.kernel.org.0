Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7686E161691
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 16:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgBQPpv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 10:45:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:40150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbgBQPpv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Feb 2020 10:45:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 73D37AD4F;
        Mon, 17 Feb 2020 15:45:50 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-efi@vger.kernel.org
Cc:     Joey Lee <jlee@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-security-module@vger.kernel.org, inux-kernel@vger.kernel.org
Subject: [PATCH] efi: Suppress spurious "Couldn't get size" error
Date:   Mon, 17 Feb 2020 16:45:49 +0100
Message-Id: <20200217154549.20895-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The current efi code emits the error message like
   Couldn't get size: 0x800000000000000e
on various Dell and other machines.  Although the whole problem is the
buggy firmware, showing this as an error level is rather annoying, as
the error message appears over the boot splash.  Basically this is the
result of missing entry and we have no explicit way to fix it for such
a firmware problem, the error message may be suppressed.

This patch changes the error print condition and suppresses the error
message if status is EFI_NOT_FOUND.  It's a partial patch from the
more comprehensive one Joey Lee submitted in the past.

Link: https://lore.kernel.org/linux-efi/20190322103350.27764-2-jlee@suse.com/
Cc: Joey Lee <jlee@suse.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 security/integrity/platform_certs/load_uefi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 111898aad56e..8501ea62cb3e 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -44,7 +44,8 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 
 	status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
 	if (status != EFI_BUFFER_TOO_SMALL) {
-		pr_err("Couldn't get size: 0x%lx\n", status);
+		if (status != EFI_NOT_FOUND)
+			pr_err("Couldn't get size: 0x%lx\n", status);
 		return NULL;
 	}
 
-- 
2.16.4

