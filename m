Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7124928AFF9
	for <lists+linux-efi@lfdr.de>; Mon, 12 Oct 2020 10:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgJLIUa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Oct 2020 04:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgJLIU3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 12 Oct 2020 04:20:29 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE3872173E;
        Mon, 12 Oct 2020 08:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602490828;
        bh=EyzO8tMJTCC+XyN3KqgvVYGrtb1TyCbmbp+zSz7Ppb8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MK0Oh3MqDgB9koAAuMRnltl0pM4teX6nvEbpJ8eTuCY4Ggb6RJkrfQuKryQEnkujO
         cRs9QYAesP58e8cpB3x/UynzJ84dbIIpfCCvp8guHgBATm5jFZRQ4TIaa11tnHce83
         LO5hd35DYO0JYp4pgONIK9qaZz8LdV3m0ec96GxY=
Received: by mail-oo1-f49.google.com with SMTP id w25so3875330oos.10;
        Mon, 12 Oct 2020 01:20:28 -0700 (PDT)
X-Gm-Message-State: AOAM531feG3SP0ZMvNpwJpBG+8ZKzOx2k9CeB3eBm+qY/9hMbIFtEtWc
        2cRg6O5g7KmyEHZUJli/AmfwYA/bGdoBURldPyY=
X-Google-Smtp-Source: ABdhPJz18oAbSZB6d6XIsdsJGA0aS3dlg/rVP/cn+P035DH9wUktgzqk1T3Vckd4dT99S0gHURmYGdxdLHe5gZ9haKc=
X-Received: by 2002:a4a:c3ca:: with SMTP id e10mr17802185ooq.41.1602490827863;
 Mon, 12 Oct 2020 01:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200904072905.25332-1-clin@suse.com> <20200904072905.25332-2-clin@suse.com>
 <CAMj1kXEXvmO5mrTcKpqYUASBAQB-1=xLa0vg7KwmvOHMjaQ34w@mail.gmail.com>
 <20200914080522.GA26718@linux-8mug> <20201005022014.GA5112@linux-8mug>
In-Reply-To: <20201005022014.GA5112@linux-8mug>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 12 Oct 2020 10:20:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXErMjbvwuP6YhgaZ4M47vzhYkFJb2kYC+h7Odr4Zu3eSA@mail.gmail.com>
Message-ID: <CAMj1kXErMjbvwuP6YhgaZ4M47vzhYkFJb2kYC+h7Odr4Zu3eSA@mail.gmail.com>
Subject: Re: [PATCH 1/6] efistub: pass uefi secureboot flag via fdt params
To:     Chester Lin <clin@suse.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 5 Oct 2020 at 04:20, Chester Lin <clin@suse.com> wrote:
>
> On Mon, Sep 14, 2020 at 04:05:22PM +0800, Chester Lin wrote:
> > Hi Ard,
> >
> > On Fri, Sep 11, 2020 at 06:01:09PM +0300, Ard Biesheuvel wrote:
> > > On Fri, 4 Sep 2020 at 10:29, Chester Lin <clin@suse.com> wrote:
> > > >
> > > > Add a new UEFI parameter: "linux,uefi-secure-boot" in fdt boot params
> > > > as other architectures have done in their own boot data. For example,
> > > > the boot_params->secure_boot in x86.
> > > >
> > > > Signed-off-by: Chester Lin <clin@suse.com>
> > >
> > > Why do we need this flag? Can't the OS simply check the variable directly?
> > >
> >
> > In fact, there's a difficulty to achieve this.
> >
> > When linux kernel is booting on ARM, the runtime services are enabled later on.
> > It's done by arm_enable_runtime_services(), which is registered as an early_initcall.
> > Before it calls efi_native_runtime_setup(), all EFI runtime callbacks are still
> > NULL so calling efi.get_variable() will cause NULL pointer dereference.
> >
> > There's a case that arch_ima_get_secureboot() can be called in early boot stage.
> > For example, when you try to set "ima_appraise=off" in kernel command line, it's
> > actually handled early:
> >
> > [    0.000000] Kernel command line: BOOT_IMAGE=/boot/Image-5.9.0-rc3-9.gdd61cda-
> > vanilla root=UUID=a88bfb80-8abb-425c-a0f3-ad317465c28b splash=silent mitigations
> > =auto ignore_loglevel earlycon=pl011,mmio,0x9000000 console=ttyAMA0 ima_appraise=off
> > [    0.000000] ima: Secure boot enabled: ignoring ima_appraise=off boot parameter option
> > [    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> >
> > However EFI services are remapped and enabled afterwards.
> >
> > [    0.082286] rcu: Hierarchical SRCU implementation.
> > [    0.089592] Remapping and enabling EFI services.
> > [    0.097509] smp: Bringing up secondary CPUs ...
> >
> > Another problem is that efi_rts_wq is created in subsys_initcall so we have to
> > wait for both EFI services mapping and the workqueue get initiated before calling
> > efi.get_variable() on ARM.
> >
> > The only way I can think of is to put a flag via fdt params. May I have your
> > suggestions? I will appreciate if there's any better approach.
> >
> > Thanks,
> > Chester
>
> Ping. May I have some suggestions here?
>

IMA itself is initialized as a late initcall. The only reason you see
this message early is because this is where the parsing of the command
line parameter happens.

I'll send out a patch with a proposed solution for this issue.
