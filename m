Return-Path: <linux-efi+bounces-760-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE29874D25
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 12:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89500B23076
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AAE127B7E;
	Thu,  7 Mar 2024 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5IYZXcZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56386AC5
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810036; cv=none; b=nf+8GdVzDWuWxNLc/h9HuLZis7Epklwx9QBu+DTX08bFq3loCdhYsE5RxlQ52edrMW5ObZymDIP0hf2TewuGHZ/rH7qyRC+4XtefJCuyBEXIDuYmfVuvkux9eZIjHQeLUwMsgy+T4klRTi9gFzc6BlsjD4/U+0aDtJOHfza62IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810036; c=relaxed/simple;
	bh=JFo6+21egMJ+HMsq+Ypj5c2ko/Qw1CKsLuNZ/O96z+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYz6Rj9n/6XZ4sgRXGsOQQbuVs4LlZ2jyIdMCjer+cX9dgG08eGljexQU+U8B6QI/eLlGnnvgrKLEYKY/bbsaSl2oDN0Gjxwu3Cm7lc5kPAnuKKXRKpjplog4NcXEAM68WKxBFhy6MvM/V8QU1Nx8rq601/Qu6uQkv2XIIhJTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5IYZXcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68EAC433F1
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 11:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709810035;
	bh=JFo6+21egMJ+HMsq+Ypj5c2ko/Qw1CKsLuNZ/O96z+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M5IYZXcZQYTm1jQjbUL52zLkHJLnzfP1XvXYJZeed/F+eEz71OfRqkpUSl+r4gbNc
	 HnTZRuM+nQKK2B7pkM0Qm5x7WinCMowZ9pEVf27Ttd207Xs3F5CSsnYpingcYROu3n
	 zlUlauOFccm3AAvYqS9CtE8M7Ffzgor5rHw5u8weYZq9nPAHobz+ShT16NZG/adRmp
	 Slcq+2AdWJhQ77XGPLw1h3L5qwnikuHCp2/WqlB2jEYF8Jnj2O7j9qu9sY3K90GML3
	 NN8xwNdKlmc69cb06MlQNM5mi99bLM9q7dGlUuiyyqH/c5zjRSBEYQHPUf8lgyuRJY
	 Z241WJMC45tnA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d27fef509eso9822541fa.3
        for <linux-efi@vger.kernel.org>; Thu, 07 Mar 2024 03:13:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQ8C80q0If9WrAfoab9KEtiCI5g/c1EdcITGS4Rf52ZPU0XOup0+tyEE8y18kV/KpwuSYbGylM5IhLv3P9h2Il4Af49VogGmVZ
X-Gm-Message-State: AOJu0YxhwBPAiBXHhSviuynawLGoKp9ckNmCrxojC+bu3Jg6AwpTbj2H
	GZ9DrGDFUxUYFgZ6t4eoXG/jB8b5FcEz/yZ2Txd032scl9T9Un6NzY+HlSEZTHzcqSw6/fywdG+
	n4vxe37rD71uNvkmG19SYbvLR7B8=
X-Google-Smtp-Source: AGHT+IGU0d7nuKQ7e65/nOwU1ITb55FrPli4bI0Znl1veN4gMjnEHR6wNepzTsMHRzGgSR9S8dF5FIFBv9qkER8tsBM=
X-Received: by 2002:a05:6512:2215:b0:512:e4f4:b562 with SMTP id
 h21-20020a056512221500b00512e4f4b562mr1370919lfu.31.1709810033911; Thu, 07
 Mar 2024 03:13:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0229a87e-fb19-4dad-99fc-4afd7ed4099a@collabora.com> <CAMj1kXE166VdJLWSWo7_3MDw4V3zSuYRx44Z7yqyj5mQVOdDCA@mail.gmail.com>
In-Reply-To: <CAMj1kXE166VdJLWSWo7_3MDw4V3zSuYRx44Z7yqyj5mQVOdDCA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 7 Mar 2024 12:13:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGFLwsgPo9Xy_-9gaOUUO=wDd_K12ccYUhP1nWf3KLb0w@mail.gmail.com>
Message-ID: <CAMj1kXGFLwsgPo9Xy_-9gaOUUO=wDd_K12ccYUhP1nWf3KLb0w@mail.gmail.com>
Subject: Re: [Bug Report] Bug in "efi/libstub: Add get_event_log() support for
 CC platforms"
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, 
	"Kuppuswamy Sathyanarayanan," <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 12:08, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Hi Muhammad,
>
> Thanks for the report.
>
> On Thu, 7 Mar 2024 at 12:02, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> >
> > Hi,
> >
> > The recent patch:
> > 276805fb9c305: efi/libstub: Add get_event_log() support for CC platforms
> > has introduced
> > #define EFI_CC_EVENT_LOG_FORMAT_TCG_2   0x00000002
> >
> > But EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 has the same numerical value:
> > #define EFI_TCG2_EVENT_LOG_FORMAT_TCG_2   0x2
> >
> > Thus there is dead code in efi_retrieve_tcg2_eventlog() i.e, multiple if
> > conditions with (version == 2) I'm unable to decide on what is wrong and
> > what is right here. Please have a look.
> >
>
> Why is this a problem? The compiler will recognize this and simplify
> the conditional. The code as written is semantically correct, the fact
> that the symbolic constants resolve to the same numerical value is
> just an implementation detail.

Ah hold on. I see what you mean now:

if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
+ else if (version == EFI_CC_EVENT_LOG_FORMAT_TCG_2)
+ final_events_table = get_efi_config_table(LINUX_EFI_CC_FINAL_LOG_GUID);

Yes, that is broken.

