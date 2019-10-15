Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22543D6E88
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2019 07:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfJOFYB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Oct 2019 01:24:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbfJOFYB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 15 Oct 2019 01:24:01 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4F4DC0568FD
        for <linux-efi@vger.kernel.org>; Tue, 15 Oct 2019 05:24:00 +0000 (UTC)
Received: by mail-io1-f71.google.com with SMTP id y2so30206093ioj.11
        for <linux-efi@vger.kernel.org>; Mon, 14 Oct 2019 22:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GX8bC+LvWnJ5dJICeG2nAc0CD2f9tU+0Yk6RVJKRFtA=;
        b=OZDPF0hjrmukYy/2siXAXPKfZ4cL2LvHhlMPDmbUQycmgF5UOJtjyo4K8BqmCMwK+N
         7F60xWeiKYEPUPFTFmgiHplaaMoi32uPC/Rsco/whtGJRl45NzXAoC+s644q+VvKew8C
         /Mx42KrR+ITOHXcSwydP43VxQLlgZx/Ia+Hyw3mNpREZEiyY2OspPSoSbdlVtohudeBA
         Q1A9Z/BED/Vp9iia5zIxD7HwNcrssysI9wcvcCohwQCxkBESErB8vkPtZQFB+qknN7hx
         4kxa3jjcmLAMtSl2N2sNBtAVSATuAVSzHvsvkfi4NljpzQpHitIU7xARkXJKkWPVf/DI
         RE9Q==
X-Gm-Message-State: APjAAAUo84AEcG8ReJCfbW9GDVvaJV+yktTgNK33u9Co1OBDPNWtNPhH
        6DgCWOvorH5qWtuDRVIhFqbVKRM0ap+AY4LambVnODAsGjIJqE8xBe4hCZqqNatC8NEKkFR8w+p
        OoQN7/DcQQGeIuhsS3HmMhKs7r3ICS5fu3q/L
X-Received: by 2002:a6b:d104:: with SMTP id l4mr6603811iob.50.1571117039945;
        Mon, 14 Oct 2019 22:23:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqww5YfFPBA4nCSFpjo/cQDUXxSK3cOo8C1EDzKG3a48BASQG3eqI/WCzxReb0tvQtzyFwx3u5yJVlqH0eDl4Ms=
X-Received: by 2002:a6b:d104:: with SMTP id l4mr6603788iob.50.1571117039602;
 Mon, 14 Oct 2019 22:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191012034421.25027-1-kasong@redhat.com> <20191014101419.GA4715@zn.tnic>
In-Reply-To: <20191014101419.GA4715@zn.tnic>
From:   Kairui Song <kasong@redhat.com>
Date:   Tue, 15 Oct 2019 13:23:48 +0800
Message-ID: <CACPcB9f6i_PvxDz9aLpAiakmnEOu-o5N_ZvP5dGe73yyS-KvjA@mail.gmail.com>
Subject: Re: [PATCH v3] x86, efi: never relocate kernel below lowest
 acceptable address
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 14, 2019 at 6:14 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Oct 12, 2019 at 11:44:21AM +0800, Kairui Song wrote:
> > Currently, kernel fails to boot on some HyperV VMs when using EFI.
> > And it's a potential issue on all platforms.
> >
> > It's caused a broken kernel relocation on EFI systems, when below three
> > conditions are met:
> >
> > 1. Kernel image is not loaded to the default address (LOAD_PHYSICAL_ADDR)
> >    by the loader.
> > 2. There isn't enough room to contain the kernel, starting from the
> >    default load address (eg. something else occupied part the region).
> > 3. In the memmap provided by EFI firmware, there is a memory region
> >    starts below LOAD_PHYSICAL_ADDR, and suitable for containing the
> >    kernel.
> >
> > Efi stub will perform a kernel relocation when condition 1 is met. But
> > due to condition 2, efi stub can't relocate kernel to the preferred
> > address, so it fallback to query and alloc from EFI firmware for lowest
>
> Your spelling of "EFI" is like a random number generator in this
> paragraph: "Efi", "efi" and "EFI". Can you please be more careful when
> writing your commit messages? They're not some random text you hurriedly
> jot down before sending the patch but a most important description of
> why a change is being done.

Sorry I just ignored the acronym usage problems, I did double check the text but
didn't realize this is a problem... Will correct them.

>
> And if you don't see their importance now, just try doing some git
> archeology, trying to understand why a change has been done in the past
> and then encounter a commit message two-liner which doesn't say sh*t.
> Then you'll start appreciating properly written commit messages.
>
> > usable memory region.
> >
> > It's incorrect to use the lowest memory address. In later stage, kernel
> > will assume LOAD_PHYSICAL_ADDR as the minimal acceptable relocate address,
> > but efi stub will end up relocating kernel below it.
>
> Why don't you simply explain what
> choose_random_location()->find_random_virt_addr() does? That's the
> problem you're solving, right? KASLR using LOAD_PHYSICAL_ADDR as the
> minimum...
>
> > The later kernel decompressing code will forcefully correct the wrong
> > kernel load location,
>
> ... or do you mean by that the dance in
> arch/x86/boot/compressed/head_64.S where we move the kernel temporarily
> to LOAD_PHYSICAL_ADDR for the decompression?

The kernel move in arch/x86/boot/compressed/head_64.S is the problem
I'm saying here.

I thought it's a bad idea to include too much details about codes and details in
the commit message, so tried to describe it without mentioning the
implementation details.
It's making things confusing indeed.

I'll rethink about how the commit message should be composed...

>
> You can simply say that here...
>

OK, then I'll do so. Will update the commit message.

--
Best Regards,
Kairui Song
