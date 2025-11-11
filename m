Return-Path: <linux-efi+bounces-5471-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C39C4F1DF
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 17:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF563AE4E8
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 16:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D60D3730DD;
	Tue, 11 Nov 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiwtCZI/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3809D3019A2
	for <linux-efi@vger.kernel.org>; Tue, 11 Nov 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879789; cv=none; b=e+jhA1YAuZqtfm4iIpg2+j9Du81+jnObe16GO6OgoDFuQ3as9+/+P8fsSn5R3v49caywiZBTg6lAQz/rjHkJ8nVHoZs3RiWMY3sFdW8rq/ZS/UlOtxV77cOrFoH5FC1rlzTSE335jf7qXe6XZYwBZecFrUEJyD6hmO0QtJbHLyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879789; c=relaxed/simple;
	bh=wq1eQ9leJJwsRbg+q/+CeM5Q/J0QheoRni5LdAnm06o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDSO2MwrTJyUjvD9iyS6txAIDnIzxIfGtnl+hNZu4vWzp5T78xtS4+Z8BD9XdcJ3wdBcYp2wJ6+x2i8c709OYotVNRgE6P1hQAM5CjDdw+DDNxXFbs6jSvlZWlFzAvuiXnrSute8LfIGdfUBmEiyikfNKT8621j4+I8IO5oY4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiwtCZI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDA1C19423
	for <linux-efi@vger.kernel.org>; Tue, 11 Nov 2025 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762879789;
	bh=wq1eQ9leJJwsRbg+q/+CeM5Q/J0QheoRni5LdAnm06o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fiwtCZI/RQq4oBC46/xhxQq3J73AlgQ6n72JGFoufSVUBodKPipPpSXecDmCOtlcN
	 l9DmQpbKhP0jUakBR/mK/b175IhYWYq/lC0EpGarLBQLnFG8rVduIR0o4yDDNsffBr
	 rLyNcQrZDDVvXw9ofETH3N5GzZgEzDR4cGR/oLHarLh6SLU1zb7ik+0sPkL7TkrNHF
	 Bjc5JXOCiHW2/JlcBD2hG4TGtDQSELoUQRBpcPZ064efLGTrO6LkEdCSCmYvpMc/sO
	 KYQuxKwFVZcNnzpw1nic3w+p9E/bPzGz5rz25JWvo/qgJbCHjzStzXmVddonm6IxCn
	 2X89RgecCdRQQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-58b025fce96so3709192e87.1
        for <linux-efi@vger.kernel.org>; Tue, 11 Nov 2025 08:49:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZ7Csz/EM+YgtSex/KNzOWTPZBTW3U4pO1Dq/6q8d6ifC0sgvUSSSRXyzRWGOU6w6pDcv+9JYdA24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMa6VYW7u0PmcI/uALmJveorx3blwAcEOvQuaLzluKRE5ujWmn
	3pVNhDxoq7QsxnstO6EaPBEstdSyCxGWx+Rd6DBNqXhOCt3LYCiX/sWxQZZeosm8a1S82XoPHWB
	CHkjgc2HPNg2/1fS438Z2yHuaz6OzA0U=
X-Google-Smtp-Source: AGHT+IGZvHuVSe5iJqYbExFs6eVBWwDag21rIO8Pvby8ZgKm1I1ZyqlWZO+zj9tOa/l1dRnmZWL6TeMz7UocLRGfN6w=
X-Received: by 2002:a05:6512:39cb:b0:594:2f38:4604 with SMTP id
 2adb3069b0e04-5945f1b757emr3766330e87.41.1762879787245; Tue, 11 Nov 2025
 08:49:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com>
 <rhnei6wovxmoqs36wdysomfsul3faxtmgde73wrrqdt3qo3b2j@akd7vzne76rq>
 <CAMj1kXF+hDJy0vRWNgwoijHxvA-scvhGODMj9A3dv19v3jf2yw@mail.gmail.com>
 <lgyzruqczm7uti2lfbhfhr5hyzpnm7wtvgffa2o7nigx76g6i3@wlffltvmhhez>
 <CAMj1kXFDquPxCYSBWgjikS=209pSJ_kth67M0RDeuetV9CPYAw@mail.gmail.com>
 <wlx6pt5crtfdwtop4w5vjznjfarrwitq44wdbufncjdvtsx647@tgobruak66yb>
 <CAMj1kXFfEBkcc-aiwGrRR-pKg4LBbS7weK0pEpZJsKOk5pbkuA@mail.gmail.com>
 <jxfb5a2c2qber623l2gwewirwod54bbgfnvt7t7f3jah2ea33g@2uyhy3auzmpx>
 <d9f3352a-1c1f-464a-a8fd-741cd96b5f8e@loongson.cn> <CAAhV-H6m5vszCyiF3qi94cpHBPVuqM2xH93D=gfsQqOSYvC-sA@mail.gmail.com>
 <33612d85-e70b-26da-8460-ea6b9064ce08@loongson.cn> <CAAhV-H5ZSTFDxvm-W1CrgEoQ5d_jw5yVsfetQ_J_qL5pqLtzgg@mail.gmail.com>
 <CAMj1kXGk0udgM67wrWqahqK8H0uE8emQj51SmJey+7fE-FTjdA@mail.gmail.com>
 <CAAhV-H4c=vdNWO0v_mYL2xZ9FYjDyRDvt6f_kV4d8Bh=CRJniQ@mail.gmail.com>
 <CAMj1kXEaxxcWTTANWeEMNjYDymdL5Fxy2B=XBF4RGtteEkfinw@mail.gmail.com>
 <421c08e1-255b-447b-b5e3-ee6544fbefd2@loongson.cn> <CAAhV-H5KsFShDJ_Cxu+1_ces8oojn8+S-7PLmE7aUj8gX5_GEw@mail.gmail.com>
In-Reply-To: <CAAhV-H5KsFShDJ_Cxu+1_ces8oojn8+S-7PLmE7aUj8gX5_GEw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 11 Nov 2025 17:49:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXELVc6AMXgUnjEuoetEYqBkBE3+nFH4--hFQaFGBTF3hA@mail.gmail.com>
X-Gm-Features: AWmQ_blkkBK4eB_glR3-UhpCiwa3bDzaFeiiqfcHKYfJl_7P3Ja2j5gP_FB4hrI
Message-ID: <CAMj1kXELVc6AMXgUnjEuoetEYqBkBE3+nFH4--hFQaFGBTF3hA@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Nov 2025 at 08:00, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> On Mon, Nov 10, 2025 at 9:19=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.=
cn> wrote:
> >
> > On 2025/10/28 =E4=B8=8B=E5=8D=889:47, Ard Biesheuvel wrote:
> > > On Sun, 26 Oct 2025 at 12:20, Huacai Chen <chenhuacai@kernel.org> wro=
te:
> > >>
> > >> On Thu, Oct 23, 2025 at 4:07=E2=80=AFPM Ard Biesheuvel <ardb@kernel.=
org> wrote:
> > >>>
> > >>> On Thu, 23 Oct 2025 at 10:01, Huacai Chen <chenhuacai@kernel.org> w=
rote:
> > >>>>
> > >>>> On Thu, Oct 23, 2025 at 2:55=E2=80=AFPM Tiezhu Yang <yangtiezhu@lo=
ongson.cn> wrote:
> > >>>>>
> > >>>>> Hi Josh and Ard,
> > >>>>>
> > >>>>> On 2025/10/20 =E4=B8=8B=E5=8D=882:55, Huacai Chen wrote:
> > >>>>>> On Mon, Oct 20, 2025 at 9:24=E2=80=AFAM Tiezhu Yang <yangtiezhu@=
loongson.cn> wrote:
> > >>>>>>>
> > >>>>>>> Hi Josh, Ard and Huacai,
> > >>>>>>>
> > >>>>>>> On 2025/10/18 =E4=B8=8A=E5=8D=881:05, Josh Poimboeuf wrote:
> > >>>>>>>
> > >>>>>>> ...
> > >>>>>>>
> > >>>>>>>> But IIUC, the libstub code runs *very* early, and wouldn't sho=
w up in a
> > >>>>>>>> stack trace anyway, because there are no traces of it on the s=
tack once
> > >>>>>>>> it branches to head.S code (which doesn't save the link regist=
er).
> > >>>>>>>
> > >>>>>>> Thanks for your discussions.
> > >>>>>>>
> > >>>>>>> Are you OK with this current patch?
> > >>>>>> For me the current patch is just OK.
> > >>>>>
> > >>>>> We have discussed this a few times but there is almost no consens=
us
> > >>>>> of what should happen next and nothing changes.
> > >>>>>
> > >>>>> Could you please give me a clear reply? Then I can make progress =
for
> > >>>>> the following series:
> > >>>>>
> > >>>>> https://lore.kernel.org/loongarch/20250917112716.24415-1-yangtiez=
hu@loongson.cn/
> > >>>> For me, this patch is OK, ignore __efistub_ prefix in objtool is a=
lso
> > >>>> OK [1]. But I cannot accept the way that modifying the efistub par=
t
> > >>>> only for LoongArch.
> > >>>>
> > >>>> Clear enough?
> > >>>>
> > >>>
> > >>> LoongArch is the only architecture which has the problem, so I don'=
t
> > >>> see a reason to modify other architectures.
> > >>  From your reply I think the efistub code is completely right, but
> > >> objtool cannot handle the "noreturn" function pointer. And this patc=
h
> > >> is a workaround rather than a proper fix (so you don't want to touch
> > >> other architectures), right?
> > >>
> > >
> > > That is my reasoning, yes. But Josh is right that it shouldn't make a
> > > difference in practice, I am just reluctant to make changes to the
> > > code running on the target to accommodate a flawed build time tool.
> >
> > If I understand correctly, I should modify this patch to remove the
> > changes of arm and riscv for now, do the changes only when there is
> > a real problem or requirement some day, right? If no more comments,
> > I will send v3 later.
> Now everyone involved agrees that the efistub code is correct, so the
> proper solution is to fix the compiler. Changing efistub code and
> changing objtool (ignore __efistub prefix) are both workarounds, but I
> think changing objtool is a little more reasonable. Maybe Josh has
> different ideas?
>

Well, given that objtool cannot even infer this for direct calls (and
needs to built with a list of known noreturn functions in the entire
kernel), I think it is safe to assume that doing this for indirect
calls such as this one is intractable.

