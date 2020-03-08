Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2E017D277
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgCHIJ6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCHIJ4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:09:56 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A3120848;
        Sun,  8 Mar 2020 08:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583654996;
        bh=U09xjohhRqqV+2chi3p5cHIE4DNl19xwTDy0XvNaRGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dz2QgcK+o3ZtT+2LcDa2r18afZ9B2NCbxTxl4ts7sJ8E5Q698ZpQLCyk8jJqKxcT/
         P5yVL6JXHrY9inkBk6AQl+l1l9XPmpN9rj1kq64XGAbXAkbLtPuv+8nhEYjE9IAFU2
         kkrmyDj2M0NXErs64EyflCtr9d4HPzf34+AOSf0Q=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 14/28] efi/libstub/x86: deal with exit() boot service returning
Date:   Sun,  8 Mar 2020 09:08:45 +0100
Message-Id: <20200308080859.21568-15-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Even though it is uncommon, there are cases where the Exit() EFI boot
service might return, e.g., when we were booted via the EFI handover
protocol from OVMF and the kernel image was specified on the command
line, in which case Exit() attempts to terminate the boot manager,
which is not an EFI application itself. So let's drop into a deadloop
instead.

Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build
Link: https://lore.kernel.org/r/20200303080648.21427-1-ardb@kernel.org
[ardb: put 'hlt' in deadloop]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 7f3e97c2aad3..69a942f0640b 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -344,7 +344,8 @@ static void setup_graphics(struct boot_params *boot_params)
 static void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
 {
 	efi_bs_call(exit, handle, status, 0, NULL);
-	unreachable();
+	for(;;)
+		asm("hlt");
 }
 
 void startup_32(struct boot_params *boot_params);
-- 
2.17.1

