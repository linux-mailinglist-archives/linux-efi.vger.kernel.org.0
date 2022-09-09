Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503855B4055
	for <lists+linux-efi@lfdr.de>; Fri,  9 Sep 2022 22:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiIIUI0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Sep 2022 16:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIIUIZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Sep 2022 16:08:25 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC085BD75D;
        Fri,  9 Sep 2022 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HA7Uy5oRnhI96bvv26nvlUGrOXxQG8yAcX5TDStsA9A=; b=cQXI/T11+BWlzLJJP5tHVFQR4c
        5i/eVkQQ575n6Mjw/LImE8yb0QabditV4Od+STVQUKcfiwpvjI/QbcMnxyVk3q8NqlSbtrY9g6oi6
        vTQndosIgDFTy4/vwMZIWinoCFafOWrQVDzecutDxPEogzlhtfwrdMtplgPYXf3QzhTSJgLmqvw5Q
        kTjsLp1dTYpLcJdYv+QmwWgdUMyJN8yO5fN00dI+fuqjPpMXVIDcYny5xottm0563fWMOkOou5oi7
        LYRf6m/nOKpYsSp8kBlRYRxynJQd7WKJNcKN1rrVIKIZs8SDndDspezghmog2yh2F82bdvrnQot+j
        N1bNmOLg==;
Received: from [177.215.76.177] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oWkIX-00E6gL-52; Fri, 09 Sep 2022 22:08:21 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, kernel@gpiccoli.net,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julius Werner <jwerner@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH V4] firmware: google: Test spinlock on panic path to avoid lockups
Date:   Fri,  9 Sep 2022 17:07:55 -0300
Message-Id: <20220909200755.189679-1-gpiccoli@igalia.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: David Gow <davidgow@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


Hey folks, new version - V3 available at [0].

@Greg, I think the panic situation is well-described in the commit
message so I didn't rework that, lemme know if you want to add
something to the text.

@Evan, I kept your review tag even with the comment change, based on
the V3 discussion. Lemme know if you want it removed in case you
disagree with something!

V4:
* Reworked comment (thanks Andrew, for the suggestion!);
* Rebased against 6.0-rc4;
* Included more CCs (Andrew, Petr).

[0] https://lore.kernel.org/linux-kernel/20220819155059.451674-1-gpiccoli@igalia.com/


 drivers/firmware/google/gsmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index adaa492c3d2d..4e2575dfeb90 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -681,6 +681,15 @@ static struct notifier_block gsmi_die_notifier = {
 static int gsmi_panic_callback(struct notifier_block *nb,
 			       unsigned long reason, void *arg)
 {
+
+	/*
+	 * Panic callbacks are executed with all other CPUs stopped,
+	 * so we must not attempt to spin waiting for gsmi_dev.lock
+	 * to be released.
+	 */
+	if (spin_is_locked(&gsmi_dev.lock))
+		return NOTIFY_DONE;
+
 	gsmi_shutdown_reason(GSMI_SHUTDOWN_PANIC);
 	return NOTIFY_DONE;
 }
-- 
2.37.2

