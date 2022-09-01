Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D275A9C41
	for <lists+linux-efi@lfdr.de>; Thu,  1 Sep 2022 17:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiIAPwi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Sep 2022 11:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiIAPwh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Sep 2022 11:52:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCCF79A69;
        Thu,  1 Sep 2022 08:52:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03344B8283B;
        Thu,  1 Sep 2022 15:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B44EC433D6;
        Thu,  1 Sep 2022 15:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662047553;
        bh=BNPVRt463aI1aV+LlXnGi22C4yrVK6VnlZhgmogIhg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cOpuX2UFz6p4Q5J6jY/7+C2BaEHA6D4ntIa62WNArmE2+/HIBRxdeLOns9+4Wm2qt
         xuTKXxZzndAEQNMELIC+Dz4VTtvlaxMl0ZfQSRz2WzPO8ALdKWM869SBiCJoMgPSLs
         E5cIoWlmglIqvvIIll6eLJB8Hjma7qwymSxZRtUk=
Date:   Thu, 1 Sep 2022 17:52:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     arnd@arndb.de, evgreen@chromium.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@gpiccoli.net, ardb@kernel.org,
        davidgow@google.com, jwerner@chromium.org
Subject: Re: [PATCH V3] firmware: google: Test spinlock on panic path to
 avoid lockups
Message-ID: <YxDVPqVkdgQbAIvY@kroah.com>
References: <20220819155059.451674-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819155059.451674-1-gpiccoli@igalia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 19, 2022 at 12:50:59PM -0300, Guilherme G. Piccoli wrote:
> Currently the gsmi driver registers a panic notifier as well as
> reboot and die notifiers. The callbacks registered are called in
> atomic and very limited context - for instance, panic disables
> preemption and local IRQs, also all secondary CPUs (not executing
> the panic path) are shutdown.
> 
> With that said, taking a spinlock in this scenario is a dangerous
> invitation for lockup scenarios. So, fix that by checking if the
> spinlock is free to acquire in the panic notifier callback - if not,
> bail-out and avoid a potential hang.
> 
> Fixes: 74c5b31c6618 ("driver: Google EFI SMI")
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: David Gow <davidgow@google.com>
> Cc: Julius Werner <jwerner@chromium.org>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> 
> This is a re-submission of the patch - it was in a series [0], but
> Greg suggested me to resubmit individually in order it gets picked
> by the relevant maintainers, instead of asking them to merge
> individual patches from a series. Notice I've trimmed a bit the CC
> list, it was bigger due to the patch being in a series...
> 
> This is truly the V3 of the patch, below is the diff between versions:
> 
> V3:
> - added Evan's review tag - thanks!
> 
> V2:
> - do not use spin_trylock anymore, to avoid messing with
> non-panic paths; now we just check the spinlock state in
> the panic notifier before taking it. Thanks Evan for the review!
> 
> [0] https://lore.kernel.org/lkml/20220719195325.402745-4-gpiccoli@igalia.com/
> 
> 
>  drivers/firmware/google/gsmi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
> index adaa492c3d2d..3ef5f3c0b4e4 100644
> --- a/drivers/firmware/google/gsmi.c
> +++ b/drivers/firmware/google/gsmi.c
> @@ -681,6 +681,14 @@ static struct notifier_block gsmi_die_notifier = {
>  static int gsmi_panic_callback(struct notifier_block *nb,
>  			       unsigned long reason, void *arg)
>  {
> +	/*
> +	 * Perform the lock check before effectively trying
> +	 * to acquire it on gsmi_shutdown_reason() to avoid
> +	 * potential lockups in atomic context.
> +	 */
> +	if (spin_is_locked(&gsmi_dev.lock))
> +		return NOTIFY_DONE;
> +

What happens if the lock is grabbed right after testing for it?
Shouldn't you use lockdep_assert_held() instead as the documentation
says to?


>  	gsmi_shutdown_reason(GSMI_SHUTDOWN_PANIC);

You are grabbing the lock way in this call, again, you have a window
where the check above would not have worked :(

I don't think this is fixing anything properly, sorry.

greg k-h
