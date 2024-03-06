Return-Path: <linux-efi+bounces-749-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 662FB873814
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 14:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0DC1B21D95
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E696D13173F;
	Wed,  6 Mar 2024 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4nM8yYk"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD732131735;
	Wed,  6 Mar 2024 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732807; cv=none; b=VmePIdfMSI8rbF73mppQMFi+/ConXgiPpXYMJZUEz7gXZ5vmjDy3jLnHMFl/hh5WT/x0/kw0ypyxTUMGqpHnNhtL5Aaqq2tZw3euKAynXe3FUjyddmhflEUCUDx/nZL0FsAGqKA8ZIZTFXyesJStqRjtm0nzfkry34kASnmoKPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732807; c=relaxed/simple;
	bh=HKOrEEH9HqpMNSYfotIGkrk7ePXe6ymoHU7kWVrk5c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pf+lHELPHUCNpOYSaAh9i83cYr90dcCGRyd+yGynHFs01i4zpm3qfaZeITxcLF5r88YTgxi07UkNY0mvPDFjHRmAaOQFnYdvAu3l4Qo595Uha8vpPoyKmuXdkILcPgNTbxZFjsDlsZefU/hBpYgNWzssj0PDhNdqhif2ms4nAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4nM8yYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F352C433A6;
	Wed,  6 Mar 2024 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709732807;
	bh=HKOrEEH9HqpMNSYfotIGkrk7ePXe6ymoHU7kWVrk5c4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A4nM8yYk8QOWrEiI04Wd8IFrFQewXY+yIIPRCoEJGo2P/t5gQn60gj5qh3T1eafHs
	 LXOjbNUo04fIGUUMWWJonxlP5BCymt0wvPrVePX2mLidb5II3xxKQygK/SuBCAqxKR
	 KYx4i40t5r5SlEuobe91Fu3wHH+nSs2ElWmOjLjbz0gxoxghjJzQNPcTDtZmt+x225
	 JSzGyyOpM4stb8eeqtiIGRd3iGRc7xPpPYTrOeIhgkuPG1PHAFiVf40FA9kkT3cQ5Y
	 3AUmJr/uheeK822Kd21Epk7hNfnL2pn2OenOaOKNs7XcBHgd4MOqZ1XXZ/cft6sCmD
	 0nLLmF5QFLj1Q==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5134f830488so2775976e87.0;
        Wed, 06 Mar 2024 05:46:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKalx4M7E+N7G0YmiJd7IJHs/qIhD7fFZjNw8o/GAIg+hsNDOE32BH+4GvFmOe67Py8Tm4j4N9vkD4oUSWGFDdQcuHmEa0LpW0kf5Ce5Wuwbp5eyn4Uqq+oFb9LBne7AGRHdKihGr2
X-Gm-Message-State: AOJu0YxN3hwcZPY/0PDthkAaHRzGKIpOPHGwjAh7qfSAaikdVRYIeCxT
	HfTK6JiWFaN3xyEydypbQdJ27zla0ApXXZRAoB+slZHfE9mEZiD0uihSi/IogG8OBWcX8cKxr2+
	8gyRdGSpwhSKqfh6nVqfdqffxGf8=
X-Google-Smtp-Source: AGHT+IFtd6kyUyl/aaek2FXgMbPkbqLOm5F/X0tZjj45RQazeU+AuLjGUh5Wem8ANBIR/WKbUTh65kg8KWPii9/GDMc=
X-Received: by 2002:ac2:58d9:0:b0:513:40e8:d4fc with SMTP id
 u25-20020ac258d9000000b0051340e8d4fcmr3092686lfo.28.1709732805470; Wed, 06
 Mar 2024 05:46:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
 <26f3e99c-8f57-4779-a679-2085e469d9cd@siemens.com> <CAEEQ3wnDKdhCH4yz+MY+Xks21jLnuFiyx-xxa7CFczokG2shvQ@mail.gmail.com>
 <CAMj1kXFxzFRQz0BUVw27xdOj+xAVtX9jPjwaLHsEOYDUSqXMOw@mail.gmail.com> <CAEEQ3wnvTN5nGWAibjKKdMe4P3j3wPgghKn2HbOF1Xg56G=0kQ@mail.gmail.com>
In-Reply-To: <CAEEQ3wnvTN5nGWAibjKKdMe4P3j3wPgghKn2HbOF1Xg56G=0kQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 6 Mar 2024 14:46:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFtDyxsEvjN+Cg+HzSu_UmfES5mnpSM+LRcC3DuDoroAQ@mail.gmail.com>
Message-ID: <CAMj1kXFtDyxsEvjN+Cg+HzSu_UmfES5mnpSM+LRcC3DuDoroAQ@mail.gmail.com>
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

On Wed, 6 Mar 2024 at 14:27, yunhui cui <cuiyunhui@bytedance.com> wrote:
>
> Hi Ard,
>
> On Wed, Mar 6, 2024 at 9:11=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > On Wed, 6 Mar 2024 at 14:08, yunhui cui <cuiyunhui@bytedance.com> wrote=
:
> > >
> > > Hi Jan,
> > >
> > > On Wed, Mar 6, 2024 at 8:52=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens=
.com> wrote:
> > > >
> > > > On 06.03.24 09:56, Yunhui Cui wrote:
> > > > > This reverts commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5.
> > > > >
> > > >
> > > > This comes without a reason - which is likely something around "wil=
l fix
> > > > this properly later". But then you regress first and only fix
> > > > afterwards. Can't that be done the other way around?
> > >
> > > Sorry, I don't quite understand what you mean. Can you help explain i=
t
> > > more clearly? Do you mean "delete mno-relax instead of revert
> > > directly?"
> > >
> >
> > You should order your patches in a way that does not create
> > intermediate states (between 1-2 or between 2-3) where the original
> > problem is being recreated.
> >
> > So in this case, you should
> > a) fix the issue
> > b) revert the existing patches in *opposite* order
> Simply, I plan to remove "-mno-relax" and
> "\|R_RISCV_$(BITS)\|R_RISCV_RELAX" in the third patch (fix patch).
>

Why is that better than the current approach?

