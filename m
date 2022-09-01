Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E245A9F5B
	for <lists+linux-efi@lfdr.de>; Thu,  1 Sep 2022 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiIASqu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Sep 2022 14:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiIASqj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Sep 2022 14:46:39 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240F4B498;
        Thu,  1 Sep 2022 11:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XRAc12CEffd6UPewH7ccY0GIxlcGsZ0nDr5uMann2po=; b=LrIm/0Nee/5kQPChCwKM5mR7cS
        x/tkmOjSOkF21LeaUXzbtHiYXJ2G2eDB6PjOHrdhA2NLbODRKysIiHWX2Po/jLSxA73LX6AIjwYpo
        uCDMRwWffp9Kg0N64hh/CRmZC7fZcdH3jRzGf/QBtsIG+2D62NB6yaZUbjUg7yneBzT2wipVCed1D
        4DmdJ7Vqo2DmckjAUvu07vzR3BOLdjqRWCUSL4VI7ycxabym8A6kaMOb9fBZJNXoFafQWFaltEg6v
        r6IJYn+myeJlTUWsnMrHYZukWw90sMtyav3tRe2tTXpkn07uGfn8Uu7z8pyTHbB1qq7eVnevSVL4u
        KuIgAf0Q==;
Received: from 189-69-202-182.dial-up.telesp.net.br ([189.69.202.182] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oTpCz-007tqI-1P; Thu, 01 Sep 2022 20:46:33 +0200
Message-ID: <b050f00b-6c3a-a0d9-a3c1-175a724faf1c@igalia.com>
Date:   Thu, 1 Sep 2022 15:46:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3] firmware: google: Test spinlock on panic path to avoid
 lockups
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     evgreen@chromium.org, arnd@arndb.de, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@gpiccoli.net, ardb@kernel.org,
        davidgow@google.com, jwerner@chromium.org,
        Petr Mladek <pmladek@suse.com>
References: <20220819155059.451674-1-gpiccoli@igalia.com>
 <YxDVPqVkdgQbAIvY@kroah.com>
 <f89cd87c-7d1c-d8e6-ed95-6876f0201872@igalia.com>
 <YxDX9+p+58q2sip2@kroah.com>
 <6bc5dbc3-2cdd-5cb8-1632-11de2008a85a@igalia.com>
 <YxDhiSDs4YcUrqV5@kroah.com>
 <85683284-db85-7e3a-57bd-750e1c204e3e@igalia.com>
 <YxD56RTI9v/P2QOL@kroah.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YxD56RTI9v/P2QOL@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 01/09/2022 15:28, Greg KH wrote:
> [...]
>> I honestly didn't understand exactly what you're suggesting Greg...
>> Mind clarifying?
> 
> Something like this totally untested code:
> 
> diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
> index adaa492c3d2d..6ad41b22671c 100644
> --- a/drivers/firmware/google/gsmi.c
> +++ b/drivers/firmware/google/gsmi.c
> @@ -19,6 +19,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/fs.h>
>  #include <linux/slab.h>
> +#include <linux/panic.h>
>  #include <linux/panic_notifier.h>
>  #include <linux/ioctl.h>
>  #include <linux/acpi.h>
> @@ -611,6 +612,11 @@ static const struct attribute *gsmi_attrs[] = {
>  	NULL,
>  };
>  
> +static bool panic_in_progress(void)
> +{
> +	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
> +}
> +
>  static int gsmi_shutdown_reason(int reason)
>  {
>  	struct gsmi_log_entry_type_1 entry = {
> @@ -629,7 +635,8 @@ static int gsmi_shutdown_reason(int reason)
>  	if (saved_reason & (1 << reason))
>  		return 0;
>  
> -	spin_lock_irqsave(&gsmi_dev.lock, flags);
> +	if (!panic_in_progress())
> +		spin_lock_irqsave(&gsmi_dev.lock, flags);
>  
>  	saved_reason |= (1 << reason);
>  
> @@ -644,7 +651,8 @@ static int gsmi_shutdown_reason(int reason)
>  
>  	rc = gsmi_exec(GSMI_CALLBACK, GSMI_CMD_SET_EVENT_LOG);
>  
> -	spin_unlock_irqrestore(&gsmi_dev.lock, flags);
> +	if (!panic_in_progress())
> +		spin_unlock_irqrestore(&gsmi_dev.lock, flags);
>  
>  	if (rc < 0)
>  		printk(KERN_ERR "gsmi: Log Shutdown Reason failed\n");
> 
> 
>

Thanks! Personally, I feel the approach a bit more complex than mine,
and...racy!
Imagine CPU0 runs your tests, right after the if (!panic_in_progress())
is done, spinlock is taken and boom - panic on CPU1. This would cause
the same issue...

My approach is zero racy, since it checks if spinlock was taken in a
moment that the machine is like a no-SMP, only a single CPU running...


> That being said, are you sure spinlocks are still held in the panic
> notifier?  What about the call to bust_spinlocks() that is called in
> panic() already?  Wouldn't that have already dropped whatever you were
> worried about here?

This function is very weird. Basically, the call of "bust_spinlocks(1);"
in panic effectively means "++oops_in_progress;" IIUC.
So, I still think we can have lockups in panic notifiers with locks
previously taken =)

Cheers,


Guilherme
