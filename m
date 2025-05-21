Return-Path: <linux-efi+bounces-3763-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A873ABF8F9
	for <lists+linux-efi@lfdr.de>; Wed, 21 May 2025 17:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7247B3B859F
	for <lists+linux-efi@lfdr.de>; Wed, 21 May 2025 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA43E1DEFFC;
	Wed, 21 May 2025 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku8szkqe"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF9A1DDA1E;
	Wed, 21 May 2025 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840269; cv=none; b=d45+S7V3RmzXnp9tXONG4RmecXWq2nWixe9/CuNdJukI4cGPQVHuphc1YlN0BYzM61j5KFPrDhNLhq5nBV8JS7W0r92cFIuzjtYWN6LkP+HnuIfTpb7lZk7M+dntNyKcNDMaujjPz6BKg0V2bHKUJNhXZBTJuducci02tBSocx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840269; c=relaxed/simple;
	bh=rf5KKNagSS+Ep78t789CZRexOArLM/q6lgtQp5b75n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5en+YipkHckcqk3xtAKnvl3r854BOlpKK2U4jUqkZGDGkCYG7PjCuKOHEJk30MvXDfjcjKfyuvdhH/WXAJ22XpySmcieqf22qCyg9MMkpdQZguz2cBK1gcQtnpV4i17xgyMgX/p69l09edIvjYur7/MTqmi7xNpklmK/aDwizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku8szkqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78CFC4CEE7;
	Wed, 21 May 2025 15:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747840268;
	bh=rf5KKNagSS+Ep78t789CZRexOArLM/q6lgtQp5b75n8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ku8szkqeevtcmqtgK8C7iUkUT2PLVpLbJDjrQSBJtMJOWfcPTbmsq3vw9OcF8m9ud
	 akenuznlQiTA2GiFFl6ZssTTyhVLTUnEI699nguS2UEWYos54qLw0OOG4U23ddJ1BJ
	 RjmN+qg5lECLGa6NlbNczkjewGlgRH3tqzsCBKhCKbNG38n5idSMMM66WZevayqPEC
	 s/sesF9RGMtbcbReg7g8XrzYoDEiLAgjxAiaSL4yS7oVAXP6Lb5t/6mmo9FP9HVdiB
	 iQKcxzBsA2gYMryg4aF7Ni7NSlugyw8fLo4iScWYf8iy9ZVFJatiH+WJa02bRkvJ3P
	 /Kbkv6cBSew0g==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3106217268dso64913981fa.1;
        Wed, 21 May 2025 08:11:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1zLvqU0pYAKZGs2m0NpZ36ZHRzjHrDbRszsN7Wn1V4DO4sY0uPhH1urGtdRipIcuJjLG1liSv6aWJQ7OZ@vger.kernel.org, AJvYcCXj2ZRiNzxZx32rN0L6+Mq3JjOc3SdwZI955D1uUiyged0LgPnF+pjRNy4uuGSaiILFwJfaikIJFes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyY3pPKNPZwSXsLq01lsxfjJ7S/0wxr0qnbyHGWe0oeKX0Wunl
	7npwAsHdqa2tGp4aPWoPeqYaVv5qwrxHWyTiqxg+oqRTZQIuAZs+Cdug6gmgXzuToL2WKD9RXOq
	iZVI6i3z/K4iFTJQfE2k7YVvAulPSEAw=
X-Google-Smtp-Source: AGHT+IFiy+7d7pnSNTPHNyLmYyFaX/UwWfUH2Dg7JMmaFpvDfxmoq162Boqbk2tRJOirGvAFcXb1V/KMGMSCBoKzZ/Y=
X-Received: by 2002:a2e:a01b:0:b0:329:3b72:4f2f with SMTP id
 38308e7fff4ca-3293b7250e7mr5166281fa.39.1747840267297; Wed, 21 May 2025
 08:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250504182244.30446-1-pali@kernel.org> <CAMj1kXE5DQ-tBFa+xLR10+joGADRB6BJ70EvDfJzfWJr1o3Q2A@mail.gmail.com>
 <20250505173259.b34f6hvn6t73q3df@pali> <CAMj1kXGE0fSRvR4=+qAWu54ehzJfdC9GSzHODr4pMTEbBwOhuA@mail.gmail.com>
 <bc8307c5-cf59-4a9a-95e1-c49ac19efb43@uncooperative.org>
In-Reply-To: <bc8307c5-cf59-4a9a-95e1-c49ac19efb43@uncooperative.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 21 May 2025 17:10:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG9zkGGEQRXv41ro2mwZBcSvO=UJXfN5Aemu4CmBHkVxA@mail.gmail.com>
X-Gm-Features: AX0GCFsRUgtvKt_e6ugHF7ETscSfYXODoL32KmMa3Zd9Lbt1HLnxFoRw2ICBiHg
Message-ID: <CAMj1kXG9zkGGEQRXv41ro2mwZBcSvO=UJXfN5Aemu4CmBHkVxA@mail.gmail.com>
Subject: Re: [PATCH] include: pe.h: Fix PE definitions
To: Peter Jones <pjones@redhat.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-efi@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 21 May 2025 at 16:11, Peter Jones <pjones@redhat.com> wrote:
>
> On Wed, May 21, 2025 at 03:45:13PM +0200, Ard Biesheuvel wrote:
> > (cc Peter)
> >
> > On Mon, 5 May 2025 at 19:33, Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > >
> > > Hello Ard!
> > >
> > > On Monday 05 May 2025 13:25:45 Ard Biesheuvel wrote:
> > > > Hello Pali,
> > > >
> > > > On Sun, 4 May 2025 at 20:23, Pali Roh=C3=A1r <pali@kernel.org> wrot=
e:
> > > > >
> > > > > * Rename constants to their standard PE names:
> > > > >   - MZ_MAGIC -> IMAGE_DOS_SIGNATURE
> > > > >   - PE_MAGIC -> IMAGE_NT_SIGNATURE
> > > > >   - PE_OPT_MAGIC_PE32_ROM -> IMAGE_ROM_OPTIONAL_HDR_MAGIC
> > > > >   - PE_OPT_MAGIC_PE32 -> IMAGE_NT_OPTIONAL_HDR32_MAGIC
> > > > >   - PE_OPT_MAGIC_PE32PLUS -> IMAGE_NT_OPTIONAL_HDR64_MAGIC
> > > > >   - IMAGE_DLL_CHARACTERISTICS_NX_COMPAT -> IMAGE_DLLCHARACTERISTI=
CS_NX_COMPAT
> > > > >
> > > >
> > > > Where are these 'standard PE names' defined?
> > >
> > > Basically in any project which is doing something with PE, at least i=
n
> > > projects which I saw or used it. Those names are mostly coming from
> > > Windows SDKs/WDKs as the Microsoft is inventor of them and are de-fac=
to
> > > standard names -- or at least people are following existing naming
> > > convention for a good reasons. If you are are not familiar with
> > > MS/Windows world, you can find them also in projects like binutils,
> > > llvm/clang, wine or mingw-w64, which are hopefully well-known project
> > > references.
> > >
> > > Some of IMAGE_DLLCHARACTERISTICS_* names (including the NX_COMPAT) ar=
e
> > > defined also in the PE MS spec (win32/debug/pe-format). I hope that t=
his
> > > spec can be taken as a reference, even that it does not document
> > > everything related to PE, and contains mistakes.
> >
> > I don't feel strongly either way with any of this - I don't think
> > there's anything to fix here, but I'm not attached to the names so I
> > don't mind changing them either.
> >
> > Peter: any thoughts?
>
> I'm broadly for making the names look more like what the spec uses
> whenever we can when it doesn't introduce naming collisions with other
> stuff.  But like you, it makes very little difference to me.
>

Thanks for the insight.

I've queued it up now - thanks.

