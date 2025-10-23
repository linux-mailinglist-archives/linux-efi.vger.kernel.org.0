Return-Path: <linux-efi+bounces-5099-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9F8BFFC2E
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 10:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 282E835345C
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 08:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8098C2EA496;
	Thu, 23 Oct 2025 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA7j75QV"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA262E6CC4
	for <linux-efi@vger.kernel.org>; Thu, 23 Oct 2025 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206515; cv=none; b=bP7sfZsbJ6df+PDxRkkPfmsjmcE+infw1rlTbM5rZ9nfdlrrCo2DgjjApKF5pQOnLM9emRLjPFpITWyxn65UJPDckTjK0vogTXF9sORuds3kbl4p2u5Hq5gfjMH9luDgCpV+04zGC70DnKqB7YCJztYj04JWNHsjzsVwBk5OmfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206515; c=relaxed/simple;
	bh=m7tbJmNH1DXNfTU+Xp3xL+FoPO8IvUCQ4iTCgB6ek3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0WFOOpEwNvAgJ7zgPIulOyKSiy+vRdcj4pnibnwk97FWKfbBZOid5C/DTQMzfB/B3XGi+1+9IIM8G7mlAaONNi7W6HzH2d1r+zPwC4Dq1Fzs84KpZ8p+uV166McWnlEvcXdQCY687UAYheiVHL1r+2keNXaSF0/4p/NP6+aU9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA7j75QV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F02C113D0
	for <linux-efi@vger.kernel.org>; Thu, 23 Oct 2025 08:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761206515;
	bh=m7tbJmNH1DXNfTU+Xp3xL+FoPO8IvUCQ4iTCgB6ek3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RA7j75QVc5ILMBKj/72NMEFdIwS9ZPlfJ+fJQRtKqD0/4aaYhy4lPNds6GfmVwrWu
	 UtqfHK9gl7XEDWTigFsMA54w2QInEqrGnLNBO8Aoy4v0NL7WQgdFnFs6NjZ/b1UaFn
	 sj6UOzmRYkylU87ieA6GjjFup20n57aQmQlUE95CA4nZlsGZcyaBLpdcrrRelcysdk
	 Em77VyHtM7uo7W3ghXZdiwRzsLEmGVrZdCt2U+zEx39jChNcRsO27jUp4vDgH2uXkR
	 YOFNQtkGMCvaNrU7GcXZnQkojb4cm+kctXgFic+peHScM083oEo4zScim4Er6s6jvg
	 nfpXjd6z7zk7Q==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c2d72581fso851750a12.0
        for <linux-efi@vger.kernel.org>; Thu, 23 Oct 2025 01:01:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVR8CAkC9+aBRbYJ3fH9f0BNnWgtDPEAskbIFGJKHunemtaj4fAOTw09cfj4c9ykJD4/mOXa3p4DAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQfvyQseLmM31rKZdKEYJOXoVhe5K1dxUHS/S7DKHDMhTA++c
	Tw4mgvOk6s0RZYJZVQbUyGwrM2Xu8T3U2C825WlnkaUhA3zdi8Wil0n1E2tfDutSF3sSbpbh/ns
	yNde95iAGuzblwDgoc3FhMkf039nKSjU=
X-Google-Smtp-Source: AGHT+IHfBLH/GBfgXrqchxfxu9l1VaoEMJ8tUkoEMadPUjtpN04Dne7DQiXnlqVZI5khk1s5nO6HkYPeLlaWwbhf/8k=
X-Received: by 2002:a05:6402:1e8f:b0:636:9129:882f with SMTP id
 4fb4d7f45d1cf-63c1f6e1e4dmr22674073a12.30.1761206513683; Thu, 23 Oct 2025
 01:01:53 -0700 (PDT)
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
 <33612d85-e70b-26da-8460-ea6b9064ce08@loongson.cn>
In-Reply-To: <33612d85-e70b-26da-8460-ea6b9064ce08@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 23 Oct 2025 16:01:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5ZSTFDxvm-W1CrgEoQ5d_jw5yVsfetQ_J_qL5pqLtzgg@mail.gmail.com>
X-Gm-Features: AS18NWATDqwQc-mvgyc-6ppP82QmD732g4zxHKYB9A2rEPJ5_4tzPE-f0_vNffE
Message-ID: <CAAhV-H5ZSTFDxvm-W1CrgEoQ5d_jw5yVsfetQ_J_qL5pqLtzgg@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, loongarch@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 2:55=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Hi Josh and Ard,
>
> On 2025/10/20 =E4=B8=8B=E5=8D=882:55, Huacai Chen wrote:
> > On Mon, Oct 20, 2025 at 9:24=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> >>
> >> Hi Josh, Ard and Huacai,
> >>
> >> On 2025/10/18 =E4=B8=8A=E5=8D=881:05, Josh Poimboeuf wrote:
> >>
> >> ...
> >>
> >>> But IIUC, the libstub code runs *very* early, and wouldn't show up in=
 a
> >>> stack trace anyway, because there are no traces of it on the stack on=
ce
> >>> it branches to head.S code (which doesn't save the link register).
> >>
> >> Thanks for your discussions.
> >>
> >> Are you OK with this current patch?
> > For me the current patch is just OK.
>
> We have discussed this a few times but there is almost no consensus
> of what should happen next and nothing changes.
>
> Could you please give me a clear reply? Then I can make progress for
> the following series:
>
> https://lore.kernel.org/loongarch/20250917112716.24415-1-yangtiezhu@loong=
son.cn/
For me, this patch is OK, ignore __efistub_ prefix in objtool is also
OK [1]. But I cannot accept the way that modifying the efistub part
only for LoongArch.

Clear enough?

[1] https://lore.kernel.org/loongarch/20250917112716.24415-1-yangtiezhu@loo=
ngson.cn/T/#meef7411abd14f4c28c85e686614aa9211fccdca0

Huacai

>
> Thanks,
> Tiezhu
>

