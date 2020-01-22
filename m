Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 261CC145C57
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2020 20:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgAVTR6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Jan 2020 14:17:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40221 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgAVTR5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Jan 2020 14:17:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so294947wrn.7
        for <linux-efi@vger.kernel.org>; Wed, 22 Jan 2020 11:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oc3W0C7lsxvS0x0G2I86IYLsKBA11xYQkxcUJEmbCxY=;
        b=WdrFopAomh7JbmI6RUhI8I3CefYifoeSrqM7TVn/AoKudKEdcg22mqt6D+tYPGf3EK
         Yqn4oEOmRmxgmba7rePX11kAsyAxplmXOndB20RQC7//TLFdP2qtTGeRoNvre9aPB8wx
         INzq2QvErD0tF4y5iytUqQmCkiCEyjiXmv1PUgfHH8k06uz+3H5GLmjSMMUG0L+SalX/
         6oOoT4Eqsi/ZawCaUZRPsJxcLrGxhwNybepMJHbMc2HfRys6Ugut8T7GWfwC32dipxrk
         2nYH5JaAhRDMp0VHWtgjL/WECUEVPbuTGgjpKR6Q/HFXEab09Y81O392cCVF/K8omcTp
         ho3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oc3W0C7lsxvS0x0G2I86IYLsKBA11xYQkxcUJEmbCxY=;
        b=QkPkop4bkZpRgG33fm1vdi3cFJoUaLWS50+IsTiZUToYqo+T28HkhepCdXdcn+rgeD
         8OFKjQ9UUUhJHGIQ1HD0psN+xd74BlmibhQ8IgJE5F4m/rgOnGLAfYwZeyJcL39+uAlC
         B6NStMgK316SP/L3K++JuuCquRT7TWKq+xbNWSyRQHZO4whDrsgtcYDaEE/iXZQBkPOg
         5DbPdjEWVwWhtEYQ3IYi7SWJ11U0rDJcSZCoDENHeybXm/HbwA+3CB8hloXg5a9amel0
         h/MxuQSIZo2Y+xVvi3AU0nA2LQi+Vzrg9A2i9maEstwZWIUXfaNk/VneS9bHG1e61X0n
         a1+w==
X-Gm-Message-State: APjAAAUyLpEvl25sa17+eqcFDPpgMfIE6BgWHzR9ZsWdTXNbHrIjrnTM
        bqIJ7aKfYYy17wYk011oxAuYyd01gnkjFnfIOGnCpg==
X-Google-Smtp-Source: APXvYqxMawU1ldsi6FPoO3JTCPTYntgGyX0+CDa7A7vgaiLziWk2RktjEmYwCFizwmWK3y1tBTxA9296f3orwKKTmUs=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr12553750wrw.126.1579720648100;
 Wed, 22 Jan 2020 11:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20200122191430.4888-1-cai@lca.pw>
In-Reply-To: <20200122191430.4888-1-cai@lca.pw>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 22 Jan 2020 20:17:17 +0100
Message-ID: <CAKv+Gu_snhTpsM4cjZ38UhH02v151NW4cJdQu9QVqCWu4rFVZw@mail.gmail.com>
Subject: Re: [PATCH -next] efi/libstub/x86: fix an EFI server boot failure
To:     Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 22 Jan 2020 at 20:15, Qian Cai <cai@lca.pw> wrote:
>
> x86_64 EFI systems are unable to boot due to a typo in the recent commit.
>
> EFI config tables not found.
>  -- System halted
>
> Fixes: 796eb8d26a57 ("efi/libstub/x86: Use const attribute for efi_is_64bit()")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/boot/compressed/eboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> index 82e26d0ff075..287393d725f0 100644
> --- a/arch/x86/boot/compressed/eboot.c
> +++ b/arch/x86/boot/compressed/eboot.c
> @@ -32,7 +32,7 @@ __attribute_const__ bool efi_is_64bit(void)
>  {
>         if (IS_ENABLED(CONFIG_EFI_MIXED))
>                 return efi_is64;
> -       return IS_ENABLED(CONFIG_X64_64);
> +       return IS_ENABLED(CONFIG_X86_64);
>  }
>
>  static efi_status_t

Apologies for the breakage - your fix is obviously correct. But I did
test this code, so I am curious why I didn't see this problem. Are you
booting via GRUB or from the UEFI shell? Can you share your .config
please?
