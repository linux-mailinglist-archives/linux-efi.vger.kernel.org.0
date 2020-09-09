Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F452638A4
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 23:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIIVpQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 17:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIVpN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Sep 2020 17:45:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C99BC061573
        for <linux-efi@vger.kernel.org>; Wed,  9 Sep 2020 14:45:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g4so4509333wrs.5
        for <linux-efi@vger.kernel.org>; Wed, 09 Sep 2020 14:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjXB6RSVR31iO/o/+lQkByeEIJlLeUpgP6mQyDn/b/c=;
        b=OZ/llB7dYS9Mz7UxAsP/ozoZXGJhVoR1/qxsJAsztQ7MQBvEAXC5AEVxS7a+nIfwCJ
         lRs5bGHeQfPTd+s1BO4OpXW+UMBUXT7EzXFve/7cnQGOWLWdiAuxZXHjX2b/nx1snSZs
         /dqG78RZbyK9aDL+IPxIkLGGvzvW2FdTVR4io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjXB6RSVR31iO/o/+lQkByeEIJlLeUpgP6mQyDn/b/c=;
        b=k3+8CCY6cxSdBuSxlN0TPigDAW470LID21bzeDJieVmFX0FImdSRG/0wcicZKWy7if
         h8vsmbw7hBS61P4WkPEOnyN+ikAa+xij6iod+2ooXRqAJkHkKEKOcQ/bajPEMBgpecJK
         C5Hiuy42bMEW+5dXrKSpPkfE2zJ7/1QJBEvflyvbTlDuiGoc/ExwRZL/Hg4exYku59XC
         Koj8AI0SilOldWqYNEqtUxjfxKr/IFYqdcJ6WIm+1Z2dKPlQA9Nxn/T9c0TYo5msEiw2
         hLc7vF7Up1x2NNjFT7cGeTkzwlUcgQQHk2qdajjNOIsJdte/pMt6EY7AQYGIXrihrd+z
         mgzA==
X-Gm-Message-State: AOAM531rHCq7kUh3sxrrzFtdW6pZKhRmgdSHAdKZEz/wfqXrY0j5BpEp
        qK6v/g7iBuq0aVuac93bHopYZhGSQrmmWNCsObbB
X-Google-Smtp-Source: ABdhPJz3pDCBDEHwsMyOAEopSTwmqesSI9PYXVRCP1kF57g5AXOXavKqcFCIQzXGDfwoWb2L9B1eqp7kssP/dlIcSYc=
X-Received: by 2002:a5d:4bcf:: with SMTP id l15mr5685168wrt.384.1599687910745;
 Wed, 09 Sep 2020 14:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200909151623.16153-1-ardb@kernel.org> <mhng-8fe8da11-e991-494e-bfc7-fd3e563dad75@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-8fe8da11-e991-494e-bfc7-fd3e563dad75@palmerdabbelt-glaptop1>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 9 Sep 2020 14:44:59 -0700
Message-ID: <CAOnJCUL+NietRhAvcGhqrdUOvxxsOpb5zAJLnXRekTv0g7o4yg@mail.gmail.com>
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

On Wed, Sep 9, 2020 at 1:52 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 09 Sep 2020 08:16:20 PDT (-0700), ardb@kernel.org wrote:
> > Maxim reports boot failures on platforms that describe reserved memory
> > regions in DT that are disjoint from system DRAM, and which are converted
> > to EfiReservedMemory regions by the EFI subsystem in u-boot.
> >
> > As it turns out, the whole notion of discovering the base of DRAM is
> > problematic, and it would be better to simply rely on the EFI memory
> > allocation routines instead, and derive the FDT and initrd allocation
> > limits from the actual placement of the kernel (which is what defines
> > the start of the linear region anyway)
> >
> > Finally, we should be able to get rid of get_dram_base() entirely.
> > However, as RISC-V only just started using it, we will need to address
> > that at a later time.
>
> Looks like we're using dram_base to derive two argumets to
> efi_relocate_kernel(): the preferred load address and the minimum load address.
> I don't see any reason why we can't use the same PAGE_OFFSET-like logic that
> x86 uses for the minimum load address, but I don't think we have any mechanism
> like "struct boot_params" so we'd need to come up with something.
>

As discussed in the other thread
(https://www.spinics.net/lists/linux-efi/msg20262.html),
we don't need to do anything special. efi_relocate_kernel can just
take preferred address as 0
so that efi_bs_alloc will fail and efi_low_alloc_above will be used to
allocate 2MB/4MB aligned address as per requirement.

I don't think the other changes in this series will cause any issue
for RISC-V. I will test it and update anyways.

> > Cc: Maxim Uvarov <maxim.uvarov@linaro.org>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Atish Patra <atish.patra@wdc.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: Francois Ozog <francois.ozog@linaro.org>
> > Cc: Etienne CARRIERE <etienne.carriere@st.com>
> > Cc: Takahiro Akashi <takahiro.akashi@linaro.org>
> > Cc: Patrice CHOTARD <patrice.chotard@st.com>
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> > Cc: Grant Likely <Grant.Likely@arm.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Christophe Priouzeau <christophe.priouzeau@linaro.org>
> > Cc: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> > Cc: Patrick DELAUNAY <patrick.delaunay@st.com>
> >
> > Ard Biesheuvel (3):
> >   efi/libstub: Export efi_low_alloc_above() to other units
> >   efi/libstub: Use low allocation for the uncompressed kernel
> >   efi/libstub: base FDT and initrd placement on image address not DRAM
> >     base
> >
> >  arch/arm/include/asm/efi.h                |   6 +-
> >  arch/arm64/include/asm/efi.h              |   2 +-
> >  drivers/firmware/efi/libstub/arm32-stub.c | 177 ++++----------------
> >  drivers/firmware/efi/libstub/efi-stub.c   |   2 +-
> >  drivers/firmware/efi/libstub/efistub.h    |   3 +
> >  drivers/firmware/efi/libstub/relocate.c   |   4 +-
> >  6 files changed, 47 insertions(+), 147 deletions(-)



-- 
Regards,
Atish
