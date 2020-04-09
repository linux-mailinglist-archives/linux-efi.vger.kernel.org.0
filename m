Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005081A2FCD
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 09:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgDIHNb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 03:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgDIHNb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 03:13:31 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26EC62072F;
        Thu,  9 Apr 2020 07:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586416411;
        bh=JgiMBGfZhpUSnuOXnmCkjKaPdsAoKkBZS0y1xY2mt00=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=El6AfiS6YSRy9Lw+pB+izIrgx7a6FngsQUqkstXkrFoOdp6eCqtzENzIhll1ENYuE
         E/wHw5zZ3ONMkSfRAhN4tZUamfSTSAWMAh3YQcuPmJ9spGckAE/mzmiefNAPHghMGk
         8yr6X8ehxE5tJWIPPfP7AilDHnAr69uDnNvDZsnM=
Received: by mail-io1-f47.google.com with SMTP id i19so2799858ioh.12;
        Thu, 09 Apr 2020 00:13:31 -0700 (PDT)
X-Gm-Message-State: AGi0PuYCHPXuEKjpoPcYcKY7IMzpOlzYW8UxdnqlgzOJgU4fdxHDhr9m
        fXYtZ20gfQgRP3D/m7N1ApGaFD7KL2pPHDD4lY0=
X-Google-Smtp-Source: APiQypJh3rzZP8mt6xsce1xFtz4clEGStPSrzwRXFSCYSYnd/LgxWcO9wM+Fa2Et4eNLHjeEHycvHuylR17603R11Zc=
X-Received: by 2002:a5e:8b47:: with SMTP id z7mr10538624iom.16.1586416410563;
 Thu, 09 Apr 2020 00:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200326135041.3264-1-b.thiel@posteo.de> <CAMj1kXF6UF318wCL74T9orJk=+LafZ3VFXUGmqoBefYVaP2gNw@mail.gmail.com>
 <20200408175756.GG24663@zn.tnic>
In-Reply-To: <20200408175756.GG24663@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Apr 2020 09:13:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFuhw8kOFP_x0QfVTD1-PW+WS9PwJpUYwN1WHDjQZHQeQ@mail.gmail.com>
Message-ID: <CAMj1kXFuhw8kOFP_x0QfVTD1-PW+WS9PwJpUYwN1WHDjQZHQeQ@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Add a prototype for efi_arch_mem_reserve()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Benjamin Thiel <b.thiel@posteo.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 8 Apr 2020 at 19:58, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Apr 08, 2020 at 07:39:56PM +0200, Ard Biesheuvel wrote:
> > On Thu, 26 Mar 2020 at 14:50, Benjamin Thiel <b.thiel@posteo.de> wrote:
> > >
> > > ... in order to fix a -Wmissing-ptototypes warning:
> > >
> > > arch/x86/platform/efi/quirks.c:245:13: warning:
> > > no previous prototype for =E2=80=98efi_arch_mem_reserve=E2=80=99 [-Wm=
issing-prototypes]
> > > void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
> > >
> > > Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
> >
> > Thanks. I'll queue this as a fix.
>
> I already took that one, see:
>
> 860f89e61824 ("x86/efi: Add a prototype for efi_arch_mem_reserve()")
>
> but forgot to Cc: linux-efi@.
>
> Sorry about that.
>

No worries.
