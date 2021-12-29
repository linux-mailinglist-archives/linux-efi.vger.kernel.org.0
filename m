Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17794816FD
	for <lists+linux-efi@lfdr.de>; Wed, 29 Dec 2021 22:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhL2VNz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Dec 2021 16:13:55 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:33350 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhL2VNw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Dec 2021 16:13:52 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 90B5E201373;
        Wed, 29 Dec 2021 21:13:48 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 5E8B980F57; Wed, 29 Dec 2021 22:10:18 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux@dominikbrodowski.net
Subject: [PATCH v8 4/7] random: mix bootloader randomness into pool
Date:   Wed, 29 Dec 2021 22:10:06 +0100
Message-Id: <20211229211009.108091-4-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229211009.108091-1-linux@dominikbrodowski.net>
References: <20211228153826.448805-1-Jason@zx2c4.com>
 <20211229211009.108091-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

If we're trusting bootloader randomness, crng_fast_load() is called by
add_hwgenerator_randomness(), which sets us to crng_init==1. However,
usually it is only called once for an initial 64-byte push, so bootloader
entropy will not mix any bytes into the input pool. So it's conceivable
that crng_init==1 when crng_initialize_primary() is called later, but
then the input pool is empty. When that happens, the crng state key will
be overwritten with extracted output from the empty input pool. That's
bad.

In contrast, if we're not trusting bootloader randomness, we call
crng_slow_load() *and* we call mix_pool_bytes(), so that later
crng_initialize_primary() isn't drawing on nothing.

In order to prevent crng_initialize_primary() from extracting an empty
pool, have the trusted bootloader case mirror that of the untrusted
bootloader case, mixing the input into the pool.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
[linux@dominikbrodowski.net: rewrite commit message]
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/random.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 21166188b7e1..9d4e1907e4b1 100644
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

