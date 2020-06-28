Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D1120C9DC
	for <lists+linux-efi@lfdr.de>; Sun, 28 Jun 2020 21:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgF1T06 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Jun 2020 15:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbgF1T06 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 28 Jun 2020 15:26:58 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2C82206C3;
        Sun, 28 Jun 2020 19:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593372417;
        bh=eWgU1bHWpQJKynygq8SlOlQDfursoSl2F7Isuu/6Qus=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LbyoDRpY+UhUHP6xya03mwMz6oDtFM2dPXfOeC95PU28nxzOnKyUOyAgvahh4SCoX
         Oov1mfKve0EmU4KUD1PjpJWoSTNR2TtML4otIW6vXcr/mf5iEw/j4TNHJjnMf7bbwe
         dr4C1qAOdf68dXjjTQqSjBhc8f+mkZDFTqtlEgMQ=
Received: by mail-ot1-f46.google.com with SMTP id m2so13532549otr.12;
        Sun, 28 Jun 2020 12:26:57 -0700 (PDT)
X-Gm-Message-State: AOAM533Nihk3+ZORS+uoOpiboGCl8aHjYSSGOnPNWNfRsGVch7ICpvL3
        jhkvtoRVG5mOjsdK9q/NO1/LhdOElw6Z4OVcAvs=
X-Google-Smtp-Source: ABdhPJzHm78KxQmwfUdKJ61L9yWPm+1u8mItRetBQKMqn1UtdPfgN72AKu4cuwEHkE6DARtuG77pEUnsfaHlMpAsJVY=
X-Received: by 2002:a9d:688:: with SMTP id 8mr10661896otx.108.1593372417154;
 Sun, 28 Jun 2020 12:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200628182601.GA84577@gmail.com> <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 28 Jun 2020 21:26:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFfLb44ifgNqBR9WM5T6sT6ekqS8cYdvbuhvs5mqcD+tw@mail.gmail.com>
Message-ID: <CAMj1kXFfLb44ifgNqBR9WM5T6sT6ekqS8cYdvbuhvs5mqcD+tw@mail.gmail.com>
Subject: Re: [GIT PULL] EFI fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 28 Jun 2020 at 20:57, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Jun 28, 2020 at 11:26 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > - Fix build regression on v4.8 and older
>
> Interesting.
>
> It's perhaps yet another reason to just skip gcc-4.8 too, since
> apparently 4.9 works.
>

+1

> gcc-4.9 really has a lot of advantages. It's where (I think) gcc
> basically supports all C11 things, including _Generic() but also
> __auto_type.
>
> So if we just say that we only care about gcc-4.9 upwards, it frees us
> to clean up some (really) old constructions where we've been using
> macros with sizeof and/or typeof, and make the code potentially rather
> more readable and often more compact.
>
> Yeah, I know we _just_ made the minimum compiler version be 4.8, but I
> do get the feeling that we should just have bitten the bullet and gone
> all the way to 4.9.
>
> Arnd, what was the reason for 4.8 support? I'm assuming there's some
> sad unfortunate distro that still uses that ancient compiler..
>

Arnd may know more, but I know one of the reasons 4.8 is significant
is because RHEL 7 uses it, which will go EOL in 2024.

> Ok, ok, 4.9 isn't exactly new either (4.9.0 released May 2014, and
> final 4.9 release was 2016), but 4.9 really from a feature angle is a
> much saner thing than 4.8.
>
> Afaik, the main "interesting" part of gcc-4.8 was that it was when gcc
> switched over to be built as C++. That's perhaps a huge milestone for
> gcc itself, but not necessarily for the users..
>
> Arnd? You're the one who tends to keep track of these things..
>
>              Linus
