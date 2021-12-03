Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D717467BBE
	for <lists+linux-efi@lfdr.de>; Fri,  3 Dec 2021 17:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbhLCQvP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Dec 2021 11:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhLCQvM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Dec 2021 11:51:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B87C061751;
        Fri,  3 Dec 2021 08:47:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AC9D629F0;
        Fri,  3 Dec 2021 16:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1511C53FCD;
        Fri,  3 Dec 2021 16:47:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IjFJ+kAu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638550065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=22CT7nkuhiK6eO5WOZjdGRvypSs0c9qMdKw22cAO/GI=;
        b=IjFJ+kAuPQY8+czixhQsh668xb/89zi5BjlEhOagrwbksKMG2ljXwe/9MEQ9ey7+tfyeBq
        u/bumx1tM10GftxEQ3MrLnfPsl2Ee7/mdwsuZG5oHDk6PSYHkYN/0+ScCd7myv1RAKT8Vx
        mnA4R1G57jeilKcVt+IzWzWCYhUZSUE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9f4b23e7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 3 Dec 2021 16:47:45 +0000 (UTC)
Message-ID: <b2a5b4a7-4aee-558c-5558-549fd2998165@zx2c4.com>
Date:   Fri, 3 Dec 2021 17:47:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4] random: fix crash on multiple early calls to
 add_bootloader_randomness()
Content-Language: en-US
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Theodore Ts'o <tytso@mit.edu>, "Ivan T. Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, hsinyi@chromium.org
References: <20211012082708.121931-1-iivanov@suse.de>
 <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YaivhAV8LouB0zGV@light.dominikbrodowski.net>
 <CAHmME9qxBeBzfKCjzfAFX9ZWAGKv1TKCQw3x22d_DmJtaAewLw@mail.gmail.com>
 <YanOIvAV1iPBEXR3@light.dominikbrodowski.net>
 <CAHmME9qGHo4n6QGxnE+O46pagOR0bA+9E8bi8ZLPAzMuMZpPwg@mail.gmail.com>
In-Reply-To: <CAHmME9qGHo4n6QGxnE+O46pagOR0bA+9E8bi8ZLPAzMuMZpPwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/3/21 16:39, Jason A. Donenfeld wrote:
> Hi Dominik,
> 
> Thanks for your analysis. Some more questions:
> 
> On Fri, Dec 3, 2021 at 8:59 AM Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
>> On subsequent calls to add_bootloader_randomness() and then to
>> add_hwgenerator_randomness(), crng_fast_load() will be skipped. Instead,
>> wait_event_interruptible() (which makes no sense for the init process)
>> and then credit_entropy_bits() will be called. If the entropy count for
>> that second seed is large enough, that proceeds to crng_reseed().
>> However, crng_reseed() may depend on workqueues being available, which
>> is not the case early during boot.
> 
> It sounds like *the* issue you've identified is that crng_reseed()
> calls into workqueue functions too early in init, right? The bug is
> about paths into crng_reseed() that might cause that?
> 
> If so, then specifically, are you referring to crng_reseed()'s call to
> numa_crng_init()? In other words, the cause of the bug would be
> 6c1e851c4edc ("random: fix possible sleeping allocation from irq
> context")? If that's the case, then I wonder if the problem you're
> seeing goes away if you revert both 6c1e851c4edc ("random: fix
> possible sleeping allocation from irq context") and its primary
> predecessor, 8ef35c866f88 ("random: set up the NUMA crng instances
> after the CRNG is fully initialized"). These fix an actual bug, so I'm
> not suggesting we actually revert these in the tree, but for the
> purpose of testing, I'm wondering if this is actually the root cause
> of the bug you're seeing.

If the above holds, I wonder if something more basic like the below 
would do the trick -- deferring the bringup of the secondary pools until 
later on in rand_initialize.

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c81485e2f126..e71b34bf9a2a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -832,7 +832,6 @@ static void __init crng_initialize_primary(struct 
crng_state *crng)
  	_extract_entropy(&input_pool, &crng->state[4], sizeof(__u32) * 12, 0);
  	if (crng_init_try_arch_early(crng) && trust_cpu) {
  		invalidate_batched_entropy();
-		numa_crng_init();
  		crng_init = 2;
  		pr_notice("crng done (trusting CPU's manufacturer)\n");
  	}
@@ -840,13 +839,13 @@ static void __init crng_initialize_primary(struct 
crng_state *crng)
  }

  #ifdef CONFIG_NUMA
-static void do_numa_crng_init(struct work_struct *work)
+static void numa_crng_init(void)
  {
  	int i;
  	struct crng_state *crng;
  	struct crng_state **pool;

-	pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL|__GFP_NOFAIL);
+	pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL | __GFP_NOFAIL);
  	for_each_online_node(i) {
  		crng = kmalloc_node(sizeof(struct crng_state),
  				    GFP_KERNEL | __GFP_NOFAIL, i);
@@ -861,13 +860,6 @@ static void do_numa_crng_init(struct work_struct *work)
  		kfree(pool);
  	}
  }
-
-static DECLARE_WORK(numa_crng_init_work, do_numa_crng_init);
-
-static void numa_crng_init(void)
-{
-	schedule_work(&numa_crng_init_work);
-}
  #else
  static void numa_crng_init(void) {}
  #endif
@@ -977,7 +969,6 @@ static void crng_reseed(struct crng_state *crng, 
struct entropy_store *r)
  	spin_unlock_irqrestore(&crng->lock, flags);
  	if (crng == &primary_crng && crng_init < 2) {
  		invalidate_batched_entropy();
-		numa_crng_init();
  		crng_init = 2;
  		process_random_ready_list();
  		wake_up_interruptible(&crng_init_wait);
@@ -1787,6 +1778,7 @@ int __init rand_initialize(void)
  {
  	init_std_data(&input_pool);
  	crng_initialize_primary(&primary_crng);
+	numa_crng_init();
  	crng_global_init_time = jiffies;
  	if (ratelimit_disable) {
  		urandom_warning.interval = 0;


