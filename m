Return-Path: <linux-efi+bounces-5402-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E923C45283
	for <lists+linux-efi@lfdr.de>; Mon, 10 Nov 2025 08:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0ADD9346D3C
	for <lists+linux-efi@lfdr.de>; Mon, 10 Nov 2025 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B12F0699;
	Mon, 10 Nov 2025 07:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOiYkuEK"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A4D2EA731
	for <linux-efi@vger.kernel.org>; Mon, 10 Nov 2025 07:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762758005; cv=none; b=i6HOYgkS9DNxL2NLmcsxkd6iqWck9adl1oDMGZetkr+fcJZtxVKETw9FCJd3T6rjTo4kihwNbFuxqAKwe2rw4E7uv6DQIpi942TMvGb78l5nmA4LpQyT7KuMpJMqiEYkzFtrakP0gxUODqvDVkAhtcRQlXtg0jaHW35ZxOWHky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762758005; c=relaxed/simple;
	bh=JdTdMo+NFiglCdCfKW95/AM4C/gcOP2vda5nUzM0Gcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhyPusJQQzTYJZltWQ2ooi/y58vTb3d6yAkiAUatJoAaOYzF91b797kr0/loAvCrGKauWdCozvoP7uK9DZHZ9qTHVUbL17YyOvRvg3NJELJ10xcDUtlVee5oj+Vi1Meq9J58MsjFYj5xm7eOyJ6gBeNTBbvcPzN1199fUNxjXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOiYkuEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40220C4AF0B
	for <linux-efi@vger.kernel.org>; Mon, 10 Nov 2025 07:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762758005;
	bh=JdTdMo+NFiglCdCfKW95/AM4C/gcOP2vda5nUzM0Gcs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fOiYkuEKJeG64GjSkTz0f062EymlHD37s8k68FmgmEKb1QyozA9aH3644MecRv1rk
	 MSLlU/QP/Vt/gBlJ3JMXb/jrSpZafF8b64XnG21/d2+aOMESrCAudIQeEymVVsc7Az
	 u1E8J6JpR7C4w6R0ivD078MdWdFEsqExMLydk09mClOb76WxnIdBZ15Zb9VZf0GtbC
	 CnGwXRkUIN8wtWYTzbK8xdN2DEE8A9YeQvTVi8aKXLDnghnVc2v/Nlj6QpAt4iK/SU
	 cSdKQXbZzBawYnrauz+xbosh04Pz0PacM2n1UkAbs05FpZ5o8rWz6Bubs4wmTyw0Gu
	 Wezc5Ezmnbkbw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b72dc0c15abso317473066b.1
        for <linux-efi@vger.kernel.org>; Sun, 09 Nov 2025 23:00:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWuuVj1oLRi2l4cBbTga/8LdjCESyMxGNsOjNR0u2EQ6br6cI/D8tfQypAdZLgYQ2cJ07TGgcPHK9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqNvjl6W+nrsTlwzqxI5Xx/e43kYnN6NdcVW3I9NfA67xWGVet
	VusMHgfJn5P7/K8E9UBr8BJhUj/v0KHgca/f+Ih3K76MRekU0N3r8DRfu7ht6kc0LXIWo82mJ/1
	LC/PbS+UDlKcncrA0xcBevnP3xyi1n8o=
X-Google-Smtp-Source: AGHT+IHkpMQjNw20ZABNl3NXRRjTGeTjlilbmH88N08NrWz3UtRyqo7y/Vo93oYm+gCDPeDFcWZjLsRDB5fNntbnReU=
X-Received: by 2002:a17:907:3fa9:b0:b6d:5262:a615 with SMTP id
 a640c23a62f3a-b72e045bbe3mr518748666b.41.1762758003839; Sun, 09 Nov 2025
 23:00:03 -0800 (PST)
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
 <CAMj1kXEaxxcWTTANWeEMNjYDymdL5Fxy2B=XBF4RGtteEkfinw@mail.gmail.com> <421c08e1-255b-447b-b5e3-ee6544fbefd2@loongson.cn>
In-Reply-To: <421c08e1-255b-447b-b5e3-ee6544fbefd2@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 10 Nov 2025 15:00:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5KsFShDJ_Cxu+1_ces8oojn8+S-7PLmE7aUj8gX5_GEw@mail.gmail.com>
X-Gm-Features: AWmQ_bmq5wLFGGuKpNEar1lHdOssPyNtLtsWck9HgwZgdpmEeIMHmCh0kt8j7JI
Message-ID: <CAAhV-H5KsFShDJ_Cxu+1_ces8oojn8+S-7PLmE7aUj8gX5_GEw@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, loongarch@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 9:19=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 2025/10/28 =E4=B8=8B=E5=8D=889:47, Ard Biesheuvel wrote:
> > On Sun, 26 Oct 2025 at 12:20, Huacai Chen <chenhuacai@kernel.org> wrote=
:
> >>
> >> On Thu, Oct 23, 2025 at 4:07=E2=80=AFPM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> >>>
> >>> On Thu, 23 Oct 2025 at 10:01, Huacai Chen <chenhuacai@kernel.org> wro=
te:
> >>>>
> >>>> On Thu, Oct 23, 2025 at 2:55=E2=80=AFPM Tiezhu Yang <yangtiezhu@loon=
gson.cn> wrote:
> >>>>>
> >>>>> Hi Josh and Ard,
> >>>>>
> >>>>> On 2025/10/20 =E4=B8=8B=E5=8D=882:55, Huacai Chen wrote:
> >>>>>> On Mon, Oct 20, 2025 at 9:24=E2=80=AFAM Tiezhu Yang <yangtiezhu@lo=
ongson.cn> wrote:
> >>>>>>>
> >>>>>>> Hi Josh, Ard and Huacai,
> >>>>>>>
> >>>>>>> On 2025/10/18 =E4=B8=8A=E5=8D=881:05, Josh Poimboeuf wrote:
> >>>>>>>
> >>>>>>> ...
> >>>>>>>
> >>>>>>>> But IIUC, the libstub code runs *very* early, and wouldn't show =
up in a
> >>>>>>>> stack trace anyway, because there are no traces of it on the sta=
ck once
> >>>>>>>> it branches to head.S code (which doesn't save the link register=
).
> >>>>>>>
> >>>>>>> Thanks for your discussions.
> >>>>>>>
> >>>>>>> Are you OK with this current patch?
> >>>>>> For me the current patch is just OK.
> >>>>>
> >>>>> We have discussed this a few times but there is almost no consensus
> >>>>> of what should happen next and nothing changes.
> >>>>>
> >>>>> Could you please give me a clear reply? Then I can make progress fo=
r
> >>>>> the following series:
> >>>>>
> >>>>> https://lore.kernel.org/loongarch/20250917112716.24415-1-yangtiezhu=
@loongson.cn/
> >>>> For me, this patch is OK, ignore __efistub_ prefix in objtool is als=
o
> >>>> OK [1]. But I cannot accept the way that modifying the efistub part
> >>>> only for LoongArch.
> >>>>
> >>>> Clear enough?
> >>>>
> >>>
> >>> LoongArch is the only architecture which has the problem, so I don't
> >>> see a reason to modify other architectures.
> >>  From your reply I think the efistub code is completely right, but
> >> objtool cannot handle the "noreturn" function pointer. And this patch
> >> is a workaround rather than a proper fix (so you don't want to touch
> >> other architectures), right?
> >>
> >
> > That is my reasoning, yes. But Josh is right that it shouldn't make a
> > difference in practice, I am just reluctant to make changes to the
> > code running on the target to accommodate a flawed build time tool.
>
> If I understand correctly, I should modify this patch to remove the
> changes of arm and riscv for now, do the changes only when there is
> a real problem or requirement some day, right? If no more comments,
> I will send v3 later.
Now everyone involved agrees that the efistub code is correct, so the
proper solution is to fix the compiler. Changing efistub code and
changing objtool (ignore __efistub prefix) are both workarounds, but I
think changing objtool is a little more reasonable. Maybe Josh has
different ideas?

Huacai

>
> Thanks,
> Tiezhu
>
>

