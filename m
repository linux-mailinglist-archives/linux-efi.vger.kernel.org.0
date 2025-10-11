Return-Path: <linux-efi+bounces-5026-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343FABCF157
	for <lists+linux-efi@lfdr.de>; Sat, 11 Oct 2025 09:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19113B0AB7
	for <lists+linux-efi@lfdr.de>; Sat, 11 Oct 2025 07:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2A122FDEA;
	Sat, 11 Oct 2025 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4wvTaGv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7244F226CF1
	for <linux-efi@vger.kernel.org>; Sat, 11 Oct 2025 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760168587; cv=none; b=ku2/LP8pxT8emNjXITr8NXsPc3KiNn2+Q23Ro/mduI4ml1jXIBuby9V0Z5VJ/vkcPwuwDiRJPfjJDBX+J0K0aOJVzTfV6cYNYM7aANvqPdta9tP03ciDD0KXi0rf6EyxWPMUrdJeQ72lMjYQET3+gc4cTPxIle2ZF6hY8WhmJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760168587; c=relaxed/simple;
	bh=kbm4votTa6BVKLQfFvb+lq1ndb0PM/xLDZ0aG+HAUR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlBj34dFDBJwXaH9dVGnfHpMBksMNqRVh4+jVT7+OGXTSG/WGW/Dj59UFEsJBRYjembn6c0qw80ukKScXJD8IcKacyKXQbNZsvwLQ3NZ4kQYsMsxARaXrco1vwo0RVMktdBaW4FygGMxqKZ3Fi6Bzmdeo52GzQHnraKG7hSLKBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4wvTaGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193D5C116C6
	for <linux-efi@vger.kernel.org>; Sat, 11 Oct 2025 07:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760168587;
	bh=kbm4votTa6BVKLQfFvb+lq1ndb0PM/xLDZ0aG+HAUR0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T4wvTaGvuy8oReUd69CQDXFvrY7CrVInOc98VNnRcLPUYmHnSXE+quOCm3pTn7mnI
	 lUYCnCiajp7hXJnE4MRw6EEgLhT8Yj/ACK0ZsD+Mv9/5oXClTCUwNHnBtkGhncLIlJ
	 c3dydXpfo9iCJgHHLdhjPeva1+xcWx8Yz21+7kq0WmS5yT2zd9gYq1LHftXI0ntJf8
	 Ii3jBJtD9JYStcrQISejHRLakFe1NgjXBjfmSx9QF3oxfQ86ha1Dwdi5apgcgIjwhW
	 AkEsgIzm1HIpncpi1gzUjOBIxuXekoMQVEPnKkfZ4GX9IAmH6FUibNJ/2sRXuPVjYk
	 kHL+fdUO2i1yw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6364eb29e74so4939785a12.0
        for <linux-efi@vger.kernel.org>; Sat, 11 Oct 2025 00:43:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRgm58pY8QB1RZLIDVRH3qPMKVhT0wkmlU3jfO7R2KdQ6LhB02wiQ+TxdLDL2JorfQPQVI6SgDiH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGERyt8mqwmNiOGHjA4YQ7GGtze6oHQy8kdY+IeYcdOn/W2ejU
	2Ujll0PPDD0s5d7YaS1FDhmdp6XF5sDUhQ7j5Xft1NqgXsu7p/MxQbf70t+4YFMUy59Vw5P6Mvi
	T3LrH8gCIQPdO9jojO7J18+FyT2RpbGA=
X-Google-Smtp-Source: AGHT+IHymoFTpE0VemuGRZAWH2VyeEmGDgjl2npd4Xxrf1HM3gf6i9lmx5J4yXsxnXH2TOhTcQG67Wrs2yvvN78DNvc=
X-Received: by 2002:a05:6402:23c9:b0:634:c03f:c605 with SMTP id
 4fb4d7f45d1cf-639d5c75dbfmr12498031a12.36.1760168585660; Sat, 11 Oct 2025
 00:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928085506.4471-1-yangtiezhu@loongson.cn> <CAMj1kXG8Wi+THa2SeLxiDT=+t_TKx0AL4H-azZO4DNJvyyv96g@mail.gmail.com>
 <CAAhV-H7xOf8DEwOrNh+GQGHktOT4Ljp+7SqutGvvDZp6GLXJrA@mail.gmail.com>
 <CAMj1kXG=EFkRAMkvKMSjPixoGqU-tZXVoRkJJ6Wcnzs3x52X6Q@mail.gmail.com>
 <CAMj1kXHWe2uGY3S1NJ6mckqD4n116rPmaOzw3_Qbvxyjh7ECMw@mail.gmail.com>
 <fec0c03d-9d8c-89a3-886a-1adc22e59b66@loongson.cn> <CAMj1kXFLyBbRL+pAAQ6be6dxqFPiyw_Ug8qNQWaicZQ235HE=A@mail.gmail.com>
 <8091e8fa-3483-af39-2f7a-e4eb62b0944f@loongson.cn> <CAAhV-H4+UGLSkbjHbq9MerWfxnq0a13x+uzNfTsCoe1UxjbWsg@mail.gmail.com>
 <CAMj1kXH-rK0bRyHXdJ-crAyMyvJHApH0WR7_8Qd8vrSPBLK+yg@mail.gmail.com> <0c9b8e6a-96a6-91d4-946f-2109f48a529b@loongson.cn>
In-Reply-To: <0c9b8e6a-96a6-91d4-946f-2109f48a529b@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 11 Oct 2025 15:42:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H41m96fvEWG5NqAE=tykPjyzt=50CseJDeCqdG-c_WMrQ@mail.gmail.com>
X-Gm-Features: AS18NWBO_ZPqa7QTYu89pI0P7ab6zSJ33a0XruFytsPgVagYFaP8MLg8Jqce60M
Message-ID: <CAAhV-H41m96fvEWG5NqAE=tykPjyzt=50CseJDeCqdG-c_WMrQ@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, loongarch@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 3:29=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 2025/10/11 =E4=B8=8A=E5=8D=8811:40, Ard Biesheuvel wrote:
> > On Fri, 10 Oct 2025 at 19:54, Huacai Chen <chenhuacai@kernel.org> wrote=
:
> >>
> >> On Sat, Oct 11, 2025 at 9:13=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongs=
on.cn> wrote:
> >>>
> >>> On 2025/10/11 =E4=B8=8A=E5=8D=8812:25, Ard Biesheuvel wrote:
> >>> ...
> >>>> Why do we need both (1) and (2)?
> >>>
> >>> Not both, either (1) or (2).
> >>> Which one do you prefer? Or any other suggestions?
> >>>
> >>> Taking all of the considerations in balance, we should decide
> >>> what is the proper way.
> >> As a summary, there are three methods:
> >> (1) Only link libstub with vmlinux.o during the final vmlinux link.
> >> (2) Remove the attribute __noreturn for real_kernel_entry() and add wh=
ile (1).
> >> (3) Ignore "__efistub_" prefix in objtool.
> >>
> >> Josh prefers method (1), I prefer method (3) but also accept method
> >> (1) if it is not only specific to loongarch.
> >>
> >
> > This is a false positive warning in objtool, which complains about a
> > function that falls through, even though that can never happen in
> > reality.
> >
> > To me, it is not acceptable to modify how vmlinux.o is constructed
> > also for other architectures, in order to hide some of its constituent
> > parts from objtool, which do not use objtool to begin with.
> >
> >
> > If you are not willing to fix objtool, I suggest fixing the loongarch
> > code like this:
>
> Thank you.
>
> > --- a/drivers/firmware/efi/libstub/loongarch.c
> > +++ b/drivers/firmware/efi/libstub/loongarch.c
> > @@ -10,7 +10,7 @@
> >   #include "efistub.h"
> >   #include "loongarch-stub.h"
> >
> > -typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdl=
ine,
> > +typedef void (*kernel_entry_t)(bool efi, unsigned long cmdline,
> >                                            unsigned long systab);
> >
> >   efi_status_t check_platform_features(void)
> > @@ -81,4 +81,6 @@
> >
> >          real_kernel_entry(true, (unsigned long)cmdline_ptr,
> >                            (unsigned long)efi_system_table);
> > +
> > +       return EFI_LOAD_ERROR;
> >   }
>
> I tested the above changes, the falls through objtool warning can
> be fixed because efi_boot_kernel() ends with a return instruction,
> I think this is reasonable.
>
> efi_boot_kernel() has a return value, there are "return status" in
> other parts of efi_boot_kernel(), it should also return at the end
> of efi_boot_kernel() in theory, although we should never get here.
>
> If there are more comments, please let me know.
I still don't want LoongArch to be a special case, which means
efi_boot_kernel() in fdt.c, jump_kernel_func in riscv.c and
enter_kernel in arm64.c should also be modified.

Huacai

>
> Thanks,
> Tiezhu
>

