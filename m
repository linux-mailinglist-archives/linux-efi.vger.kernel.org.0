Return-Path: <linux-efi+bounces-5034-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEE1BD35B1
	for <lists+linux-efi@lfdr.de>; Mon, 13 Oct 2025 16:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40ED0189D676
	for <lists+linux-efi@lfdr.de>; Mon, 13 Oct 2025 14:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EBB255240;
	Mon, 13 Oct 2025 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW9BBm+R"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0F2550AD
	for <linux-efi@vger.kernel.org>; Mon, 13 Oct 2025 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364578; cv=none; b=FLK3cii0WTLTUUjnX5+C2cPNURLPA+F6y8SdYDqNMVRzlfTGyM852P6gSdBPs107CfY89gn/N66X8DTzM2rx/5qLaZS/EG4zeDJxlkSst0taJ+3X2qrDjKGsK33VkslbV2FWHV18xe//jwj1KOamyNgOXEnLLSjd8oEtm1Cw0B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364578; c=relaxed/simple;
	bh=z15tpTrBW83KAZNHEtZD1R+Eafynq/cwxlwzlacByEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAOqR4dpfLv/Q8PUZrA90Zk1PEXl+4w5m9ANmmBbI/FSS7itrkiU1TU2ACZi+pMaf4scySD4m413sy72KQDKM63ezDQZg1qteAVl7bchXXpINESI0k68QZ0dNT4mL8hDDu+xD3GCRYPjc9nZYI2CbX36f4LRxvP7KiBsMcnIZ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW9BBm+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FD9C116D0
	for <linux-efi@vger.kernel.org>; Mon, 13 Oct 2025 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760364578;
	bh=z15tpTrBW83KAZNHEtZD1R+Eafynq/cwxlwzlacByEA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZW9BBm+RDZVXSC16M5XPZ1SNTDzkAinZVNEEu1scGxpHEzH0Ihz6imSnyg6O6CuTe
	 WkMZ+A5OesyoAhmCOsp78i/7axOWTRRoZqTpUEm6odKL3eYMJotEi3nGKygqklmUI7
	 hAlN5zB9tQEoBW5SL10UuMKf8c42Vgo4tn9b0Kh+7LrDSU48VnuxEyBW3TKwuKT8eI
	 YsPaN3bFdZ6ZvOUnhNnnGY2MQAN48TP9rOmcSMGNxfpkJOlJ8u+aqC/niIvJwsw7RT
	 yCTUe40+mst5BRbJmF1wZ0+oeUxnZ3wQbIpPGBVcBf45/5sdLo5F35/4rjNmH3JObR
	 ltyx7mJvcnRBA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63a10267219so1298310a12.0
        for <linux-efi@vger.kernel.org>; Mon, 13 Oct 2025 07:09:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWwGJgOvoGpRBPmjyNJu8TJ1POQdvkblwxtovPpXJfpVcF5hfnMq281Ny12+BAFVAW7AuOgbATGNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqxchksbN3fTL4U1rWXd2ASahO4H65Mq30grXwbG2xqEuS7w5q
	44Y213s5PdUtT/XNBgSRlexL8RFzGuWfL1o4bGSLpXPb7TG2FS2sWNW4tgkctNoH6yQCADRxt9w
	TN9UnrQQpBiKkvi4VO0cetYbK+Fei54I=
X-Google-Smtp-Source: AGHT+IGIKmx1BchY0pXNFGB9InPUsy11nkEwRUNkdw0dz8PMMYgsxJ499uv1kM2Bm0HVTHpzS82ofc5CbUu9I//1Cng=
X-Received: by 2002:aa7:d785:0:b0:633:14bb:dcb1 with SMTP id
 4fb4d7f45d1cf-639bb13500dmr18155251a12.11.1760364576745; Mon, 13 Oct 2025
 07:09:36 -0700 (PDT)
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
 <CAMj1kXH-rK0bRyHXdJ-crAyMyvJHApH0WR7_8Qd8vrSPBLK+yg@mail.gmail.com>
 <0c9b8e6a-96a6-91d4-946f-2109f48a529b@loongson.cn> <CAAhV-H41m96fvEWG5NqAE=tykPjyzt=50CseJDeCqdG-c_WMrQ@mail.gmail.com>
 <CAMj1kXEs5=VRi_rJwgHUrQWos-27PBbr3c4fYnmkV8Ahi8HZgw@mail.gmail.com>
 <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com> <CAMj1kXGvSnCMRVCW7eAxgLRWMEV3QRj3Dqg3PmZchZJNpnLK9w@mail.gmail.com>
In-Reply-To: <CAMj1kXGvSnCMRVCW7eAxgLRWMEV3QRj3Dqg3PmZchZJNpnLK9w@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 13 Oct 2025 22:09:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4UKdso0BokAqvjYeBLr-jbjFAaQX4z=1ztpBamqrOEEg@mail.gmail.com>
X-Gm-Features: AS18NWB3mSCepPt1etTJs4X35a5tkxvZPNilre683PYaU3Xj0J0E-YjIBVuCFt4
Message-ID: <CAAhV-H4UKdso0BokAqvjYeBLr-jbjFAaQX4z=1ztpBamqrOEEg@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 11:59=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Sat, 11 Oct 2025 at 08:01, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > On Sat, Oct 11, 2025 at 10:48=E2=80=AFPM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> > >
> > > On Sat, 11 Oct 2025 at 00:43, Huacai Chen <chenhuacai@kernel.org> wro=
te:
> > > >
> > > > On Sat, Oct 11, 2025 at 3:29=E2=80=AFPM Tiezhu Yang <yangtiezhu@loo=
ngson.cn> wrote:
> > > > >
> > > > > On 2025/10/11 =E4=B8=8A=E5=8D=8811:40, Ard Biesheuvel wrote:
> > > > > > On Fri, 10 Oct 2025 at 19:54, Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> > > > > >>
> > > > > >> On Sat, Oct 11, 2025 at 9:13=E2=80=AFAM Tiezhu Yang <yangtiezh=
u@loongson.cn> wrote:
> > > > > >>>
> > > > > >>> On 2025/10/11 =E4=B8=8A=E5=8D=8812:25, Ard Biesheuvel wrote:
> > > > > >>> ...
> > > > > >>>> Why do we need both (1) and (2)?
> > > > > >>>
> > > > > >>> Not both, either (1) or (2).
> > > > > >>> Which one do you prefer? Or any other suggestions?
> > > > > >>>
> > > > > >>> Taking all of the considerations in balance, we should decide
> > > > > >>> what is the proper way.
> > > > > >> As a summary, there are three methods:
> > > > > >> (1) Only link libstub with vmlinux.o during the final vmlinux =
link.
> > > > > >> (2) Remove the attribute __noreturn for real_kernel_entry() an=
d add while (1).
> > > > > >> (3) Ignore "__efistub_" prefix in objtool.
> > > > > >>
> > > > > >> Josh prefers method (1), I prefer method (3) but also accept m=
ethod
> > > > > >> (1) if it is not only specific to loongarch.
> > > > > >>
> > > > > >
> > > > > > This is a false positive warning in objtool, which complains ab=
out a
> > > > > > function that falls through, even though that can never happen =
in
> > > > > > reality.
> > > > > >
> > > > > > To me, it is not acceptable to modify how vmlinux.o is construc=
ted
> > > > > > also for other architectures, in order to hide some of its cons=
tituent
> > > > > > parts from objtool, which do not use objtool to begin with.
> > > > > >
> > > > > >
> > > > > > If you are not willing to fix objtool, I suggest fixing the loo=
ngarch
> > > > > > code like this:
> > > > >
> > > > > Thank you.
> > > > >
> > > > > > --- a/drivers/firmware/efi/libstub/loongarch.c
> > > > > > +++ b/drivers/firmware/efi/libstub/loongarch.c
> > > > > > @@ -10,7 +10,7 @@
> > > > > >   #include "efistub.h"
> > > > > >   #include "loongarch-stub.h"
> > > > > >
> > > > > > -typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned l=
ong cmdline,
> > > > > > +typedef void (*kernel_entry_t)(bool efi, unsigned long cmdline=
,
> > > > > >                                            unsigned long systab=
);
> > > > > >
> > > > > >   efi_status_t check_platform_features(void)
> > > > > > @@ -81,4 +81,6 @@
> > > > > >
> > > > > >          real_kernel_entry(true, (unsigned long)cmdline_ptr,
> > > > > >                            (unsigned long)efi_system_table);
> > > > > > +
> > > > > > +       return EFI_LOAD_ERROR;
> > > > > >   }
> > > > >
> > > > > I tested the above changes, the falls through objtool warning can
> > > > > be fixed because efi_boot_kernel() ends with a return instruction=
,
> > > > > I think this is reasonable.
> > > > >
> > > > > efi_boot_kernel() has a return value, there are "return status" i=
n
> > > > > other parts of efi_boot_kernel(), it should also return at the en=
d
> > > > > of efi_boot_kernel() in theory, although we should never get here=
.
> > > > >
> > > > > If there are more comments, please let me know.
> > > > I still don't want LoongArch to be a special case, which means
> > > > efi_boot_kernel() in fdt.c, jump_kernel_func in riscv.c and
> > > > enter_kernel in arm64.c should also be modified.
> > > >
> > >
> > > You have made LoongArch a special case by adding objtool support,
> > > which  arm64 and RISC-V do not have.
> > >
> > > So NAK to changing arm64 and RISC-V as well.
> > Hmmm, I want to know whether this problem is an objtool issue or an
> > efistub issue in essence. If it is an objtool issue, we should fix
> > objtool and don't touch efistub. If it is an efistub issue, then we
> > should modify efistub (but not specific to LoongArch, when RISC-V and
> > ARM64 add objtool they will meet the same issue).
> >
>
> It is an objtool issue in essence.
>
> The generated code looks like this
>
> 9000000001743080: ff b7 fe 57   bl      -332 <__efistub_kernel_entry_addr=
ess>
> 9000000001743084: 26 03 c0 28   ld.d    $a2, $s2, 0
> 9000000001743088: 87 00 15 00   move    $a3, $a0
> 900000000174308c: 04 04 80 03   ori     $a0, $zero, 1
> 9000000001743090: c5 02 15 00   move    $a1, $fp
> 9000000001743094: e1 00 00 4c   jirl    $ra, $a3, 0
>
> 9000000001743098 <__efistub_exit_boot_func>:
> 9000000001743098: 63 c0 ff 02   addi.d  $sp, $sp, -16
>
> There is nothing wrong with this code, given that the indirect call is
> to a __noreturn function, and so the fact that it falls through into
> __efistub_exit_boot_func() is not a problem.
>
> Even though the compiler does nothing wrong here, it would be nice if
> it would emit some kind of UD or BRK instruction after such a call, if
> only to make the backtrace more reliable. But the code is fine, and
> objtool simply does not have the information it needs to determine
> that the indirect call is of a variety that never returns.
So the best way is to fix the objtool?

>
> So I don't mind fixing it in the code, but only for LoongArch, given
> that the problem does not exist on arm64 or RISC-V.
You believe this problem won't exist even if they add objtool support
(because their objtool will be sane)?


Huacai

