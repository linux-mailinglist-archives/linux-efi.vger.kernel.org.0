Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972B7417636
	for <lists+linux-efi@lfdr.de>; Fri, 24 Sep 2021 15:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346343AbhIXNvA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Sep 2021 09:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346371AbhIXNu6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Sep 2021 09:50:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634FDC06161E
        for <linux-efi@vger.kernel.org>; Fri, 24 Sep 2021 06:49:25 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632491364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8rYfJKOmyHPZnSBm5/o0aiAKI29bYyCCerMqYXattBc=;
        b=kT62mpR4OCHz1QiluCeRF0KRak1YzdHrT8MZVehBdoQD9nNQQLQ2tQqWS3LRQpEakVb2wH
        GlKWgVGoZwz1Xew2fA8QAfWd6mZhXueqfXm2wiIDpkl8w9sUcfNJNs14LYkco6SnPeJ7vF
        mSNX2ByA2I8KGa/c2XTr9SBw9T/ivZrpZO3KGSrQnGX5cucQH5pnH4DbtBvdQjnBfa5tf5
        f7UXj4qg31ZlAgjZ1wkljeJlRjac2rI29STwK3ihlCihsWvJbYdgQIi2zWfuqfCUiWH8Ua
        ziZX58rwJc7MI1suLf4gfbHoq4OAXtIQZ/Flb3IjhrF397A8onxFTw2uRQRr/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632491364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8rYfJKOmyHPZnSBm5/o0aiAKI29bYyCCerMqYXattBc=;
        b=i3tgeELHM3KZXrgeIz6OH6K5F3m1mWZga7gPc1gZtun2CGZlvxh+2y00rQOuWfOGfzpMwC
        ccmanBbuf2UNYBDA==
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 1/2] efi: Disable runtime services on RT
Date:   Fri, 24 Sep 2021 15:49:18 +0200
Message-Id: <20210924134919.1913476-2-bigeasy@linutronix.de>
In-Reply-To: <20210924134919.1913476-1-bigeasy@linutronix.de>
References: <20210924134919.1913476-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Based on measurements the EFI functions get_variable /
get_next_variable take up to 2us which looks okay.
The functions get_time, set_time take around 10ms. These 10ms are too
much. Even one ms would be too much.
Ard mentioned that SetVariable might even trigger larger latencies if
the firmware will erase flash blocks on NOR.

The time-functions are used by efi-rtc and can be triggered during
run-time (either via explicit read/write or ntp sync).

The variable write could be used by pstore.
These functions can be disabled without much of a loss. The poweroff /
reboot hooks may be provided by PSCI.

Disable EFI's runtime wrappers on PREEMPT_RT.

This was observed on "EFI v2.60 by SoftIron Overdrive 1000".

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 847f33ffc4aed..39031cfcb6b92 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -66,7 +66,7 @@ struct mm_struct efi_mm =3D {
=20
 struct workqueue_struct *efi_rts_wq;
=20
-static bool disable_runtime;
+static bool disable_runtime =3D IS_ENABLED(CONFIG_PREEMPT_RT);
 static int __init setup_noefi(char *arg)
 {
 	disable_runtime =3D true;
--=20
2.33.0

