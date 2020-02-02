Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66AAD14FEBB
	for <lists+linux-efi@lfdr.de>; Sun,  2 Feb 2020 19:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgBBSS4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Feb 2020 13:18:56 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40269 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgBBSS4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Feb 2020 13:18:56 -0500
Received: by mail-qk1-f194.google.com with SMTP id t204so12028006qke.7;
        Sun, 02 Feb 2020 10:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I63xniiKpQdj1U3DyjVkziZFNdozieGZaSMSOJa63DA=;
        b=bBlBZ4ExHiIjVNfi75bGRhUlyfAlC8lFTrSgFK/BZVBkVUm+31wnDfxQIettyrfZSF
         +wHTualkwWhLVM/GW7xQVKI/3yf4B/Fi0NT183oTgWQdyj+GqkJ07qUJUFzh5jlKPJt8
         FUgRcn8/x/SO3yYqoo9xewd5MO4/zIHJgQwlGX/fXLw+ykW7DM47MLzh5K1EScRCkhKL
         1wC9Vc54CFukNIkU9SHRI3zK5bY66nIzr/nEfpRCFUNSo6A2meHdHzTzziPKlvzDeUdx
         OimGWtqKwphthQSyuBFkMJMS31ciJDXvZ95oak7qCJPkF7kCjkUobAUO2zieUJqx1ymi
         KuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=I63xniiKpQdj1U3DyjVkziZFNdozieGZaSMSOJa63DA=;
        b=Khk754ihjw1Feu2ihIpyYiqlDApxgwGskjuv5bO3ODzcd2d0ckENmf/Tmmbb9rGGYL
         pZT2Shjriht+0LyK/3aMTUzaDMU4TLyIWYVIpI5brfTyDkH/LTZ1iq6nHGriOZ65lYc3
         J0q+bx6r6DaUdRPHiKXvwFkNA8T6POZC+z51cRXQJPQD9qDV+XoEWTBh6ZhM8VC+v2xQ
         MBSFFu+hFFDv/bPz/ifx89c+G58GVED8Vvfyver79b96j4yGQlmZzsPTKX5ZineYpmd/
         6p77xcZUtkmc73BxI+Y9Jnl0U8C2viFgPcvWSh5KNy6Orl6Xy1SB3htaLdkUYhl7QsjM
         OgPw==
X-Gm-Message-State: APjAAAXzes5RRupFcS65DadhWUEzCuKMpMSMQbGyd5AND0vxjjAABa2V
        OoYe7LNo7Z+yPJ0Bl8HP6zs=
X-Google-Smtp-Source: APXvYqwMlCEZh3McBUplhPkxVe7FdTPOLkeD00pWyY6OSL7fSdSGc4bSabPy1f2Tmsi9ElVZmtiEZA==
X-Received: by 2002:a05:620a:12c4:: with SMTP id e4mr20850006qkl.359.1580667535213;
        Sun, 02 Feb 2020 10:18:55 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b22sm7768663qka.121.2020.02.02.10.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 10:18:55 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 2 Feb 2020 13:18:53 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] efi/x86: Don't depend on firmware GDT layout
Message-ID: <20200202181853.GA3798718@rani.riverdale.lan>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
 <20200202171353.3736319-1-nivedita@alum.mit.edu>
 <20200202171353.3736319-3-nivedita@alum.mit.edu>
 <CAKv+Gu9_bXmRMqs3Es7XXFjRafAm0HjyM6EasuKP1nka-dLdVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9_bXmRMqs3Es7XXFjRafAm0HjyM6EasuKP1nka-dLdVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Feb 02, 2020 at 06:54:48PM +0100, Ard Biesheuvel wrote:
> On Sun, 2 Feb 2020 at 18:13, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > At handover entry in efi32_stub_entry, the firmware's GDT is still
> > installed. We save the GDTR for later use in __efi64_thunk but we are
> > assuming that descriptor 2 (__KERNEL_CS) is a valid 32-bit code segment
> > descriptor and that descriptor 3 (__KERNEL_DS/__BOOT_DS) is a valid data
> > segment descriptor.
> >
> > This happens to be true for OVMF (it actually uses descriptor 1 for data
> > segments, but descriptor 3 is also setup as data), but we shouldn't
> > depend on this being the case.
> >
> > Fix this by saving the code and data selectors in addition to the GDTR
> > in efi32_stub_entry, and restoring them in __efi64_thunk before calling
> > the firmware. The UEFI specification guarantees that selectors will be
> > flat, so using the DS selector for all the segment registers should be
> > enough.
> >
> > We also need to install our own GDT before initializing segment
> > registers in startup_32, so move the GDT load up to the beginning of the
> > function.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> It might be useful to mention /somewhere/ in the commit log that this
> applies to mixed mode
> 

Good point. I'll wait for comments from the x86 guys and include that in
the next re-spin.
