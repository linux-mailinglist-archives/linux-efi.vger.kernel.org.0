Return-Path: <linux-efi+bounces-1961-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FF099C686
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2024 11:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453311F22A82
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2024 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A22158DD8;
	Mon, 14 Oct 2024 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLC1+hWa"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB98154C0F;
	Mon, 14 Oct 2024 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899725; cv=none; b=CVSQ02vGhhx0ggyV+cYkQ/kUYKHogydwEze9NbHcfH4TLoXmM5TNTJAKhMQUmz4n4LcQBrsIrwsm55u1U2myq7a9PXu7LRoNgQ3FRZ52YS/1QBytvAm9hTdlQLGj3p0iQWUuzWL5dbz5U0TXGy2O5TI1hPvXPR2NJA3K80BCsoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899725; c=relaxed/simple;
	bh=3ZMSNdQ+QTXt0UQdH7cLlWIiwKzGSC3ZEQVfekTB6WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqI2pdraWAldsKXJ7SzN8StBrMM29O5XR29UYLmfYSjaPyWfBeex5vGGthqN5cPlaM5ZhVvLiS9oMY2cWXiVGsCMLyPC+qmGl9IK2FQMrt1Ty/KRXk3FlPyMXGixMLiNoAKyZSFs3y3K2DOA37X65PEy68liV6DXB7I6GXc6fTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLC1+hWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C46C4CEC7;
	Mon, 14 Oct 2024 09:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728899724;
	bh=3ZMSNdQ+QTXt0UQdH7cLlWIiwKzGSC3ZEQVfekTB6WY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VLC1+hWalODqOMM+bV8GENTNfw9u/qqY84g0az0Q52OQuzyB2r/LOAVavyYHiU7PZ
	 CKZe0PxYuva+bokZD4V1DZXc4vit3Tj2P1qlILBpLf1rdXKsOgrX9L8gL2pbQlkCG8
	 OfHwgVBQ3ySrl8hvXdOdlqFgmWYAeViyG/RihFzUPZuVsTz78gyhEYHKmqTdzVpCHq
	 sQxckcq9ADGghs6wP8AI0giD4etj3tJ0Axqb0atUTbVJFlxE95ep6SuuXTVjFlAn8a
	 2qIVPIrsYHHOPBj4fr5r/Zj67FEYyIPssR1+B8s/2EknsV1WbQmOVkn9qpvCyTfMgG
	 4XSRwYwymMx9g==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e63c8678so1576443e87.0;
        Mon, 14 Oct 2024 02:55:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXs4hO1be/0g9vcX7SmbCH7H0EtfDyBfw0fAXMWaO+d3hGcKwvjBXPLWv0usF5tSYUnihN+KwMKHFlyim4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweBP0ItrCBownD97bvMrtj5yjVImFZW4hTuoSG/2flebDav9FT
	6iKNEqGUAmpesYAZC1G6iGcMKcD/W92K4aIVy1dBA3E7An3DcPmGcvUnlGxzPPIJ7u9z/LUNiJ6
	+lfNunHEySDSs3bZmyaK8Wmya7is=
X-Google-Smtp-Source: AGHT+IFMzNxgnEYcg2RS1dxa0nLzOYTnVQy8ri+bd8Yhbe52Y7JuSitH+4b0zobiJZv4UMc9RBk3poZWzp8s/obvi/4=
X-Received: by 2002:a05:6512:31d2:b0:537:a855:7d6f with SMTP id
 2adb3069b0e04-539e5518b62mr2722261e87.34.1728899723292; Mon, 14 Oct 2024
 02:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013051239.22564-1-jonathan@marek.ca> <CAMj1kXHvOgGysdPSNNk1bUR2f5tzRaxr4=saqF8KFXq+q6gDCA@mail.gmail.com>
 <b13dc40b-cb72-02f6-0379-358499696eb2@marek.ca>
In-Reply-To: <b13dc40b-cb72-02f6-0379-358499696eb2@marek.ca>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Oct 2024 11:55:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGbuZnM8GoHasWNxs2YOnUDL-JViRmvGdVc91WHkMbdqA@mail.gmail.com>
Message-ID: <CAMj1kXGbuZnM8GoHasWNxs2YOnUDL-JViRmvGdVc91WHkMbdqA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] efi/libstub: fix efi_parse_options() ignoring the
 default command line
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-efi@vger.kernel.org, Aditya Garg <gargaditya08@live.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	open list <linux-kernel@vger.kernel.org>, Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 13 Oct 2024 at 21:25, Jonathan Marek <jonathan@marek.ca> wrote:
>
> On 10/13/24 1:30 PM, Ard Biesheuvel wrote:
> > On Sun, 13 Oct 2024 at 07:16, Jonathan Marek <jonathan@marek.ca> wrote:
> >>
> >> v2:
> >>   - changed to check for NUL character instead of size==1
> >>   - reworked cleanup patch to remove cmd_line_len
> >>   - moved 3rd commit out of this series
> >>
> >> Jonathan Marek (2):
> >>    efi/libstub: fix efi_parse_options() ignoring the default command line
> >>    efi/libstub: remove unnecessary cmd_line_len from
> >>      efi_convert_cmdline()
> >>
> >
> > Thanks. I'm inclined to fold these together and just merge them as a
> > single patch. Any objections?
> >
>
> No objections (its not important to me, but if you want to get the fix
> into stable I think the separate commits makes that easier?)

Yeah good point. I am not going to send these out as fixes anyway,
given that they affect boot behavior, and there are some other things
to fix.

