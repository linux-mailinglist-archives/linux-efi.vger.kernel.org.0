Return-Path: <linux-efi+bounces-5198-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802F5C14FBA
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 14:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B3C422368
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 13:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF10231A32;
	Tue, 28 Oct 2025 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCBzeOpV"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A2E23183A
	for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659252; cv=none; b=qoLMlox1FvO29gcf09Q2rKr6RAohxkUSVjLIXRh8qvkvPzwccoJefL7fBIk74FCT5nR3dF5RDqY4Lq2li6bsXPkkEMfpEG57LgPzinKWLE2KD7K3XezE1rxc0tIjsg3f041291gjSyJy9eB9upuJtdeH88SanlcIyqHev9bqJBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659252; c=relaxed/simple;
	bh=GVjUEKZRgeMgDKNXAgezVSn0xrs6j1yMXphGPwksYBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOartTf4ki8rw3RhA8ex0RTM1F+kso3HdLPw9WaVnWLQHt4zG1QLzqP+mTohUzXzlNry0ldXfRyhoP+uFHd8VjXRIveWxpQ4FgUKE0zM4mP4e8TZFor8wy/ulM1Lll0TlFNFV0S34bYbMFKUBP89cADV9tvomkm/rKlTcEMWIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCBzeOpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AD3C116C6
	for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 13:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761659252;
	bh=GVjUEKZRgeMgDKNXAgezVSn0xrs6j1yMXphGPwksYBw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BCBzeOpVuTtpNnsK/HEK0mvaOH767BgRFEyc3cHrIO1uiPno7n9YbPE0RrBArxZJU
	 W1oBY0fw/FAwbktfbNtUAgrshGxHddq0rN8tOoA4XbxSqmUtrpxUBsI12txQ7WoGpW
	 ZRQoArmgPB6yUM7WhWutdmuL7EdEOUXbQDGy+kXexwRk0gFMBYoD6FrGcjfft1EaO7
	 Yw35Jaet/uAic4eP1VgrZelWiQyauRn+hnaML2Agzj5bHh9X3g7vAs6DrnQSflHlrP
	 1j+pIlVoCla2DQOukwOJTvguGHl/86+1BWvl85Hjah+3g35Bo82ImtyFxIG1M8I0Bp
	 T0vmV1b6La1Zw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3696f1d5102so53005381fa.3
        for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 06:47:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwnnFUDs5QivTD0xde5XgU6NC1NoSUZFGpb7tEUznH0lzTzmHN28B1Dq8Dp/tkXmhCDiAIlyIZn0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YydYUKKN9j57xUwU/8siNmJYW4k9x2one117s5Wi6c5JAAgNJGg
	JclGE21K3LqLnLD52TAEC3fbTXRh42TaI2am5AkBiQgSlE5Z5+ylSCE8wKsCJ4Sdeao/LHW90z5
	xZjbL3mpN6ErG8+nCONh1GOlTNNYQslo=
X-Google-Smtp-Source: AGHT+IGMDRiylwmZD0SBl5ugRhR6rIlFVm0u852ZP1jG9URNwU34wlwBhJJFjd3gP3FgNoxZynY+eRUKXAVIwfZ/a6U=
X-Received: by 2002:a2e:9a13:0:b0:36f:284:56db with SMTP id
 38308e7fff4ca-379077114c5mr10647291fa.23.1761659250814; Tue, 28 Oct 2025
 06:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com>
 <CAMj1kXGvSnCMRVCW7eAxgLRWMEV3QRj3Dqg3PmZchZJNpnLK9w@mail.gmail.com>
 <CAAhV-H4UKdso0BokAqvjYeBLr-jbjFAaQX4z=1ztpBamqrOEEg@mail.gmail.com>
 <CAMj1kXEXDC_oq4aWbkR5dqYBix2d1xJEdaj-v747e1nOA0Q_Yg@mail.gmail.com>
 <rhnei6wovxmoqs36wdysomfsul3faxtmgde73wrrqdt3qo3b2j@akd7vzne76rq>
 <CAMj1kXF+hDJy0vRWNgwoijHxvA-scvhGODMj9A3dv19v3jf2yw@mail.gmail.com>
 <lgyzruqczm7uti2lfbhfhr5hyzpnm7wtvgffa2o7nigx76g6i3@wlffltvmhhez>
 <CAMj1kXFDquPxCYSBWgjikS=209pSJ_kth67M0RDeuetV9CPYAw@mail.gmail.com>
 <wlx6pt5crtfdwtop4w5vjznjfarrwitq44wdbufncjdvtsx647@tgobruak66yb>
 <CAMj1kXFfEBkcc-aiwGrRR-pKg4LBbS7weK0pEpZJsKOk5pbkuA@mail.gmail.com>
 <jxfb5a2c2qber623l2gwewirwod54bbgfnvt7t7f3jah2ea33g@2uyhy3auzmpx>
 <d9f3352a-1c1f-464a-a8fd-741cd96b5f8e@loongson.cn> <CAAhV-H6m5vszCyiF3qi94cpHBPVuqM2xH93D=gfsQqOSYvC-sA@mail.gmail.com>
 <33612d85-e70b-26da-8460-ea6b9064ce08@loongson.cn> <CAAhV-H5ZSTFDxvm-W1CrgEoQ5d_jw5yVsfetQ_J_qL5pqLtzgg@mail.gmail.com>
 <CAMj1kXGk0udgM67wrWqahqK8H0uE8emQj51SmJey+7fE-FTjdA@mail.gmail.com> <CAAhV-H4c=vdNWO0v_mYL2xZ9FYjDyRDvt6f_kV4d8Bh=CRJniQ@mail.gmail.com>
In-Reply-To: <CAAhV-H4c=vdNWO0v_mYL2xZ9FYjDyRDvt6f_kV4d8Bh=CRJniQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 28 Oct 2025 14:47:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEaxxcWTTANWeEMNjYDymdL5Fxy2B=XBF4RGtteEkfinw@mail.gmail.com>
X-Gm-Features: AWmQ_bkAt2Vtj9hvye18BBbdzR0dpGQ4Zhb1DJGs0utdf4kJbulyIP6uV_Jkez8
Message-ID: <CAMj1kXEaxxcWTTANWeEMNjYDymdL5Fxy2B=XBF4RGtteEkfinw@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Oct 2025 at 12:20, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> On Thu, Oct 23, 2025 at 4:07=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Thu, 23 Oct 2025 at 10:01, Huacai Chen <chenhuacai@kernel.org> wrote=
:
> > >
> > > On Thu, Oct 23, 2025 at 2:55=E2=80=AFPM Tiezhu Yang <yangtiezhu@loong=
son.cn> wrote:
> > > >
> > > > Hi Josh and Ard,
> > > >
> > > > On 2025/10/20 =E4=B8=8B=E5=8D=882:55, Huacai Chen wrote:
> > > > > On Mon, Oct 20, 2025 at 9:24=E2=80=AFAM Tiezhu Yang <yangtiezhu@l=
oongson.cn> wrote:
> > > > >>
> > > > >> Hi Josh, Ard and Huacai,
> > > > >>
> > > > >> On 2025/10/18 =E4=B8=8A=E5=8D=881:05, Josh Poimboeuf wrote:
> > > > >>
> > > > >> ...
> > > > >>
> > > > >>> But IIUC, the libstub code runs *very* early, and wouldn't show=
 up in a
> > > > >>> stack trace anyway, because there are no traces of it on the st=
ack once
> > > > >>> it branches to head.S code (which doesn't save the link registe=
r).
> > > > >>
> > > > >> Thanks for your discussions.
> > > > >>
> > > > >> Are you OK with this current patch?
> > > > > For me the current patch is just OK.
> > > >
> > > > We have discussed this a few times but there is almost no consensus
> > > > of what should happen next and nothing changes.
> > > >
> > > > Could you please give me a clear reply? Then I can make progress fo=
r
> > > > the following series:
> > > >
> > > > https://lore.kernel.org/loongarch/20250917112716.24415-1-yangtiezhu=
@loongson.cn/
> > > For me, this patch is OK, ignore __efistub_ prefix in objtool is also
> > > OK [1]. But I cannot accept the way that modifying the efistub part
> > > only for LoongArch.
> > >
> > > Clear enough?
> > >
> >
> > LoongArch is the only architecture which has the problem, so I don't
> > see a reason to modify other architectures.
> From your reply I think the efistub code is completely right, but
> objtool cannot handle the "noreturn" function pointer. And this patch
> is a workaround rather than a proper fix (so you don't want to touch
> other architectures), right?
>

That is my reasoning, yes. But Josh is right that it shouldn't make a
difference in practice, I am just reluctant to make changes to the
code running on the target to accommodate a flawed build time tool.

