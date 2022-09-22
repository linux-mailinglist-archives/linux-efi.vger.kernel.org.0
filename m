Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6277E5E62FC
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 14:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiIVM6C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 08:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiIVM56 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 08:57:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD95B2F
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 05:57:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66392B8363F
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 12:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0318BC433C1
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 12:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663851474;
        bh=B98kHnfo3so8V7OnVf1XjmEKZQD0tYrGbV+P+W2cLHI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ebhXGgOYtu/n3E2CoFCPpqZnXUvxwe9FL1w5Pa2T1pepb+dyEDTH9ErvcRC/cZbyy
         5bmc+ZcTvmk0OSECUTvPOhzSRHZ36HbVlUhqpBTgITMEceyk5NvXCZ0CE8eJ4XMFZO
         pMI/Swb/bt5KyKVkh4xLUq/jx7WvyGKe5bxInw5aKZZ6D/cul3pFG1WKs/9cODVYo+
         GJkIoIHCrXoI3dOgJeg+DQ/m0mX5QUum5QFHrLisbv6h1TmPV2HwKgh52Ex2+2j6Qh
         XihCP+91jXGUP9GOg/i+kaV/zOjzXWwTyGo+U23VsIXNOU42hwGZBcRqh5izkwKl+E
         3CIQltqPK3u1w==
Received: by mail-lf1-f49.google.com with SMTP id a2so14537588lfb.6
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 05:57:53 -0700 (PDT)
X-Gm-Message-State: ACrzQf0bjaXM07+QEG1lbnSpypyfMpQhPbw3O/JcGYuAg3inVask8PcL
        FdClIJCp3A4Q2iDcETVih+SasVVcv+eRshsoElg=
X-Google-Smtp-Source: AMsMyM4titHzFAPYGFWEipNh4Qc8BF2xPHgafUlfsj3EYPlbqdQW/vXaVlruFHwB7D6ds3rIrk4An786hN0PyfM3BaQ=
X-Received: by 2002:ac2:4431:0:b0:497:aaf5:83eb with SMTP id
 w17-20020ac24431000000b00497aaf583ebmr1184618lfl.228.1663851471998; Thu, 22
 Sep 2022 05:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220920183554.3870247-1-ardb@kernel.org> <20220920183554.3870247-9-ardb@kernel.org>
 <CAAhV-H4+Exqu6Z3G_hYmhz=Ccv_4EKLjQ5GVT8h3YsJy0FSpAg@mail.gmail.com>
 <CAMj1kXG9HRn6iV5x-Q94xdOhNhiKMGiO6SkE3LMwzXPkXxen_Q@mail.gmail.com>
 <CAAhV-H5AjwKd-ydZTA=vKCA+fe_gAVyhCM2s-Wm54AqWqpBF1A@mail.gmail.com>
 <CAMj1kXFKfwvvidNPumQNzhHXSR4kHpTq-j4ygR=Jow7yySc44Q@mail.gmail.com>
 <CAAhV-H6O+a57aZbYH0yiCgNp18=shFvGtAppXFNSWGPRs0Ng2g@mail.gmail.com>
 <CAMj1kXF=ON-7GyHVvW8bMX1-5zreDUr7D_zNUs5PQdRW+uM+JQ@mail.gmail.com>
 <CAAhV-H5LLFyQbzzZLUyY38kYU5LvOacXPfrL6zzbZFDvE7QBhw@mail.gmail.com>
 <CAMj1kXGYFD+_VZ51M4mu1OAjbkPQsPyE-iKviiUbb8ibLrNczQ@mail.gmail.com>
 <CAAhV-H7cp_ip9B4BD65CsCerjKtfaxcQqi1T3QB8VveRXLhY_w@mail.gmail.com> <CAMj1kXG0nnB4qOyKp8-=ggxFYC_1ut6oHdkqX_mVqdZMadjb8g@mail.gmail.com>
In-Reply-To: <CAMj1kXG0nnB4qOyKp8-=ggxFYC_1ut6oHdkqX_mVqdZMadjb8g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 22 Sep 2022 14:57:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHrogd9MBauePjx8+68V0N4XjkVs6RKATJn06itie_J-g@mail.gmail.com>
Message-ID: <CAMj1kXHrogd9MBauePjx8+68V0N4XjkVs6RKATJn06itie_J-g@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] efi/loongarch: libstub: remove dependency on
 flattened DT
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, loongarch@lists.linux.dev,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 22 Sept 2022 at 14:50, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 22 Sept 2022 at 14:08, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Ard,
> >
> > On Thu, Sep 22, 2022 at 4:59 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 22 Sept 2022 at 09:42, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > >
> > > > On Thu, Sep 22, 2022 at 3:25 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Thu, 22 Sept 2022 at 09:22, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Sep 22, 2022 at 3:13 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, 22 Sept 2022 at 04:15, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Wed, Sep 21, 2022 at 4:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, 21 Sept 2022 at 06:02, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Thank you Huacai
> > > > > > > > >
> > > > > > > > > I have created a separate tag with these patches applied onto the
> > > > > > > > > first loongarch efi enablement patch (see below)
> > > > > > > > >
> > > > > > > > > I would prefer to keep the loongarch trees separate for the next merge
> > > > > > > > > window, but if needed to avoid massive conflicts, you could merge the
> > > > > > > > > tag into the loongarch tree and rebase your changes on top. But please
> > > > > > > > > take care not to rebase those patches themselves: the commit SHAs need
> > > > > > > > > to remain the same.
> > > > > > > > >
> > > > > > > > > However, if the conflicts are only minor, you can just explain in your
> > > > > > > > > PR to Linus what the resolution should look like.
> > > > > > > > >
> > > > > > > > > The tag can be found here:
> > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/tag/?h=efi-loongarch-for-v6.1-2
> > > > > > > > >
> > > > > > > > > I have merged this into the EFI tree as well and pushed it out; it
> > > > > > > > > should appear in -next tomorrow.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > b093dc55ba9a efi/loongarch: libstub: remove dependency on flattened DT
> > > > > > > > > 102faf0747c2 efi: libstub: install boot-time memory map as config table
> > > > > > > > > 7318926e7bc9 efi: libstub: remove DT dependency from generic stub
> > > > > > > > > 7cb6671e3caa efi: libstub: unify initrd loading between architectures
> > > > > > >
> > > > > > > I will have to respin the initrd patch, unfortunately, as it breaks
> > > > > > > x86. So the signed tag will be updated, and the SHAs above will change
> > > > > > > as well.
> > > > > > Emm, initrd is also broken on LoongArch, the core kernel gets an
> > > > > > EFI_INVALID_TABLE_ADDR address.
> > > > > >
> > > > >
> > > > > OK, I will investigate. This was working fine before so I'm not sure
> > > > > what happened there.
> > > > >
> > >
> > > I cannot reproduce this. Can you reproduce it with qemu? If so, can
> > > you share your command line and .config etc?
> > In qemu we also OK, but on a real machine efistub fails at
> > efi_bs_call(locate_device_path, &lf2_proto_guid, &dp, &handle), maybe
> > our UEFI BIOS has some problems? On a real machine we use grub and
> > there is no "initrd" command in UEFI shell.
> >
>
> Ah ok, so i guess your GRUB lacks the LoadFile2 patches?
>
> https://lists.gnu.org/archive/html/grub-devel/2022-09/msg00057.html
>
> Those have been blocked in review for almost 2 years. I cc'ed you on
> the latest version. Without those patches, GRUB will generate a DT to
> pass the initrd information.
>
> I understand this is annoying right now, but I strongly suggest to
> implement only a single method of loading the INITRD for EFI boot - it
> is much easier to reason about when things like secure boot and
> measured boot become relevant on your architecture.
>
> In any case, you can build your UEFI shell with the following dynamic
> command from EDK2:
>
> OvmfPkg/LinuxInitrdDynamicShellCommand/LinuxInitrdDynamicShellCommand.inf
>
> This add a 'initrd' command to the UEFI shell
>
> (it will also work for bare metal platforms not only for virtual machines)
>
>
> If this is a deal breaker for you, one workaround we might consider is
> to parse /chosen/linux,initrd-* in the LoongArch stub (but nothing
> else) if locating the LoadFile2 protocol fails and a DTB exists in the
> config table array. I'd prefer to avoid that if we can, but at least
> the initrd is always visible to the stub, for measurement etc.

Are all DT properties you need for kexec/kdump under the /chosen node?
