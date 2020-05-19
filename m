Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D181D9D19
	for <lists+linux-efi@lfdr.de>; Tue, 19 May 2020 18:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgESQok (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 May 2020 12:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgESQoj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 19 May 2020 12:44:39 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15C7E207D8
        for <linux-efi@vger.kernel.org>; Tue, 19 May 2020 16:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589906679;
        bh=qsGLGWwXZBmiJsy0h+6j5uh/Fa2hObxN527Jcx3V1qY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=guiXTe9nT/JLBNJEouC+4xNi+ZtMzePN8wl0h86W9gqisLSbWxlG8rftKc0EHQRlb
         PXeLj2fBwETo0rLUsHg/rOxO8ZlUNB4umtob1LBSdFUk8QGVvRJeStdGi9wJeMUjW+
         iHGL6z8PC5MoVYnOM+YO5qdW+eyBrnCXQEm0QWyU=
Received: by mail-il1-f180.google.com with SMTP id 4so47133ilg.1
        for <linux-efi@vger.kernel.org>; Tue, 19 May 2020 09:44:39 -0700 (PDT)
X-Gm-Message-State: AOAM5325fvpl6ui3k8eU2gkUOWsidruLXWTpCHUBgwpPIhgqARq4Iwfo
        v8zSuLXH2cfTNt0HABOWP4ZWe106F3FAuKQMiaM=
X-Google-Smtp-Source: ABdhPJwPQ6KEIlr+o8kUCqP8sUJoej1H6+9gedLKK8Dw1a+zPXz3w6Knsc3UfVr7i7cY6C6zuJ+Q5Vj0BP+M7kJPfKY=
X-Received: by 2002:a92:3556:: with SMTP id c83mr20070171ila.218.1589906678491;
 Tue, 19 May 2020 09:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
 <CAMj1kXE7EasnCLW0LrWP7f8A9dpTThSHJUP+iM-i0Tqrm=FoOA@mail.gmail.com> <20200519150629.GB1526900@rani.riverdale.lan>
In-Reply-To: <20200519150629.GB1526900@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 19 May 2020 18:44:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGuM6sEE5HoAmGP7EZDnyUsW73FH+f2C_MvH76UCMYkpg@mail.gmail.com>
Message-ID: <CAMj1kXGuM6sEE5HoAmGP7EZDnyUsW73FH+f2C_MvH76UCMYkpg@mail.gmail.com>
Subject: Re: [PATCH 00/24] efi/libstub: Add printf implementation
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 19 May 2020 at 17:06, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, May 19, 2020 at 09:53:47AM +0200, Ard Biesheuvel wrote:
> >
> > Thanks Arvind, this is looking really good!
> >
> > Did you use any test code for the printf() parsing? Given that the
> > kernel command line is not covered by secure boot signing (or the
> > initrd, come to think of it), I'd hate to open up a security hole
> > here.
> >
> I only did basic functional testing, I haven't tried to actually break
> it.
>
> I think the code will be robust enough to avoid overflowing the buffer
> passed to vsnprintf, even if the output ends up being garbage due to
> bugs.
>
> That said, one thing in efi_convert_cmdline is that we use int to hold
> both options_chars and options_bytes. The size of load options is
> limited to uint32, so int should be ok for options_chars but
> options_bytes could theoretically overflow?
>
> In any case, there's no point parsing beyond COMMAND_LINE_SIZE anyway,
> so we should limit options_bytes to COMMAND_LINE_SIZE-1 + terminating
> NUL, and if it's longer we can either truncate it (blindly or at
> whitespace?) or ignore the options altogether. I can add that in v2.
>

Anything that will make it more robust is good to have.

> One more question -- since the first version of the stub, we truncate
> the command line at the first newline character. Do you know if there's
> something that actually needs that?
>

Not that I am aware of.

> efibootmgr can actually even set up the load options as a series of
> NUL-terminated strings if you miss putting them all inside quotes :)

Someone else may have thought of that already, so we can't simply
start treating anything past the first newline or \0 as part of the
command line.
