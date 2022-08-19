Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0859599F81
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 18:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350722AbiHSP6j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 11:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350724AbiHSP5C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 11:57:02 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE52108B00;
        Fri, 19 Aug 2022 08:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=28vkizyvUtYm4/sTyN+MXhOLB0Fo0DX7lO6TnmiJ624=; b=nRKFd6buwCNbA3003YPVFxn6ZF
        8IfZbIwtydC8ZU5xNGIYjRMrNlaFUnAbH4BQ0psaGBPKAQdQNodJ9aAM8tBIDYEsilzFjaOOwGY0O
        rURKPeOQkBy6IrMkwIE4NyAmPbUfMzLWtTFvpxK6rAHILVTNCRbWaFpTKW7moSBiRYZtYH/OV7Ytm
        GEA8RDpIXlNJxOeqxSNqD3BZhbjrL4fLxFQdTK7aGM3qV5pE4wvEA7xMtH7Pv4YytPq1RzsONSVNM
        yItfcCNT9tkveEBRM9cd2PIGqQHKtBBuoUaF9SI/sgQEoLq6TLrQnaZKjrMDfqC+5LVyQnQuJu/bd
        oStPx5LA==;
Received: from [179.232.144.59] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oP4HM-00CNLN-Dx; Fri, 19 Aug 2022 17:51:27 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, evgreen@chromium.org
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        gpiccoli@igalia.com, kernel@gpiccoli.net, ardb@kernel.org,
        davidgow@google.com, jwerner@chromium.org
Subject: [PATCH V3] firmware: google: Test spinlock on panic path to avoid lockups
Date:   Fri, 19 Aug 2022 12:50:59 -0300
Message-Id: <20220819155059.451674-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently the gsmi driver registers a panic notifier as well as
reboot and die notifiers. The callbacks registered are called in
atomic and very limited context - for instance, panic disables
preemption and local IRQs, also all secondary CPUs (not executing
the panic path) are shutdown.

With that said, taking a spinlock in this scenario is a dangerous
invitation for lockup scenarios. So, fix that by checking if the
spinlock is free to acquire in the panic notifier callback - if not,
bail-out and avoid a potential hang.

Fixes: 74c5b31c6618 ("driver: Google EFI SMI")
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: David Gow <davidgow@google.com>
Cc: Julius Werner <jwerner@chromium.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


This is a re-submission of the patch - it was in a series [0], but
Greg suggested me to resubmit individually in order it gets picked
by the relevant maintainers, instead of asking them to merge
individual patches from a series. Notice I've trimmed a bit the CC
list, it was bigger due to the patch being in a series...

This is truly the V3 of the patch, below is the diff between versions:

V3:
- added Evan's review tag - thanks!

V2:
- do not use spin_trylock anymore, to avoid messing with
non-panic paths; now we just check the spinlock state in
the panic notifier before taking it. Thanks Evan for the review!

[0] https://lore.kernel.org/lkml/20220719195325.402745-4-gpiccoli@igalia.com/


 drivers/firmware/google/gsmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index adaa492c3d2d..3ef5f3c0b4e4 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -681,6 +681,14 @@ static struct notifier_block gsmi_die_notifier = {
 static int gsmi_panic_callback(struct notifier_block *nb,
 			       unsigned long reason, void *arg)
 {
+	/*
+	 * Perform the lock check before effectively trying
+	 * to acquire it on gsmi_shutdown_reason() to avoid
+	 * potential lockups in atomic context.
+	 */
+	if (spin_is_locked(&gsmi_dev.lock))
+		return NOTIFY_DONE;
+
 	gsmi_shutdown_reason(GSMI_SHUTDOWN_PANIC);
 	return NOTIFY_DONE;
 }
-- 
2.37.2

