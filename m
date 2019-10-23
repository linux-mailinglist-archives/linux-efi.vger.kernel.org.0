Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0083CE21CA
	for <lists+linux-efi@lfdr.de>; Wed, 23 Oct 2019 19:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfJWRcJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Oct 2019 13:32:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36168 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbfJWRcH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Oct 2019 13:32:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id w18so22475200wrt.3
        for <linux-efi@vger.kernel.org>; Wed, 23 Oct 2019 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mqk9lnQxsCRkESOqxWXPCiFE5tGlzXJcbsR9dSjU8io=;
        b=pX1fAvcoTDxwW/VJpbfmFNtdo4fhYGst7dtK6Ws3sqRgZamLy4biv+zY5OdGO4Fq5P
         uf9m57CdjurB61LX7RzR6sh0KZJakGxXmLfRRkqSIp0oF4V901ZccrxnB4FV+p8xloQn
         dtI66Q02YRDXTJF5I8+RO4ZkaofmzAW2UHkc6dvK3vANpPOheuq8QSjW9uPMIUh/zFvW
         ykVzof8CUBheJ32MHr2WwuuTROI3jCVIJHOAF6Z7Tg+0/15AAFv+qwli1hep1yGjiTAq
         3hZzC9l/fkR6UJt8edKNrVIiVmIXzK0KtecWks3ioBllug7N5WUqOzt7dWImmP+F1wUr
         HUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mqk9lnQxsCRkESOqxWXPCiFE5tGlzXJcbsR9dSjU8io=;
        b=b1WAJF9zkCc4KBy3OhQVwH8MMFHmt5mQY1B7KUi6tINFsl6RP7I1XMA1rPc4Rkeg4K
         F48tUdwjLSQoixP8gxrgopppMAEGLZz/DLBvFeRdtfYFn/b2kAO4meXqe2gMcLPF+epq
         V1gaDLulU8o0bajc3q7zfen+ztRsmOspX9JkONPmvoXRoLWcaYlOdO90U2Zm3UVpWeli
         4dfG+yGc8xQ1jiVqtrvLRg3cQpjEKVqCOjJ1UqSPGRPRH1lXlRhiYA72b6qdudLR4PUH
         aikP/aYKdab8Gh7wPcwcYYgOCCk96J8zTXjVgy8Y2tV6IRuN/D1ksK7poUSo/p737sP4
         t8Dg==
X-Gm-Message-State: APjAAAUYl+xC/iNoSQYg6bixwWzuGA38nt1mLBRXRYp8BxPn7Zz8q+1r
        5LGKVkKyVBbGnbD2r1BDr5a1LLrmz6GHk23B
X-Google-Smtp-Source: APXvYqxfqwTxI1LhbV428InmPQyII9sFlty46FB2NJzu3rlL1NUCyr79qCnwdyyZ+MagHlFDaepVJA==
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr9509023wra.201.1571851925290;
        Wed, 23 Oct 2019 10:32:05 -0700 (PDT)
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr. [90.118.215.104])
        by smtp.gmail.com with ESMTPSA id f7sm14900374wre.68.2019.10.23.10.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 10:32:04 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] efi/random: treat EFI_RNG_PROTOCOL output as bootloader randomness
Date:   Wed, 23 Oct 2019 19:31:59 +0200
Message-Id: <20191023173201.6607-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023173201.6607-1-ard.biesheuvel@linaro.org>
References: <20191023173201.6607-1-ard.biesheuvel@linaro.org>
X-ARM-No-Footer: FoSSMail
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Dominik Brodowski <linux@dominikbrodowski.net>

Commit 428826f5358c ("fdt: add support for rng-seed") introduced
add_bootloader_randomness(), permitting randomness provided by the
bootloader or firmware to be credited as entropy. However, the fact
that the UEFI support code was already wired into the RNG subsystem
via a call to add_device_randomness() was overlooked, and so it was
not converted at the same time.

Note that this UEFI (v2.4 or newer) feature is currently only
implemented for EFI stub booting on ARM, and further note that
CONFIG_RANDOM_TRUST_BOOTLOADER must be enabled, and this should be
done only if there indeed is sufficient trust in the bootloader
_and_ its source of randomness.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
[ardb: update commit log]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 69f00f7453a3..e98bbf8e56d9 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -554,7 +554,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 					      sizeof(*seed) + size);
 			if (seed != NULL) {
 				pr_notice("seeding entropy pool\n");
-				add_device_randomness(seed->bits, seed->size);
+				add_bootloader_randomness(seed->bits, seed->size);
 				early_memunmap(seed, sizeof(*seed) + size);
 			} else {
 				pr_err("Could not map UEFI random seed!\n");
-- 
2.17.1

