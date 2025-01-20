Return-Path: <linux-efi+bounces-2694-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9F4A16B9E
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 12:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146A31880631
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 11:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B71DF728;
	Mon, 20 Jan 2025 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoSiUS6t"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC131DF252;
	Mon, 20 Jan 2025 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372596; cv=none; b=hhPmYCkx1ghlQD5qgoGQHUDXuXp1b4SbL1Dserj7vsVGVXPNnoIjdYkBfUADQuxioJOICRZXU3BSZrZGOCI8nIbT+WGhOAzGA3MbD4uVeddIjAwUwWshjTxxWi8sfsP+OppTrGzprhxOKA7AA7uDJcu0X8+P0AhfEePnJIMja7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372596; c=relaxed/simple;
	bh=bkOG/wiavVoSPZmvBGUylFMX2LgSHcSIzuKHpjcrowQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1enQx6KSQ2NJz9iwEPrgS6P+0mku/Z+TphEopHl+dQROBaBXnvVQN8TDdrZT52CpFHAY++FCBpr+8RH3Kpc8c5LAMoyDG2M7+TX23ZhBuVLAHU9ciwC0zgwqGLqbL4dSveUl7SZudGO+ryMJmhAQvT8O/c9IoKg/Cs3yxizaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoSiUS6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BF5C4CEE3;
	Mon, 20 Jan 2025 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737372595;
	bh=bkOG/wiavVoSPZmvBGUylFMX2LgSHcSIzuKHpjcrowQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NoSiUS6tQadoQFt8/5JsmFAVzNnfg7wMqAGidnv807zqKl8U6kRDye4r0XnmM075w
	 5I60kC1XgtrJwS0vxYDHIne9K+cQWhE4UO92ch6X+EocXCuO1iBkUVyqikeurQ7PJV
	 8BN2JA4NwoiNXwkVnR2UOYzux+X2E+vF4CiOCSyMbHwVmFuCHDWP2PAvrUoaW/tNDQ
	 mMuupWtRoJuWrYpWREL2pkNncuEwwjV1rxpDs/fi8J7hvPyMQn6gDWoShwSL+GcJdK
	 2aCIwLQoG556x9qmdTInvQY63M1ac6RJ8p1/rksfXocPnS2BwduwIq29V73YrWzWb5
	 0IlBMtm9NzW4w==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3061513d353so40181761fa.2;
        Mon, 20 Jan 2025 03:29:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUda6oS9oGwZ3eo+AhbbJ8U5caOhj9usnO/jRA0cYS1RglGyV9mRsJIjnR8v859fVyqP8O3yMHwuPZpbIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3kFPCQx350RmH5uJ+ZGqSczhtXakvFD1Axqd0qkL3k0NWFazU
	41ZaN/FgoY5Rfm7o+hzblDKqKlV20TG0ZsLWOD/HxqN3Gytdzf0qI3YCkgry2XtjUFf/o2qpYKj
	m99h7W+STb75mJ1e0UAGk27DTkTQ=
X-Google-Smtp-Source: AGHT+IGNxrMOnOIAWE/wFoL5lfSdbC9E8swPrDYTeFRacrHO/Py3Bl/Wke94VpS8fEIG5mlWiSxjrfr3K7Vc/jvFUv0=
X-Received: by 2002:a2e:bc18:0:b0:302:1e65:f2ab with SMTP id
 38308e7fff4ca-3072caa13b5mr49028121fa.20.1737372594247; Mon, 20 Jan 2025
 03:29:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com> <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com> <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com> <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
 <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com> <138f28ec-341e-4c48-a14b-4371a8198de8@gmail.com>
 <ed7ad48f-2270-4966-bdba-ccd4592a0fd4@gmail.com> <CAMj1kXFMxfOswAdBEVsCoVO90y_m1TUigWRG-3FJTsv4xOGTpw@mail.gmail.com>
 <029cff22-f2e0-4796-9c27-1df056e08f8f@gmail.com>
In-Reply-To: <029cff22-f2e0-4796-9c27-1df056e08f8f@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 20 Jan 2025 12:29:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEhKbuqVz9paggxQQz1Wyk_UNRvWZ46X7YKx9b-xMfWyQ@mail.gmail.com>
X-Gm-Features: AbW1kvYdsQPQ_3t732WmECe_gD4pITHs-agDHxVG4Hyf2tsLvavhpYRZ3h6XkUQ
Message-ID: <CAMj1kXEhKbuqVz9paggxQQz1Wyk_UNRvWZ46X7YKx9b-xMfWyQ@mail.gmail.com>
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	hannes@cmpxchg.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	leitao@debian.org, gourry@gourry.net, kernel-team@meta.com, 
	Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jan 2025 at 11:50, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 20/01/2025 10:32, Ard Biesheuvel wrote:
> > On Mon, 20 Jan 2025 at 11:27, Usama Arif <usamaarif642@gmail.com> wrote:
> >>
> >>
> > ...
> >> Hi Ard,
> >>
> >> Just wanted to check how should we proceed forward? Should we try and fix the warning
> >> and corruption during kexec as done in this series or not initialize memory attributes
> >> table at all in kexec boot? I would prefer fixing the issues as in this series.
> >>
> >
> > I would prefer kexec boot on x86 to disregard the memory attributes
> > table entirely.
>
> Would you like Dave to send something like
> https://lore.kernel.org/all/CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com/
> on the mailing list (wrapped in ifdef CONFIG_X86_64)
>

I prefer this approach. and no need for the ifdef, this is x86
specific code, and the memory attributes table is already ignored
entirely on 32-bit x86 iirc

