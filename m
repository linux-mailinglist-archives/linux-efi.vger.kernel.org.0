Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038DD26399A
	for <lists+linux-efi@lfdr.de>; Thu, 10 Sep 2020 03:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgIJB60 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 21:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgIJBfV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Sep 2020 21:35:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18114C061374
        for <linux-efi@vger.kernel.org>; Wed,  9 Sep 2020 18:34:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so4013852wmi.3
        for <linux-efi@vger.kernel.org>; Wed, 09 Sep 2020 18:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GrPqY5T/J8rFLZPU1SZ+TN9A67zhzaFO1L8J/pur38w=;
        b=rZmdQJaC1gYBHG2YMMZ1DTjmUef9K8e2HDxn7aojLvseKBjLjYR8hrK3Ej81O0x363
         1USedyZeB03aFe+dooEu26IFKY6Myr0m/jXnruC0bRazZOqTx2/eFNSWaZeh1E/xk+Wl
         l6bZ3aKz++n0jw72edqsT6hOeQMcUuYY3WC1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GrPqY5T/J8rFLZPU1SZ+TN9A67zhzaFO1L8J/pur38w=;
        b=Fht3sk/UKv1Fj5btLKrbR4xASonij1l1Jz6nlN2JsESa8DZzw1GV8YZhhcn8Rf49oN
         u85/XCS8bGmxr8Gq1/Nx7SarQttzo+O1hk8cJE5tla8sOXbetpjuribaAY2+86yUcZiZ
         s/3mDR6T9l9MrqEg7YO/G5Cq+gD1fBxD/1adT0irK3yMi0s1RpacPbK3LW8gOyDuE5Jd
         9/MAsaFTduCoGYE5aRZHSmOQFyuDqlknwHsdzMhlB5xGpJFcLY6ClezsxlEOQBYjojc1
         F5v6WcenZl7zfyvkrJ5/8umQ8L3MTyvwClljjxwOqTxU4rNUm9t9eDDrSqT3tIQtWfC1
         PFCQ==
X-Gm-Message-State: AOAM532IyAETqrqkp0bUCRw3QkhsPBJ3F8ZgleF5PgEtmSxYOEZV6iAs
        7ypM9mucyJB9+REQBMTINgP4XCuM8Z6zRizH8u/k
X-Google-Smtp-Source: ABdhPJwKXlPDQeLzoE66dc6qojgB7mFpYwMUAHE0Ux6W0acKIPST7Q5fYuM7DC+vIr4bQbctJMC1nPrG1VJ3gA/UMIg=
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr5919874wml.176.1599701697148;
 Wed, 09 Sep 2020 18:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200909151623.16153-1-ardb@kernel.org> <mhng-8fe8da11-e991-494e-bfc7-fd3e563dad75@palmerdabbelt-glaptop1>
 <CAOnJCUL+NietRhAvcGhqrdUOvxxsOpb5zAJLnXRekTv0g7o4yg@mail.gmail.com>
In-Reply-To: <CAOnJCUL+NietRhAvcGhqrdUOvxxsOpb5zAJLnXRekTv0g7o4yg@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 9 Sep 2020 18:34:46 -0700
Message-ID: <CAOnJCULe5+dJmJuCJanMrYj_CX2BRN5=6VWYEZ6vyg8Y6jBWSw@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT 0/3] efi/libstub: arm32: Remove dependency on dram_base
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>,
        etienne.carriere@st.com,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        patrice.chotard@st.com, sumit.garg@linaro.org,
        Grant Likely <Grant.Likely@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        christophe.priouzeau@linaro.org, r.czerwinski@pengutronix.de,
        Patrick Delaunay <patrick.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 9, 2020 at 2:44 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Wed, Sep 9, 2020 at 1:52 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > On Wed, 09 Sep 2020 08:16:20 PDT (-0700), ardb@kernel.org wrote:
> > > Maxim reports boot failures on platforms that describe reserved memory
> > > regions in DT that are disjoint from system DRAM, and which are converted
> > > to EfiReservedMemory regions by the EFI subsystem in u-boot.
> > >
> > > As it turns out, the whole notion of discovering the base of DRAM is
> > > problematic, and it would be better to simply rely on the EFI memory
> > > allocation routines instead, and derive the FDT and initrd allocation
> > > limits from the actual placement of the kernel (which is what defines
> > > the start of the linear region anyway)
> > >
> > > Finally, we should be able to get rid of get_dram_base() entirely.
> > > However, as RISC-V only just started using it, we will need to address
> > > that at a later time.
> >
> > Looks like we're using dram_base to derive two argumets to
> > efi_relocate_kernel(): the preferred load address and the minimum load address.
> > I don't see any reason why we can't use the same PAGE_OFFSET-like logic that
> > x86 uses for the minimum load address, but I don't think we have any mechanism
> > like "struct boot_params" so we'd need to come up with something.
> >
>
> As discussed in the other thread
> (https://www.spinics.net/lists/linux-efi/msg20262.html),
> we don't need to do anything special. efi_relocate_kernel can just
> take preferred address as 0
> so that efi_bs_alloc will fail and efi_low_alloc_above will be used to
> allocate 2MB/4MB aligned address as per requirement.
>
> I don't think the other changes in this series will cause any issue
> for RISC-V. I will test it and update anyways.
>
> > > Cc: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > Cc: Atish Patra <atish.patra@wdc.com>
> > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > > Cc: Francois Ozog <francois.ozog@linaro.org>
> > > Cc: Etienne CARRIERE <etienne.carriere@st.com>
> > > Cc: Takahiro Akashi <takahiro.akashi@linaro.org>
> > > Cc: Patrice CHOTARD <patrice.chotard@st.com>
> > > Cc: Sumit Garg <sumit.garg@linaro.org>
> > > Cc: Grant Likely <Grant.Likely@arm.com>
> > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Cc: Christophe Priouzeau <christophe.priouzeau@linaro.org>
> > > Cc: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> > > Cc: Patrick DELAUNAY <patrick.delaunay@st.com>
> > >
> > > Ard Biesheuvel (3):
> > >   efi/libstub: Export efi_low_alloc_above() to other units
> > >   efi/libstub: Use low allocation for the uncompressed kernel
> > >   efi/libstub: base FDT and initrd placement on image address not DRAM
> > >     base
> > >
> > >  arch/arm/include/asm/efi.h                |   6 +-
> > >  arch/arm64/include/asm/efi.h              |   2 +-
> > >  drivers/firmware/efi/libstub/arm32-stub.c | 177 ++++----------------
> > >  drivers/firmware/efi/libstub/efi-stub.c   |   2 +-
> > >  drivers/firmware/efi/libstub/efistub.h    |   3 +
> > >  drivers/firmware/efi/libstub/relocate.c   |   4 +-
> > >  6 files changed, 47 insertions(+), 147 deletions(-)
>

I verified the above patches along with the following RISC-V specific changes.

diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index 93c305a638f4..dd6ceea9d548 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -37,7 +37,7 @@ static inline unsigned long
efi_get_max_fdt_addr(unsigned long dram_base)
 static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
                                                    unsigned long image_addr)
 {
-       return dram_base + SZ_256M;
+       return image_addr + SZ_256M;
 }

--- a/drivers/firmware/efi/libstub/riscv-stub.c
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -100,7 +100,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
         */
        preferred_addr = round_up(dram_base, MIN_KIMG_ALIGN) + MIN_KIMG_ALIGN;
        status = efi_relocate_kernel(image_addr, kernel_size, *image_size,
-                                    preferred_addr, MIN_KIMG_ALIGN, dram_base);
+                                    0, MIN_KIMG_ALIGN, 0);

FWIW: Tested-by: Atish Patra <atish.patra@wdc.com>
>
>
> --
> Regards,
> Atish

Do

-- 
Regards,
Atish
