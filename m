Return-Path: <linux-efi+bounces-1156-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA098FBE04
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 23:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC3E1F224FA
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 21:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F381F1422AD;
	Tue,  4 Jun 2024 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkCjg0az"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2AD8174E
	for <linux-efi@vger.kernel.org>; Tue,  4 Jun 2024 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536424; cv=none; b=LrvgVIjp8qWh+7EpDCFlabhhp4eF31uoGCTANy+E1i/qaUk7ZrEDOjIFZRtuC68z8CZEnRv7QSoyvHijFAwABmTZAD1A/45zXWzO+pocvSW/y3IU6EOXYvYrawrZ6UhVV8h6FefmBT+rN9MnjRtt03E41TClXGZKuY28Wg9XM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536424; c=relaxed/simple;
	bh=27ld/nJRl6JcnTIdc4esKeC8KHkrks4TVCLB8h66hXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YiVSGJfCG71pEMF9w8z6zAo452mAsDcIQOmgi/L0blSv2t5MCol5FcUOJcIbXohhu36OlkD2/6v1ccrjV+B8QcsytbbS6D1W7oovzqzLIiolwp4wFNJw+6jKvvBJOL3yVUR14Z4EGcSO5sWRU7OsLZmbydnyKQAU2BC04N/96CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkCjg0az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5851EC4AF08
	for <linux-efi@vger.kernel.org>; Tue,  4 Jun 2024 21:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717536424;
	bh=27ld/nJRl6JcnTIdc4esKeC8KHkrks4TVCLB8h66hXY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YkCjg0aze818xdFudGQhLf+xW/KA+QKJrdr9pyjjO0ceG1Pd6vLlraCmQUSXeVK2x
	 WQzeAy+5cjAthJI54GB6xn005aQ8DX4t8YKNKl0TIl/nkpqA2iRVOP7O1b3lM4Jk+n
	 WTOHUqek9/uuQC7GWt5qle/NGCu0HOkhW6Ftdc67x9g37zC8Esa2OFh7YqhGEd0FqZ
	 vCiWmFbK1IkZxlM0QDrYfXIqNilSmO0PfKC0PtBXGAwtoiebzKfjPM1ifczPmw3HXn
	 pgnxa7FPaEYCjPYl6xRn+gsnipxGnhDy58Tbg7Op9lrIQsePtAOD1rmqoYngHxunQY
	 jD//x+av2JK0Q==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e73441edf7so65504411fa.1
        for <linux-efi@vger.kernel.org>; Tue, 04 Jun 2024 14:27:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWO2cQC4b2aH3lQ3lPMnUrQlqkUpbnKMeXyICziI/ZYENdrdfU+5zFiSoNlbPUaCTHFv5gtwjKUVw2Y6/rHX5BLBvt44mOsSAp
X-Gm-Message-State: AOJu0YyEzs02MOJMQd/6oMV2GFDw8wpLrE4u+BXkzjqcxDQN4SlOvCls
	z7RFmsU+g2rCbJfUNePjuVV209+9jOOX2pT8uY77varRKRw58KwRzmUPVQxgno8uAKhGN2jBKIk
	tZ7HGYOV+pY/1Y0PDgnUk89ROQ6g=
X-Google-Smtp-Source: AGHT+IG5U9VySDXtIuLieLAg/p9hCgRuIDEfDud4RNfr80AGpJ0P9pEBsZAl+b6+Gm41PfjofEXAUm/645c2OT0ufdU=
X-Received: by 2002:a2e:9615:0:b0:2ea:8408:c1a7 with SMTP id
 38308e7fff4ca-2eac79f184fmr2511521fa.21.1717536422702; Tue, 04 Jun 2024
 14:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604155625.2197275-2-ardb+git@google.com> <CACRpkdZ=-OMFD0d25m_YBjo+Wt-Ca7mjSNphgSA+2avxkcDYBA@mail.gmail.com>
In-Reply-To: <CACRpkdZ=-OMFD0d25m_YBjo+Wt-Ca7mjSNphgSA+2avxkcDYBA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 4 Jun 2024 23:26:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHZ=tchvZ7qmJiE2ajU2nbzkcMnbviyhZeug58wMWzNUw@mail.gmail.com>
Message-ID: <CAMj1kXHZ=tchvZ7qmJiE2ajU2nbzkcMnbviyhZeug58wMWzNUw@mail.gmail.com>
Subject: Re: [PATCH] efi: Add missing __nocfi annotations to runtime wrappers
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Kees Cook <keescook@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Jun 2024 at 23:05, Linus Walleij <linus.walleij@linaro.org> wrote=
:
>
> On Tue, Jun 4, 2024 at 5:56=E2=80=AFPM Ard Biesheuvel <ardb+git@google.co=
m> wrote:
>
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The EFI runtime wrappers are a sandbox for calling into EFI runtime
> > services, which are invoked using indirect calls. When running with kCF=
I
> > enabled, the compiler will require the target of any indirect call to b=
e
> > type annotated.
> >
> > Given that the EFI runtime services prototypes and calling convention
> > are governed by the EFI spec, not the Linux kernel, adding such type
> > annotations for firmware routines is infeasible, and so the compiler
> > must be informed that prototype validation should be omitted.
> >
> > Add the __nocfi annotation at the appropriate places in the EFI runtime
> > wrapper code to achieve this.
> >
> > Note that this currently only affects 32-bit ARM, given that other
> > architectures that support both kCFI and EFI use an asm wrapper to call
> > EFI runtime services, and this hides the indirect call from the
> > compiler.
> >
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Thanks for looking into this Ard!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Maybe tag on:
> Fixes: 1a4fec49efe5 ("ARM: 9392/2: Support CLANG CFI")
>
> So it goes into the v6.10-rc:s.
>

Thanks, I've added these and pushed the result to efi/urgent.

