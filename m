Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C779050E
	for <lists+linux-efi@lfdr.de>; Fri, 16 Aug 2019 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfHPP5h (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Aug 2019 11:57:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42650 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbfHPP5h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Aug 2019 11:57:37 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hyebf-00047L-ES; Fri, 16 Aug 2019 17:57:35 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] efi: Disable runtime services on RT
Date:   Fri, 16 Aug 2019 17:57:29 +0200
Message-Id: <20190816155729.12518-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190816155729.12518-1-bigeasy@linutronix.de>
References: <20190816155729.12518-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Based on meassurements the EFI functions get_variable /
get_next_variable take up to 2us which looks okay.
The functions get_time, set_time take around 10ms. Those 10ms are too
much. Even one ms would be too much.
Ard mentioned that SetVariable might even trigger larger latencies if
the firware will erase flash blocks on NOR.

The time-functions are used by efi-rtc and can be triggered during
runtimed (either via explicit read/write or ntp sync).

The variable write could be used by pstore.
These functions can be disabled without much of a loss. The poweroff /
reboot hooks may be provided by PSCI.

Disable EFI's runtime wrappers.

This was observed on "EFI v2.60 by SoftIron Overdrive 1000".

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/firmware/efi/efi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -88,7 +88,7 @@ struct mm_struct efi_mm =3D {
=20
 struct workqueue_struct *efi_rts_wq;
=20
-static bool disable_runtime;
+static bool disable_runtime =3D IS_ENABLED(CONFIG_PREEMPT_RT);
 static int __init setup_noefi(char *arg)
 {
 	disable_runtime =3D true;
