Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658265E6624
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 16:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiIVOsY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 10:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiIVOsX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 10:48:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09828F2755
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 07:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82CF5B837F8
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 14:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256B2C43470
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663858099;
        bh=cMel3Eu2KXw20lTWdA6aCEa3jaT7myHDgNc9LdQVwEk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jonmxDaXcjAZ++2A/OzrcypmSfrOcelJ9nHLd9Knh70hE6/ZwVuBBrNVFMuZO1k0N
         Am+jjbJLcUWTncJ3sgdLkgmGotw7x8diiMuLerYx4g82Zq7lgEtDdpQtS5dVLl1dWt
         YQHfYlj92EDrFt3UlurUPdJqKIaIbjU8Ypt0t9ePd4dGp6M+JeSIEUjwZj8ATKl7ka
         J1ZBpad1l7DQtQtnOPdfCtoMR70uXsdHkr4L/SjauRCY7f59JMj30yHRisYEMeYaX3
         OmhVuz8onuo17W0Ps8Bp31ZLdU58z8T1v4Fx+lApwPw/k7xXqfRy1v0+RyYvoEknRB
         6wOacLv2l4jlQ==
Received: by mail-vs1-f46.google.com with SMTP id u189so10563940vsb.4
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 07:48:19 -0700 (PDT)
X-Gm-Message-State: ACrzQf3DucU+i5cm3HlDc54k0zPaeMefbZIxhCVUbs0cvbmuFuiMZh+W
        bqB5Rnr1A7kgARJupGxN4t6+JncTZA0sB+TN49o=
X-Google-Smtp-Source: AMsMyM6orUn5WJdFVXsvByIj4xy5chSrK9frM43HHauQziF2lM+Ck7tTPZGVc7W2rgJItzUwD34QKyAKWa/JikG3SRg=
X-Received: by 2002:a67:d59d:0:b0:398:211f:9a45 with SMTP id
 m29-20020a67d59d000000b00398211f9a45mr1660995vsj.78.1663858098049; Thu, 22
 Sep 2022 07:48:18 -0700 (PDT)
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
 <CAAhV-H7cp_ip9B4BD65CsCerjKtfaxcQqi1T3QB8VveRXLhY_w@mail.gmail.com>
 <CAMj1kXG0nnB4qOyKp8-=ggxFYC_1ut6oHdkqX_mVqdZMadjb8g@mail.gmail.com>
 <CAAhV-H6botg=dVVQb1YiPnBHwxVuoyDo1CKd-HbrnhCztQiQZA@mail.gmail.com>
 <CAMj1kXHcbtjR=+==eBhxTRN=uUrvfBjYEpoLKkMQpbpqrxdN9A@mail.gmail.com>
 <CAAhV-H439XWK5ZRSw5w2zN-w8sNLMkR7VSFfxp04ud4C-gOLnA@mail.gmail.com>
 <CAMj1kXGoG8XDASsEEn3B8b0DvF37ryY5Do1iRdKHuouohsLN3g@mail.gmail.com>
 <CAMj1kXH_vWCxr1r1j7kJ43PcmgAUeuf=QdrbXU2fanEgeCTTgQ@mail.gmail.com> <CAMj1kXF8JOuTSZONzF20Qz6xhrou7puwjWMK8z7u7aDg1yGBkg@mail.gmail.com>
In-Reply-To: <CAMj1kXF8JOuTSZONzF20Qz6xhrou7puwjWMK8z7u7aDg1yGBkg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 22 Sep 2022 22:48:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4HLz7rjxrBb1QVGKBfVWC7RdmpL8rHdOSU0e2vtmG6BA@mail.gmail.com>
Message-ID: <CAAhV-H4HLz7rjxrBb1QVGKBfVWC7RdmpL8rHdOSU0e2vtmG6BA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] efi/loongarch: libstub: remove dependency on
 flattened DT
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Thu, Sep 22, 2022 at 9:52 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 22 Sept 2022 at 15:19, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 22 Sept 2022 at 15:18, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 22 Sept 2022 at 15:12, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > >
> > > > On Thu, Sep 22, 2022 at 9:10 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Thu, 22 Sept 2022 at 15:09, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Sep 22, 2022 at 8:50 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, 22 Sept 2022 at 14:08, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > >
> > > > > > > > Hi, Ard,
> > > > > > > >
> > > > > > > > On Thu, Sep 22, 2022 at 4:59 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, 22 Sept 2022 at 09:42, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Sep 22, 2022 at 3:25 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, 22 Sept 2022 at 09:22, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Sep 22, 2022 at 3:13 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, 22 Sept 2022 at 04:15, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Wed, Sep 21, 2022 at 4:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Wed, 21 Sept 2022 at 06:02, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Thank you Huacai
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I have created a separate tag with these patches applied onto the
> > > > > > > > > > > > > > > first loongarch efi enablement patch (see below)
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I would prefer to keep the loongarch trees separate for the next merge
> > > > > > > > > > > > > > > window, but if needed to avoid massive conflicts, you could merge the
> > > > > > > > > > > > > > > tag into the loongarch tree and rebase your changes on top. But please
> > > > > > > > > > > > > > > take care not to rebase those patches themselves: the commit SHAs need
> > > > > > > > > > > > > > > to remain the same.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > However, if the conflicts are only minor, you can just explain in your
> > > > > > > > > > > > > > > PR to Linus what the resolution should look like.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The tag can be found here:
> > > > > > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/tag/?h=efi-loongarch-for-v6.1-2
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I have merged this into the EFI tree as well and pushed it out; it
> > > > > > > > > > > > > > > should appear in -next tomorrow.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > b093dc55ba9a efi/loongarch: libstub: remove dependency on flattened DT
> > > > > > > > > > > > > > > 102faf0747c2 efi: libstub: install boot-time memory map as config table
> > > > > > > > > > > > > > > 7318926e7bc9 efi: libstub: remove DT dependency from generic stub
> > > > > > > > > > > > > > > 7cb6671e3caa efi: libstub: unify initrd loading between architectures
> > > > > > > > > > > > >
> > > > > > > > > > > > > I will have to respin the initrd patch, unfortunately, as it breaks
> > > > > > > > > > > > > x86. So the signed tag will be updated, and the SHAs above will change
> > > > > > > > > > > > > as well.
> > > > > > > > > > > > Emm, initrd is also broken on LoongArch, the core kernel gets an
> > > > > > > > > > > > EFI_INVALID_TABLE_ADDR address.
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > OK, I will investigate. This was working fine before so I'm not sure
> > > > > > > > > > > what happened there.
> > > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I cannot reproduce this. Can you reproduce it with qemu? If so, can
> > > > > > > > > you share your command line and .config etc?
> > > > > > > > In qemu we also OK, but on a real machine efistub fails at
> > > > > > > > efi_bs_call(locate_device_path, &lf2_proto_guid, &dp, &handle), maybe
> > > > > > > > our UEFI BIOS has some problems? On a real machine we use grub and
> > > > > > > > there is no "initrd" command in UEFI shell.
> > > > > > > >
> > > > > > >
> > > > > > > Ah ok, so i guess your GRUB lacks the LoadFile2 patches?
> > > > > > >
> > > > > > > https://lists.gnu.org/archive/html/grub-devel/2022-09/msg00057.html
> > > > > > Maybe it is a GRUB problem (I'll discuss with GRUB team), but why
> > > > > > without this series the GRUB can load initrd? Because in the old way
> > > > > > UEFI BIOS fill initrd information to FDT?
> > > > > >
> > > > >
> > > > > No GRUB loads the initrd and creates a DT with a /chosen node to
> > > > > record the initrd base and size.
> > > > Without this series, efistub also fails at
> > > > efi_bs_call(locate_device_path, &lf2_proto_guid, &dp, &handle), but
> > > > initrd works well, this makes me puzzled.
> > > >
> > >
> > > That is because you don't have DTB support in the core kernel yet right?
> >
> > Never mind - what exact commit are you testing this with?
>
> OK, so the existing code only does
>
> early_init_dt_scan(fdt_ptr);
> early_init_fdt_reserve_self();
> efi_system_table = efi_get_fdt_params(&data);
>
> so it never parses the /chosen node, and therefore does not discover the initrd.
>
> I suppose you may have been running with the loongson-2k patches?
>
> But actually, this describes exactly the problem that I am addressing
> with this series: you have been inadvertently relying on DT hardware
> support for initrd functionality ...
Yes, the correct way is to update our grub. But for kexec, seems
initrd over cmdline is the only way because we don't know how to
handle systemtable and don't know how to work together with both
ACPI/DT systems after efistub refactoring.

Huacai
