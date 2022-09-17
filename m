Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60D5BB708
	for <lists+linux-efi@lfdr.de>; Sat, 17 Sep 2022 09:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIQH7p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 17 Sep 2022 03:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIQH7p (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 17 Sep 2022 03:59:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A161400E
        for <linux-efi@vger.kernel.org>; Sat, 17 Sep 2022 00:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34215B8015A
        for <linux-efi@vger.kernel.org>; Sat, 17 Sep 2022 07:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBE1C433D6
        for <linux-efi@vger.kernel.org>; Sat, 17 Sep 2022 07:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663401578;
        bh=/Aovh0Sqajn80II7zoVXfdYqQJdl+W8eTy4HPh4rtFQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qRvIC14OsKc5o3iJeFKTtZnZ09cVcenqfkObKpVq7TciD8wX4MAf0zaJOPTChK0kS
         dqAxxFQjmgCUp3igQSpwSkkfsHwdJqfk9zoz6VgEkeZlRFI2Z8iridFZjeeeWMSZKv
         K8uAmllI5zjJBHYs3cXfU4BooQ/xEMq1sm/REropn7HEuzYDCavrbXWqZPe9VCtXtL
         4tEAXp9LQqkX0tN7HXlNllcvjDoTd9L0tiw7vauO24Rx26AJw7q2Di06KmvABnlvp8
         unv5Ma40eKVrVi7mJ2sn2Bwium27pWBWKPJzEya3IK9tuJEUFmCJdUg3Jt15SopGr8
         lX9JRpORPXixw==
Received: by mail-vs1-f51.google.com with SMTP id 129so24939153vsi.10
        for <linux-efi@vger.kernel.org>; Sat, 17 Sep 2022 00:59:38 -0700 (PDT)
X-Gm-Message-State: ACrzQf3tSB5G99eEoHvbe/yuhRv3qwrsa6PDXIGraMtP9MGZiyjY9+T4
        VO/j0UczqRokrq+e/yoTvgd2foEHepe9+oNXuUU=
X-Google-Smtp-Source: AMsMyM4DldcHyeNgMxcqL7EywIWD5H7U2AsA2HPKA7+q+r61Zsvb+Mw0AT5M76vdSZikHyI9m2ya5rSIJvKr3TlEIGw=
X-Received: by 2002:a05:6102:1481:b0:39a:67f5:3096 with SMTP id
 d1-20020a056102148100b0039a67f53096mr3325990vsv.70.1663401577594; Sat, 17 Sep
 2022 00:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXHk2o2g2t34-iMawUjfJd1uCZc1QaXH90TpS54Sg6PiCQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHk2o2g2t34-iMawUjfJd1uCZc1QaXH90TpS54Sg6PiCQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 17 Sep 2022 15:59:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5t0WRYqNi-jCBM0sikn9RUc88s8zLd8sKGmRvYxNFnnA@mail.gmail.com>
Message-ID: <CAAhV-H5t0WRYqNi-jCBM0sikn9RUc88s8zLd8sKGmRvYxNFnnA@mail.gmail.com>
Subject: Re: Removing DT dependency from LoongArch EFI stub
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Xuerui Wang <kernel@xen0n.name>,
        linux-efi <linux-efi@vger.kernel.org>, loongarch@lists.linux.dev
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

On Sat, Sep 17, 2022 at 2:37 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Hello,
>
> One of the things I didn't quite like was that LoongArch now uses
> libfdt only because our EFI stub code depends on it. I would like to
> fix this.
>
> I have pushed a branch here that implements this. Unfortunately, it
> doesn't proceed beyond
>
> and I need some help debugging the error.
>
> EFI stub: Booting Linux Kernel...
> EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> EFI stub: Exiting boot services ...
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=efi-cleanups-for-v6.1
>
> The idea is to pass the EFI system table pointer and the command line
> pointer directly. In previous patches, the initrd and memmap code is
> updated so it exposes the information via configuration tables that
> the generic code can parse.
>
> Any help is greatly appreciated.
I'm sorry but I suggest keeping the current light FDT approach. Of
course the upstream LoongArch kernel uses UEFI+ACPI, but it only
supports high-end systems (Loongson-3A/3C CPU with LS7A chipset). In
fact, low-end systems (Loongson-2K CPU in SoC) support is already on
the way and target for 6.2, which uses FDT in order to share a number
of existing drivers. Using the current approach can share lots of boot
code for both high-end and low-end systems, and doesn't break boot
again.

Thanks,
Huacai

>
> Thanks,
> Ard.
