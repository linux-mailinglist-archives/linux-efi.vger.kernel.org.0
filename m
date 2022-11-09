Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8717062349E
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 21:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiKIUbp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 15:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiKIUbe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 15:31:34 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6A5303DE;
        Wed,  9 Nov 2022 12:31:32 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2D9A4240006;
        Wed,  9 Nov 2022 20:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668025890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ETbXvYBEg/yFeCJeEL3kpLNlGNar65IVNcGJHPKe/k=;
        b=jlmmtfINw0vPXlA+sXdDn828teotLJMLzUB2TIMMRvLOXEz5LVAUuOhICrEhAyyAuHzI0C
        1H0NoF3Uj8B10hI41fyElJGADvVxiGmV9SUkcmPGLQl6ISZ+lpWEOeFa1VRvJohF10u1jj
        qKqX/oNf4H6yPWCT5SW7Xxb+0aItmxZFUbl1oIc6C6uMyYIME02TJIW7r6jEI36DyWj42S
        5pnSXTXxFEWjVnPaT3UnvKVrdqZqvItDqY0twx+O1b8ikENzAsX/OeL3imrnPMfztiWvKB
        0eVRvVTB892r3m4poWJ6cYIX1R+Ge1WLB3eywTH0nSFXDpnphIL0WxzWvVtqnw==
Date:   Wed, 9 Nov 2022 21:31:27 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ardb@kernel.org,
        linux-efi@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [BUG] rtc-efi: Error in efi.get_time() spams dmesg with error
 message
Message-ID: <Y2wOH1X0tAWWY4zd@mail.local>
References: <Y2o1hdZK9GGDVJsS@monolith.localdoman>
 <Y2rM/ud0JfX4QXJB@mail.local>
 <Y2u+Z7uWfokQYwKt@monolith.localdoman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2u+Z7uWfokQYwKt@monolith.localdoman>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 09/11/2022 14:51:19+0000, Alexandru Elisei wrote:
> Hi,
> 
> On Tue, Nov 08, 2022 at 10:41:18PM +0100, Alexandre Belloni wrote:
> > On 08/11/2022 10:55:15+0000, Alexandru Elisei wrote:
> > > Hi,
> > > 
> > > Commit d3549a938b73 ("efi/arm64: libstub: avoid SetVirtualAddressMap() when
> > > possible") exposed a firmware error on an Ampere Altra machine that was
> > > causing the machine to panic. Then commit 23715a26c8d8 ("arm64: efi:
> > > Recover from synchronous exceptions occurring in firmware") made the EFI
> > > exception non-fatal, and disabled runtime services when the exception
> > > happens. The interaction between those two patches are being discussed in a
> > > separate thread [1], but that should be orthogonal to this.
> > > 
> > > Now efi.get_time() fails and each time an error message is printed to
> > > dmesg, which happens several times a second and clutters dmesg
> > > unnecessarily, to the point it becomes unusable.
> > > 
> > > I was wondering if it would be possible to turn dev_err() into a
> > > dev_WARN_ONCE() or do something to avoid this issue. Tried to replace
> > > dev_err() with dev_err_ratelimited(), and the error message was displayed
> > > less often (about once per second), but dmesg was still being cluttered.
> > > 
> > 
> > The question this raise is what is actually trying to read the RTC this
> > often?
> > 
> > This should be read once at boot and maybe every time you wake up from
> > suspend but there is no real reason to read it multiple times per
> > seconds.
> 
> Reverted the commit the exposed the firmware bug, which means rtc-efi works as
> it should. Added these debug statements to check how many times efi_read_time()
> is called if there are no errors:
> 
> --- a/drivers/rtc/rtc-efi.c
> +++ b/drivers/rtc/rtc-efi.c
> @@ -154,6 +154,7 @@ static int efi_set_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
>         return status == EFI_SUCCESS ? 0 : -EINVAL;
>  }
> 
> +static unsigned long i = 0;
>  static int efi_read_time(struct device *dev, struct rtc_time *tm)
>  {
>         efi_status_t status;
> @@ -162,6 +163,9 @@ static int efi_read_time(struct device *dev, struct rtc_time *tm)
> 
>         status = efi.get_time(&eft, &cap);
> 
> +       i++;
> +       pr_info("%s: Call number %lu\n", __func__, i);
> +
>         if (status != EFI_SUCCESS) {
>                 /* should never happen */
>                 dev_err(dev, "can't read time\n");
> 
> The function gets called 3 times, twice during boot and once after. I would say
> that efi_read_time() gets called so many times because it fails.
> 

It should really get called only once, at device registration when
CONFIG_RTC_HCTOSYS is set (which I despise):
https://elixir.bootlin.com/linux/latest/source/drivers/rtc/class.c#L431

Could you maybe use dump_stack() ?


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
