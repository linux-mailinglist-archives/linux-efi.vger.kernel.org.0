Return-Path: <linux-efi+bounces-866-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBED08879B1
	for <lists+linux-efi@lfdr.de>; Sat, 23 Mar 2024 18:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6231F216D9
	for <lists+linux-efi@lfdr.de>; Sat, 23 Mar 2024 17:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9C551C33;
	Sat, 23 Mar 2024 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF+0VKTb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C314AA3;
	Sat, 23 Mar 2024 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711214337; cv=none; b=PRoSQP5uLRahwY528QObw1+lPvttYlAjqtaTXPa9iNlwFGIQwxW5wRprBVbORWosxfiwu3542kanaiafIgmvHprwbMNVb8CGo7p3jCIoCvPtNrkKBhRTploy7N7BnAQYmZ9BAc2H8rexJ4CQP4iXggRa+0ktF7IjVaIXm09d4z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711214337; c=relaxed/simple;
	bh=YsvblgwmDLQtvJ2SS/c86WY6mRVzSY9IS5ya+KTKy6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWGO/Bmt+s6PbZM/PErI8h10EB/33+GMdiolbsXuRBDf+3bbCTvBC3nYQxm32wpanliJra7/GkPHMkxI6S7DbQh4I5gVIywvl4V0xJhsWPBT2KsP58TDja0UsSNkhADLV257A0vtIjCLH7VszdttErpwWcP7wmvroapeycSTY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF+0VKTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3674C43394;
	Sat, 23 Mar 2024 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711214336;
	bh=YsvblgwmDLQtvJ2SS/c86WY6mRVzSY9IS5ya+KTKy6A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XF+0VKTbIrctf3zVHuwfvivJErpVduP6uYtLojhOxw+bQTKwKZ7sQCLxtLImYTtUm
	 GX21Jz575FhuJ+4VPolJDKASiym/cbgWjlViop6XT84wVHqRjcNj0djs8QYsYAxdKr
	 0Lmh1RTYZtpRrlyMVPhJM5/U7gkTrjAbY3LwK1O7qshUTnJEM3I6uNsCiHghimAo1D
	 caxneuu59z80KNySdrwCvDWy5WSVNwQUuqAcYrtke3h/Qhwhc0luWfjDnqTHHWcceI
	 enQZELZ0136gXgMtGUfEkRjWqBejoiJsjJFDUwLLo2el+bnZGc6adUCUGzxoCLPS9J
	 AxA+7mpXpxLrg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d094bc2244so42310061fa.1;
        Sat, 23 Mar 2024 10:18:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvqe6tHxlfhpwcACZN6bK0Dr2yOpcI76b+FDrVXdSqyd4H1CCXQe++/AOCEa6v43yHAEjlLz0jNmC250H/N5RYqN8v+eUmlsjhLt818bSGNRuGyzAstdTmoVoxidveoZ3Ygm6wLi23
X-Gm-Message-State: AOJu0YzKoTLeSsGjqP1/239aOGz6852d+nZ98/4ntmL8HTbgjTfe+Zm2
	AqqARry+BwpkL3GVAGpr+ojQ5R0xx/3QswN/CACsXl6Ln+LOfCF67YkyF71+qyGUKwDv7RbUtJ9
	iC7u1Pz3RTABlGNQhJZMd03VnuDA=
X-Google-Smtp-Source: AGHT+IElyK7wxxON6t0kB6QHEL4Gmij3dcTe/m8dkE3fDOkS3+rJwNBNre0HRuB8OHnaJXR/HUFNm+rf3WJhWB1dC3Y=
X-Received: by 2002:a05:651c:547:b0:2d4:5404:3e8e with SMTP id
 q7-20020a05651c054700b002d454043e8emr1857603ljp.42.1711214335293; Sat, 23 Mar
 2024 10:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321150510.GI8211@craftyguy.net> <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
 <20240321170641.GK8211@craftyguy.net> <CAMj1kXE-sxGM2H8akunJ1mZPDSVX1+2ehDtK-jqW--8tw9J5LA@mail.gmail.com>
 <20240322091857.GM8211@craftyguy.net> <CAMj1kXFmnv+FGRMnnJMJejj5yvSybgZTNEYZz0hxb6K9VAeo1Q@mail.gmail.com>
 <fe09869c2d853bde8ce0feb537c4dab09014f5d9@craftyguy.net> <CAMj1kXEH4CTnQ3d+Z-TnqNUhFaFc1yH+Eaa6cHk9-vZ_geQ2nw@mail.gmail.com>
 <8a64ba697d719bc9750e6fffc268e194dfde16e5@craftyguy.net> <CAMj1kXEk=7_BoaavZtZs7giBq4Kwk-QQoNjMZS=rWLJP=LdVLw@mail.gmail.com>
In-Reply-To: <CAMj1kXEk=7_BoaavZtZs7giBq4Kwk-QQoNjMZS=rWLJP=LdVLw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 23 Mar 2024 19:18:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHEJuZH4GsPKpu2vn6NQtKq1FBUtb-Rkfatwa63brgXpw@mail.gmail.com>
Message-ID: <CAMj1kXHEJuZH4GsPKpu2vn6NQtKq1FBUtb-Rkfatwa63brgXpw@mail.gmail.com>
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
To: Clayton Craft <clayton@craftyguy.net>
Cc: Hans de Goede <hdegoede@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Mar 2024 at 14:39, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 22 Mar 2024 at 21:34, Clayton Craft <clayton@craftyguy.net> wrote:
> >
> > March 22, 2024 at 11:30 AM, "Ard Biesheuvel" <ardb@kernel.org> wrote:
> >
> >
> > >
> > > On Fri, 22 Mar 2024 at 19:57, Clayton Craft <clayton@craftyguy.net> wrote:
> > >
> > > I have pushed a branch below that reverts the patch you identified in
> > >
> > > 4 separate steps. Could you please check which step makes your system
> > >
> > > boot again?
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-clayton
> > >
> >
> > Thanks a lot for doing this, I really appreciate the help!
> >
> > It looks like if I build from 868a7245, booting breaks again on my Bay Trail systems. If I put back 00e85ab5, they boot again.
> >
>
> OK.
>
> I have reshuffled the branch and put the patch you identified as the
> one fixing the boot first. Please double check whether this change
> still fixes the boot for you.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-clayton-2
>
> If so, we can try applying it to mainline, and merge it if it works there too.
>

I have a mainline branch with the same change applied, please try that one too.

