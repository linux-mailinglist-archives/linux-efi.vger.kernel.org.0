Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F18480AF0
	for <lists+linux-efi@lfdr.de>; Tue, 28 Dec 2021 16:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbhL1PjD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Dec 2021 10:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbhL1PjC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Dec 2021 10:39:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2B4C061574;
        Tue, 28 Dec 2021 07:39:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57FA261237;
        Tue, 28 Dec 2021 15:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C58C36AE8;
        Tue, 28 Dec 2021 15:38:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FbFcvSIr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640705938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKTCkze0hqaEdMZ/cQLq0jKRXzl988fPbiom7x0AOK0=;
        b=FbFcvSIrWpVOOp++CfrP+mN1d4RAvR3bpETqJR5mATNe5c9918qwwZkySRY1V1LnTdYQ+g
        vD7ze4p+/cWvoPXFwCem3IQXbfjHH2l+X0pREr5MMngZp1reHdDn1pqOhaPvrY4tVKZgQ/
        USBaA/NMHtmvlfWfXiZtUbCjOkRTDok=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1055957f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 28 Dec 2021 15:38:58 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v7 2/4] random: do not re-init if crng_reseed completes before primary init
Date:   Tue, 28 Dec 2021 16:38:24 +0100
Message-Id: <20211228153826.448805-2-Jason@zx2c4.com>
In-Reply-To: <20211228153826.448805-1-Jason@zx2c4.com>
References: <CAHmME9qC2iX5EvDLj5YBZBdDJ_n8xTUYZT73qonsEhbKCwizFw@mail.gmail.com>
 <20211228153826.448805-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If the bootloader supplies sufficient material and crng_reseed() is called
very early on, but not too early that wqs aren't available yet, then we
might transition to crng_init==2 before rand_initialize()'s call to
crng_initialize_primary() made. Then, when crng_initialize_primary() is
called, if we're trusting the CPU's RDRAND instructions, we'll
needlessly reinitialize the RNG and emit a message about it. This is
mostly harmless, as numa_crng_init() will allocate and then free what it
just allocated, and excessive calls to invalidate_batched_entropy()
aren't so harmful. But it is funky and the extra message is confusing,
so avoid the re-initialization all together by checking for crng_init <
2 in crng_initialize_primary(), just as we already do in crng_reseed().

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b003e266a499..95aac486177e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -827,7 +827,7 @@ static void __init crng_initialize_primary(struct crng_state *crng)
 {
 	chacha_init_consts(crng->state);
 	_extract_entropy(&input_pool, &crng->state[4], sizeof(__u32) * 12, 0);
-	if (crng_init_try_arch_early(crng) && trust_cpu) {
+	if (crng_init_try_arch_early(crng) && trust_cpu && crng_init < 2) {
 		invalidate_batched_entropy();
 		numa_crng_init();
 		crng_init = 2;
-- 
2.34.1

