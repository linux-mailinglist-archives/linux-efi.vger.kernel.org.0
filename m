Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581013FAB7D
	for <lists+linux-efi@lfdr.de>; Sun, 29 Aug 2021 14:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhH2Muy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Aug 2021 08:50:54 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:42262
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235124AbhH2Muy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 29 Aug 2021 08:50:54 -0400
Received: from workstation5.fritz.box (ip-88-152-144-157.hsi03.unitymediagroup.de [88.152.144.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A486C3F232;
        Sun, 29 Aug 2021 12:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630241400;
        bh=ec9ejvL3UxKr94M+EKJMH+mi9gqyGvaor8NJmZDmCrM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=hqwjzK8Pk1HHHiiCbqdMmZ8ZXDheXoRjjaaTRZtkgyVIy2p325O1Rn+SuMGUT4hFn
         ht+Yn4+NM1xBjPsrvE5sa36FPsya60mvtva9nCp70rABOaCyVdSfrCUumtQZYDYYjD
         aQ6YcqbC0O6Dnxr1CgutUBJ/JxiMeJ5aFhL0NBaczTU2WsZFMMeLhrdVU6n8DvXSMW
         j8Jdw2OB4SicG0S1/TGVi4iWX0fTLFX4HP+5QpkiCfb8wLtke4qvBx8WB/2yBT5ytM
         BgORcTIiAyZFdPBA7FIqcjL3bTGoOrzMGhEmE12NOYzaugRTHxOod4IkTpx1WCTy6q
         dmSWBc3ZCJjnQ==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Heinrich Schuchardt <xypron.gpk@gmx.de>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] efi/libstub: "Exiting bootservices" message
Date:   Sun, 29 Aug 2021 14:49:55 +0200
Message-Id: <20210829124955.74429-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The message

    "Exiting boot services and installing virtual address map...\n"

is even shown if we have efi=novamap on the command line or the firmware
does not provide EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP.

To avoid confusion we should print

    "Exiting boot services...\n"

in this case.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/firmware/efi/libstub/fdt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 365c3a43a198..d871b1ac4d8b 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -271,7 +271,10 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 		return status;
 	}
 
-	efi_info("Exiting boot services and installing virtual address map...\n");
+	if (efi_novamap)
+		efi_info("Exiting boot services...\n");
+	else
+		efi_info("Exiting boot services and installing virtual address map...\n");
 
 	map.map = &memory_map;
 	status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, ULONG_MAX);
-- 
2.30.2

