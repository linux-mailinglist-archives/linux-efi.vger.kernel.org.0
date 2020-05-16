Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F025A1D6163
	for <lists+linux-efi@lfdr.de>; Sat, 16 May 2020 15:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgEPNiE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 09:38:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53278 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgEPNiE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 16 May 2020 09:38:04 -0400
Received: from zn.tnic (p200300ec2f1da5006c2171768245b3fc.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:a500:6c21:7176:8245:b3fc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0BBE1EC0345;
        Sat, 16 May 2020 15:38:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589636282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnC5M8+45coK6blTjpWVSwTrK5ZsOZRTdrUKNcF4tRM=;
        b=iMspuoAiJP+ZjHVfa1VXtwQZfdYwGvj4OEXN+b5iLwb3EwSMy8iO6brhm+SMl47AHwmI/n
        +Zs7ULwEVUtL+KDr3Uhf9/lL4aafdWXOWAUfG5FVYFJJ+UhDDmOxWnidaCG9JdEQ2soZ7J
        TFYOFXr2Fp8CpGDzNvWeSHOlEZ+vYkE=
Date:   Sat, 16 May 2020 15:37:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Benjamin Thiel <b.thiel@posteo.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] efi: Pull up arch-specific prototype
 efi_systab_show_arch()
Message-ID: <20200516133758.GA19372@zn.tnic>
References: <20200516132647.14568-1-b.thiel@posteo.de>
 <CAMj1kXE92_hmbaNURjW9FuRo02B9my1UBBUhPZi_CS+FRr8-aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXE92_hmbaNURjW9FuRo02B9my1UBBUhPZi_CS+FRr8-aw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, May 16, 2020 at 03:32:25PM +0200, Ard Biesheuvel wrote:
> On Sat, 16 May 2020 at 15:26, Benjamin Thiel <b.thiel@posteo.de> wrote:
> >
> > ... in order to fix a -Wmissing-prototypes warning:
> >
> > arch/x86/platform/efi/efi.c:957:7: warning: no previous prototype for
> > ‘efi_systab_show_arch’ [-Wmissing-prototypes]
> > char *efi_systab_show_arch(char *str)
> >
> > Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
> 
> Thanks, I'll queue this as a fix.
> 
> Nit: please don't treat the subject line as the first N words of the
> commit log, but start with a full sentence. Not all mail readers show
> the subject line and the body together. I've fixed it up for now.

That was my suggestion as I do that a lot. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
