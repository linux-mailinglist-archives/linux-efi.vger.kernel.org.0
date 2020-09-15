Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158C326B4C8
	for <lists+linux-efi@lfdr.de>; Wed, 16 Sep 2020 01:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgIOXbx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Sep 2020 19:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgIOXb2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Sep 2020 19:31:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC474C06178A
        for <linux-efi@vger.kernel.org>; Tue, 15 Sep 2020 16:31:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so2872125pfi.4
        for <linux-efi@vger.kernel.org>; Tue, 15 Sep 2020 16:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfXBk0KHiNq5IUkPtCX999gAUXzd65HT75On2kwV83A=;
        b=L6J0t78IIdPk5eEfqoZrvsxPhXlGVeIDxlbV+5UqKzpiA5OxRqOA9ENKO1iagUHi0n
         b2TPHp6VanlnetFyXOjwmpHvvbuj6sk0yjHH3c6D76dQiPHAolytIxuoH9MR03wJBPe3
         Y4ZldXfT3qzJqisUrb6swG/D9hljxOHyqBGGUlXUvtPj6nosERkL1d0N3sSt0cVmsL7/
         Kzgt3PU9H5jpEMsZG7sZaeEVt0uz5zV8Q4x1Vjyc/XFYTHvcUf3vdqwBg9j4wF8nzBKE
         G5Q5yIQPftlts2vCbL/5z/6MyXhV4wkPIyEzwXmSueVOk/gKcAaeyMgp3xan6vF1dG1I
         GbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfXBk0KHiNq5IUkPtCX999gAUXzd65HT75On2kwV83A=;
        b=nmh2yCN6PsaXhGegaKjqXq/JeePnEHsDVCKo6kTTuZvxiPS0q4giLwRWomop+z1DNt
         a9l5uHVudsUHLkIH5pt8hh2zEu05AaJ4YhhWpCwiu4vLCST5gomJemOhBchpUTwk2lWo
         VPq8ZdDKYnHaOBdnJqXyo1qMmXsSpiuj9/zfNrS5bn0KF6hwUnMLfTqOqLPZquhSX6bC
         fJHP35lfcyKuqz0Eohg/2p9T0XUxaDirrWfcTREmMAu67Lf/YcoEpDl3RtKFKrXGGTl7
         HnA9OhG4iBM7WU3uvaBTvCC44kENEKlkj1icHvYh2/sHkLLEPVybnPOkUFWyxoulwbbe
         cDWw==
X-Gm-Message-State: AOAM531SLyJZL38k3VgtXc7ieVK2rCIB0orrZ1SvnZ9USf1p5Qdww4yn
        VyCc444vxSp+uL8vOQKXhtjGXV7tjhff+BBFgmv49w==
X-Google-Smtp-Source: ABdhPJz+WYPnf7n4zJXtInFlr+FZ2PAunvj7sSnr0p4kfWsPbClw3IUfRBSCogVw+lLmqE/gl2z4ZJcUDp+N/zvxQ8M=
X-Received: by 2002:a65:5a4c:: with SMTP id z12mr16195605pgs.10.1600212685166;
 Tue, 15 Sep 2020 16:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200914095706.3985-1-ardb@kernel.org> <CAKwvOdmSXm7cV3hB_Yp=DD0RwwDHtPzzDBU8Xj5kBREn3xqYdA@mail.gmail.com>
 <CAMj1kXGuFFUyT48EYvzFmjCP4QZi_Sk_GpBrBCaHjP7HKLhjBA@mail.gmail.com>
In-Reply-To: <CAMj1kXGuFFUyT48EYvzFmjCP4QZi_Sk_GpBrBCaHjP7HKLhjBA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 16:31:12 -0700
Message-ID: <CAKwvOdmkNgi_+kfauTSLwtpVChipW851_KGJG+gBbhwRxJJORA@mail.gmail.com>
Subject: Re: [PATCH 00/12] ARM: use adr_l/ldr_l macros for PC-relative references
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jian Cai <jiancai@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 15, 2020 at 2:30 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Excellent, thanks for testing. Do you have any coverage for Thumb2
> builds as well? (CONFIG_THUMB2_KERNEL=y)

Ah, right, manually testing ARCH=arm defconfig with
CONFIG_THUMB2_KERNEL enabled via menuconfig:

Builds and boots for clang.

(Also needed https://lore.kernel.org/lkml/20200915225751.274531-1-ndesaulniers@google.com/T/#u
for an unrelated issue).

For GCC, I observe:

arch/arm/vfp/vfphw.o: in function `vfp_support_entry':
(.text+0xa): relocation truncated to fit: R_ARM_THM_JUMP19 against
symbol `vfp_kmode_exception' defined in .text.unlikely section in
arch/arm/vfp/vfpmodule.o

There doesn't seem to be a config option to work around that for now.
Though it's not caused by your series; if I drop your series, I can
still reproduce.

Is there a different config I should be testing rather than
defconfig+manual testing, like one of the existing configs? Looks like
only milbeaut_m10v_defconfig enable THUMB2 by default.  I should add
that to my CI and kernelCI for coverage with clang.
https://github.com/ClangBuiltLinux/continuous-integration/issues/94#issuecomment-693030376

milbeaut_m10v_defconfig
builds with your series for clang.  Looks like that config may be
currently broken for GCC?
Looks like it doesn't boot with Clang, so I'll need to debug that.
Again, both of the two past sentences are regardless of your series.
So your series still LGTM.
-- 
Thanks,
~Nick Desaulniers
