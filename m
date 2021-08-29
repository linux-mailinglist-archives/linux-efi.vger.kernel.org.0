Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC53FABF3
	for <lists+linux-efi@lfdr.de>; Sun, 29 Aug 2021 15:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbhH2NYJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Aug 2021 09:24:09 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:43814
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235376AbhH2NYI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 29 Aug 2021 09:24:08 -0400
Received: from workstation5.fritz.box (ip-88-152-144-157.hsi03.unitymediagroup.de [88.152.144.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 837F83F0B8;
        Sun, 29 Aug 2021 13:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630243395;
        bh=Lck8ieg/DRVz0Gp1/fiKpkSJ54XkbC9/gukX6sShCVA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Xp1+St3j8flp394JKP8Spx5GM1WW090lOQ+G4xpW6rDhipjXBx9PgWIzACu/iLKI6
         8sA+O6ChILCe5f3/6KctodaZJPIkewqXgSpjhLhO0c4ymArYMkmfV8w40jZN84NQvK
         sAXvJU8qj2d8lBshtY1Cyub/FKqhHM3vknVFFi2zpQZpkj3syIiut3/NyHsntnXlmJ
         thcrmh0QZ1ps2rVv2fsq/maaICMvN+XO0PpSCeGbEvAtHKxXoCv7LpFbDXFtu+x687
         xo9yGOYv3Fn4dgx9NCnV8QKGdegV4ToqqyIgardHYtj3GCoJIirHzWqPDpP+emG0ZF
         zABBFVbNl3tPg==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Heinrich Schuchardt <xypron.gpk@gmx.de>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2: 1/1] efi/libstub: "Exiting bootservices" message
Date:   Sun, 29 Aug 2021 15:23:10 +0200
Message-Id: <20210829132310.75687-1-heinrich.schuchardt@canonical.com>
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

To avoid confusion just print

    "Exiting boot services...\n"

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	reduce complexity, use same message irrespective of efi_novamap
---
 drivers/firmware/efi/libstub/fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 365c3a43a198..fe567be0f118 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -271,7 +271,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 		return status;
 	}
 
-	efi_info("Exiting boot services and installing virtual address map...\n");
+	efi_info("Exiting boot services...\n");
 
 	map.map = &memory_map;
 	status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, ULONG_MAX);
-- 
2.30.2

