Return-Path: <linux-efi+bounces-4345-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00F8B0509B
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 07:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D230F4A79F1
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 05:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3891B25F994;
	Tue, 15 Jul 2025 05:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gak5QrGR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109938248C;
	Tue, 15 Jul 2025 05:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752556169; cv=none; b=cc/1FR4kX62rjzCvdBBG9aDiUIQz5nqolZV1gUWDhf8hiZxh/CAC7r9lGsXb9D9U8IbxbOQ9KZIq965oQRm1p6W6B0Vfo1PaaDbtqfhm9TsSze1Gdrb2uEfMXedxKODUUTRxl3TaZonjpioCGpGNoQ3jJA/d9QrKDZP+cLznnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752556169; c=relaxed/simple;
	bh=PhqLb+Lr7k9vePdjKOgjAtahAs1PSS1SUYnE2QCrBmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0cWM0sHDlMBQuMi6zXnB8epOXSgIeArpLMFlqVvbfwWGA/8CcsblV27G80Io6b27czswrq746Gm+QQtP6+2EK4nI5bsAyRt9DqrSs43L3jFTPBRZ6QpKpAKWpx8B3CW2d2lTkcjzTU/AyJKoIBpD9+DggMLgwhtF3i+w5utwR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gak5QrGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E89EC4CEF4;
	Tue, 15 Jul 2025 05:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752556168;
	bh=PhqLb+Lr7k9vePdjKOgjAtahAs1PSS1SUYnE2QCrBmI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gak5QrGRKAbZdnEGxVnROtmYFoHIfjJnZH3vLxFFhrhLt0+LR7VCCyRxR4UDIhrD+
	 qNmla1c7UPdSDcomGMdKr5TBpGVLmRF6Oy++wdu8492aLQI7tLSb8meVBJ+mnv529f
	 QHcQefW7E57nhkhus0evzobvNG5I7sOUXe7Of3XvCuudm5W9kujc/J/+Yljufp/k2z
	 YaXnOP/AOT41pwez/xn5MhB+Iudu9lMG2KcgLpDfWPmT6j4tK6N0WnpZtKv1b6zw34
	 QmSD+ooB6LYDkH08iupE+krnrckdNacEaZvrmZ6XWCrhN8mid3nXY1HJ7vPhUs184L
	 THuivP6Jta6Ww==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-556373661aaso4209892e87.2;
        Mon, 14 Jul 2025 22:09:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvRybGJ7yGkl3GGXUAsXNxMnmk+JbC8u73vrsjn2MyN9QTv6oH46ivEW491Z5TKtyaMzQVvk7kAAk=@vger.kernel.org, AJvYcCXrFPUIsH3kRm4P2hZqRlia3NVvhav5yV4hhIdx9UXtUKdRAsAnnKFoKS0AWW6XT9UXzkmRElbihqbqocRH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3oWcGsZiqN1mj70pjJR/CchK2rQvK4Eks66hATtv6BXLqVuU
	/XOfnXWqUn8olPyR2eIPNT30Yqd0QojWBoEyYiEiqzTI+Stu/WmpLyUh5/jRtQRqlrnl75EwVGe
	mj0b73Y8jJlmUv09RTSkFK9drZLlUSxI=
X-Google-Smtp-Source: AGHT+IHKAKIwXVVneFXdNMccii1Yp5WMopm97MAz+Ip2SVK0JpVcxWrXLh/w4g1H+L38OjRvw+Z6CQnKOdaQV49digU=
X-Received: by 2002:a05:6512:686:b0:553:cf7d:7283 with SMTP id
 2adb3069b0e04-55a1ddd12dfmr341256e87.33.1752556166902; Mon, 14 Jul 2025
 22:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
 <20250709080840.2233208-34-ardb+git@google.com> <d872728a-e223-8bcd-7652-7dbe38d93802@amd.com>
In-Reply-To: <d872728a-e223-8bcd-7652-7dbe38d93802@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 15 Jul 2025 15:09:15 +1000
X-Gmail-Original-Message-ID: <CAMj1kXFPQyAwSfyXjhrpvThsVtMT31AYG5JdypsCEBJee=Dgsg@mail.gmail.com>
X-Gm-Features: Ac12FXyF030hrouiF75XUCRlBlgXRjHJcUIL6sIfkWRHCByPdq1SBy-06d42Rg4
Message-ID: <CAMj1kXFPQyAwSfyXjhrpvThsVtMT31AYG5JdypsCEBJee=Dgsg@mail.gmail.com>
Subject: Re: [PATCH v4 08/24] x86/sev: Share implementation of MSR-based page
 state change
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Jul 2025 at 04:24, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 7/9/25 03:08, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Both the decompressor and the SEV startup code implement the exact same
> > sequence for invoking the MSR based communication protocol to effectuate
> > a page state change.
> >
> > Before tweaking the internal APIs used in both versions, merge them and
> > share them so those tweaks are only needed in a single place.
>
> I think you can keep the save and restore of the MSR in the the combined
> code so that you don't need the previous patch and that will keep
> everything safe. We should be doing a minimal amount of MSR protocol
> page state changes, so it really shouldn't have much effect.
>

OK, so I'll drop the previous patch, and rework this one accordingly.

