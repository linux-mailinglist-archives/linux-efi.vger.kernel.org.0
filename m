Return-Path: <linux-efi+bounces-4379-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CBCB0734E
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 12:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0539A3B172C
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6272F1FF2;
	Wed, 16 Jul 2025 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VA1sKFZI"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19702309B2;
	Wed, 16 Jul 2025 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661631; cv=none; b=ccswbwz0RU4RJxaRJMCpT6dIuazkM9XNLRa1uvS04U20YfvQ/n5bQvLMhFQ5DqiQbAypIrdJxmeVXwLitC7bmed5sTNF24r1ajk0Su1BH5Z8teQ+Kkqcqd8ovuzZBMZ79tDwV1i3tTmvMBBvYV//YMhjFkHPnaePePyslMa3YpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661631; c=relaxed/simple;
	bh=eje/atnbbOgwfSrIBlbXh9smtB6jfmX0bEMzCbMqs4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Frba703y7LeB7BkQai5lfUmNN6Mvlk9j3bMHGx1yFQpCC/9rMFsURluvA7CwgOwe+3zVYQs2Xc6YeHQqH8SyuAAflRB8bLO/cVcF9zIrc7vphbSNWPdTIzRB05uG16utswigSlxxDk4ogAEtsm//Xax8/t6byKezp1w0m760Hqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VA1sKFZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64402C4CEF9;
	Wed, 16 Jul 2025 10:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752661629;
	bh=eje/atnbbOgwfSrIBlbXh9smtB6jfmX0bEMzCbMqs4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VA1sKFZIbEZ3qgsMzkohX5PG8eU5gwTJTInpmZwsiN0m2UZAZIANrBBFKdho7x4pe
	 xSjP9pLdsd8fDoRJ7qOT2PasfZEjQcaOmNkZXoFfQBKo+ObM+7Lnlt3aE1CysLxksh
	 HfHKmRx24YvlrDROn4dGuwEp++rib66+pk7sNlwkjbXVX4nXHxpzNWDX0avt6Ur94G
	 tWb0RIb1JXXwseDOjv1KVz1RN4bk7QfOd8VM3eXMo/i0oEORd0SS2PWoz7YG5NtEAj
	 1MeW6C628UPps1Y4wNrbZNrQTPy63OGfLaVvLC1TJWko59S98MEpb0yh23Cl4t+i7F
	 N38bM6a+/Chmg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553b5165cf5so7824776e87.0;
        Wed, 16 Jul 2025 03:27:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9iWvVSWs0mJ7EEjm/RUn+nQ7MdVAuBsJN1nZsaWUhyx0g7lnazSLMBMU89pHMbaXtOgKUXFrxIoc=@vger.kernel.org, AJvYcCXdSaFL4RoX/z8KcwErIz/a5ardZqQ9DpddxDd3oL4WWEXojhUiAYBZS43XHnTdyopOmqtZVaUK2/hE5GKI@vger.kernel.org
X-Gm-Message-State: AOJu0YysgGZTgOdrKNbjSPrC7I/a9AkERsrKDfA5K0yja4p8S7919h9d
	ljzaQWvJrBGK+zzNXhIb3P7K/h6aJwRDDzYw0hoe6NkAG6BKuAToEeGsxAag9fcog5YHb3h+ryu
	RsZj1ZP3+EVvyeL/242nCvwZLIpSymeI=
X-Google-Smtp-Source: AGHT+IEK/ZMlPdJZ+7xoWCkefw45kfpuSaPX7BibFuwf5YPURSnys04j/M4gYNkjPMaq3qTJHwqsrVB27d5KNoWFe4w=
X-Received: by 2002:a05:6512:ad3:b0:553:26f6:bbf9 with SMTP id
 2adb3069b0e04-55a2332f102mr976059e87.18.1752661627693; Wed, 16 Jul 2025
 03:27:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
 <20250716031814.2096113-39-ardb+git@google.com> <20250716095446.GV905792@noisy.programming.kicks-ass.net>
In-Reply-To: <20250716095446.GV905792@noisy.programming.kicks-ass.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 16 Jul 2025 20:26:55 +1000
X-Gmail-Original-Message-ID: <CAMj1kXHNvPdgG+OKX6UB70oTzzbvovfvDhSH73vAj-q7G03c5Q@mail.gmail.com>
X-Gm-Features: Ac12FXzLkdMBNAYhtzUBtWa7lsljDpOq7i6yiHftVSU24S7MKWzX-Flbj1fcicI
Message-ID: <CAMj1kXHNvPdgG+OKX6UB70oTzzbvovfvDhSH73vAj-q7G03c5Q@mail.gmail.com>
Subject: Re: [PATCH v5 15/22] objtool: Add action to check for absence of
 absolute relocations
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 19:54, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jul 16, 2025 at 05:18:30AM +0200, Ard Biesheuvel wrote:
> > index d967ac001498..5d1d38404892 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -4643,6 +4643,39 @@ static void disas_warned_funcs(struct objtool_file *file)
> >               disas_funcs(funcs);
> >  }
> >
> > +static int check_abs_references(struct objtool_file *file)
> > +{
> > +     struct section *sec;
> > +     struct reloc *reloc;
> > +     int ret = 0;
> > +
> > +     for_each_sec(file, sec) {
> > +             /* absolute references in non-loadable sections are fine */
> > +             if (!(sec->sh.sh_flags & SHF_ALLOC))
> > +                     continue;
> > +
> > +             /* section must have an associated .rela section */
> > +             if (!sec->rsec)
> > +                     continue;
> > +
> > +             /*
> > +              * Special case for compiler generated metadata that is not
> > +              * consumed until after boot.
> > +              */
> > +             if (!strcmp(sec->name, "__patchable_function_entries"))
> > +                     continue;
> > +
> > +             for_each_reloc(sec->rsec, reloc) {
> > +                     if (reloc_type(reloc) == R_ABS64) {
>
> This should probably also check R_ABS32. Yes, your current only user is
> x86_64 so R_ABS64 covers things, but we're getting more and more archs
> using objtool. No reason this check shouldn't also work on PPC32 for
> example.
>

Yeah, I was unsure about this.

This check is sufficient to ensure that PIC code is not emitted with,
e.g., global variables with absolute addresses, etc. So the R_ABS64
check here is only a check whether any relocations of the native
pointer size are present (but no R_ABS_NATIVE exists at this point)

For robustness, we should actually check for all absolute relocations
here, including R_X86_64_32S, which is not abstracted into a R_ABSxx
type for objtool.

So perhaps this needs an arch hook where x86_64 can implement it as

bool arch_is_abs_reloc(reloc)
{
   switch (reloc_type(reloc)) {
   case R_X86_64_32:
   case R_X86_64_32S:
   case R_X86_64_64:
      return true;
   }
   return false;
}

and the default just compares against R_ABS32 / R_ABS64 depending on
the word size?

