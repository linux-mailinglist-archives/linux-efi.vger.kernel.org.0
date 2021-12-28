Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9010480AF4
	for <lists+linux-efi@lfdr.de>; Tue, 28 Dec 2021 16:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhL1PjK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Dec 2021 10:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbhL1PjK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Dec 2021 10:39:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89366C061574;
        Tue, 28 Dec 2021 07:39:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29E5F61196;
        Tue, 28 Dec 2021 15:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D9EC36AE8;
        Tue, 28 Dec 2021 15:39:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VGuCrq9g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640705947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANfqn58pkIJbbIFqryT56GHdUs/idxcpyxgLxPbdpfc=;
        b=VGuCrq9g45ctfoWWh9fS0Q+bf4HS8vN+Vm6j2ObeBJCcJhvcpK2vtiPUe/DdOK8EreiA+B
        RTSGeNvs2W3FBQ7kDeNVXwUV6QLQMZayjUXU46G8R1Iu8hcDnEqkCJ9maQ5UkRb4r6yuxT
        NjS9Owv+SDl227XtX7qls9/INeu3vbQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6bd5c1c0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 28 Dec 2021 15:39:07 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v7 4/4] random: mix bootloader randomness into pool
Date:   Tue, 28 Dec 2021 16:38:26 +0100
Message-Id: <20211228153826.448805-4-Jason@zx2c4.com>
In-Reply-To: <20211228153826.448805-1-Jason@zx2c4.com>
References: <CAHmME9qC2iX5EvDLj5YBZBdDJ_n8xTUYZT73qonsEhbKCwizFw@mail.gmail.com>
 <20211228153826.448805-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If we're trusting bootloader randomness, crng_fast_load() is called by
add_hwgenerator_randomness(), which sets us to crng_init==1. However, if
it's not called after that initial 64-byte push, it won't additionally
mix any bytes into the entropy pool. So it's conceivable that
crng_init==1 when later crng_initialize_primary() is called, but the
entropy pool is empty. When that happens, the crng state key will then
be overwritten with extracted output from the empty input pool. That's
bad.

In contrast, if we're not trusting bootloader randomness, we call
crng_slow_load() *and* we call mix_pool_bytes(), so that later
crng_initialize_primary() isn't drawing on nothing.

In order to prevent crng_initialize_primary() from extracting an empty
pool, have the trusted bootloader case mirror that of the untrusted
bootloader case, mixing the input into the pool.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 020443e34603..3499f6762ac1 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2298,6 +2298,7 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 
 	if (unlikely(crng_init == 0)) {
 		size_t ret = crng_fast_load(buffer, count);
+		mix_pool_bytes(poolp, buffer, ret);
 		count -= ret;
 		buffer += ret;
 		if (!count || crng_init == 0)
-- 
2.34.1

