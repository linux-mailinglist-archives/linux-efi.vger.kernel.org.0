Return-Path: <linux-efi+bounces-5035-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B23BFBD3AFB
	for <lists+linux-efi@lfdr.de>; Mon, 13 Oct 2025 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 752C14F3A6C
	for <lists+linux-efi@lfdr.de>; Mon, 13 Oct 2025 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95EF2F60D5;
	Mon, 13 Oct 2025 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kukn3Z9N"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3487272801
	for <linux-efi@vger.kernel.org>; Mon, 13 Oct 2025 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366222; cv=none; b=seaQ1Prm6BA9P3ey3VcnWc39D/6zwef0ZsBq51BHkMjXQ1ldQ0CyoWNQHp0eD3shSAB0YLrdhPxBgrQhpUwur1MLerrCr7t8wOUzPbyjZWZzAxgs5CrEoTVzpgRaCJ/uRWcVKRsmYQWSYVUOs86sQfxC4rcJ2miWgB8tk8kPBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366222; c=relaxed/simple;
	bh=PYNJouYZOnK80Bm/nJhe6SqANkwVgSKIenFusl8KFig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3+QB4IG+Tbdtjge7P7tz9tNi3jL+6rwKjuMmsIxcU/YYyoirexIZFUCr1SFvjeOWi4Kd/htuojDN4gB1+uuwlYNG+b8L7f+mHbNYixUb6DdRWZCx/GkTrdfIBSdOYdJVzr4WVT2Km1Jl0hQRte+PrBVho2pBd3m1OvSUgV1ZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kukn3Z9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644F7C19421
	for <linux-efi@vger.kernel.org>; Mon, 13 Oct 2025 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760366222;
	bh=PYNJouYZOnK80Bm/nJhe6SqANkwVgSKIenFusl8KFig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kukn3Z9Nzn2a5qoTTWwJ/2BFDGKq6Hd6Tyj77mRtqIMsChRoV1cxnS/z77xrFAS9k
	 cy1DZbQFvPz+hBnECAVPg3R1xpsKtHqdJma1tUnQTElIHCBJsyUpX863yzITiXff8r
	 lpeDt7yn8JTEw8cyTK9DA11L+pfaC5PtKGiLf2fuYEnZO8WtaLR+bXkKoTtCduyn/G
	 U1eK1K/+BayvVHa4olVwlsDCDIRO3/Xp1ZoKj1RihdUp8oGunNXC3he2yXtcQxyj9Q
	 zP1Yvvy/Td63mI2NJ+oO8kIfaltgxJlP+V5ZYAUHVJGn/usPYFHB+/lH7fUIoF3ZIC
	 cV2yUCSycTDfQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57992ba129eso5353154e87.3
        for <linux-efi@vger.kernel.org>; Mon, 13 Oct 2025 07:37:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqFqqIvCak5dCNN0AkdH0fKW7VOztDx/88AVIdGiT1GDZtgFxhP7HvPJK0HMOYB+8MjIvseoMko98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsVpxjjql/V/MKBqZE0D1rznhp5EqrcszHcbWHKkAH9Y1oxZzI
	J1wKjt42PjckjdBhK7u+xHXi/2M+SmE4Uk9I2BfllCy0wYbsRE7V1/JBAp0oBPy2ZEuWCDO0sqF
	ukQqQzgytKquzqHWWVh0qPIP6kEOYLIw=
X-Google-Smtp-Source: AGHT+IGEEOZ9VfTQ6ngkF8TFWCWZsUsks3HYpMtK+pRGdVEaBkbYcmJuOavvMnwfEbP13CKVvY+U//cKRiULxIVuvpc=
X-Received: by 2002:a05:6512:3d23:b0:58b:189:871e with SMTP id
 2adb3069b0e04-5906dc12463mr5914777e87.3.1760366220623; Mon, 13 Oct 2025
 07:37:00 -0700 (PDT)
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
 <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com>
 <CAMj1kXGvSnCMRVCW7eAxgLRWMEV3QRj3Dqg3PmZchZJNpnLK9w@mail.gmail.com> <CAAhV-H4UKdso0BokAqvjYeBLr-jbjFAaQX4z=1ztpBamqrOEEg@mail.gmail.com>
In-Reply-To: <CAAhV-H4UKdso0BokAqvjYeBLr-jbjFAaQX4z=1ztpBamqrOEEg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 13 Oct 2025 16:36:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEXDC_oq4aWbkR5dqYBix2d1xJEdaj-v747e1nOA0Q_Yg@mail.gmail.com>
X-Gm-Features: AS18NWAv9gA3fJmZoOCeAqGMe6vicknpLFzEFxHn_UczaDtdwwo0A8kcuivI9jM
Message-ID: <CAMj1kXEXDC_oq4aWbkR5dqYBix2d1xJEdaj-v747e1nOA0Q_Yg@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Oct 2025 at 16:09, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> On Sat, Oct 11, 2025 at 11:59=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> >
> > On Sat, 11 Oct 2025 at 08:01, Huacai Chen <chenhuacai@kernel.org> wrote=
:
> > >
> > > On Sat, Oct 11, 2025 at 10:48=E2=80=AFPM Ard Biesheuvel <ardb@kernel.=
org> wrote:
> > > >
> > > > On Sat, 11 Oct 2025 at 00:43, Huacai Chen <chenhuacai@kernel.org> w=
rote:
> > > > >
> > > > > On Sat, Oct 11, 2025 at 3:29=E2=80=AFPM Tiezhu Yang <yangtiezhu@l=
oongson.cn> wrote:
> > > > > >
> > > > > > On 2025/10/11 =E4=B8=8A=E5=8D=8811:40, Ard Biesheuvel wrote:
> > > > > > > On Fri, 10 Oct 2025 at 19:54, Huacai Chen <chenhuacai@kernel.=
org> wrote:
> > > > > > >>
> > > > > > >> On Sat, Oct 11, 2025 at 9:13=E2=80=AFAM Tiezhu Yang <yangtie=
zhu@loongson.cn> wrote:
> > > > > > >>>
> > > > > > >>> On 2025/10/11 =E4=B8=8A=E5=8D=8812:25, Ard Biesheuvel wrote=
:
> > > > > > >>> ...
> > > > > > >>>> Why do we need both (1) and (2)?
> > > > > > >>>
> > > > > > >>> Not both, either (1) or (2).
> > > > > > >>> Which one do you prefer? Or any other suggestions?
> > > > > > >>>
> > > > > > >>> Taking all of the considerations in balance, we should deci=
de
> > > > > > >>> what is the proper way.
> > > > > > >> As a summary, there are three methods:
> > > > > > >> (1) Only link libstub with vmlinux.o during the final vmlinu=
x link.
> > > > > > >> (2) Remove the attribute __noreturn for real_kernel_entry() =
and add while (1).
> > > > > > >> (3) Ignore "__efistub_" prefix in objtool.
> > > > > > >>
> > > > > > >> Josh prefers method (1), I prefer method (3) but also accept=
 method
> > > > > > >> (1) if it is not only specific to loongarch.
> > > > > > >>
> > > > > > >
> > > > > > > This is a false positive warning in objtool, which complains =
about a
> > > > > > > function that falls through, even though that can never happe=
n in
> > > > > > > reality.
> > > > > > >
> > > > > > > To me, it is not acceptable to modify how vmlinux.o is constr=
ucted
> > > > > > > also for other architectures, in order to hide some of its co=
nstituent
> > > > > > > parts from objtool, which do not use objtool to begin with.
> > > > > > >
> > > > > > >
> > > > > > > If you are not willing to fix objtool, I suggest fixing the l=
oongarch
> > > > > > > code like this:
> > > > > >
> > > > > > Thank you.
> > > > > >
> > > > > > > --- a/drivers/firmware/efi/libstub/loongarch.c
> > > > > > > +++ b/drivers/firmware/efi/libstub/loongarch.c
> > > > > > > @@ -10,7 +10,7 @@
> > > > > > >   #include "efistub.h"
> > > > > > >   #include "loongarch-stub.h"
> > > > > > >
> > > > > > > -typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned=
 long cmdline,
> > > > > > > +typedef void (*kernel_entry_t)(bool efi, unsigned long cmdli=
ne,
> > > > > > >                                            unsigned long syst=
ab);
> > > > > > >
> > > > > > >   efi_status_t check_platform_features(void)
> > > > > > > @@ -81,4 +81,6 @@
> > > > > > >
> > > > > > >          real_kernel_entry(true, (unsigned long)cmdline_ptr,
> > > > > > >                            (unsigned long)efi_system_table);
> > > > > > > +
> > > > > > > +       return EFI_LOAD_ERROR;
> > > > > > >   }
> > > > > >
> > > > > > I tested the above changes, the falls through objtool warning c=
an
> > > > > > be fixed because efi_boot_kernel() ends with a return instructi=
on,
> > > > > > I think this is reasonable.
> > > > > >
> > > > > > efi_boot_kernel() has a return value, there are "return status"=
 in
> > > > > > other parts of efi_boot_kernel(), it should also return at the =
end
> > > > > > of efi_boot_kernel() in theory, although we should never get he=
re.
> > > > > >
> > > > > > If there are more comments, please let me know.
> > > > > I still don't want LoongArch to be a special case, which means
> > > > > efi_boot_kernel() in fdt.c, jump_kernel_func in riscv.c and
> > > > > enter_kernel in arm64.c should also be modified.
> > > > >
> > > >
> > > > You have made LoongArch a special case by adding objtool support,
> > > > which  arm64 and RISC-V do not have.
> > > >
> > > > So NAK to changing arm64 and RISC-V as well.
> > > Hmmm, I want to know whether this problem is an objtool issue or an
> > > efistub issue in essence. If it is an objtool issue, we should fix
> > > objtool and don't touch efistub. If it is an efistub issue, then we
> > > should modify efistub (but not specific to LoongArch, when RISC-V and
> > > ARM64 add objtool they will meet the same issue).
> > >
> >
> > It is an objtool issue in essence.
> >
> > The generated code looks like this
> >
> > 9000000001743080: ff b7 fe 57   bl      -332 <__efistub_kernel_entry_ad=
dress>
> > 9000000001743084: 26 03 c0 28   ld.d    $a2, $s2, 0
> > 9000000001743088: 87 00 15 00   move    $a3, $a0
> > 900000000174308c: 04 04 80 03   ori     $a0, $zero, 1
> > 9000000001743090: c5 02 15 00   move    $a1, $fp
> > 9000000001743094: e1 00 00 4c   jirl    $ra, $a3, 0
> >
> > 9000000001743098 <__efistub_exit_boot_func>:
> > 9000000001743098: 63 c0 ff 02   addi.d  $sp, $sp, -16
> >
> > There is nothing wrong with this code, given that the indirect call is
> > to a __noreturn function, and so the fact that it falls through into
> > __efistub_exit_boot_func() is not a problem.
> >
> > Even though the compiler does nothing wrong here, it would be nice if
> > it would emit some kind of UD or BRK instruction after such a call, if
> > only to make the backtrace more reliable. But the code is fine, and
> > objtool simply does not have the information it needs to determine
> > that the indirect call is of a variety that never returns.
> So the best way is to fix the objtool?
>

I think the best solution is to fix the compiler, and ensure that call
instructions are always followed by some undefined or debug/break
opcode. This works around this problem, but it also ensures that the
return address does not point to the wrong function, which may cause
confusion in backtraces.


> >
> > So I don't mind fixing it in the code, but only for LoongArch, given
> > that the problem does not exist on arm64 or RISC-V.
> You believe this problem won't exist even if they add objtool support
> (because their objtool will be sane)?
>

It depends on the compiler.

