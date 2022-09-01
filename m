Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5425A9D68
	for <lists+linux-efi@lfdr.de>; Thu,  1 Sep 2022 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiIAQpM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Sep 2022 12:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiIAQpH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Sep 2022 12:45:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1574E30561;
        Thu,  1 Sep 2022 09:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63117B82844;
        Thu,  1 Sep 2022 16:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886E4C433C1;
        Thu,  1 Sep 2022 16:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662050701;
        bh=WTVoLyArljMwvj6zU+m2L6cOF0xZFcbBpY3XVPZOeBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kf92I5lzjXCibPDPWmxIHXKuoDoS+UwpSkVq3OFDFg9hc+aE6t0CRar10bQx6lRpP
         LwLi3pZm1yHhBgRj77UycglMGL1AUhHSoP06PsLM6vrT7rbENbsa4cmPQv8jUDN/xo
         2pQB7bA0s91jdt8UopkLwsPIzulsc/XcWERrrmTE=
Date:   Thu, 1 Sep 2022 18:44:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     evgreen@chromium.org, arnd@arndb.de, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@gpiccoli.net, ardb@kernel.org,
        davidgow@google.com, jwerner@chromium.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH V3] firmware: google: Test spinlock on panic path to
 avoid lockups
Message-ID: <YxDhiSDs4YcUrqV5@kroah.com>
References: <20220819155059.451674-1-gpiccoli@igalia.com>
 <YxDVPqVkdgQbAIvY@kroah.com>
 <f89cd87c-7d1c-d8e6-ed95-6876f0201872@igalia.com>
 <YxDX9+p+58q2sip2@kroah.com>
 <6bc5dbc3-2cdd-5cb8-1632-11de2008a85a@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bc5dbc3-2cdd-5cb8-1632-11de2008a85a@igalia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 01, 2022 at 01:24:46PM -0300, Guilherme G. Piccoli wrote:
> On 01/09/2022 13:04, Greg KH wrote:
> > [...]
> >>> What happens if the lock is grabbed right after testing for it?
> >>> Shouldn't you use lockdep_assert_held() instead as the documentation
> >>> says to?
> >>
> >> How, if in this point only a single CPU (this one, executing the code)
> >> is running?
> > 
> > How are we supposed to know this here?
> > 
> 
> Reading the code?
> Or you mean, in the commit description this should be mentioned?

Yes, and in the comment as this type of call is very rare and should
almost never be used.

> >> other CPUs, except this one executing the code. So, either the lock was
> >> taken (and we bail), or it wasn't and it's safe to continue.
> > 
> > Then who else could have taken the lock?  And if all other CPUs are
> > stopped, who cares about the lock at all?  Just don't grab it (you
> > should check for that when you want to grab it) and then you can work
> > properly at that point in time.
> > 
> 
> I don't think it is so simple - we are in the panic path.

Great, then the lock doesn't matter :)

> So, imagine the lock was taken in CPU0, where GSMI is doing some
> operation. During that operation, CPU1 panics!
> 
> When that happens, panic() executes in CPU1, disabling CPU0 through
> "strong" mechanisms (NMI). So, CPU0 had the lock, it is now off, and
> when CPU1 goes through the panic notifiers, it'll eventually wait
> forever for this lock in the GSMI handler, unless we have this patch
> that would prevent the handler to run in such case.
> Makes sense?

I'm trying to say "if you are in panic, never grab the lock in the first
place".  So change the place when you grab the lock, not here.

thanks,

greg k-h
