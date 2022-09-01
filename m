Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6205A9F7B
	for <lists+linux-efi@lfdr.de>; Thu,  1 Sep 2022 20:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiIAS72 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Sep 2022 14:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiIAS71 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Sep 2022 14:59:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06AE753AB;
        Thu,  1 Sep 2022 11:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81C23B828F0;
        Thu,  1 Sep 2022 18:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98892C433D6;
        Thu,  1 Sep 2022 18:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662058764;
        bh=5fU70Ychqi0YYh788VsTJeDlLacntWYEQlFqq4z4IZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFlsCqygHYWv9aKauP3+SSgNjBuZyoilzR7aFbL2d8WrJ+SmjrXbGBhpw+8+PuiEL
         1qLfZ5lrLz1yL6FAJrGUtj86Pov+pkGp8bkCRETnMkIvOa/iSRkFHHry0Tmmvfj0lW
         cNTGV/ZTmukuQK1Tafr/1QJW7WB2XKYQjQVQ/pN4=
Date:   Thu, 1 Sep 2022 20:59:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     evgreen@chromium.org, arnd@arndb.de, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@gpiccoli.net, ardb@kernel.org,
        davidgow@google.com, jwerner@chromium.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH V3] firmware: google: Test spinlock on panic path to
 avoid lockups
Message-ID: <YxEBCVRgWE8VTZaf@kroah.com>
References: <20220819155059.451674-1-gpiccoli@igalia.com>
 <YxDVPqVkdgQbAIvY@kroah.com>
 <f89cd87c-7d1c-d8e6-ed95-6876f0201872@igalia.com>
 <YxDX9+p+58q2sip2@kroah.com>
 <6bc5dbc3-2cdd-5cb8-1632-11de2008a85a@igalia.com>
 <YxDhiSDs4YcUrqV5@kroah.com>
 <85683284-db85-7e3a-57bd-750e1c204e3e@igalia.com>
 <YxD56RTI9v/P2QOL@kroah.com>
 <b050f00b-6c3a-a0d9-a3c1-175a724faf1c@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b050f00b-6c3a-a0d9-a3c1-175a724faf1c@igalia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 01, 2022 at 03:46:17PM -0300, Guilherme G. Piccoli wrote:
> On 01/09/2022 15:28, Greg KH wrote:
> > [...]
> >> I honestly didn't understand exactly what you're suggesting Greg...
> >> Mind clarifying?
> > 
> > Something like this totally untested code:
> > 
> > diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
> > index adaa492c3d2d..6ad41b22671c 100644
> > --- a/drivers/firmware/google/gsmi.c
> > +++ b/drivers/firmware/google/gsmi.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/dma-mapping.h>
> >  #include <linux/fs.h>
> >  #include <linux/slab.h>
> > +#include <linux/panic.h>
> >  #include <linux/panic_notifier.h>
> >  #include <linux/ioctl.h>
> >  #include <linux/acpi.h>
> > @@ -611,6 +612,11 @@ static const struct attribute *gsmi_attrs[] = {
> >  	NULL,
> >  };
> >  
> > +static bool panic_in_progress(void)
> > +{
> > +	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
> > +}
> > +
> >  static int gsmi_shutdown_reason(int reason)
> >  {
> >  	struct gsmi_log_entry_type_1 entry = {
> > @@ -629,7 +635,8 @@ static int gsmi_shutdown_reason(int reason)
> >  	if (saved_reason & (1 << reason))
> >  		return 0;
> >  
> > -	spin_lock_irqsave(&gsmi_dev.lock, flags);
> > +	if (!panic_in_progress())
> > +		spin_lock_irqsave(&gsmi_dev.lock, flags);
> >  
> >  	saved_reason |= (1 << reason);
> >  
> > @@ -644,7 +651,8 @@ static int gsmi_shutdown_reason(int reason)
> >  
> >  	rc = gsmi_exec(GSMI_CALLBACK, GSMI_CMD_SET_EVENT_LOG);
> >  
> > -	spin_unlock_irqrestore(&gsmi_dev.lock, flags);
> > +	if (!panic_in_progress())
> > +		spin_unlock_irqrestore(&gsmi_dev.lock, flags);
> >  
> >  	if (rc < 0)
> >  		printk(KERN_ERR "gsmi: Log Shutdown Reason failed\n");
> > 
> > 
> >
> 
> Thanks! Personally, I feel the approach a bit more complex than mine,
> and...racy!
> Imagine CPU0 runs your tests, right after the if (!panic_in_progress())
> is done, spinlock is taken and boom - panic on CPU1. This would cause
> the same issue...

True, it would, but so would yours if the unlock happens and then your
test passes and then this lock is taken and then a panic happens.

There's no "race free" way here perhaps.  The joys of notifier chains (I
hate the things...)

> My approach is zero racy, since it checks if spinlock was taken in a
> moment that the machine is like a no-SMP, only a single CPU running...

Ah, I missed that this path is only called if an panic is happening.
Well, also a reboot.

Ick, I don't know, this all feels odd.  I want someone else to review
this and give their ack on the patch before I'll take it so someone else
can share in the blame :)

thanks,

greg k-h
