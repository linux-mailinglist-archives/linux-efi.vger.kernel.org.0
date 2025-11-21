Return-Path: <linux-efi+bounces-5637-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78986C7A4EF
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 15:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D5BD4F0BE9
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3E34F24E;
	Fri, 21 Nov 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWSFHcys"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8239B34EF1C
	for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735811; cv=none; b=akHRZC3T1A738VowHmKihxbHFlR4GrxqxkaYiBm4pZlvrUohSDu54++7+wnJseeo9NDgvHFcUwB3Fs8YYSU2KpEnfYn7joPKNXD0gVzdq+haGd2G5fRZBcnNSUORam3FOO7ol+j1SMH/sDw2UHdhtAFHiOftPhcWVoztGQEzcsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735811; c=relaxed/simple;
	bh=SmBuQ9/3jkzBF6e+X6HfAqHhQQeAfwauHNiCwCHezeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLePws7c84hY4Q+jPBH5/k63ClCot9Xmxvdd6ADNn5nRLq49savQMsJXZktGm9Nb6VOWeKUtN9UBIr/lIbc1uZteJXYSIHzja45kFQ34Jq/yDczqXSMOQabUu8Xy5NJbTgcWYYtWGAQN9cg/G1Mw4L8DYgQPLWGsWTtD8eE2tnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWSFHcys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397F5C19423
	for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 14:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763735811;
	bh=SmBuQ9/3jkzBF6e+X6HfAqHhQQeAfwauHNiCwCHezeU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hWSFHcysSdwZQUrKk+WqnHZKql8r4fws5zm+ngQOYlYGCd+lEP9qJWgKe+itDkptd
	 dQykKBD0J6RuNCeyAZBQ9DIuPET5rjB2B31vmzxOf1Fh5/8fkyBGbdNb45kjn6UBZL
	 9CHkPCiTNfG3GPecygJfoQ1JIS++/JIerWIyKnHuhw6c9oUDxG5dc/zqOBbJNm6t17
	 T1S+QVYU81Ydq9o2/b38VgYADoJ43W2LSaQQnKcHbcCfLgE2kQzAJ/iwrT1OMXyTX6
	 GdCeuvzJiqRKWvv3aNDBXImbCSRXGbZf33YBIAckFfEsfBBn/SeSIA2UNJjlB/ClH4
	 q5oTM34g4RCvg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7277324204so361942166b.0
        for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 06:36:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUs95/TkLiEuuI2VivOjLBcQ2W3kJQ2peHyCgVQR1Iu6Z7qhb3uOwTpQMajBmAC0MR2UyEMN3SxkMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ+kCbrawF7taNqQsb1oCD+yhFLtXYOlFdhnrN6GMnmbvLXRjt
	k2HH6sznJr9ujcGRXUDuGGRDAUM/fseVvgLtfDQN1sQ3AsiTFT0OpceVj6TQ+iAib1kRDr0P2w1
	lxRuyebx6iGwe9iwhuQWq/2b3EbgV2uM=
X-Google-Smtp-Source: AGHT+IF99ZcOKZxwHhj61TbMLuNJeoS2wkCa3w0U0FmKNTTd0uxPqztc32MWgNrKH3nOf/+gpJAsTUn3W2sc9TU7vnU=
X-Received: by 2002:a17:907:7286:b0:b71:ea7c:e509 with SMTP id
 a640c23a62f3a-b767173189bmr313742466b.41.1763735809607; Fri, 21 Nov 2025
 06:36:49 -0800 (PST)
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
 <CAAhV-H47fzaKcMhgLWWOTxB+srBsg85-eK0LW1vQXQnvq32-+w@mail.gmail.com> <aRsH7RTpAah4g5Xr@willie-the-truck>
In-Reply-To: <aRsH7RTpAah4g5Xr@willie-the-truck>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 21 Nov 2025 22:36:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4AasfFet_Gi_mVyte3RPMH3qBS73dBfF-=Gd7HJ6ZPEw@mail.gmail.com>
X-Gm-Features: AWmQ_bmzF-PBbbGb1pyM-7ojfFGXsdzHVd24-gNLEumxbI6shCwp2NX04xLwnRw
Message-ID: <CAAhV-H4AasfFet_Gi_mVyte3RPMH3qBS73dBfF-=Gd7HJ6ZPEw@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Will Deacon <will@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Ard Biesheuvel <ardb@kernel.org>, loongarch@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 7:33=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Sat, Nov 15, 2025 at 11:16:42AM +0800, Huacai Chen wrote:
> > On Wed, Nov 12, 2025 at 2:00=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel=
.org> wrote:
> > >
> > > On Mon, Nov 10, 2025 at 03:00:00PM +0800, Huacai Chen wrote:
> > > > On Mon, Nov 10, 2025 at 9:19=E2=80=AFAM Tiezhu Yang <yangtiezhu@loo=
ngson.cn> wrote:
> > > > > If I understand correctly, I should modify this patch to remove t=
he
> > > > > changes of arm and riscv for now, do the changes only when there =
is
> > > > > a real problem or requirement some day, right? If no more comment=
s,
> > > > > I will send v3 later.
> > > >
> > > > Now everyone involved agrees that the efistub code is correct, so t=
he
> > > > proper solution is to fix the compiler.
> > >
> > > Hm?  I don't see how it's a compiler bug.  It's really just an objtoo=
l
> > > limitation.
> > >
> > > > Changing efistub code and changing objtool (ignore __efistub prefix=
)
> > > > are both workarounds, but I think changing objtool is a little more
> > > > reasonable. Maybe Josh has different ideas?
> > >
> > > I thought the conversation had converged on what Tiezhu mentioned abo=
ve,
> > > which is to skip objtool on libstub for loongarch, but leave the othe=
r
> > > arches alone.  That way objtool behavior is consistent between loonga=
rch
> > > and x86, and objtool doesn't need to ignore any prefixes.
> > >
> > > So basically, the v2 patch minus the arm64/riscv changes.
> >
> > Hi, ARM64 and RISC-V maintainers,
> >
> > Would you mind that this patch modifies the three architectures
> > together (they are exactly the same style now)?
> >
> > Madhavan is the author of ARM64's objtool, I think your opinion is
> > also very important.
>
> arm64 doesn't (yet) use objtool.
>
> I defer to Ard on anything relating to the arm64 efistub. Reading the
> start of this thread, it doesn't look like he's convinced and I'm not
> surprised if it's purely an issue with objtool.
OK, I know, but I have a concern.

Ard said that he is reluctant to make changes to accommodate a flawed
build time tool and there may be regression risk.

So, I'm also reluctant and don't want LoongArch to meet regression
risk. If one day LoongArch has a regression, we probably need another
workaround to "fix" this workaround. But if these three architectures
change in the same way, we may have a chance to solve some fundamental
problems...

Huacai

>
> Will

