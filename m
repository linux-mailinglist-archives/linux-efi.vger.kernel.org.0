Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70623276DB5
	for <lists+linux-efi@lfdr.de>; Thu, 24 Sep 2020 11:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIXJpY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 05:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgIXJpX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 24 Sep 2020 05:45:23 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C253823977;
        Thu, 24 Sep 2020 09:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600940722;
        bh=yxZaR8oHCKmbjvofeBI7154Pzfy5ckgYTMwdIng5lfc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DpMHvs/+ynAjvKVx5Aj3p/dwAFZejJzwsOMF/qi81GBlcMl7MYV3/F2PzydqyMbPD
         as6wT9rJsSAsrri9EkAaA+hvf7onEy/YXw6ESMBr/SPWeMCckfOa2x0nG5YihA4VXl
         fgy64/b/73LPl/1kb9s3m1c603dfvjz7AXhmWuaE=
Received: by mail-ot1-f51.google.com with SMTP id y5so2571579otg.5;
        Thu, 24 Sep 2020 02:45:22 -0700 (PDT)
X-Gm-Message-State: AOAM532JrB0yWDJZi/lOmCeE0B5r3Tqpi8erXj0KfpKQI3+AA7HaFbIn
        9XSFlgKmt/80+z8VPEhzGplGG+LWa3QXmgNaxek=
X-Google-Smtp-Source: ABdhPJxoellXIpyU0LHX8I0XsNYx3OIWNYU0Klr4nYoPB5A75M1KYnpRpffRjnqMc5d/R8WVBiDyUMG8J33nChSQM7M=
X-Received: by 2002:a9d:335:: with SMTP id 50mr2389727otv.90.1600940722000;
 Thu, 24 Sep 2020 02:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200923161404.17811-1-ardb@kernel.org> <20200923161404.17811-2-ardb@kernel.org>
 <202009231140.B4648C6@keescook> <CAMj1kXFFs2rLMn5kdY9CGsz32ctBshb93iN7yBtZNHYwW2mWnw@mail.gmail.com>
 <202009231400.E52D1C7E7@keescook>
In-Reply-To: <202009231400.E52D1C7E7@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 24 Sep 2020 11:45:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGGk2v69u+67LAyiyCTCteWxuMoRmVmWFGNdFbMPm6hCA@mail.gmail.com>
Message-ID: <CAMj1kXGGk2v69u+67LAyiyCTCteWxuMoRmVmWFGNdFbMPm6hCA@mail.gmail.com>
Subject: Re: [PATCH 1/7] efi: pstore: disentangle from deprecated efivars module
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 23 Sep 2020 at 23:02, Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Sep 23, 2020 at 08:43:21PM +0200, Ard Biesheuvel wrote:
> > On Wed, 23 Sep 2020 at 20:41, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Wed, Sep 23, 2020 at 06:13:58PM +0200, Ard Biesheuvel wrote:
> > > > The EFI pstore implementation relies on the 'efivars' abstraction,
> > > > which encapsulates the EFI variable store in a way that can be
> > > > overridden by other backing stores, like the Google SMI one.
> > > >
> > > > On top of that, the EFI pstore implementation also relies on the
> > > > efivars.ko module, which is a separate layer built on top of the
> > > > 'efivars' abstraction that exposes the [deprecated] sysfs entries
> > > > for each variable that exists in the backing store.
> > > >
> > > > Since the efivars.ko module is deprecated, and all users appear to
> > > > have moved to the efivarfs file system instead, let's prepare for
> > > > its removal, by removing EFI pstore's dependency on it.
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > With this and the other pstore patch, do the pstore self-tests still
> > > pass on an EFI system?
> > >
> > > If so, please consider both:
> > >
> > > Acked-by: Kees Cook <keescook@chromium.org>
> > >
> >
> > Selftests? Excellent! Are they documented too?
>
> Not really, but they're pretty simple:
>
> cd tools/testing/selftests/pstore
> *double-check "config" against running kernel config*
> ./pstore_tests
> ./pstore_crash_test
> *wait for system to reboot*
> cd tools/testing/selftests/pstore
> ./pstore_post_reboot_tests
>
> (though please test before/after, just to make sure other deltas haven't
> broken things before your series -- I don't test EFI pstore with high
> frequency)
>

I have done the 'before' test on three different EFI Linux systems
(x86, arm64 and ARM), and they all give me something like the below

=== Pstore unit tests (pstore_tests) ===
UUID=109d02e6-9395-4274-9554-2c078e87a662
Checking pstore backend is registered ... ok
  backend=efi
  cmdline=BOOT_IMAGE=/vmlinuz-5.3.0-59-generic
root=/dev/mapper/crypt-root ro quiet splash vt.handoff=1
Checking pstore console is registered ... FAIL
Checking /dev/pmsg0 exists ... FAIL
Writing unique string to /dev/pmsg0 ... FAIL

So I'm not sure if there is any point to doing the 'after' test if
this is the baseline.
