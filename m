Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE7973E2FE
	for <lists+linux-efi@lfdr.de>; Mon, 26 Jun 2023 17:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjFZPPi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Jun 2023 11:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjFZPP3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Jun 2023 11:15:29 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A96130
        for <linux-efi@vger.kernel.org>; Mon, 26 Jun 2023 08:15:25 -0700 (PDT)
Date:   Mon, 26 Jun 2023 15:15:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687792519; x=1688051719;
        bh=bPOqBroTrfrEuX9wmxhJZKj4JlBhrbZ/m7xB82P7nRU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=aA5XZY0NXALj/BeQBDC4I3TzgULqp956CqlZdSPBdqBZA9BTt0LTjs1aOg8n1FFVp
         bqLVpK6BNptE7mZfrbjSWQOXfhlwioHgC3+vvKmsl4W71IfuRYwElvNhWONXitrHVt
         PAQrEazxOiop0iYYa2gXSm7z/1w/hH9JuDcJG4rjjWjNYb+iIU0HvAq/wG9Y4Wcqq2
         YgvJMSXQXyp3nj/S1I/A7jYPhH6EOw5FMrSBB5IsT6ky/2cB2/CTfu8OqvoXsx57Zt
         vrWocpDUz1hpmdTTXYpggqFSIuqRzDhplpOkXePFVsZX8dm3Cd4OSreQzKjXqqSifJ
         4qHddhih//KLQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
From:   Sami Korkalainen <sami.korkalainen@proton.me>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH] efivarfs: Expose RandomSeed variable but with limited permissions
Message-ID: <OjqaFXzfhYptWcVhkBKPvd9th9zIokPME44PXC6DYfD5OYZ3iE-fVt-KJq0GKpc-6RrLcAS7CDcR5Gre1tWHXX57VkfJ0YlWmC4IfNb4et4=@proton.me>
In-Reply-To: <CAHk-=witNP7Ejgdk8YBZs5ujdxbjqYOVLdbtAsZC1NWoiPWkvA@mail.gmail.com>
References: <20230624180446.2048867-1-ardb@kernel.org> <ZJhSysqUcxOqh37n@zx2c4.com> <CAHk-=witNP7Ejgdk8YBZs5ujdxbjqYOVLdbtAsZC1NWoiPWkvA@mail.gmail.com>
Feedback-ID: 45678890:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sunday, June 25th, 2023 at 22.21, Linus Torvalds <torvalds@linux-foundat=
ion.org> wrote:
>
> Sami - can you try to revert the revert:
>
> git revert 69cbeb61ff9093a9155cb19a36d633033f71093a
>
> but then additionally in drivers/firmware/efi/efi.c, just change the
>
> static DECLARE_WORK(work, refresh_nv_rng_seed);
> schedule_work(&work);
>
> in refresh_nv_rng_seed_notification() to be something like
>
> static DECLARE_DELAYED_WORK(work, refresh_nv_rng_seed);
> schedule_delayed_work(&work, 120*HZ);
>
> to make the work fire two minutes after boot?
>
> The question then being:
>
> (a) does that fix the boot for you (maybe it's the schedule_work
> itself that confused things, however unlikely that sounds)
>
> (b) if it does boot, do you notice something happening two minutes
> after booting?

I did that and:
(a) It does boot fine with this change.
(b) I don't notice anything happening at two minutes after booting. I can s=
ee there is a random-seed file located in EFI partition, but it does not ch=
ange two minutes after boot (but it is different each boot).

> I'm not entirely sure which laptop it is, with laptop manufacturers
> often re-using model names over several years, but "HP 6730b" seems to
> be basically from July 2008 (going by the service manual I found). So
> we're talking 15 years ago, and yes, EFI was likely much less
> reliable back then.

I got the laptop secondhand 7 years ago, but the 2008 has been my guess as =
well based on online resources. I have the _latest_ bios on it, 68PDD Ver. =
F.20 from 2011.
