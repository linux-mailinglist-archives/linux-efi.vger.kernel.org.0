Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B21862F70A
	for <lists+linux-efi@lfdr.de>; Fri, 18 Nov 2022 15:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbiKROR6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Nov 2022 09:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242364AbiKRORb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Nov 2022 09:17:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0776E572;
        Fri, 18 Nov 2022 06:16:53 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 253C11FABB;
        Fri, 18 Nov 2022 14:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668781012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kZ58kSNPkg2axHTVODVsT4bVIql8VHmIU+fBPlfAvdk=;
        b=p3lzwGcZoFIPOO8U6H5tkUoGie6Ga+jjn1bs45YnUt9ie9/ZFUuEvHKsdBa7BghVCez2Fc
        BZkmlBTfI1druGJj0hWdMBlsWH29+AodUdWsiHY0HnNklwYxTJ14Xe5iJJL9MEQdvBZY58
        SpN+qSLHeJKYzMx/O9w02yfgbketBhw=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EBF712C141;
        Fri, 18 Nov 2022 14:16:51 +0000 (UTC)
Date:   Fri, 18 Nov 2022 15:16:49 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RFC v1 2/6] vsprintf: initialize siphash key using
 notifier
Message-ID: <Y3eT0fd/t270Qeaj@alley>
References: <20221116161642.1670235-1-Jason@zx2c4.com>
 <20221116161642.1670235-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116161642.1670235-3-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed 2022-11-16 17:16:38, Jason A. Donenfeld wrote:
> Rather than polling every second, use the new notifier to do this at
> exactly the right moment.

Great news!

> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -752,26 +753,21 @@ early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
>  
>  static bool filled_random_ptr_key __read_mostly;
>  static siphash_key_t ptr_key __read_mostly;
> -static void fill_ptr_key_workfn(struct work_struct *work);
> -static DECLARE_DELAYED_WORK(fill_ptr_key_work, fill_ptr_key_workfn);
>  
> -static void fill_ptr_key_workfn(struct work_struct *work)
> +static int fill_ptr_key(struct notifier_block *nb, unsigned long action, void *data)
>  {
> -	if (!rng_is_initialized()) {
> -		queue_delayed_work(system_unbound_wq, &fill_ptr_key_work, HZ  * 2);
> -		return;
> -	}
> -
>  	get_random_bytes(&ptr_key, sizeof(ptr_key));
>  
>  	/* Pairs with smp_rmb() before reading ptr_key. */
>  	smp_wmb();
>  	WRITE_ONCE(filled_random_ptr_key, true);
> +	return 0;

I believe that we should rather return NOTIFY_DONE here.
It is rather a formal change. The value is 0 as well.

That said, I have never really understood the difference between
NOTIFY_OK and NOTIFY_DONE.

>  }
>  
>  static int __init vsprintf_init_hashval(void)
>  {
> -	fill_ptr_key_workfn(NULL);
> +	static struct notifier_block fill_ptr_key_nb = { .notifier_call = fill_ptr_key };
> +	notify_on_rng_initialized(&fill_ptr_key_nb);
>  	return 0;
>  }
>  subsys_initcall(vsprintf_init_hashval)

Anyway, the code looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
