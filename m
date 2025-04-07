Return-Path: <linux-efi+bounces-3214-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB59A7E902
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 19:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62DF189BC79
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 17:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF52217736;
	Mon,  7 Apr 2025 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/sKjp9/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0C12144A1;
	Mon,  7 Apr 2025 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047973; cv=none; b=H1ewG4m4OxPC7AbRb0dwymCKoaKh0PgjMddjcnPLg9242f0cBqS+dGEm38fbbcfNoNa+8FqhsYxmLtChF0y7gSfFFwq9HG/mT7NfSqiwOXLp5BdINUo0Va9FWs+iGEuYdj9vylnAQ4QtoFoqTuMsFxIjffpbqvJGKLijnvu+GIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047973; c=relaxed/simple;
	bh=0fKTXOZW5qo0X+TiPkjQ6mKAeLsXB/zopMIkwzFYKkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBxfIt0WyEKCsHi0XlqGMkZi5TGvIT0eE7P2mSxubRyOqVdIxCcxY3cQixq/FpsyJzsIXDHqVMW2YegaPjS4+KdncoqIfBNGChEw29mLehHTUoDG6l9uL2mLtL3eKO93SMhmtCW6rhGE7l1iK7gAy3MhsHvLA3veEqXajMVXkBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/sKjp9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70126C4CEE9;
	Mon,  7 Apr 2025 17:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047972;
	bh=0fKTXOZW5qo0X+TiPkjQ6mKAeLsXB/zopMIkwzFYKkY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h/sKjp9/0UEj3NLNlpbKVUKjaab0cvUHzBQftW4GVPyilANLb59ujPgeoT+CjTiT6
	 jffT6zLc+nk9TJZOqffiBsieyO7M1SBjEsgWDJoh3ycdyARaeZBfg2O7qtxA6OD2PM
	 LmvYX33jzf5hYPcxvc+fj8NG45DtQyGUeE1q3P5WBOAGW6SJjdVhbeG8gG7ZwfV3oa
	 Z8t6lz0Z5/0xOX+cUJVfIXTWsL1/EDkQoRhBQoQMYieq0V9Bi3s9ZEtXD7dxI2WV+L
	 rBqUOD/WGboMxqn3Gf9TDHGXtsEhT+gd6FIp1pONwv8rKS1EIF8C0z6nTLZ7bmIxrI
	 VTV95pfDJ0FzQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5499bd3084aso4383318e87.0;
        Mon, 07 Apr 2025 10:46:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOAut0xVKefLeG6WX19cyMGw5saXIEGXDexOhCDpnie8W+K4rzoglvNkIzK95Ss0878YlpUmM4K4e9OcqI@vger.kernel.org, AJvYcCXpGbfFzylxB/GtvkAaHJkQo/Z5BPm2Hg4BqbZWjKlmMCuFzc1cUssI9WV6CJftedAJD2GAgcMxvTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1tfspCSx7y36pI5Mn/uF9ybXwjT3X2YYEyULsoqWRhYNUjst
	9b+pPVCbP2XPk4jQRVCdzH2dP017AY+3IsocZFGsIAn1YeaU7bz7/QKg3UL5e62mWT9UQIokg6h
	vkUDSpD5oqjZwD430eih4nLpSkhs=
X-Google-Smtp-Source: AGHT+IGhlKGWnsMcOTGKmTWl7l4Q+R+vNEutfZ2rMUOfKaUEuAlPYG819aLiXhL+YHA/4nzk483tdd68kdI6IZm798s=
X-Received: by 2002:a05:6512:3056:b0:549:c1e6:cbb9 with SMTP id
 2adb3069b0e04-54c22767ef4mr3237009e87.9.1744047970782; Mon, 07 Apr 2025
 10:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404082921.2767593-5-ardb+git@google.com> <20250404082921.2767593-8-ardb+git@google.com>
 <l6izksy3qtvo6t6l3v44xhuzmrnl2ijv7fx5ypvaz7kjxvpwhh@4zwlvxyfrp43>
 <CAMj1kXGwnTkb1bUDaRpkh3ES8thcUVQE7+qgfZQw+RORtvtv-g@mail.gmail.com>
 <CAAH4kHbxMDGQy3v9ef1ZdqK0TNzpm==BJgx1KiUpRP-CRKDx4w@mail.gmail.com>
 <ldrma6tce2bwhenu5kobjzvk7cz445ubfmpcynwadqudgvzuh3@aibigcdzui6m>
 <Z_QA6GwqoxdW6D0e@gmail.com> <CAMj1kXGWPopQupteK0=mqd5z29Oj4Ye6KyPfgup-nHQO863Qow@mail.gmail.com>
 <grmalijxenphqg664brbqbreitq3qkancb7qv32yjdwzfoqowy@6tavdslt75i7>
In-Reply-To: <grmalijxenphqg664brbqbreitq3qkancb7qv32yjdwzfoqowy@6tavdslt75i7>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 7 Apr 2025 19:45:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHcdT8X8uUyd+9eEF1Nc=CBNj2M4z172DUU7g_pJ5BHuw@mail.gmail.com>
X-Gm-Features: ATxdqUETiXubx7oL92fu01tgK_Ofbmg0d3GrBgABA6pQ3UBszjzW9WPybc7BwRM
Message-ID: <CAMj1kXHcdT8X8uUyd+9eEF1Nc=CBNj2M4z172DUU7g_pJ5BHuw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/boot: Implement early memory acceptance for SEV-SNP
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Ingo Molnar <mingo@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Apr 2025 at 19:33, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Mon, Apr 07, 2025 at 07:21:17PM +0200, Ard Biesheuvel wrote:
> > On Mon, 7 Apr 2025 at 18:44, Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > > On Fri, Apr 04, 2025 at 08:07:03AM -0700, Dionna Amalie Glaze wrote:
> > > > > If the GHCB is available, we should always prefer it.
> > > >
> > > > I believe we should consider the cost of code duplication in this
> > > > situation.
> > > >
> > > > If the non-early version is only used in the kexec path, it will not be
> > > > tested as frequently and could be more easily broken. I think it would be
> > > > acceptable for kexec to be slightly slower if it results in more
> > > > maintainable code.
> > >
> > > Absolutely so.
> > >
> >
> > It would be nice if someone could quantify 'slightly slower' - I am
> > leaning to the same conclusion but I have no clue what the actual
> > performance impact is.
>
> If we can survive the performance of the initial boot, we can live with it
> for kexec.
>

The initial boot does not occur via the decompressor, but via the EFI
stub, where memory acceptance is handled by the firmware (as it
should).

Given that the traditional decompressor carves out an allocation from
the raw E820 map without using any of the higher level APIs, it has to
accept the memory itself if it is marked as unaccepted in the table.

Perhaps the decompressor should try to avoid unaccepted memory?

