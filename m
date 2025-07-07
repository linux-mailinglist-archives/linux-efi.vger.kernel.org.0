Return-Path: <linux-efi+bounces-4177-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF1BAFBECB
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 01:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8359F1AA56F5
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 23:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6138B28641B;
	Mon,  7 Jul 2025 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMNqaREG"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0017DFE7;
	Mon,  7 Jul 2025 23:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932276; cv=none; b=hlUz67T7d85TIt+ZaR1TC0aD0rSjRXFv9pqS3J6gHbB8IaHIk2l4MXJlXHEEvxN6MYCpI2kUkmu12f7LA/hPj8FAYzg7HIH3z6pNYrnuMZQAlTkCMD9d8FGaRmf+AZNJ8+2/yxL7aDM7FGzVwafkl5RO5f7OgYiIiKEuPGQ0dgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932276; c=relaxed/simple;
	bh=g6Zd4/YDNPpc8R6MR1dmXxoBbReZK1XUHG0S0Nc65TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i807rY5yn7G2h/K1yqkApd4vrX50zs13fNMa1TI/ap4kvBURNnEuhZp3l0WaHyhQIl4lUIiKF4pBaaAAPvuAz7yxxZqKUoSrI9NCm+9Xb2i/C8ei28N5Mh+h9sDYza5cuh42pXnOuduR9I64TlSsdDPUSSJPzPsWn/1FZpHhg9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMNqaREG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF649C4CEE3;
	Mon,  7 Jul 2025 23:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751932275;
	bh=g6Zd4/YDNPpc8R6MR1dmXxoBbReZK1XUHG0S0Nc65TU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lMNqaREGgynbC0APNevxTVYNZc4nSkfrn4meWm+WKY3wNJbRiPoJ2KTo11gJzjUEu
	 num6hHNDYkC/hEcpfkkkc5N8IXWvtkJNGyZkkU+PqVDc395zu3HtZUVgyY111lalL2
	 unsDRf5xAR4htC5bY/yisBW3XNIwhjFyNyRo66MHJgcSLeW+mQVgXP9Eu+ISWcs3bP
	 ILklmt3qhIKtuXWNkbbfIBsp1qBO/s7hKXO3XO3L8fAXR0AHG+3m6nrCoLAY1GWi6L
	 wWOQADFgiySRGy45N6hOMtFGfyMrPVjG44Qv/nn1W7oAKAm0oCtb2kC35uS2S7lmCs
	 NLvwU7ekmwtKA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54b10594812so4573768e87.1;
        Mon, 07 Jul 2025 16:51:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4a9BB05sZUIgvIECldvPYLTqi5L5ra3fTswAz9CmuWxrsoG3nmTzCjyc1HYpQIRVy1/evWav0Elw=@vger.kernel.org, AJvYcCV9hxK8bY5oZyvEW7WLexdBIGrQChnJpsYMBcsCW/fih6BVpECwpd/XCNSQIsZhJw/IQZ3lA2wQ/ez02FrH@vger.kernel.org
X-Gm-Message-State: AOJu0YxbgNLkIwfUE8aePF8GmszofAaUkJsXlv3WzRLBZqqd4cnWhNwi
	2ZqEr9WF0iz9kC7gfvmEM+0FrqAx64noovYfwpOHutjc/bV+pEDiCcnNPQlDt45hIPmlSFnz++T
	VdUFgaemli3TGpJZB4EqNfDuDI1PBe8c=
X-Google-Smtp-Source: AGHT+IGMaguh6toiAh/k7cFQ1tuRjFzWdDQNSdoI3c4ua80mQ80lPdQl7Oxx/+O05xgqGkLgYx6+sISNhnhDmYkrTVI=
X-Received: by 2002:a05:6512:e83:b0:553:543d:d999 with SMTP id
 2adb3069b0e04-557aa2930f2mr4546082e87.32.1751932274154; Mon, 07 Jul 2025
 16:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606154112.311565-1-vkuznets@redhat.com> <256ad7fc-c6d4-470d-a434-7b5556c3b8f6@redhat.com>
 <e1644469-77ca-4770-bc79-5243a46b8a9e@redhat.com>
In-Reply-To: <e1644469-77ca-4770-bc79-5243a46b8a9e@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 8 Jul 2025 09:51:01 +1000
X-Gmail-Original-Message-ID: <CAMj1kXFg7wnfn=ipd86XNxeoXa=LtWviAgiVoTL1Y76q0yWA9g@mail.gmail.com>
X-Gm-Features: Ac12FXyFHDNA3lSkwd3CiRKZ5s-R6kUiH-K04bNkBonH3HICWhgRZ4ZqunZ7Dsw
Message-ID: <CAMj1kXFg7wnfn=ipd86XNxeoXa=LtWviAgiVoTL1Y76q0yWA9g@mail.gmail.com>
Subject: Re: [PATCH] efi: Drop preprocessor directives from zboot.lds
To: Luiz Capitulino <luizcap@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 07:36, Luiz Capitulino <luizcap@redhat.com> wrote:
>
> On 2025-06-06 11:55, Luiz Capitulino wrote:
> > On 2025-06-06 11:41, Vitaly Kuznetsov wrote:
> >> Older versions of `ld` don't seem to support preprocessor directives in
> >> linker scripts, e.g. on RHEL9's ld-2.35.2-63.el9 the build fails with:
> >>
> >>   ld:./drivers/firmware/efi/libstub/zboot.lds:32: ignoring invalid character `#' in expression
> >>   ld:./drivers/firmware/efi/libstub/zboot.lds:33: syntax error
> >>
> >> We don't seem to need these '#ifdef', no empty .sbat section is created
> >> when CONFIG_EFI_SBAT_FILE="":
> >>
> >>   # objdump -h arch/arm64/boot/vmlinuz.efi
> >>
> >>   arch/arm64/boot/vmlinuz.efi:     file format pei-aarch64-little
> >>
> >>   Sections:
> >>   Idx Name          Size      VMA               LMA               File off  Algn
> >>     0 .text         00b94000  0000000000001000  0000000000001000  00001000  2**2
> >>                     CONTENTS, ALLOC, LOAD, READONLY, CODE
> >>     1 .data         00000200  0000000000b95000  0000000000b95000  00b95000  2**2
> >>                     CONTENTS, ALLOC, LOAD, DATA
> >>
> >> Fixes: 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT section")
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >
> > Thanks for fixing Vitaly:
> >
> > Tested-by: Luiz Capitulino <luizcap@redhat.com>
> >
> > (this is for the build test, not SBAT testing).
>
> Vitaly, Ard,
>
> Are we planning to include this fix for 6.16? I'm afraid we'll introduce a
> regression if we don't include it.
>

Apologies, I let this sit for a bit longer than I intended. I'll send
out the PR today.

