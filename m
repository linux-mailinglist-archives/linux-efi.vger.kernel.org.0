Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF28673E332
	for <lists+linux-efi@lfdr.de>; Mon, 26 Jun 2023 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjFZPYD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Jun 2023 11:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjFZPYC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Jun 2023 11:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA0F10CF
        for <linux-efi@vger.kernel.org>; Mon, 26 Jun 2023 08:23:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7680260EBD
        for <linux-efi@vger.kernel.org>; Mon, 26 Jun 2023 15:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C21C433C8;
        Mon, 26 Jun 2023 15:23:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Oxar+kpI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1687793035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fOticjPHuKNWRc0KdlBalSp+A/m4ZqUg9kBIWg4bp1M=;
        b=Oxar+kpIz30e2NCW4lJig4NpblvLX0hXYYZM+mELGjWibiVxkSkHA29/HK+R4OR59/Wnni
        B4IpQHLWUaoDOuEUuIfYqnUKululZfVq82i/h/r/EwdllX4Q0KVxNTnaI79T+1EUEDnHIo
        bGKigRVPu1E4jYoumKwjKXXl9nx1yqY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 913a0dfd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 26 Jun 2023 15:23:54 +0000 (UTC)
Date:   Mon, 26 Jun 2023 17:23:52 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sami Korkalainen <sami.korkalainen@proton.me>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH] efivarfs: Expose RandomSeed variable but with limited
 permissions
Message-ID: <ZJmtiEk3UP6TpjNn@zx2c4.com>
References: <20230624180446.2048867-1-ardb@kernel.org>
 <ZJhSysqUcxOqh37n@zx2c4.com>
 <CAHk-=witNP7Ejgdk8YBZs5ujdxbjqYOVLdbtAsZC1NWoiPWkvA@mail.gmail.com>
 <OjqaFXzfhYptWcVhkBKPvd9th9zIokPME44PXC6DYfD5OYZ3iE-fVt-KJq0GKpc-6RrLcAS7CDcR5Gre1tWHXX57VkfJ0YlWmC4IfNb4et4=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <OjqaFXzfhYptWcVhkBKPvd9th9zIokPME44PXC6DYfD5OYZ3iE-fVt-KJq0GKpc-6RrLcAS7CDcR5Gre1tWHXX57VkfJ0YlWmC4IfNb4et4=@proton.me>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 26, 2023 at 03:15:08PM +0000, Sami Korkalainen wrote:
> On Sunday, June 25th, 2023 at 22.21, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > Sami - can you try to revert the revert:
> >
> > git revert 69cbeb61ff9093a9155cb19a36d633033f71093a
> >
> > but then additionally in drivers/firmware/efi/efi.c, just change the
> >
> > static DECLARE_WORK(work, refresh_nv_rng_seed);
> > schedule_work(&work);
> >
> > in refresh_nv_rng_seed_notification() to be something like
> >
> > static DECLARE_DELAYED_WORK(work, refresh_nv_rng_seed);
> > schedule_delayed_work(&work, 120*HZ);
> >
> > to make the work fire two minutes after boot?
> >
> > The question then being:
> >
> > (a) does that fix the boot for you (maybe it's the schedule_work
> > itself that confused things, however unlikely that sounds)
> >
> > (b) if it does boot, do you notice something happening two minutes
> > after booting?
> 
> I did that and:
> (a) It does boot fine with this change.

Interesting! And after around 4 minutes, you don't see any stall
warnings in your dmesg?

> (b) I don't notice anything happening at two minutes after booting. I
> can see there is a random-seed file located in EFI partition, but it
> does not change two minutes after boot (but it is different each
> boot).

That's an unrelated file. This has to do with EFI variables.
