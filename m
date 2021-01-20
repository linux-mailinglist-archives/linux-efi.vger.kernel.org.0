Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CDA2FD178
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 14:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbhATMrn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 07:47:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45150 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388715AbhATLp3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 Jan 2021 06:45:29 -0500
Received: from zn.tnic (p200300ec2f0bb0007fac97ee58c503f0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b000:7fac:97ee:58c5:3f0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 570471EC046E;
        Wed, 20 Jan 2021 12:44:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611143084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=20LzYZPoh99oMXgfw4CHHwaH/q6GrOZfZD3z4Nnb0wg=;
        b=E2E7ATLf7PM0xDk7VFGsC6LxaCDqpTk3/0jmeLtCJRUuWShS5yavgB3rAPVCug/oo+ImsB
        L6SHAbHQ5zcrqFw5h2IhN5QsZ+AojeGeadBBHW92tAQYfgt2hPULXuYXsJzlpI5Ep/5qia
        nQ1kpdrk2Y5BIsKRUOm39J/CHZZpmO4=
Date:   Wed, 20 Jan 2021 12:44:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <20210120114438.GD825@zn.tnic>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
 <YAH6r3lak/F2wndp@rani.riverdale.lan>
 <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
 <20210118202409.GG30090@zn.tnic>
 <YAYAvBARSRSg8z8G@rani.riverdale.lan>
 <CAMj1kXHM98-iDYpAozaWEv-qxhZ0-CUMwSdG532x2d+55gXDhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHM98-iDYpAozaWEv-qxhZ0-CUMwSdG532x2d+55gXDhQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 20, 2021 at 10:33:43AM +0100, Ard Biesheuvel wrote:
> The churn doesn't seem to be worth it, tbh.
> 
> So could we get rid of the complexity here, and only build_bug() on
> the start address of the EFI region being outside the topmost p4d?
> That should make the PGD test redundant as well.

Yah, makes sense to me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
