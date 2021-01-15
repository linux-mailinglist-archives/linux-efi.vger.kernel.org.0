Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1732F853F
	for <lists+linux-efi@lfdr.de>; Fri, 15 Jan 2021 20:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbhAOTTU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Jan 2021 14:19:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50354 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbhAOTTU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 15 Jan 2021 14:19:20 -0500
Received: from zn.tnic (p200300ec2f0acf007cb1195bb528937a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:cf00:7cb1:195b:b528:937a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE2441EC041D;
        Fri, 15 Jan 2021 20:18:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610738318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vRaLSxM+z9kh51zGEHjPKubHQKF9CpJm494sShQUxrA=;
        b=a4/U7CvDSqbu111l2vSbwdyJn6bNIhbDvBudnYVeDkOiawxRfoZE+O4onBapZXNhghMypT
        RoXgibSW7KMHWZdAHMUGOgKcIc7CHreUzLpM/4Mhi9wScv64BbiNkY7wHijyTYTchyc5FS
        dV3uDP1JAkoR66sJvRC4Dz0YeaPjNE8=
Date:   Fri, 15 Jan 2021 20:18:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <20210115191833.GF9138@zn.tnic>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <20210115182300.GD9138@zn.tnic>
 <20210115183203.GA1991122@ubuntu-m3-large-x86>
 <20210115190729.GE9138@zn.tnic>
 <YAHo3ZEMu+6mESZA@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAHo3ZEMu+6mESZA@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 15, 2021 at 02:11:25PM -0500, Arvind Sankar wrote:
> That's how build-time assertions work: they are _supposed_ to be
> optimized away completely when the assertion is true. If they're
> _not_ optimized away, the build will fail.

Yah, that I know, thanks.

If gcc really inlines p4d_index() and does a lot more aggressive
optimization to determine that the condition is false and thus optimize
everything away (and clang doesn't), then that would explain the
observation.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
