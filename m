Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E9520BC04
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 23:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgFZV5q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Jun 2020 17:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgFZV5p (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Jun 2020 17:57:45 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84643C03E979
        for <linux-efi@vger.kernel.org>; Fri, 26 Jun 2020 14:57:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so10819959wrs.11
        for <linux-efi@vger.kernel.org>; Fri, 26 Jun 2020 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GaefEko3kEAOd19TubqWqNAf+AVqFUJ4Wq5QM8k6oA0=;
        b=qL1iJ7bZpKKnvVKjD187zlZlhBdctCIOERlzFxD2/eUC+EigcNn9fFXpSLUQiHsyPM
         J2GyHAN1uXx0fDpU6ax3Q+zfqDjOXSEV4Imh/Rr/W9vmTL3sHKRmaPqoKv/uCzOoM5xe
         jnSN/Kniwd9tOv+pNM5FyqOtdLSjaqdhl1eCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaefEko3kEAOd19TubqWqNAf+AVqFUJ4Wq5QM8k6oA0=;
        b=K7rxmtvferOaxvzMCL4+Fd5IpcUAYoyZU1EZHxDNCy0Jy0Kp1YTaPLYcCUCyzjLMfm
         +cpa0K4oogwYI+yIueMtevfrsh2bLCT2zhoA+JZd5R8eBATigkmNvIHeozG2cV2Ll5OX
         Robex32gqU9d4WfJntasJQ2iABakTXtsBwR3/CEuRcdr+VxXQZ7oXfkXK6pQR55BGmDY
         ZPlaOzWa4TQkcUUUyz/lAPwuhfTjp9vZ+mdXIm1CILcAQ7yWQafCFDDhc06LwOztjfcn
         P0e3Amgn5csXyxOsvqJ0Bp0sWpAI3YalpV00gyWdNcHjTDvarXApVpHLC8nhnD22hFoc
         Sjdg==
X-Gm-Message-State: AOAM530SVklYOnJELvfxAy/p9lBdthGkMRyI7yKz4qVA/0nmDTPzhwT4
        gLlBGf4n2Fx0wQpWcro6Llv6is+vvIwAcVARwRRm
X-Google-Smtp-Source: ABdhPJyOcljMPyApSrrEvUL7seEvgR6bpWPbI+cLBCYQT1ljE7hdK0sJpijoILYe0Ntw+U/b51zVLnq6pnDNP2TU1tE=
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr5616423wrv.162.1593208664289;
 Fri, 26 Jun 2020 14:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200625234516.31406-1-atish.patra@wdc.com> <20200625234516.31406-11-atish.patra@wdc.com>
 <8b71b663-8a68-26f3-c806-a2873a6d8923@gmx.de>
In-Reply-To: <8b71b663-8a68-26f3-c806-a2873a6d8923@gmx.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 26 Jun 2020 14:57:33 -0700
Message-ID: <CAOnJCU+=0Ozz=qfMULsN4-4rq_q4UFYsnkH50Bo5PfzUU45e6g@mail.gmail.com>
Subject: Re: [RFC PATCH 10/11] efi: Rename arm-init to efi-init common for all arch
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 25, 2020 at 8:00 PM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 6/26/20 1:45 AM, Atish Patra wrote:
> > arm-init is responsible for setting up efi runtime and doesn't actually
> > do any ARM specific stuff. RISC-V can use the same source code as it is.
> >
> > Rename it to efi-init so that RISC-V can use it.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  drivers/firmware/efi/{arm-init.c => efi-init.c} | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename drivers/firmware/efi/{arm-init.c => efi-init.c} (100%)
> >
> > diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/efi-init.c
> > similarity index 100%
> > rename from drivers/firmware/efi/arm-init.c
> > rename to drivers/firmware/efi/efi-init.c
> >
>
> After each patch we should have code that builds. This helps when

Absolutely.

> bisecting. Therefore I would have expected an adjustment of
> drivers/firmware/efi/Makefile in this patch and not in patch 11/11:
>
> -arm-obj-$(CONFIG_EFI)                  := arm-init.o arm-runtime.o
> +arm-obj-$(CONFIG_EFI)                  := efi-init.o arm-runtime.o
>

I think I messed it up while rebasing. My bad. I will fix it in the
next version.

> Best regards
>
> Heinrich
>


-- 
Regards,
Atish
