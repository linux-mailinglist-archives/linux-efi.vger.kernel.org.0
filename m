Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8413D5A9C74
	for <lists+linux-efi@lfdr.de>; Thu,  1 Sep 2022 18:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiIAQET (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Sep 2022 12:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbiIAQES (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Sep 2022 12:04:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5085E90192;
        Thu,  1 Sep 2022 09:04:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9447261F4E;
        Thu,  1 Sep 2022 16:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65754C433D7;
        Thu,  1 Sep 2022 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662048256;
        bh=pQxU1Hx46HVa2BGwTDDJODoaJZM5iDl3ZsY/PMp4qC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKvG4cLldxg1T5JujRz9O5eOwa24UxQBobo+/k9BoBr1pDUEnOY4PHX0/8TRhF8jD
         5UKOiUDwk5Qs4htZO8FpFF2gsqBhoO+InB8oQ+j9u4g9d7ENoIipfMZk4wfENP3PGo
         XZon6VqQSRWwwEFRETAfPCmFrceK8z3ldQPwxtb0=
Date:   Thu, 1 Sep 2022 18:04:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     evgreen@chromium.org, arnd@arndb.de, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@gpiccoli.net, ardb@kernel.org,
        davidgow@google.com, jwerner@chromium.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH V3] firmware: google: Test spinlock on panic path to
 avoid lockups
Message-ID: <YxDX9+p+58q2sip2@kroah.com>
References: <20220819155059.451674-1-gpiccoli@igalia.com>
 <YxDVPqVkdgQbAIvY@kroah.com>
 <f89cd87c-7d1c-d8e6-ed95-6876f0201872@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f89cd87c-7d1c-d8e6-ed95-6876f0201872@igalia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 01, 2022 at 12:59:36PM -0300, Guilherme G. Piccoli wrote:
> + Petr, since this was extensively discussed in the original thread [0]
> and maybe he can help with the argument.
> 
> [0]
> https://lore.kernel.org/lkml/20220427224924.592546-1-gpiccoli@igalia.com/
> 
> 
> On 01/09/2022 12:52, Greg KH wrote:
> > [...]
> 
> >> +	 * Perform the lock check before effectively trying
> >> +	 * to acquire it on gsmi_shutdown_reason() to avoid
> >> +	 * potential lockups in atomic context.
> >> +	 */
> >> +	if (spin_is_locked(&gsmi_dev.lock))
> >> +		return NOTIFY_DONE;
> >> +
> > 
> > What happens if the lock is grabbed right after testing for it?
> > Shouldn't you use lockdep_assert_held() instead as the documentation
> > says to?
> 
> How, if in this point only a single CPU (this one, executing the code)
> is running?

How are we supposed to know this here?

> Remember this is the panic path - before this point we disabled all
> other CPUs, except this one executing the code. So, either the lock was
> taken (and we bail), or it wasn't and it's safe to continue.

Then who else could have taken the lock?  And if all other CPUs are
stopped, who cares about the lock at all?  Just don't grab it (you
should check for that when you want to grab it) and then you can work
properly at that point in time.

thanks,

greg k-h
