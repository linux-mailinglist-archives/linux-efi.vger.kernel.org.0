Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554AA2656E8
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 04:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgIKCQn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Sep 2020 22:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgIKCQm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Sep 2020 22:16:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A395C061573
        for <linux-efi@vger.kernel.org>; Thu, 10 Sep 2020 19:16:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q4so955084pjh.5
        for <linux-efi@vger.kernel.org>; Thu, 10 Sep 2020 19:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=n4v/8rr4VkLsCE+CfY9rCVTARECuJFIXohdPd2zyXTQ=;
        b=WleHAgg9vWTEvgdLvDghO2BkCqWqrk1JEDuvlC1o4sEkaBomsTKalfNPsUZxQ2ruZr
         gqLjYegWIW+CkUeqJj4EblGKIFPjluIkv2ODcrrFZzatS/cbvOCNEvmOzqRzB3lsPD5M
         I/87nVkWdeWCpi9vPuouMuMwniw1oYt6QOpTMnbEHP+3+StzYHYtuPzdjDkuQZ6WxGxV
         t6DSa94u4zoYuOmforKM8oKFkw8+xlM2hHwUBjhdLs0Rc2qBIqVA/5uqFot5zcKwDAaV
         49MkQXdHSZHNs18LH8TYqEcoFHMStN8awZq/zCegLgE2FZ3KcFxkNp53aBeEIAO8o0NN
         FDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=n4v/8rr4VkLsCE+CfY9rCVTARECuJFIXohdPd2zyXTQ=;
        b=ujcft75qhFXFRdse9YIWCNQsYCtrjH6SHJUtA4qaMS5xxKj9mg9WPwp+sZIV+++PIa
         KPx1xek3ej41sc7mpxGkcnfT3AXdK4enP8JELrbzKGabGW3ImPqEI2z4G9lH1Gz04rYn
         ixvlZv40YZLOL6WcOcw8ohcA88Lf7CVYebbkAFe5Av07xUehs4pzb+aHNwUoRZy2lCkI
         sfmcOTrxnywG8RaVT45D0OOyyehdUwQx0ZNsCRNieNmNpUpflxkCWOBChfWN7PuNjU2F
         teGXeofj488v0C3z6dA17zocidrTvVIqbbdao03tns/93C1S6a9hBsQMWO4gsarqOaDo
         DLzA==
X-Gm-Message-State: AOAM530WrD0KaAgidpFu6xkCTiNl/RbpQCs5LKpJYzHYXPYm85Pd0CmW
        tZZ2St+yhPzJnDPC6o5u/dNxcyXnscBnWQ==
X-Google-Smtp-Source: ABdhPJwGtM8lnuFyTNYcmWKTWl78+u1+1Wp/vKfr2wpUYejVt8g10MPZsXyb4QavLxLQnh/UiGyV7w==
X-Received: by 2002:a17:90a:f117:: with SMTP id cc23mr97942pjb.155.1599790599306;
        Thu, 10 Sep 2020 19:16:39 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v26sm266958pgo.83.2020.09.10.19.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 19:16:38 -0700 (PDT)
Date:   Thu, 10 Sep 2020 19:16:38 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Sep 2020 19:16:37 PDT (-0700)
Subject:     Re: [PATCH RFC/RFT 0/3] efi/libstub: arm32: Remove dependency on dram_base
In-Reply-To: <CAMj1kXG6VRXOPRhHmeyiPP06BVByEYsqYE001BZYyRDqtvyDBg@mail.gmail.com>
CC:     atishp@atishpatra.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, maxim.uvarov@linaro.org,
        xypron.glpk@gmx.de, Atish Patra <Atish.Patra@wdc.com>,
        jens.wiklander@linaro.org, francois.ozog@linaro.org,
        etienne.carriere@st.com, takahiro.akashi@linaro.org,
        patrice.chotard@st.com, sumit.garg@linaro.org,
        Grant.Likely@arm.com, ilias.apalodimas@linaro.org,
        christophe.priouzeau@linaro.org, r.czerwinski@pengutronix.de,
        patrick.delaunay@st.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ardb@kernel.org
Message-ID: <mhng-f3ca14fc-58f7-423e-8abe-a85de1a2d55b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 10 Sep 2020 07:08:07 PDT (-0700), ardb@kernel.org wrote:
> On Thu, 10 Sep 2020 at 13:04, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Thu, 10 Sep 2020 at 04:34, Atish Patra <atishp@atishpatra.org> wrote:
>> >
>> > On Wed, Sep 9, 2020 at 2:44 PM Atish Patra <atishp@atishpatra.org> wrote:
>> > >
>> > > On Wed, Sep 9, 2020 at 1:52 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> > > >
>> > > > On Wed, 09 Sep 2020 08:16:20 PDT (-0700), ardb@kernel.org wrote:
>> > > > > Maxim reports boot failures on platforms that describe reserved memory
>> > > > > regions in DT that are disjoint from system DRAM, and which are converted
>> > > > > to EfiReservedMemory regions by the EFI subsystem in u-boot.
>> > > > >
>> > > > > As it turns out, the whole notion of discovering the base of DRAM is
>> > > > > problematic, and it would be better to simply rely on the EFI memory
>> > > > > allocation routines instead, and derive the FDT and initrd allocation
>> > > > > limits from the actual placement of the kernel (which is what defines
>> > > > > the start of the linear region anyway)
>> > > > >
>> > > > > Finally, we should be able to get rid of get_dram_base() entirely.
>> > > > > However, as RISC-V only just started using it, we will need to address
>> > > > > that at a later time.
>> > > >
>> > > > Looks like we're using dram_base to derive two argumets to
>> > > > efi_relocate_kernel(): the preferred load address and the minimum load address.
>> > > > I don't see any reason why we can't use the same PAGE_OFFSET-like logic that
>> > > > x86 uses for the minimum load address, but I don't think we have any mechanism
>> > > > like "struct boot_params" so we'd need to come up with something.
>> > > >
>> > >
>> > > As discussed in the other thread
>> > > (https://www.spinics.net/lists/linux-efi/msg20262.html),
>> > > we don't need to do anything special. efi_relocate_kernel can just
>> > > take preferred address as 0
>> > > so that efi_bs_alloc will fail and efi_low_alloc_above will be used to
>> > > allocate 2MB/4MB aligned address as per requirement.
>> > >
>> > > I don't think the other changes in this series will cause any issue
>> > > for RISC-V. I will test it and update anyways.
>> > >
>> > > > > Cc: Maxim Uvarov <maxim.uvarov@linaro.org>
>> > > > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> > > > > Cc: Atish Patra <atish.patra@wdc.com>
>> > > > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> > > > > Cc: Jens Wiklander <jens.wiklander@linaro.org>
>> > > > > Cc: Francois Ozog <francois.ozog@linaro.org>
>> > > > > Cc: Etienne CARRIERE <etienne.carriere@st.com>
>> > > > > Cc: Takahiro Akashi <takahiro.akashi@linaro.org>
>> > > > > Cc: Patrice CHOTARD <patrice.chotard@st.com>
>> > > > > Cc: Sumit Garg <sumit.garg@linaro.org>
>> > > > > Cc: Grant Likely <Grant.Likely@arm.com>
>> > > > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> > > > > Cc: Christophe Priouzeau <christophe.priouzeau@linaro.org>
>> > > > > Cc: Rouven Czerwinski <r.czerwinski@pengutronix.de>
>> > > > > Cc: Patrick DELAUNAY <patrick.delaunay@st.com>
>> > > > >
>> > > > > Ard Biesheuvel (3):
>> > > > >   efi/libstub: Export efi_low_alloc_above() to other units
>> > > > >   efi/libstub: Use low allocation for the uncompressed kernel
>> > > > >   efi/libstub: base FDT and initrd placement on image address not DRAM
>> > > > >     base
>> > > > >
>> > > > >  arch/arm/include/asm/efi.h                |   6 +-
>> > > > >  arch/arm64/include/asm/efi.h              |   2 +-
>> > > > >  drivers/firmware/efi/libstub/arm32-stub.c | 177 ++++----------------
>> > > > >  drivers/firmware/efi/libstub/efi-stub.c   |   2 +-
>> > > > >  drivers/firmware/efi/libstub/efistub.h    |   3 +
>> > > > >  drivers/firmware/efi/libstub/relocate.c   |   4 +-
>> > > > >  6 files changed, 47 insertions(+), 147 deletions(-)
>> > >
>> >
>> > I verified the above patches along with the following RISC-V specific changes.
>> >
>> > diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
>> > index 93c305a638f4..dd6ceea9d548 100644
>> > --- a/arch/riscv/include/asm/efi.h
>> > +++ b/arch/riscv/include/asm/efi.h
>> > @@ -37,7 +37,7 @@ static inline unsigned long
>> > efi_get_max_fdt_addr(unsigned long dram_base)
>> >  static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
>> >                                                     unsigned long image_addr)
>> >  {
>> > -       return dram_base + SZ_256M;
>> > +       return image_addr + SZ_256M;
>> >  }
>> >
>>
>> Ah yes, we need this change as well - this is a bit unfortunate since
>> that creates a conflict with the RISC-V tree.
>>
>> > --- a/drivers/firmware/efi/libstub/riscv-stub.c
>> > +++ b/drivers/firmware/efi/libstub/riscv-stub.c
>> > @@ -100,7 +100,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>> >          */
>> >         preferred_addr = round_up(dram_base, MIN_KIMG_ALIGN) + MIN_KIMG_ALIGN;
>> >         status = efi_relocate_kernel(image_addr, kernel_size, *image_size,
>> > -                                    preferred_addr, MIN_KIMG_ALIGN, dram_base);
>> > +                                    0, MIN_KIMG_ALIGN, 0);
>> >
>> > FWIW: Tested-by: Atish Patra <atish.patra@wdc.com>
>>
>> Thanks for confirming.
>
> OK,
>
> So, just to annoy Palmer and you more than I already have up to this
> point: any chance we could do a final respin of the RISC-V code on top
> of these changes? They are important for ARM, and I would prefer these
> to be merged in a way that makes it easy to backport them to -stable
> if needed.
>
> So what I would suggest is:
> - I will create a new 'shared-efi' tag/stable branch containing the
> existing two patches, as well as these changes (in a slightly updated
> form)
> - Palmer creates a new topic branch in the riscv repo based on this
> shared tag, and applies the [updated] RISC-V patches on top
> - Palmer drops the current version of the riscv patches from
> riscv/for-next, and merges the topic branch into it instead.
>
> Again, sorry to be a pain, but I think this is the cleanest way to get
> these changes queued up for v5.10 without painting ourselves into a
> corner too much when it comes to future follow-up changes.

That's fine for me.
