Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC21E257B93
	for <lists+linux-efi@lfdr.de>; Mon, 31 Aug 2020 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgHaPAc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Aug 2020 11:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaPAb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 31 Aug 2020 11:00:31 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F40E720936;
        Mon, 31 Aug 2020 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598886030;
        bh=+TU+gwRio8JWgglRL++C4eb2K+Sd3krTX7+AJtYIW3s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ThPCkcLBkEYvALiOwUx25L2kmKURkIZKvpC8gWkOw7kBM3dnmuFUw4OqT5wBbXaAu
         rZ7nIJZnBOCT/Y69TldJ2Fx8d0R64XI8rjdQoIEMnsrL9xRv1UcHP/YEUJPGEAS5jb
         I5eLg4kSWNKxy2LkPgcNO7WqHJamai6r2IKsS1Lg=
Received: by mail-ot1-f41.google.com with SMTP id t7so5595231otp.0;
        Mon, 31 Aug 2020 08:00:29 -0700 (PDT)
X-Gm-Message-State: AOAM5334sCx4C+aS/s7Wcgw7ZMKq900clJRH8utBrO7i7CURiAcVkJos
        8/YQMMeG5SGtk9k4+6DD8xftaYuyd8YMNJEPwpE=
X-Google-Smtp-Source: ABdhPJwVGGb+gngLstrqLW0PFlbTXrG0TJiMbmlJ0aUDpEVAWF0OCWbFZD7MokZPg8Qes14uTkPbWeYCU0wBhXRJVO4=
X-Received: by 2002:a9d:774d:: with SMTP id t13mr1176717otl.108.1598886029308;
 Mon, 31 Aug 2020 08:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200829051524.706585-1-masahiroy@kernel.org> <20200829051524.706585-3-masahiroy@kernel.org>
In-Reply-To: <20200829051524.706585-3-masahiroy@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 31 Aug 2020 18:00:18 +0300
X-Gmail-Original-Message-ID: <CAMj1kXF6-oFD3t4FkieLYRxB8gHpEAPnW+APouW0+AKb8ZXhvw@mail.gmail.com>
Message-ID: <CAMj1kXF6-oFD3t4FkieLYRxB8gHpEAPnW+APouW0+AKb8ZXhvw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ia64: remove unneeded header includes from <asm/mca.h>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        linux-kbuild@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 29 Aug 2020 at 08:16, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> <asm/mca.h> includes too many unneeded headers.
>
> This commit cuts off a lot of header includes.
>
> What we need to include are:
>
>  - <linux/percpu.h> for DECLARE_PER_CPU(u64, ia64_mca_pal_base)
>  - <linux/threads.h> for NR_CPUS
>  - <linux/types.h> for u8, u64, size_t, etc.
>  - <asm/ptrace.h> for KERNEL_STACK_SIZE
>
> The other header includes are actually unneeded.
>
> <asm/mca.h> previously included 436 headers, and now it includes
> only 138. I confirmed <asm/mca.h> is still self-contained.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>
>  arch/ia64/include/asm/mca.h | 9 +++------
>  arch/ia64/kernel/efi.c      | 1 +
>  arch/ia64/kernel/mca.c      | 1 +
>  3 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/ia64/include/asm/mca.h b/arch/ia64/include/asm/mca.h
> index c92b9c15962c..05805249296c 100644
> --- a/arch/ia64/include/asm/mca.h
> +++ b/arch/ia64/include/asm/mca.h
> @@ -14,13 +14,10 @@
>
>  #if !defined(__ASSEMBLY__)
>
> -#include <linux/interrupt.h>
> +#include <linux/percpu.h>
> +#include <linux/threads.h>
>  #include <linux/types.h>
> -
> -#include <asm/param.h>
> -#include <asm/sal.h>
> -#include <asm/processor.h>
> -#include <asm/mca_asm.h>
> +#include <asm/ptrace.h>
>
>  #define IA64_MCA_RENDEZ_TIMEOUT                (20 * 1000)     /* value in milliseconds - 20 seconds */
>
> diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
> index f932b25fb817..b6bb718ed1ff 100644
> --- a/arch/ia64/kernel/efi.c
> +++ b/arch/ia64/kernel/efi.c
> @@ -39,6 +39,7 @@
>  #include <asm/meminit.h>
>  #include <asm/processor.h>
>  #include <asm/mca.h>
> +#include <asm/sal.h>
>  #include <asm/setup.h>
>  #include <asm/tlbflush.h>
>
> diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
> index 17151269d655..3911c561d2bb 100644
> --- a/arch/ia64/kernel/mca.c
> +++ b/arch/ia64/kernel/mca.c
> @@ -96,6 +96,7 @@
>  #include <asm/ptrace.h>
>  #include <asm/sal.h>
>  #include <asm/mca.h>
> +#include <asm/mca_asm.h>
>  #include <asm/kexec.h>
>
>  #include <asm/irq.h>
> --
> 2.25.1
>
