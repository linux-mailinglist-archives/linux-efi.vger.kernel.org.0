Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB20C14188D
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2020 17:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgARQ5j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Jan 2020 11:57:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgARQ5j (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 18 Jan 2020 11:57:39 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B883246A0;
        Sat, 18 Jan 2020 16:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579366658;
        bh=HzFkFOFRFltQBYxjTFdkWIZ8kujJ3zqIVXa8Olqmf3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ZV/56T7N2mmnQRnxlIF/sBfm6SU9AQ+Gjn85VVjI8yeYP09v5B3WKneBUlNl8i8x
         M+/ulT9GOW4171x7y/6lTBshZKMGh46sshM4tVlD3d/tIlbtXfUE7vfuyV7YboNyy7
         4ESz+n1M27ADHO+n7qwQ728mWXRLA0sBlSazvl5I=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     mingo@kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 3/3] efi/x86: disallow efi=old_map in mixed mode
Date:   Sat, 18 Jan 2020 17:57:05 +0100
Message-Id: <20200118165705.16544-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118165705.16544-1-ardb@kernel.org>
References: <20200118165705.16544-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Before commit ... ("efi/x86: limit EFI old memory map to SGI UV
machines"), enabling the old EFI memory map on mixed mode systems
disabled EFI runtime services altogether. Given that efi=old_map is
a debug feature designed to work around firmware problems related
to EFI runtime services, and disabling them can be achieved more
straightforwardly using 'noefi' or 'efi=noruntime', it makes more
sense to ignore efi=old_map on mixed mode systems.

Currently, we do neither, and try to use the old memory map in
combination with mixed mode routines, which results in crashes,
so let's fix this by making efi=old_map functional on native
systems only.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/uv/bios_uv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 7c2b8c5d0b49..607f58147311 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -371,7 +371,7 @@ static int __init arch_parse_efi_cmdline(char *str)
 		return -EINVAL;
 	}
 
-	if (parse_option_str(str, "old_map"))
+	if (!efi_is_mixed() && parse_option_str(str, "old_map"))
 		set_bit(EFI_UV1_MEMMAP, &efi.flags);
 
 	return 0;
-- 
2.17.1

