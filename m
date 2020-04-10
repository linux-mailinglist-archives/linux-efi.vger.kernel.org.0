Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 662AE1A4375
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 10:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgDJIUy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 04:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDJIUx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Apr 2020 04:20:53 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AB5421556;
        Fri, 10 Apr 2020 08:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586506853;
        bh=5k2owslALNv4JQUFd76NSg+vxcF3iacavyDaDEKz6so=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mdiHg9r9Nsg8z9iAJPD1dpeagLc0bAVvUmW+3NmVjSPG/4TtLUyFQ0NRDuZbrM2Ju
         DZmaI7sFZqVbqF1j9lBUF+XSwvaAVNK1O8EiCx/SEagBBJ99cN5urm+0rIlNkJcgrN
         lXMa8YhK+KFQ68twSAgBYZ/YAT8lUNh0uy86HLik=
Received: by mail-il1-f177.google.com with SMTP id p13so1203454ilp.3;
        Fri, 10 Apr 2020 01:20:53 -0700 (PDT)
X-Gm-Message-State: AGi0PuY6JGIBrch6AVJ9AcRJCPwk0sENvo0pcYvSZuPRmCB8m73bHe/N
        hb3v3+i/KLjUtVW7dO8L9Ojwe7Qc2iZO5AAVntA=
X-Google-Smtp-Source: APiQypIKE0UGN7ziuo+6K0SRPgC+zVoVPqcK1SO1VFVqbW7C4JolbA+dHo9egsBlDpl5rYSZu1dKu4ThJgoeL80ZcOY=
X-Received: by 2002:a92:dcd1:: with SMTP id b17mr4073059ilr.80.1586506852792;
 Fri, 10 Apr 2020 01:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200409130434.6736-1-ardb@kernel.org> <20200409130434.6736-4-ardb@kernel.org>
 <CAMzpN2gJWwVun1Kp6vGuza9LM5KpB=0EwsP8x8eOJQuDGh38Hg@mail.gmail.com>
 <CAMzpN2jFbf8k99pWaTYRBmSB+iNAKYsufjEhqO6Vv0qxAcHyGA@mail.gmail.com> <20200409210847.GA1312580@rani.riverdale.lan>
In-Reply-To: <20200409210847.GA1312580@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Apr 2020 10:20:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFhtK=FRDKBE5OtenNEtpK=kVwyo+0nqJZ_K80RmtYxEg@mail.gmail.com>
Message-ID: <CAMj1kXFhtK=FRDKBE5OtenNEtpK=kVwyo+0nqJZ_K80RmtYxEg@mail.gmail.com>
Subject: Re: [PATCH 3/9] efi/x86: Move efi stub globals from .bss to .data
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Brian Gerst <brgerst@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 Apr 2020 at 23:08, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Apr 09, 2020 at 04:53:07PM -0400, Brian Gerst wrote:
> > > Can we use the -fno-zero-initialized-in-bss compiler flag instead of
> > > explicitly marking global variables?
> >
> > Scratch that.  Apparently it only works when a variable is explicitly
> > initialized to zero.
> >
> > --
> > Brian Gerst
>
> Right, there doesn't seem to be a compiler option to turn off the use of
> .bss altogether.

Yeah. I'll try to come up with a way to consolidate this a bit across
architectures (which is a bit easier now that all of the EFI stub C
code lives in the same place). It is probably easiest to use a section
renaming trick similar to the one I added for ARM (as Arvind suggested
as well, IIRC), and get rid of the per-symbol annotations altogether.
