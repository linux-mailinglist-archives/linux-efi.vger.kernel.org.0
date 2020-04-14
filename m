Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11551A89A3
	for <lists+linux-efi@lfdr.de>; Tue, 14 Apr 2020 20:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503999AbgDNScq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Apr 2020 14:32:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504019AbgDNSco (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 14 Apr 2020 14:32:44 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 040DD2074D;
        Tue, 14 Apr 2020 18:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586889164;
        bh=aMgICZ0DbRdXvD3uWrORNNguBQeKs4PhM0IInqphAhQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XfIhvFsgxducy/79xPb6PuW6aGDpJNTv8SgSfkKE5j8IOkLygZtW12kHVhyyfdo+I
         PK7OLQyfIkruNmP7rsqIhJ85FSuV148czdCpC2qQRitLDO1MefAABnaRbTqULLz7KA
         UFlEKdLVcW1cpZ96WHu9sVApx7wt4ztMN55pzeVI=
Received: by mail-io1-f49.google.com with SMTP id s18so10966641ioe.10;
        Tue, 14 Apr 2020 11:32:43 -0700 (PDT)
X-Gm-Message-State: AGi0PuaDfxWVsEhz/p0TGTB8sUkvxCYFTbj7eD2/nQ0uKHnjyC1kj+AB
        yLmBmge861Hcq0zF1Gzf0U8qqe958d8gz05yUyA=
X-Google-Smtp-Source: APiQypKav3WF7b4959gYRb4rMnNBPvkKR4rIb6+qdaWp1uLO7cvZSPLe+Li9/xtzPrkG38ZrAXVf5g0i0NS110Xnpzg=
X-Received: by 2002:a6b:ef03:: with SMTP id k3mr11387607ioh.203.1586889163435;
 Tue, 14 Apr 2020 11:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <CADDKRnBdM_T1W=iECrt89hmAmbRRyskGhS4d3ozTz1nWj_i_qQ@mail.gmail.com>
 <CAMj1kXGuMjHi=E6cVGGpwrKF_-KXcj0VRcvAdFS_vmwV7PudCQ@mail.gmail.com> <CAHk-=wi-s0mmLAVg-aSmNU55=cE8ES7mC=Mc3Wn62P8W9VjY-A@mail.gmail.com>
In-Reply-To: <CAHk-=wi-s0mmLAVg-aSmNU55=cE8ES7mC=Mc3Wn62P8W9VjY-A@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Apr 2020 20:32:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE9046X9EDd636Bw1A9npv0QKAuLcTAzMXAn=JVZeCN0Q@mail.gmail.com>
Message-ID: <CAMj1kXE9046X9EDd636Bw1A9npv0QKAuLcTAzMXAn=JVZeCN0Q@mail.gmail.com>
Subject: Re: Kernel V5.7-rc1 doesn't boot (EFI?)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 14 Apr 2020 at 20:27, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Apr 14, 2020 at 3:50 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > [*] GRUB on x86 turns out not to zero initialize BSS when it invokes
> > the EFI stub as a PE/COFF executable
>
> The fix seems to be to put all globals in the .data section, even if
> they don't have initializers.
>
> That seems very fragile. Very easy to forget to not declare some
> static variable with __efistub_global.
>
> Could we not make the EFI stub code zero out the BSS itself? Perhaps
> setting a warning flag (for a later printout) if it wasn't already
> zero, so that people could point fingers are buggy loaders..
>

That is the quick fix, but Arvind is working on getting rid of
__efistub_global entirely, and use the right linker foo to put .bss in
.data. This gives a tiny bit of bloat, but we are talking about a
handful of bools here.
