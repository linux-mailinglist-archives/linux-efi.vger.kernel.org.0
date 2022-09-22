Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65475E61F1
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 14:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiIVMIH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 08:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiIVMIG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 08:08:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FC19F8DD
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 05:08:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E0B2611F5
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 12:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2876C43470
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 12:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663848484;
        bh=mZtO78L7kUm4pLq8Iw70ss7GQPlynjH+x+7zIy2VvRw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CCeLqhxXzkcEfRm6dn755WHy36BeFAtNiTBIH+gVSlNSl3nJLaFM+xCJNtGwBNuhd
         hzuABqlnlpqYaP2FYZP3uDuS47dqr0TP7w1TiQoV5CyZAdFP+/5b1gqANvgwdvtMGY
         rb+JQS1xpPm5UX2+sBKNnKcwVkXATVrWQjDFGCwpq3WQJvgrACheHwwhAoMJJIxWuB
         auZ6vD/FMGoPGzlaMYFr5DpK1dbyI1iccGRTgxvnlMULDQWct75zWPI/bda1ptZr2X
         K9AQ5b7CyPxUGfvUhko90r9uv9OIgOWAcwFeP04zSa2kVrbwO+W4Ml9cevarCmfsLF
         1cndDw7BzTyeg==
Received: by mail-vs1-f41.google.com with SMTP id k2so10021365vsk.8
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 05:08:04 -0700 (PDT)
X-Gm-Message-State: ACrzQf1KBac4dPqTxM5Bm1aukeSLt/o0ZbEQ3VTckyTQj1F88NpBNpv5
        4vGtjeInuU94IjJeUibvxeuZXAAGSM6NsVlQp9o=
X-Google-Smtp-Source: AMsMyM6QIJF9P7etA/3bfW9xEi9a0pGf9L8/Yu4xO2EsSB2/QvgD68OrwjcUMrgGDe+rhTpuuTqNmNEyEAjKnOOvGoU=
X-Received: by 2002:a05:6102:1481:b0:39a:67f5:3096 with SMTP id
 d1-20020a056102148100b0039a67f53096mr936440vsv.70.1663848483545; Thu, 22 Sep
 2022 05:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220920183554.3870247-1-ardb@kernel.org> <20220920183554.3870247-9-ardb@kernel.org>
 <CAAhV-H4+Exqu6Z3G_hYmhz=Ccv_4EKLjQ5GVT8h3YsJy0FSpAg@mail.gmail.com>
 <CAMj1kXG9HRn6iV5x-Q94xdOhNhiKMGiO6SkE3LMwzXPkXxen_Q@mail.gmail.com>
 <CAAhV-H5AjwKd-ydZTA=vKCA+fe_gAVyhCM2s-Wm54AqWqpBF1A@mail.gmail.com>
 <CAMj1kXFKfwvvidNPumQNzhHXSR4kHpTq-j4ygR=Jow7yySc44Q@mail.gmail.com>
 <CAAhV-H6O+a57aZbYH0yiCgNp18=shFvGtAppXFNSWGPRs0Ng2g@mail.gmail.com>
 <CAMj1kXF=ON-7GyHVvW8bMX1-5zreDUr7D_zNUs5PQdRW+uM+JQ@mail.gmail.com>
 <CAAhV-H5LLFyQbzzZLUyY38kYU5LvOacXPfrL6zzbZFDvE7QBhw@mail.gmail.com> <CAMj1kXGYFD+_VZ51M4mu1OAjbkPQsPyE-iKviiUbb8ibLrNczQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGYFD+_VZ51M4mu1OAjbkPQsPyE-iKviiUbb8ibLrNczQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 22 Sep 2022 20:07:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7cp_ip9B4BD65CsCerjKtfaxcQqi1T3QB8VveRXLhY_w@mail.gmail.com>
Message-ID: <CAAhV-H7cp_ip9B4BD65CsCerjKtfaxcQqi1T3QB8VveRXLhY_w@mail.gmail.com>
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

Hi, Ard,

On Thu, Sep 22, 2022 at 4:59 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 22 Sept 2022 at 09:42, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > On Thu, Sep 22, 2022 at 3:25 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 22 Sept 2022 at 09:22, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > >
> > > > On Thu, Sep 22, 2022 at 3:13 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Thu, 22 Sept 2022 at 04:15, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Sep 21, 2022 at 4:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > >
> > > > > > > On Wed, 21 Sept 2022 at 06:02, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > >
> > > > > > > > Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > > > >
> > > > > > >
> > > > > > > Thank you Huacai
> > > > > > >
> > > > > > > I have created a separate tag with these patches applied onto the
> > > > > > > first loongarch efi enablement patch (see below)
> > > > > > >
> > > > > > > I would prefer to keep the loongarch trees separate for the next merge
> > > > > > > window, but if needed to avoid massive conflicts, you could merge the
> > > > > > > tag into the loongarch tree and rebase your changes on top. But please
> > > > > > > take care not to rebase those patches themselves: the commit SHAs need
> > > > > > > to remain the same.
> > > > > > >
> > > > > > > However, if the conflicts are only minor, you can just explain in your
> > > > > > > PR to Linus what the resolution should look like.
> > > > > > >
> > > > > > > The tag can be found here:
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/tag/?h=efi-loongarch-for-v6.1-2
> > > > > > >
> > > > > > > I have merged this into the EFI tree as well and pushed it out; it
> > > > > > > should appear in -next tomorrow.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > b093dc55ba9a efi/loongarch: libstub: remove dependency on flattened DT
> > > > > > > 102faf0747c2 efi: libstub: install boot-time memory map as config table
> > > > > > > 7318926e7bc9 efi: libstub: remove DT dependency from generic stub
> > > > > > > 7cb6671e3caa efi: libstub: unify initrd loading between architectures
> > > > >
> > > > > I will have to respin the initrd patch, unfortunately, as it breaks
> > > > > x86. So the signed tag will be updated, and the SHAs above will change
> > > > > as well.
> > > > Emm, initrd is also broken on LoongArch, the core kernel gets an
> > > > EFI_INVALID_TABLE_ADDR address.
> > > >
> > >
> > > OK, I will investigate. This was working fine before so I'm not sure
> > > what happened there.
> > >
>
> I cannot reproduce this. Can you reproduce it with qemu? If so, can
> you share your command line and .config etc?
In qemu we also OK, but on a real machine efistub fails at
efi_bs_call(locate_device_path, &lf2_proto_guid, &dp, &handle), maybe
our UEFI BIOS has some problems? On a real machine we use grub and
there is no "initrd" command in UEFI shell.

Huacai
