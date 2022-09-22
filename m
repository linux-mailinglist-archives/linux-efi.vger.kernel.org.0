Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183925E5C46
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 09:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiIVHWX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 03:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiIVHWW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 03:22:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF86E9A6B9
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 00:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 777E7B834D7
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 07:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348B9C433D6
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 07:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663831338;
        bh=ECswKkioxqUYJvDjL4amLlR/VyDBspn+RwnVrk9djqQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A9yoNAbTVGtjEQqZg/x1c+935RfCNXgG/1O1+Ifu2znV8rKVXUWfYsdmz4zo+k0Gq
         4Bv3IrwfeBREyDN953Z0cbSWrV/0WvmhD2nN69U3+WABFzVKf37yiExE+NNDuUDjb8
         /GHEpkW6zCBeNiAKvn4iWElq+dLPOUwN2hbMYLqsDAvtqQNDjKCLepSP8bbAm+0ZtX
         GV9AOEppt1eUtyuOkmRbqil3A2fqdvmFPtGCxMEvWW4KShbi8SYsqEFQdWwoTzfklQ
         arF+Jes33FBus0Qzqds0g6Pc++PPUPYIVcuB6PAaNn8E0SW3Ob5oKXWJW+WBl3HCK3
         DJ3CTsnjYyqZQ==
Received: by mail-vs1-f49.google.com with SMTP id k2so9317091vsk.8
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 00:22:18 -0700 (PDT)
X-Gm-Message-State: ACrzQf1Nb6fd3idOGiUqU+YDlHqmx3atplO+oRTiTI/en29bLo1SxJ8C
        4ilXD/Lg5mv+E9tCY1HKgoA2azZaKorcHnHPygc=
X-Google-Smtp-Source: AMsMyM4Eg74+i/jU4lJi1FgtdcwGnDPhkPELFMznXR2qE2jKyOdz8dFPlGue8k0dBbIikQMyd/PZR69nH+90u4yZ9zw=
X-Received: by 2002:a05:6102:3d05:b0:398:7dce:8492 with SMTP id
 i5-20020a0561023d0500b003987dce8492mr692585vsv.43.1663831337107; Thu, 22 Sep
 2022 00:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220920183554.3870247-1-ardb@kernel.org> <20220920183554.3870247-9-ardb@kernel.org>
 <CAAhV-H4+Exqu6Z3G_hYmhz=Ccv_4EKLjQ5GVT8h3YsJy0FSpAg@mail.gmail.com>
 <CAMj1kXG9HRn6iV5x-Q94xdOhNhiKMGiO6SkE3LMwzXPkXxen_Q@mail.gmail.com>
 <CAAhV-H5AjwKd-ydZTA=vKCA+fe_gAVyhCM2s-Wm54AqWqpBF1A@mail.gmail.com> <CAMj1kXFKfwvvidNPumQNzhHXSR4kHpTq-j4ygR=Jow7yySc44Q@mail.gmail.com>
In-Reply-To: <CAMj1kXFKfwvvidNPumQNzhHXSR4kHpTq-j4ygR=Jow7yySc44Q@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 22 Sep 2022 15:21:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6O+a57aZbYH0yiCgNp18=shFvGtAppXFNSWGPRs0Ng2g@mail.gmail.com>
Message-ID: <CAAhV-H6O+a57aZbYH0yiCgNp18=shFvGtAppXFNSWGPRs0Ng2g@mail.gmail.com>
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

On Thu, Sep 22, 2022 at 3:13 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 22 Sept 2022 at 04:15, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > On Wed, Sep 21, 2022 at 4:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 21 Sept 2022 at 06:02, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > >
> > > > Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> > > >
> > >
> > > Thank you Huacai
> > >
> > > I have created a separate tag with these patches applied onto the
> > > first loongarch efi enablement patch (see below)
> > >
> > > I would prefer to keep the loongarch trees separate for the next merge
> > > window, but if needed to avoid massive conflicts, you could merge the
> > > tag into the loongarch tree and rebase your changes on top. But please
> > > take care not to rebase those patches themselves: the commit SHAs need
> > > to remain the same.
> > >
> > > However, if the conflicts are only minor, you can just explain in your
> > > PR to Linus what the resolution should look like.
> > >
> > > The tag can be found here:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/tag/?h=efi-loongarch-for-v6.1-2
> > >
> > > I have merged this into the EFI tree as well and pushed it out; it
> > > should appear in -next tomorrow.
> > >
> > >
> > >
> > > b093dc55ba9a efi/loongarch: libstub: remove dependency on flattened DT
> > > 102faf0747c2 efi: libstub: install boot-time memory map as config table
> > > 7318926e7bc9 efi: libstub: remove DT dependency from generic stub
> > > 7cb6671e3caa efi: libstub: unify initrd loading between architectures
>
> I will have to respin the initrd patch, unfortunately, as it breaks
> x86. So the signed tag will be updated, and the SHAs above will change
> as well.
Emm, initrd is also broken on LoongArch, the core kernel gets an
EFI_INVALID_TABLE_ADDR address.

>
> > > 1add08ceb15b efi: libstub: remove pointless goto kludge
> > > d2130a9cf0f7 efi: libstub: simplify efi_get_memory_map() and struct
> > > efi_boot_memmap
> > > bc5853aa56de efi: libstub: avoid efi_get_memory_map() for allocating
> > > the virt map
> > > d80ca810f096 efi: libstub: drop pointless get_memory_map() call
> > > ead384d95634 (tag: efi-loongarch-for-v6.1) efi/loongarch: Add efistub
> > > booting support
> > > 568035b01cfb (tag: v6.0-rc1) Linux 6.0-rc1
> > Hmmm, I want to also merge zboot support in the loongarch-next's base,
> > is that possible?
> >
>
> No, let's keep that separate. LoongArch boots fine without it, so we
> can wait until it arrives via the EFI tree, no?
Both OK but I prefer to use a compressed kernel in daily work.

Huacai
