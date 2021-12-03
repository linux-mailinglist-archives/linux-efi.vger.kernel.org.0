Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A8F4672FF
	for <lists+linux-efi@lfdr.de>; Fri,  3 Dec 2021 08:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379069AbhLCICl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Dec 2021 03:02:41 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:54580 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379056AbhLCICk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Dec 2021 03:02:40 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 6BFDD20136A;
        Fri,  3 Dec 2021 07:59:14 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 4FE1320C52; Fri,  3 Dec 2021 08:58:26 +0100 (CET)
Date:   Fri, 3 Dec 2021 08:58:26 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, "Ivan T. Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, hsinyi@chromium.org
Subject: [PATCH v4] random: fix crash on multiple early calls to
 add_bootloader_randomness()
Message-ID: <YanOIvAV1iPBEXR3@light.dominikbrodowski.net>
References: <20211012082708.121931-1-iivanov@suse.de>
 <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YaivhAV8LouB0zGV@light.dominikbrodowski.net>
 <CAHmME9qxBeBzfKCjzfAFX9ZWAGKv1TKCQw3x22d_DmJtaAewLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qxBeBzfKCjzfAFX9ZWAGKv1TKCQw3x22d_DmJtaAewLw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Jason,

Am Thu, Dec 02, 2021 at 11:55:10AM -0500 schrieb Jason A. Donenfeld:
> Thanks for the patch. One trivial nit and one question:

Thanks for your review!

> On Thu, Dec 2, 2021 at 6:35 AM Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> > +       /* We cannot do much with the input pool until it is set up in
> > +        * rand_initalize(); therefore just mix into the crng state.
> 
> I think you meant "rand_initialize()" here (missing 'i').

Indeed, sorry about that.

> > If the added entropy suffices to increase crng_init to 1, future calls
> > to add_bootloader_randomness() or add_hwgenerator_randomness() used to
> > progress to credit_entropy_bits(). However, if the input pool is not yet
> > properly set up, the cmpxchg call within that function can lead to an
> > infinite recursion.
> 
> I see what this patch does with crng_global_init_time, and that seems
> probably sensible, but I didn't understand this part of the reasoning
> in the commit message; I might just be a bit slow here. Where's the
> recursion exactly? Or even an infinite loop?

On arm64, it was actually a NULL pointer dereference reported by Ivan T.
Ivanov; see

	https://lore.kernel.org/lkml/20211012082708.121931-1-iivanov@suse.de/

Trying to reproduce this rather bluntly on x86/qemu by multiple manual calls
to add_bootloader_randomness(), I mis-interpreted the symptoms to point to an
infinite recursion. The real problem seems to be that crng_reseed() isn't
ready to be called too early in the boot process, in particular before
workqueues are ready (see the call to numa_crng_init()).

However, there seem be additional issues with add_bootloader_randomness()
not yet addressed (or worsened) by my patch:

	- If CONFIG_RANDOM_TRUST_BOOTLOADER is enabled and crng_init==0,
	  add_hwgenerator_randomness() calls crng_fast_load() and returns
	  immediately. If it is disabled and crng_init==0,
	  add_device_randnomness() calls crng_slow_load() but still
	  continues to call _mix_pool_bytes(). That means the seed is
	  used more extensively if CONFIG_RANDOM_TRUST_BOOTLOADER is not
	  set!

	- If CONFIG_RANDOM_TRUST_BOOTLOADER is enabled and crng_init==0,
	  the entropy is not credited -- same as if
	  CONFIG_RANDOM_TRUST_BOOTLOADER is not set. Only subsequent calls
	  to add_bootloader_randomness() would credit entropy, but that
	  causes the issue NULL pointer dereference or the hang...

	- As crng_fast_load() returns early, that actually means that my
	  patch causes the additional entropy submitted to
	  add_hwgenerator_randomness() by subsequent calls to be completely
	  lost.

	- For add_bootloader_randomness(), it makes no sense at all to call
	  wait_event_interruptible().

Therefore, it might make more sense to

	- modify add_bootloader_randomness() to always call
	  add_device_randomness(), and if CONFIG_RANDOM_TRUST_BOOTLOADER is
	  enabled, to call credit_entropy_bits().

	- update credit_entropy_bits() to not call credit_entropy_bits()
	  if crng_global_init_time==0, as workqueues (and possibly other
	  infrastructure) might not be available at that time.

What do you think? Draft patch below. @Ivan: Could you re-test on your
system, please?

Thanks,
	Dominik

---

Currently, if CONFIG_RANDOM_TRUST_BOOTLOADER is enabled, mutliple calls
to add_bootloader_randomness() are broken and can cause a NULL pointer
dereference, as noted by Ivan T. Ivanov. This is not only a hypothetical
problem, as qemu on arm64 may provide bootloader entropy via EFI and via
devicetree.

On the first call to add_hwgenerator_randomness(), crng_fast_load() is
executed, and if the seed is long enough, crng_init will be set to 1.
However, no entropy is currently credited for that, even though the
name and description of CONFIG_RANDOM_TRUST_BOOTLOADER states otherwise.

On subsequent calls to add_bootloader_randomness() and then to
add_hwgenerator_randomness(), crng_fast_load() will be skipped. Instead,
wait_event_interruptible() (which makes no sense for the init process)
and then credit_entropy_bits() will be called. If the entropy count for
that second seed is large enough, that proceeds to crng_reseed().
However, crng_reseed() may depend on workqueues being available, which
is not the case early during boot.

To fix these issues, unconditionally call add_device_randomness() but not
add_hwgenerator_randomness() in add_bootloader_randomness(). This has the
additional advantage that the seed provided by the first call to
add_bootloader_randomness() is not only used by crng_{fast,slow}_load(),
but also mixed into the input pool. If CONFIG_RANDOM_TRUST_BOOTLOADER is
set, explicitly credit the entropy. However, avoid a call to crng_reseed()
too early during boot. It is safe to be called after rand_initialize(),
so use crng_global_init_time (which is set to != 0 in that function) to
determine which branch to take.

Reported-by: Ivan T. Ivanov <iivanov@suse.de>
Fixes: 18b915ac6b0a ("efi/random: Treat EFI_RNG_PROTOCOL output as bootloader randomness")
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---
v3->v4: complete rewrite
v2->v3: only one unlikely (Ard Biesheuvel)
v1->v2: fix commit message; unmerge Reported-and-tested-by-tag (Ard Biesheuvel)


diff --git a/drivers/char/random.c b/drivers/char/random.c
index 605969ed0f96..d8614b426dfb 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -722,7 +722,8 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 	if (r == &input_pool) {
 		int entropy_bits = entropy_count >> ENTROPY_SHIFT;
 
-		if (crng_init < 2 && entropy_bits >= 128)
+		if (crng_init < 2 && entropy_bits >= 128 &&
+		    crng_global_init_time > 0)
 			crng_reseed(&primary_crng, r);
 	}
 }
@@ -1763,8 +1764,8 @@ static void __init init_std_data(struct entropy_store *r)
 }
 
 /*
- * Note that setup_arch() may call add_device_randomness()
- * long before we get here. This allows seeding of the pools
+ * add_device_randomness() or add_bootloader_randomness() may be
+ * called long before we get here. This allows seeding of the pools
  * with some platform dependent data very early in the boot
  * process. But it limits our options here. We must use
  * statically allocated structures that already have all
@@ -2291,15 +2292,13 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
 
 /* Handle random seed passed by bootloader.
- * If the seed is trustworthy, it would be regarded as hardware RNGs. Otherwise
- * it would be regarded as device data.
+ * If the seed is trustworthy, its entropy will be credited.
  * The decision is controlled by CONFIG_RANDOM_TRUST_BOOTLOADER.
  */
 void add_bootloader_randomness(const void *buf, unsigned int size)
 {
+	add_device_randomness(buf, size);
 	if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
-		add_hwgenerator_randomness(buf, size, size * 8);
-	else
-		add_device_randomness(buf, size);
+		credit_entropy_bits(&input_pool, size * 8);
 }
 EXPORT_SYMBOL_GPL(add_bootloader_randomness);
