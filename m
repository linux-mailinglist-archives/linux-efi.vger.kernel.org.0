Return-Path: <linux-efi+bounces-5023-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A27DDBCEEA2
	for <lists+linux-efi@lfdr.de>; Sat, 11 Oct 2025 04:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4FD3E81F5
	for <lists+linux-efi@lfdr.de>; Sat, 11 Oct 2025 02:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFFD194098;
	Sat, 11 Oct 2025 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AopT685Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C0817B425
	for <linux-efi@vger.kernel.org>; Sat, 11 Oct 2025 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760151280; cv=none; b=ehs8Fv6Iz0GQVpuV0uW0zlAJu9cndiWgS/DZy4ipBTTctCztFM0tU4LMQ5EFpDQUr+nwYuSbaBm6CoKtxywXQzP3hpMFeteAXiMyFodjNuYCv8Tz598Rifz3I3+oSp3kAbiX3fCJnd/3UuH7FXNtbkDkGPDcXkWaSFmwqUMglT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760151280; c=relaxed/simple;
	bh=0BsgeZrUj1KXKp6RgSEwCit69Zxybcd5U5cra+JDpqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9+6HTl3FXy88Ge6AiOwBOoi+DrZtVPAPCytkEqIvlaMt7yb6a99vC494ReMKsTgkqFVTFKDEXsVwxPAO9l8KdUyXgnjva9CstadJqpJ4+R4xchDDvCgqdpSCVOR3K93ZoUY9Bq4HJxaG5IWMfAXBoZyPJFeMOhczk/P4TqLbv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AopT685Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F08C113D0
	for <linux-efi@vger.kernel.org>; Sat, 11 Oct 2025 02:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760151280;
	bh=0BsgeZrUj1KXKp6RgSEwCit69Zxybcd5U5cra+JDpqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AopT685ZVyiq/B13YoWAdE/uU7ZByQOi8O//wNShEHRW/aN7M8he3IudB6pmzAhLk
	 rsxTX5qL0jtNz/l3oj+f0O5j2/bPe9ffDzsjX66OgRuL2Ef2BCCOPyXULb404xZmDn
	 Use3yrTlDNkLxKts4HbYNtXaA526ofA0016/swVhUnIeUhOcJO6mbBXnQQeEMNDn5h
	 0yOE5FNaknEXbNoOUgIJA0IFog+fl1XOO3BpHi0Ei43RiQPLtNTYovB67pjNJnb+u2
	 lwD76XIrCBkRfaDb0581OJe0haU56lUwPm8Iw0GPLpOK0EuuP3BSEIjapKAIXp9XUN
	 1kVyCSEUYol3g==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so5447169a12.1
        for <linux-efi@vger.kernel.org>; Fri, 10 Oct 2025 19:54:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgzpO8jy0Fw/GojpeHEsPJiZ9MhbtIu+jMwTtxwhVixI+E1bElpZMaMkyYSrNySkgryaw/CK8HYKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUhieZWsr2s9vTFTmFue/r2jPEy0u+5GrnBQquD2lUu9v3OgbO
	ts+2f1fbck6viXTsLNOAXnTo2GZddSjAbC7x4Xa1gWGRgj8vmIguJtvENvp20+vdXyEzjwk+get
	lNIk/K95dJlzzBXQkBP0Ml1nNMgSb7Rk=
X-Google-Smtp-Source: AGHT+IF9JxI+9VeTgFvdqyJbZPk/80hHvb+lokzIbLfoZR2oxQr/1YSDD9mWyNinLrGKRqjQU4ppDgkuAk1ji6g4P9g=
X-Received: by 2002:a05:6402:194:b0:62f:2f9f:88bf with SMTP id
 4fb4d7f45d1cf-639d5c76af0mr9286969a12.38.1760151278841; Fri, 10 Oct 2025
 19:54:38 -0700 (PDT)
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
 <8091e8fa-3483-af39-2f7a-e4eb62b0944f@loongson.cn>
In-Reply-To: <8091e8fa-3483-af39-2f7a-e4eb62b0944f@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 11 Oct 2025 10:54:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4+UGLSkbjHbq9MerWfxnq0a13x+uzNfTsCoe1UxjbWsg@mail.gmail.com>
X-Gm-Features: AS18NWBWal44DW5X5_JBBkD_g1Z13iGjEk6ARiGEjcxdbyEFQrUdwFzObW-aflA
Message-ID: <CAAhV-H4+UGLSkbjHbq9MerWfxnq0a13x+uzNfTsCoe1UxjbWsg@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, loongarch@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 9:13=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 2025/10/11 =E4=B8=8A=E5=8D=8812:25, Ard Biesheuvel wrote:
> ...
> > Why do we need both (1) and (2)?
>
> Not both, either (1) or (2).
> Which one do you prefer? Or any other suggestions?
>
> Taking all of the considerations in balance, we should decide
> what is the proper way.
As a summary, there are three methods:
(1) Only link libstub with vmlinux.o during the final vmlinux link.
(2) Remove the attribute __noreturn for real_kernel_entry() and add while (=
1).
(3) Ignore "__efistub_" prefix in objtool.

Josh prefers method (1), I prefer method (3) but also accept method
(1) if it is not only specific to loongarch.

Huacai

>
> Thanks,
> Tiezhu
>
>

