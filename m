Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471422247A9
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jul 2020 03:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGRBFs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Jul 2020 21:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGRBFr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Jul 2020 21:05:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C435C0619D2
        for <linux-efi@vger.kernel.org>; Fri, 17 Jul 2020 18:05:47 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so20172418wmh.2
        for <linux-efi@vger.kernel.org>; Fri, 17 Jul 2020 18:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LE3moRbyBfkEEvwl1ynsLf05iOxnrGFtEat6arjyjJA=;
        b=DlQrUmEcVs+sEzs7LTd6DciH8etJ7IwCujSHeDADxBNWKlerCcMjspn/MdYRgsubVO
         eTUPZ9yUuqQCMtLBhNQ3KgfTfCtnpEDh+rCd+1VBseJoD6abQWrF1PCQ+R7sbSO/cDgu
         sv9WWSlhBIos7DU49J+FTiOuQAgdnZvz8oTW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LE3moRbyBfkEEvwl1ynsLf05iOxnrGFtEat6arjyjJA=;
        b=GoNXhypVoucprgTVX/VFksnoECmsNC8KiQn4FZM22lgaqWykcjF9exEGvciLNIojJh
         SNsc1+Bf4Bmw1GnWXRgUnPCDm9DODZd4e+FrZkeXS3Hi8Ed8LsIcVAMVpEJo1fOvkb7w
         gfECCXNQUsQrPTiH9+t/Azr17JBzWitvLBSSib/uuhoToVomh+xupIj7rYvPzRtL9LX7
         XoocHbX+2esQ39Ukhs0thAjJzKEfeeIoj6r4rx/tUa1gZhx7UkvVITZ6q/va/OXrijVx
         96b33sG+ZW2PADEdBXOZCTWMtuBD9ZE5YB0Ox4wwoSV0sO2PaqDxeIqD4tKfElX3BKnC
         mjEQ==
X-Gm-Message-State: AOAM532I/p8nTvqXbf5LDja2dDvaDxSdfnUXdGfSAoCkko/zDtzk2IF6
        umTmfURW6lGdgQ8iK/7i5dmrhaaIILI4JkiFMQKH
X-Google-Smtp-Source: ABdhPJyW71Q+9gPc4iagfJKsdp8eQ4psR6/HGFDPbhItnh5dgiQ/pXQ+97eEPflcrjAm5dln6WHL8WYRXQVbggtopgg=
X-Received: by 2002:a1c:345:: with SMTP id 66mr11309396wmd.31.1595034344969;
 Fri, 17 Jul 2020 18:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200716234104.29049-1-atish.patra@wdc.com> <20200716234104.29049-2-atish.patra@wdc.com>
 <CAK8P3a2EesjQAs-YGrCO=cYfUVWFQ3CbJfVXJx3qZjCS_XW+wA@mail.gmail.com>
In-Reply-To: <CAK8P3a2EesjQAs-YGrCO=cYfUVWFQ3CbJfVXJx3qZjCS_XW+wA@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 17 Jul 2020 18:05:34 -0700
Message-ID: <CAOnJCUKF-tfN-fHyRcjyAMnYVzQqp=_CLa2F4TQNO7jA4infoQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 1/9] RISC-V: Move DT mapping outof fixmap
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 16, 2020 at 11:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jul 17, 2020 at 1:41 AM Atish Patra <atish.patra@wdc.com> wrote:
> >
> > From: Anup Patel <anup.patel@wdc.com>
> >
> > Currently, RISC-V reserves 1MB of fixmap memory for device tree. However,
> > it maps only single PMD (2MB) space for fixmap which leaves only < 1MB space
> > left for other kernel features such as early ioremap which requires fixmap
> > as well. The fixmap size can be increased by another 2MB but it brings
> > additional complexity and changes the virtual memory layout as well.
> > If we require some additional feature requiring fixmap again, it has to be
> > moved again.
> >
> > Technically, DT doesn't need a fixmap as the memory occupied by the DT is
> > only used during boot. Thus, init memory section can be used for the same
> > purpose as well. This simplifies fixmap implementation.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
>
> The patch seems fine for the moment, but I have one concern for the
> long run:
>
> > +#define DTB_EARLY_SIZE         SZ_1M
> > +static char early_dtb[DTB_EARLY_SIZE] __initdata;
>
> Hardcoding the size in .bss seems slightly problematic both for
> small and for big systems. On machines with very little memory,
> this can lead to running out of free pages before .initdata gets freed,
> and it increases the size of the uncompressed vmlinux file by quite
> a bit.
>
> On some systems, the 1MB limit may get too small. While most dtbs
> would fall into the range between 10KB and 100KB, it can also be
> much larger than that, e.g. when there are DT properties that include
> blobs like device firmware that gets loaded into hardware by a kernel
> driver.
>
I was not aware that we can do such things. Is there a current example of that ?

> Is there anything stopping you from parsing the FDT in its original
> location without the extra copy before it gets unflattened?
>

That's what the original code was doing. A fixmap entry was added to
map the original fdt
location to a virtual so that parse_dtb can be operated on a virtual
address. But we can't map
both FDT & early ioremap within a single PMD region( 2MB ). That's why
we removed the DT
mapping from the fixmap to .bss section. The other alternate option is
to increase the fixmap space to
4MB which seems more fragile.

>        Arnd



-- 
Regards,
Atish
