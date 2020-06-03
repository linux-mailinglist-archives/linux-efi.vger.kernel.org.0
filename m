Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915E51ECFE7
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jun 2020 14:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgFCMh4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Jun 2020 08:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFCMh4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 3 Jun 2020 08:37:56 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF1BE207D5;
        Wed,  3 Jun 2020 12:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591187875;
        bh=8JlnyN6S/PN8wTr3vaJQco0HsmfSsiCL1/iN/QbG/do=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PASYPRaO1ZQu3VEqyUCTGNP75BEwkV+NPJ5r2QXnutBfXNZ3fx1VOH0onm85T0b1g
         7K947wnDYDwLSXD0P8hkm6uYkpx29/oXrILhk940MP4utFoXWTDelQ1P6ASszaJoC3
         /Bk8gM3JBuBtw6vNnofDz8nX06GA4eDSrJFpNn5A=
Received: by mail-oi1-f177.google.com with SMTP id a137so1653995oii.3;
        Wed, 03 Jun 2020 05:37:55 -0700 (PDT)
X-Gm-Message-State: AOAM530d/XLef5KDyAPtsinfTOuIFMpkajT9aAH8fWHUSyuUM9CLtr+P
        dF4AxLvTxvRfVES5D8naUkReqIF/yKmW7lzX16A=
X-Google-Smtp-Source: ABdhPJywa4iSWwyZ1llLvDbHWvpqlEFTjxCH5s8foK0VuhKDv8Dz1IpT3jsUMPmjfa0TLOsh7VhjryiiG7dStUL48Fg=
X-Received: by 2002:aca:6144:: with SMTP id v65mr6018150oib.33.1591187875061;
 Wed, 03 Jun 2020 05:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtCP3d805MpSMq0TGkz2uhHpFLaizP8uHxHzC5jnAc0hQ@mail.gmail.com>
In-Reply-To: <CA+G9fYtCP3d805MpSMq0TGkz2uhHpFLaizP8uHxHzC5jnAc0hQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 3 Jun 2020 14:37:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHHNWNmZeQD9vC_g7gNo7pP1t2VyQn=LSgxkaPNy8i62A@mail.gmail.com>
Message-ID: <CAMj1kXHHNWNmZeQD9vC_g7gNo7pP1t2VyQn=LSgxkaPNy8i62A@mail.gmail.com>
Subject: Re: linux-next: arm64 build failed - aarch64-linux-gnu-ld: cannot
 find ./drivers/firmware/efi/libstub/lib.abuilt-in.a: No such file or directory
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 3 Jun 2020 at 14:31, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> arm64 build failed on Linux-next 20200603.
>
> make -sk KBUILD_BUILD_USER=TuxBuild -C/linux -j16 ARCH=arm64
> CROSS_COMPILE=aarch64-linux-gnu- HOSTCC=gcc CC="sccache
> aarch64-linux-gnu-gcc" O=build Image
>  #
> aarch64-linux-gnu-ld: cannot find
> ./drivers/firmware/efi/libstub/lib.abuilt-in.a: No such file or
> directory
>  make[1]: *** [/linux/Makefile:1132: vmlinux] Error 1
>

9203be13ef5bfd1fcf39f7b7fe94597d2d2a0eb4 is the first bad commit
commit 9203be13ef5bfd1fcf39f7b7fe94597d2d2a0eb4
Author: Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon Jun 1 14:56:59 2020 +0900

    kbuild: refactor KBUILD_VMLINUX_{OBJS,LIBS} calculation

    Do not overwrite core-y or drivers-y. Remove libs-y1 and libs-y2.

    Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
