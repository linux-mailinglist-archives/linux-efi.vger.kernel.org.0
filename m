Return-Path: <linux-efi+bounces-858-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8283887324
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 19:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692AB1F2612B
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 18:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A1767C65;
	Fri, 22 Mar 2024 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnoN8CRL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0725667A10;
	Fri, 22 Mar 2024 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132236; cv=none; b=B2TcmULNJXKexCG8As5oNP0gI/5A9t4bb1/8StprjLd029/cu5jYQEIK9obewMKOwl6tEWpE6GonsGqgkaTOSm+UIE6N3kt+yJBWGGc5enGcHgmxCg9kjTLNgrbh+lPCRBWdbMUt3CxQHiHtPUDAw7+o2J5+84PpS5WqNQAMZLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132236; c=relaxed/simple;
	bh=eLZrPW5/BBzCKT083Tm+TToma1maumf1MAEtzAoEDpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9GaKuaIIPzlKeLpb1naYTPqNnTGhMUAPdllVc8rovWw4jJvdZC+TTqr35ICtfaYv5LXektrSBBoOPx7+mzS5mm9VOchrwLnlynR0DYcBflN4S/0WrEzYoRg3bfBbUTX6qZ8Htr9+NZ/gp/RSJeGrs6CIY/GM6O0K3smOwXQ4Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnoN8CRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0C0C433B1;
	Fri, 22 Mar 2024 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711132235;
	bh=eLZrPW5/BBzCKT083Tm+TToma1maumf1MAEtzAoEDpU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gnoN8CRLC7rrYvNlxsh4qcU0RIvxQAJjEL3frxWP01vNulKnqAdDVR3shz1BfSjSb
	 zDTySd7cg5+Vu4HkK9vj2zfwKoVpI6P+amLPCvQcE67kkeYTHuqh92INgzCGPu4H5p
	 IMwcwrLqs1LcfJmsx89o4O0+ppPGxikG55XETOASRotJHaYDbEo9CeIhJnv7tt4FJf
	 9zsdTh59u9gnniy9ciwUYOyNWjFq+y7Oq7yCnGvZNpwYfXUKGEbbZoXaifIi8ezdmy
	 42vbK5vGxLUj/7D8SRicudhtl88h17m7noCObQMcqU5gSMAu4ckD/Ipnvspj7q15sI
	 JzcTK/dIX3HbQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d476d7972aso41757791fa.1;
        Fri, 22 Mar 2024 11:30:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVL+Pb0av+AwLJkuDEYtSR7tCK3fHmDFPek1l8xvYkYcG+5DScWCK3c8KGlDGkz95fI+GLg5snxRTEM96bq/IJx8hMaikVCzrSmDNGG/Utj/PkGXhsRtcraSYAtim7BOxxY+RKgH2zC
X-Gm-Message-State: AOJu0Yx2AV4gmxdWgDJD76u85Dl0ZmNqHNNd1PHGNI1XEIY9YBJi22E1
	DoosC4EaukKTu2H0yN6jjPLjCPjhMp4nAoRmxzOXvyuH5ZX9S8ekgJg+2TegXnpR3qFjus9Yt3u
	CKix0tiI10lCJVyqpS1CkfYeoGjQ=
X-Google-Smtp-Source: AGHT+IEY+hpTZZfoFV0XughIgQM77xIK8PD83oEmajbW4ZYcRsXaZ5ZfGGOc9RPxz5aF0rP1rIrDSEnvvHm+d3Gzj/k=
X-Received: by 2002:a05:651c:b1f:b0:2d4:6e08:34a2 with SMTP id
 b31-20020a05651c0b1f00b002d46e0834a2mr275700ljr.47.1711132234004; Fri, 22 Mar
 2024 11:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321150510.GI8211@craftyguy.net> <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
 <20240321170641.GK8211@craftyguy.net> <CAMj1kXE-sxGM2H8akunJ1mZPDSVX1+2ehDtK-jqW--8tw9J5LA@mail.gmail.com>
 <20240322091857.GM8211@craftyguy.net> <CAMj1kXFmnv+FGRMnnJMJejj5yvSybgZTNEYZz0hxb6K9VAeo1Q@mail.gmail.com>
 <fe09869c2d853bde8ce0feb537c4dab09014f5d9@craftyguy.net>
In-Reply-To: <fe09869c2d853bde8ce0feb537c4dab09014f5d9@craftyguy.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 22 Mar 2024 20:30:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEH4CTnQ3d+Z-TnqNUhFaFc1yH+Eaa6cHk9-vZ_geQ2nw@mail.gmail.com>
Message-ID: <CAMj1kXEH4CTnQ3d+Z-TnqNUhFaFc1yH+Eaa6cHk9-vZ_geQ2nw@mail.gmail.com>
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
To: Clayton Craft <clayton@craftyguy.net>
Cc: Hans de Goede <hdegoede@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 19:57, Clayton Craft <clayton@craftyguy.net> wrote:
>
> March 22, 2024 at 9:51 AM, "Ard Biesheuvel" <ardb@kernel.org> wrote:
>
>
> > > As I mentioned initially, I bisected my failure to e2ab9eab32. Does that give
> > >
> > >  any hint about what might be the problem?
> > >
> >
> > Not at all, unfortunately. What we might try is to back out the
> >
> > changes step by step. I can prepare a branch for you if you like.
>
>
> Yeah sure, if you don't mind! I'd be happy to test changes in a branch to try and figure out what is causing this.
>

I have pushed a branch below that reverts the patch you identified in
4 separate steps. Could you please check which step makes your system
boot again?

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-clayton

