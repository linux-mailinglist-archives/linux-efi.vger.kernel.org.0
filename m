Return-Path: <linux-efi+bounces-5657-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B4EC7DACA
	for <lists+linux-efi@lfdr.de>; Sun, 23 Nov 2025 03:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7A83AACB3
	for <lists+linux-efi@lfdr.de>; Sun, 23 Nov 2025 02:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25AF1DF24F;
	Sun, 23 Nov 2025 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSkynLBV"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4BC1A9F9B
	for <linux-efi@vger.kernel.org>; Sun, 23 Nov 2025 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763864941; cv=none; b=RayNXol2ij+XTjgnRCYwTAnSLUFi4RLM8UkexGfOFmVcFxUMbfpCbmpn6k7SL4acmUcaRjlA7L09fDH3GAnT1N1JYsSY0P3XQ3JEXemh0gzwSdQmbhRA6MgQPOQFKbNdWz2nuNekzkj+9DYHaVAuAFrwk0nbPBfPD1UwciYpkwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763864941; c=relaxed/simple;
	bh=5/gE9+3vHOoB1f8yml6mnDnZO5OsQRxggIUPttmfMEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRd6kMVIGn3pq18CTbIN4wmXGGQhmZKtFTfats3ypy+sYeBBzzWnWffa/sZGcbWylGH0ZhDNekrjoXDA0ar1c5Vkubw7RLoNM8t15++WoRaOwVxizPJh3dbAS8nVitDJ01zeDx89pgyb715IdiAnCofo56vhFDjxkPge8lRKAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSkynLBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B2EC4CEF5
	for <linux-efi@vger.kernel.org>; Sun, 23 Nov 2025 02:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763864941;
	bh=5/gE9+3vHOoB1f8yml6mnDnZO5OsQRxggIUPttmfMEI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lSkynLBVL7qbBWmP7VIrRx09zE8Ng0gBmoadl+PInPMq+4lFWJmeMmAgdjGxGV9Q4
	 nMmQsSLfPGz283G1TBASqmUaA0hSUvc7EuBSpcxU2UzLEW2mvUpAhkP26dcAcwu0C1
	 bFOYmIVd/0XCG4sQbdwGEywoIYs4WXHc6eHigLBK/MFXyBCSIhfmHU4SKMnb3PW03p
	 VC1UGiJ7B5n0YlLVsgWG6v3Wf5fSoRR0MvHnIKxmC+rxkO6N6LdLBck0MU0MuNzlJo
	 y2F0FO4XTTyBGU+G7dFmuiEOrFBgptYD0gG9hMFRjg93a/mlLse1zNSvIY0mYYjpDQ
	 B3+DHfCj797ww==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b737502f77bso458161966b.2
        for <linux-efi@vger.kernel.org>; Sat, 22 Nov 2025 18:29:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0lidYkixUENttNSydUK8ltuPawldQLB00YwYIunKeQOz3ODBJO5cR2RO8j5aBFOlc0KJs34u7RmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/uUW23ymZ6cc6ad+jxE1DsuCfI3/rWLaIQ7t68OH4xPCQ8ypo
	UziCP6AxCom3khLP0P/Eq3+sbuVzQnCce+mmdVLFSYODRbJxNoNxtzZA1QO/UzS9zXX7WXYFO55
	22gXV0H6oGZhI4D36JG2sJRvcSeIr32g=
X-Google-Smtp-Source: AGHT+IF2NG45CGhewRb+YxxwCpQ+Qs09Wv1Cd6UcCR2RSlep4aU6EwJEltWefiEmVuOu3WrO2PpFhIzvWqq/mYqO3k4=
X-Received: by 2002:a17:907:7f1e:b0:b70:b077:b957 with SMTP id
 a640c23a62f3a-b767158cd7amr622544566b.15.1763864939736; Sat, 22 Nov 2025
 18:28:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhV-H6m5vszCyiF3qi94cpHBPVuqM2xH93D=gfsQqOSYvC-sA@mail.gmail.com>
 <33612d85-e70b-26da-8460-ea6b9064ce08@loongson.cn> <CAAhV-H5ZSTFDxvm-W1CrgEoQ5d_jw5yVsfetQ_J_qL5pqLtzgg@mail.gmail.com>
 <CAMj1kXGk0udgM67wrWqahqK8H0uE8emQj51SmJey+7fE-FTjdA@mail.gmail.com>
 <CAAhV-H4c=vdNWO0v_mYL2xZ9FYjDyRDvt6f_kV4d8Bh=CRJniQ@mail.gmail.com>
 <CAMj1kXEaxxcWTTANWeEMNjYDymdL5Fxy2B=XBF4RGtteEkfinw@mail.gmail.com>
 <421c08e1-255b-447b-b5e3-ee6544fbefd2@loongson.cn> <CAAhV-H5KsFShDJ_Cxu+1_ces8oojn8+S-7PLmE7aUj8gX5_GEw@mail.gmail.com>
 <32s3lvzfu6jkyho7qenrqbsm5wkgjnzn2imdp6tfwycmyxpzgu@kg5367uxmxii>
 <CAAhV-H47fzaKcMhgLWWOTxB+srBsg85-eK0LW1vQXQnvq32-+w@mail.gmail.com>
 <aRsH7RTpAah4g5Xr@willie-the-truck> <CAAhV-H4AasfFet_Gi_mVyte3RPMH3qBS73dBfF-=Gd7HJ6ZPEw@mail.gmail.com>
 <39617a3e-c476-abac-8425-bbcece769cdb@loongson.cn>
In-Reply-To: <39617a3e-c476-abac-8425-bbcece769cdb@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 23 Nov 2025 10:29:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4fHBuRpDEDQrExApgnREJaT8JWUJ2700bEPFxDqToi2w@mail.gmail.com>
X-Gm-Features: AWmQ_bmAZrJIPzwBoGQGazI9CFQ9PH-O_LgSCm_k_cIQ90BdG2Wz9hDhqi3Uewg
Message-ID: <CAAhV-H4fHBuRpDEDQrExApgnREJaT8JWUJ2700bEPFxDqToi2w@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>, Ard Biesheuvel <ardb@kernel.org>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 7:04=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Cc: Nathan Chancellor <nathan@kernel.org>
>
> Hi all,
>
> On 11/21/25 22:36, Huacai Chen wrote:
> > On Mon, Nov 17, 2025 at 7:33=E2=80=AFPM Will Deacon <will@kernel.org> w=
rote:
> >>
> >> On Sat, Nov 15, 2025 at 11:16:42AM +0800, Huacai Chen wrote:
> >>> On Wed, Nov 12, 2025 at 2:00=E2=80=AFAM Josh Poimboeuf <jpoimboe@kern=
el.org> wrote:
> >>>>
> >>>> On Mon, Nov 10, 2025 at 03:00:00PM +0800, Huacai Chen wrote:
> >>>>> On Mon, Nov 10, 2025 at 9:19=E2=80=AFAM Tiezhu Yang <yangtiezhu@loo=
ngson.cn> wrote:
> >>>>>> If I understand correctly, I should modify this patch to remove th=
e
> >>>>>> changes of arm and riscv for now, do the changes only when there i=
s
> >>>>>> a real problem or requirement some day, right? If no more comments=
,
> >>>>>> I will send v3 later.
> >>>>>
> >>>>> Now everyone involved agrees that the efistub code is correct, so t=
he
> >>>>> proper solution is to fix the compiler.
> >>>>
> >>>> Hm?  I don't see how it's a compiler bug.  It's really just an objto=
ol
> >>>> limitation.
> >>>>
> >>>>> Changing efistub code and changing objtool (ignore __efistub prefix=
)
> >>>>> are both workarounds, but I think changing objtool is a little more
> >>>>> reasonable. Maybe Josh has different ideas?
> >>>>
> >>>> I thought the conversation had converged on what Tiezhu mentioned ab=
ove,
> >>>> which is to skip objtool on libstub for loongarch, but leave the oth=
er
> >>>> arches alone.  That way objtool behavior is consistent between loong=
arch
> >>>> and x86, and objtool doesn't need to ignore any prefixes.
> >>>>
> >>>> So basically, the v2 patch minus the arm64/riscv changes.
> >>>
> >>> Hi, ARM64 and RISC-V maintainers,
> >>>
> >>> Would you mind that this patch modifies the three architectures
> >>> together (they are exactly the same style now)?
> >>>
> >>> Madhavan is the author of ARM64's objtool, I think your opinion is
> >>> also very important.
> >>
> >> arm64 doesn't (yet) use objtool.
> >>
> >> I defer to Ard on anything relating to the arm64 efistub. Reading the
> >> start of this thread, it doesn't look like he's convinced and I'm not
> >> surprised if it's purely an issue with objtool.
> > OK, I know, but I have a concern.
> >
> > Ard said that he is reluctant to make changes to accommodate a flawed
> > build time tool and there may be regression risk.
> >
> > So, I'm also reluctant and don't want LoongArch to meet regression
> > risk. If one day LoongArch has a regression, we probably need another
> > workaround to "fix" this workaround. But if these three architectures
> > change in the same way, we may have a chance to solve some fundamental
> > problems...
>
> IIUC, Josh do not like to ignore these EFISTUB functions in
> validate_branch() of objtool, Huacai do not like to only link
> libstub to vmlinux only for LoongArch.
>
> It seems that there is only one way to fix or workaround this
> problem, remove the attribute __noreturn for real_kernel_entry()
> and then make efi_boot_kernel() ends with a return instruction [1]
> or an unconditional jump instruction [2] that only touches
> drivers/firmware/efi/libstub/loongarch.c.
>
> Since this is a issue only for LoongArch by now, what do you
> think of this minimal change only for LoongArch libstub code?
> Using "return EFI_LOAD_ERROR" [1] or "while (1)" [2]?
>
> Maybe this is the simple and direct way for this special issue
> only on LoongArch so far. If not, any other suggestions?
>
> On the other hand, is it possible to add KBUILD_VMLINUX_LIBS_FINAL
> and then use it only for LoongArch first [3]? Any potential risks?
>
> What is the next step?
Is it possible to improve objtool that can handle indirect __noreturn funct=
ions?
Is it possible to improve objtool that can handle
OBJECT_FILES_NON_STANDARD event LTO is enabled?
Is it possible to improve objtool that only ignore __efistub prefix
for LoongArch?


Huacai

>
> [1]
> https://lore.kernel.org/loongarch/CAMj1kXH-rK0bRyHXdJ-crAyMyvJHApH0WR7_8Q=
d8vrSPBLK+yg@mail.gmail.com/
> [2]
> https://lore.kernel.org/loongarch/20250826064631.9617-2-yangtiezhu@loongs=
on.cn/
> [3] https://lore.kernel.org/loongarch/20251122000101.GA1996391@ax162/
>
> Thanks,
> Tiezhu
>

