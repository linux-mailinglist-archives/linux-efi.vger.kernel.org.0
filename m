Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF96277771D
	for <lists+linux-efi@lfdr.de>; Thu, 10 Aug 2023 13:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbjHJLeS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Aug 2023 07:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjHJLeR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Aug 2023 07:34:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5A510D
        for <linux-efi@vger.kernel.org>; Thu, 10 Aug 2023 04:34:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A02D2659DC
        for <linux-efi@vger.kernel.org>; Thu, 10 Aug 2023 11:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EDDC433C9
        for <linux-efi@vger.kernel.org>; Thu, 10 Aug 2023 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691667256;
        bh=Z4qBpx5t4lbieMxRMI42P9vNcaDgJyT5t74kSlEhcGQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PlJf4ZKaqomthfV4RQOVCKKSYGNk/xsrXCY4FHYADfTrCYY1ehVziq+gremqFxDAY
         UJYJ39y2GipQaL3gPkxR89k/HE8iuE9lqgTZfyZrwUUtDIjOHajxXREWZfcaoUyVsP
         SbTrB9QxhAn4/0sWjxVmF+kZibpNgt7hYKSsaCViGJJGvrClKwUjC2JYELnF0HevP4
         qR6/d3r5PKjxiwO7M62BxRMf3JrRu4ckhJPi5A/uFd8n/1VEd0PAd4pAH2GONt1QjE
         LF1CiMsYUWY+ufdRW3FR0GPa4KHRb0GQzOLeNJTDh8l6pEfTy7UW6grsvD4Ft/D+BL
         VbpyhlADCP0dQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b962535808so12580601fa.0
        for <linux-efi@vger.kernel.org>; Thu, 10 Aug 2023 04:34:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YzXkhvy494Yt+ddtrejb3KB9MPlliHdbXapmGYdc7EU+7MSERVQ
        Z3Ce1k5spTacjsQXqpbGpHhZBHJaqo1zNcUX/vw=
X-Google-Smtp-Source: AGHT+IEtVSfZa3PLOxFcxJSSDO0NQnMfuUsST7zdCAdeo0a9FdhWdfpE/lxzexIz7HJpZfUw+G3lFjEwfNy56JO7W8Q=
X-Received: by 2002:a2e:7a0a:0:b0:2b5:bc27:d6eb with SMTP id
 v10-20020a2e7a0a000000b002b5bc27d6ebmr1571231ljc.8.1691667253955; Thu, 10 Aug
 2023 04:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230810092835.1025088-1-ardb@kernel.org> <e135fd0d-86d3-6c01-1b50-0736b21aaab2@redhat.com>
In-Reply-To: <e135fd0d-86d3-6c01-1b50-0736b21aaab2@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Aug 2023 13:34:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHbOvw=_G_90+Jm_devVsH8OojaGXJwLc1fRdf=NR=jxQ@mail.gmail.com>
Message-ID: <CAMj1kXHbOvw=_G_90+Jm_devVsH8OojaGXJwLc1fRdf=NR=jxQ@mail.gmail.com>
Subject: Re: [RFC PATCH] efi/x86: Limit mixed mode support to runtime services
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-efi@vger.kernel.org, Daniel Kiper <daniel.kiper@oracle.com>,
        Steve McIntyre <steve@einval.com>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 10 Aug 2023 at 12:32, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ard,
>
> On 8/10/23 11:28, Ard Biesheuvel wrote:
> > As currently implemented, mixed mode support on x86 depends on special
> > Linux/x86 specific logic in the bootloader that is not covered by the
> > UEFI specification: it relies on the so-called EFI handover protocol to
> > invoke a special 32-bit entrypoint into the EFI stub that 64-bit Linux
> > builds expose if they were configured with CONFIG_EFI_MIXED=3Dy (and
> > CONFIG_EFI_HANDOVER_PROTOCOL=3Dy)
> >
> > When EFI mixed mode was introduced, booting via the EFI stub was a
> > prerequisite, as the stub code captured the context that was restored
> > again when invoking firmware services, both at boot time and at runtime=
.
> > (segment selectors, GDTs, IDTs etc). However, since commit 96738c69a7fc
> > ("x86/efi: Avoid triple faults during EFI mixed mode calls"), the
> > runtime logic no longer uses any of this preserved context, and simply
> > invokes the firmware services in compatibility mode instead.
> >
> > Given that the EFI handover protocol was never implemented except in
> > distro forks of GRUB, mainline GRUB does not support it. However, its
> > legacy x86 boot code will happily boot a 64-bit kernel from a 32-bit
> > build, and given that booting via the EFI stub is no longer needed, it
> > can also invoke the 32-bit EFI runtime services without problems. And
> > even Debian's GRUB fork, which implements the EFI handover protocol for
> > native boot, will happily boot in mixed mode with all the EFI stub
> > pieces ripped out.
> >
> > This means that the complex and messy EFI mixed mode support in the EFI
> > stub is redundant, and can be removed.
>
> How do you see this working, esp. wrt upgrade paths for distros which cur=
rently have a patched grub which will execute the EFI stub when EFI booting=
, both for 32 bits and for 64 bit grub builds ?
>
> If I understand this correctly the 32 bit grub UEFI binaries will need to=
 boot through the x86 boot protocol now instead of using the EFI stub. Will=
 the current (distro patched) UEFI grub binaries be able to detect stub sup=
port is missing and then automatically fall back to the x86 boot protocol? =
I doubt that the current EFI handover / stub support patches in grub actual=
ly do this.
>

As mentioned in the commit log, Debian's GRUB already does this.
However, as far as I can tell, its mixed mode support never enters via
the stub, so I imagine Fedora's GRUB behaves differently in this
regard.

> AFAICT this would mean that if this lands in lets say 6.7 and that lets s=
ay Fedora 39 then moves to 6.7 once approx. 6.7.4 is out all Fedora 40 x86_=
64 installs done on low-end machines using 32 bit UEFI will then stop booti=
ng ?
>

Of course, this is not the intent.

> And this will also completely break booting 64 bit kernels on 32 bit UEFI=
 using systemd-boot.
> systemd-boot exclusively relies on the UEFI stub, since the whole concept=
 of system-boot is to do as little as possible and rely on UEFI for pretty =
much everything. As such I also consider it quite unlikely that systemd-boo=
t will ever get support for the x86 boot protocol.
>

I don't think it will. I didn't realize systemd-boot actually went
ahead with this, although I did get pulled into some discussions about
this a while ago.

So, to be clear, mixed mode boot using systemd-boot is a supported
configuration on Fedora?

> Another thing to consider is that booting through the stub tends to be mo=
re reliable then using grub. There is a reason why Fedora has been patched =
grub to use the stub even long before 32/64 bit mixed mode support was impl=
emented. I've more then once seen 64 bit UEFI systems where upstream grub w=
ould fail to boot the system, where as a grub patched to handover booting t=
o the EFI stub would boot. And since the often low qualitty of 32 bit UEFI =
BIOS-es I'm worried that some of them likewise will fail to boot when using=
 the x86 boot protocol.
>

I'd argue that the less we involve the boot services on such systems,
the better it is.

> I'm sorry, but to me breaking grub distro upgrade paths and completely lo=
osing support for systemd-boot seems like an unacceptable regression.
>
> I can understand the desire to remove this hairy code, but the diffstat s=
hows this only removes about 800 lines. Now if we were talking 10 kloc or s=
ome such we could maybe look into some sort of migration path.
>
> IMHO the balance between amount of cleanups versus the severity of the re=
gressions / lost functionality tips the scale to the regressions being wors=
e then the positve effect of the code cleanup. So based on my current under=
standing of this I'm against the proposed change.
>

Fair enough, thanks for the input.

I think we all agree that we should not regress or block the upgrade
path for existing installations that rely on this. The question is
really for how much longer this needs to be supported, as I imagine
the set of machines relying on this (and keeping up with the latest
distro) is shrinking quickly.

In any case, consider the patch withdrawn. Let's try again in a year or 2.

--=20
Ard.
