Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C195742DB3
	for <lists+linux-efi@lfdr.de>; Thu, 29 Jun 2023 21:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjF2TfX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 29 Jun 2023 15:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjF2TfX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 29 Jun 2023 15:35:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A73D12F;
        Thu, 29 Jun 2023 12:35:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688067320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cQWrepqeMi4qIeVTOHeQAMFD514b/C3xCiVp4otJIcA=;
        b=sPLqChFMbwkv7gUwFdIZmNr84XHb6D2mjdmp+jV6yLK0gpjf/1guCqRCQXf3UuVN9a1jhT
        KV2/t0r8g9bIum79RRipBqOw8tSsmID2evmWe5Bf/B0gEHDub6hMjp+uUll2VUR1cWO8bg
        BkmH3PrRndazrmGkcskfGUfZlOGtfgU21Br07TmLqvpoOFozC8HI/WgmBqaCYLwNNjec/D
        Q2uuxVUXXwia0M6QZyAxA9IqMq2VimbUC+HcdcUmSw7+y+MAegwR75iG5owSN6mHloiKCe
        qxoIqSvBguJlLmCEJZuAcspj69ITLqBOhHL26Lz8ealCLhDPK6f7C9wBEoy1zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688067320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cQWrepqeMi4qIeVTOHeQAMFD514b/C3xCiVp4otJIcA=;
        b=3nR0ix5L1Oxfruv0U7AwkFzNl5SLb/elXiT6FzigX3+qvl5ejSZN8rglwscHPwqtjlK2zI
        pQaEZybL3uj4hxDA==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     =?utf-8?Q?Nikl=C4=81vs_Ko=C4=BCes=C5=86ikovs?= 
        <pinkflames.linux@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, x86@kernel.org,
        regressions@lists.linux.dev
Subject: x86/efi: Make efi_set_virtual_address_map IBT safe
Date:   Thu, 29 Jun 2023 21:35:19 +0200
Message-ID: <87jzvm12q0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Nikl=C4=81vs reported a boot regression on an Alderlake machine and bisecte=
d it
to commit 9df9d2f0471b ("init: Invoke arch_cpu_finalize_init() earlier").

By moving the invocation of arch_cpu_finalize_init() further down he
identified that efi_enter_virtual_mode() is the function which causes
the boot hang.

The main difference of the earlier invocation is that the boot CPU is
already fully initialized and mitigations and alternatives are applied.

But the only really interesting change turned out to be IBT, which is
now enabled before efi_enter_virtual_mode(). "ibt=3Doff" on the kernel
command line cured the problem.

Inspection of the involved calls in efi_enter_virtual_mode() unearthed that
efi_set_virtual_address_map() is the only place in the kernel which invokes
an EFI call without the IBT safe wrapper. This went obviously unnoticed so
far as IBT was enabled later.

Use arch_efi_call_virt() instead of efi_call() to cure that.

Fixes: fe379fa4d199 ("x86/ibt: Disable IBT around firmware")
Fixes: 9df9d2f0471b ("init: Invoke arch_cpu_finalize_init() earlier")
Reported-by: Nikl=C4=81vs Ko=C4=BCes=C5=86ikovs <pinkflames.linux@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217602
---
I put two fixes tags in as the IBT one missed that and the earlier
invocation unearthed it and made it observable.
---
 arch/x86/platform/efi/efi_64.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -853,9 +853,9 @@ efi_set_virtual_address_map(unsigned lon
=20
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
-	status =3D efi_call(efi.runtime->set_virtual_address_map,
-			  memory_map_size, descriptor_size,
-			  descriptor_version, virtual_map);
+	status =3D arch_efi_call_virt(efi.runtime, set_virtual_address_map,
+				    memory_map_size, descriptor_size,
+				    descriptor_version, virtual_map);
 	local_irq_restore(flags);
=20
 	efi_fpu_end();
