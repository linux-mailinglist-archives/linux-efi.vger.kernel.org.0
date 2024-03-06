Return-Path: <linux-efi+bounces-746-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B407E873772
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 14:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47484B22113
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 13:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75348132468;
	Wed,  6 Mar 2024 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUJIv8Vv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F57C131E56;
	Wed,  6 Mar 2024 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730694; cv=none; b=qYGfAwajf0KoadMoIMh26XDbelSIIXZHK9qnOr85GpwAP+f0YLrIytvWz8KIOUL0kl5V2RzLEtOwcZEBa4jmyEipXWdHrnMxgJ/WpqslrEM1snAc3sTzE/6HkQGMgFeGwxGghIIhLp0ZbUaGNgtBVb+0zgYv9mvt4HhqQC5lPQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730694; c=relaxed/simple;
	bh=56f2HhQhxeS1dJOLBZNhXaT2SUwuIV0zVPH+7uTCfMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZ/CF5esH9zhJIJNOLEiLlCLVjHR3+VJNyb+NlNbSZ8NPmfVs180drZ048godK5X3HYa16yE2U1DU64zF2xQHGpf9B0iXRZCX7mqdQ7ZVWaFCzgwpv7gOMTnaIW+xYOqG5sw/l9Mlom6op3rwajuSrgOkMKdBUfBpqybgCRJ2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUJIv8Vv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEA1C4167E;
	Wed,  6 Mar 2024 13:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709730693;
	bh=56f2HhQhxeS1dJOLBZNhXaT2SUwuIV0zVPH+7uTCfMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IUJIv8VvEfYLvwT+YDnqccZcw1yCt7fXEs+bWvMVLPgIkVdEhgbkMhBOJuGgsAQzm
	 VxJ7Lbq+OgPkntwvH05FmbHw8TKJK0dv669vqaO/SBBNd7AADf6d22fVhurg0ZmH2X
	 39o1H5UG9I9l9xSYNCAHq36Uy4W0QD1q25VyYqrGkYQg4wZPwEaZSob15o4REp73Cq
	 CtjyIZDfEGb5L7jg42VaCs6uDR6G73c1dWWejnTRRtsmg3VJHRK5/Q0P5PKOJoIfhD
	 WZAbnOuk5eexqwbMeXqzukcPjt4Amza3nqlJufXhDFemROvbdlh06F/YvTx7gjmU/M
	 y7JFSUhKp/uZQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5133d26632fso5019871e87.2;
        Wed, 06 Mar 2024 05:11:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtdn+ZS6L2jfbCMGuTIts8V6BqWt9L6dayr8X8Zeovb6usiwQ3YOa83GwSOTJOj7G3bEedLS6TV0/d3PKzpEj3HZgudEs6xMxnRrXqwERcRxeTWULOL96P0copkw//3ouPRY4LyH6v
X-Gm-Message-State: AOJu0YzJKtPhLDYNW9zQ33JKw31NBti+OMXt8HiWXF8sVYJIwDLtaGi1
	3YXUPqpDyDCaq24lDzm3xm9U4tm7IZvOu3a+XDyRxvFPctDwASjCB8So0wshig6l3EZGp25asbd
	U7zgcX96D8hHl39nZToma4qhqRtM=
X-Google-Smtp-Source: AGHT+IGwsRyIuiauoWfKtSLXpu4UtpzpI5hTliB/89gQ4tkgzBQId4Wcr1DRFw8Ntkd6cNvqo95hi/5Je9wNAgYhyCU=
X-Received: by 2002:ac2:5193:0:b0:513:5e2f:7bc9 with SMTP id
 u19-20020ac25193000000b005135e2f7bc9mr1093188lfi.9.1709730691762; Wed, 06 Mar
 2024 05:11:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
 <26f3e99c-8f57-4779-a679-2085e469d9cd@siemens.com> <CAEEQ3wnDKdhCH4yz+MY+Xks21jLnuFiyx-xxa7CFczokG2shvQ@mail.gmail.com>
In-Reply-To: <CAEEQ3wnDKdhCH4yz+MY+Xks21jLnuFiyx-xxa7CFczokG2shvQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 6 Mar 2024 14:11:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFxzFRQz0BUVw27xdOj+xAVtX9jPjwaLHsEOYDUSqXMOw@mail.gmail.com>
Message-ID: <CAMj1kXFxzFRQz0BUVw27xdOj+xAVtX9jPjwaLHsEOYDUSqXMOw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/3] Revert "riscv/efistub: Ensure
 GP-relative addressing is not used"
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, bp@alien8.de, xiao.w.wang@intel.com, 
	kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Mar 2024 at 14:08, yunhui cui <cuiyunhui@bytedance.com> wrote:
>
> Hi Jan,
>
> On Wed, Mar 6, 2024 at 8:52=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
> >
> > On 06.03.24 09:56, Yunhui Cui wrote:
> > > This reverts commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5.
> > >
> >
> > This comes without a reason - which is likely something around "will fi=
x
> > this properly later". But then you regress first and only fix
> > afterwards. Can't that be done the other way around?
>
> Sorry, I don't quite understand what you mean. Can you help explain it
> more clearly? Do you mean "delete mno-relax instead of revert
> directly?"
>

You should order your patches in a way that does not create
intermediate states (between 1-2 or between 2-3) where the original
problem is being recreated.

So in this case, you should
a) fix the issue
b) revert the existing patches in *opposite* order

However, I don't think the EFI stub can use GP - please refer to my other r=
eply.

