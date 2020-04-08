Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2077C1A280B
	for <lists+linux-efi@lfdr.de>; Wed,  8 Apr 2020 19:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgDHRkJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Apr 2020 13:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgDHRkJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 8 Apr 2020 13:40:09 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 958F82082F;
        Wed,  8 Apr 2020 17:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586367608;
        bh=4z1t98y0f7P25Qq1cT4GsOFIlAkeVEE1O985a/IK2bw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2aCurHaf3Kme+m9VA6KdGsnfYZHycQsMSe1KCF6NApw9Al+cODF6apQPpghxHCZb7
         XXqHbl32UYsvaItv1JOE4FnK6an5lnTUOYN8mTX+ySi2WF6JJcImhX5FjWDrvn7lZk
         8Izq2J1s8bYv9/13kjMGJe7p7tFjZdImAwQ3c+kQ=
Received: by mail-io1-f48.google.com with SMTP id b12so945479ion.8;
        Wed, 08 Apr 2020 10:40:08 -0700 (PDT)
X-Gm-Message-State: AGi0PuaCJcAOX65z5ZwJboLG/frzHJzv7y9lwR6ZQOEhfbuOPC4LLNyn
        e3TRR3Xda2cNL0W1vrxfW3Ar3eGfIij5tEQK8kQ=
X-Google-Smtp-Source: APiQypLEH9T9Ob5L5UbvOCSRgeiNT5mh0Wy0gYcPpE7ul5g85frCf//lo7NmhEqJG95c0EUOoQ/LFCfUSNUCkGDKkpA=
X-Received: by 2002:a02:7785:: with SMTP id g127mr7811753jac.134.1586367607998;
 Wed, 08 Apr 2020 10:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200326135041.3264-1-b.thiel@posteo.de>
In-Reply-To: <20200326135041.3264-1-b.thiel@posteo.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Apr 2020 19:39:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF6UF318wCL74T9orJk=+LafZ3VFXUGmqoBefYVaP2gNw@mail.gmail.com>
Message-ID: <CAMj1kXF6UF318wCL74T9orJk=+LafZ3VFXUGmqoBefYVaP2gNw@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Add a prototype for efi_arch_mem_reserve()
To:     Benjamin Thiel <b.thiel@posteo.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 26 Mar 2020 at 14:50, Benjamin Thiel <b.thiel@posteo.de> wrote:
>
> ... in order to fix a -Wmissing-ptototypes warning:
>
> arch/x86/platform/efi/quirks.c:245:13: warning:
> no previous prototype for =E2=80=98efi_arch_mem_reserve=E2=80=99 [-Wmissi=
ng-prototypes]
> void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>
> Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>

Thanks. I'll queue this as a fix.

> ---
>  include/linux/efi.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 7efd7072cca5..e4b28ae1ba61 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1703,4 +1703,6 @@ struct linux_efi_memreserve {
>
>  void efi_pci_disable_bridge_busmaster(void);
>
> +void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
> +
>  #endif /* _LINUX_EFI_H */
> --
> 2.17.1
>
