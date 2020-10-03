Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B46282593
	for <lists+linux-efi@lfdr.de>; Sat,  3 Oct 2020 19:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgJCR2b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 3 Oct 2020 13:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJCR2a (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 3 Oct 2020 13:28:30 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E20C0613D0;
        Sat,  3 Oct 2020 10:28:30 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q1so4133724ilt.6;
        Sat, 03 Oct 2020 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ELu+5uVozv2ULR6Pu9brtuQnO09/jiqf88ctecPqu38=;
        b=HP1sBcDksrr3El68OvbbFIjWiTK0OSbcZKbQfKcouLzOfpsMNp11LCRDFRPN+7ktiT
         UqwVQ48vWprimz5izKMvo3A2N55YVnOPtIL4u8VB9AEnoXPt7rcf6in/5Ldc+fZnhqkl
         QCZWbOoagZWnkV2zhyl3CB8iHJF91fQLtRf4ucMKrIeka7hUJ0rMo5xahTwo+D10MGw9
         g9hJeHGoi6h6ICBevMNlZ1RYTmoN06uZAGcroo8uzdC5OguPxOmPko5Ihlb8h5STUlUn
         0MMi96EvyV2Rk0kO4jy1vCHFB+8lX8+MvihYkn+h2XpQ7ZtjKy6A3iCt45GqgK1wKvDU
         QQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ELu+5uVozv2ULR6Pu9brtuQnO09/jiqf88ctecPqu38=;
        b=WuKoUvZk8fy1hcPv5deW0kUVM61aGjrtSscDfAa15vBJVddlPc1jxok7PNMRbm236/
         KCKNh2YnSZfbyFk7UcWiMByxcu/oT9/cYjuxW1zWPY0EnjRscue7mgLeLncxGNWV300v
         rE4a6SYbLY4H5liibi3CAW4qarp7qdR0CFssYx7o/LOYUAZBPregtEwnAXSuilKWaCRW
         joDOM3zJrMJ8vmavWZWLkZH0imy7jGo1mP/ZJPNZPOGuoVfq2bowMv6glY1LZeH+kX+o
         seqgq9EdNP4VBzPmVQzaf4EWcvZVw7PM+eoWdyotmdYLqHHwGXVU55XWSYRNO/XlyUEj
         anLw==
X-Gm-Message-State: AOAM533HdJUxBgxVLg+UYfYehpBk/zrH+phBHDNCzDk4oge7C+fT5QdU
        ipSXMAYFzuBOzb9y3lOTRC34TO6lVA2Hsa1MrQ==
X-Google-Smtp-Source: ABdhPJzIAkzNAxDGARAEsSXQFBwfj9ZbcFxR43W1bpIMEQkw3/L4Dh+xODk0gPBC2Oz9wnmy1lR2FV/95OPm45lQThc=
X-Received: by 2002:a92:d08f:: with SMTP id h15mr5671143ilh.27.1601746109810;
 Sat, 03 Oct 2020 10:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201003060356.4913-1-xypron.glpk@gmx.de>
In-Reply-To: <20201003060356.4913-1-xypron.glpk@gmx.de>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sat, 3 Oct 2020 13:28:18 -0400
Message-ID: <CAMzpN2hZ6833u4P=Vr1hueoYCfYryHoTW1dpa-9FTL3nvehJ0A@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub/x86: simplify efi_is_native()
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Oct 3, 2020 at 2:05 AM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> CONFIG_EFI_MIXED depends on CONFIG_X86_64=y.
> There is no need to check CONFIG_X86_64 again.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  arch/x86/include/asm/efi.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index b9c2667ac46c..ab28bf1c74cf 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -223,8 +223,6 @@ static inline bool efi_is_64bit(void)
>
>  static inline bool efi_is_native(void)
>  {
> -       if (!IS_ENABLED(CONFIG_X86_64))
> -               return true;
>         return efi_is_64bit();
>  }

This would then return false for native 32-bit.

--
Brian Gerst
