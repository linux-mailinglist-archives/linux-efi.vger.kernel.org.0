Return-Path: <linux-efi+bounces-2692-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E3A16AC9
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 11:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789AE188759D
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84411193409;
	Mon, 20 Jan 2025 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiwhTKLF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA191917F9;
	Mon, 20 Jan 2025 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737369152; cv=none; b=PD/3jHRM5VBbCk7var4hxKPyMd8uzq6Kv2oGowrtocY2PtpMv/+nEtrbwEVFHBa5vsc+Xo3GuUiIp4x4DC2+Jy94Z6d8g7O8eQLLskBuE12uQiCgaCPT3oRFPCXy6uqCkJncCa49PPkkUXDH1l7G+KDsDjf+fROOYo2kCisNl1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737369152; c=relaxed/simple;
	bh=GDjp/3qZSP0yaVZ7+rsBSDc0lEeMc58n2sy+4YwlrQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxcX+J2JCnUEOZ9BnwVJsg4sGAfGbl3pmzdGRzsr5H24xLtdgcY3STFZTE/s23Af7jBvOY7AC2tvvXzEUQq1XWTaCa2p8ENPlWyU8qKU6SFhqdonKsuh7VM0enQeoI92EjH+eWrS005xS6biuyUiK5mPqDlw+HrYGQ/jRzw1Brk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiwhTKLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E35C4CEE0;
	Mon, 20 Jan 2025 10:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737369151;
	bh=GDjp/3qZSP0yaVZ7+rsBSDc0lEeMc58n2sy+4YwlrQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iiwhTKLFlGUtKynzWQkLAjTigZC4aTPbgKZfoBP3T5+z1WApZABr+cWr9fAgWuHYu
	 HgNWr8mOGEwlGLJV1fFnzv+aUa43kas/Q4SmuUO3mWSotyZsSsCYFWFZxtRyxZ2fMm
	 iWJ9F9Spobf4xhHlhE5QhdaAnvPf2opseThrBYhlsCnVFPoQjLwQGE8wBoRZ1fw0qC
	 +RtZ9L+UXJBrPned2oP8hr51lauM9PxKE5zTwnrqZF9RN3KaHEafmTozMZlJrOXsbG
	 uvrIMofxnjY6VjEm1QchD0NUlzaCqY2cPSRgRq70mMLW9goaBxNsMsz2ykbrNQNYI7
	 TQ8ncQqL9Fwbg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54287a3ba3cso4936623e87.0;
        Mon, 20 Jan 2025 02:32:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXooZhitwAnmAhknu69pWKlLsCKQ9/lGRZ/H66S99VfGOQOvSmTEhjEDT1E4AvuYHkCG/zwoduXjsh7iKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwS/JEWZ7CODCA3lXF3RQHS9cqBFIv2cAo/lGDqq21f+E8Bxl
	ORIC4BkpwcFMGxSQmsGPdhavaKmCswIh3ppDVWd7l3tHDyvfX5WVK58yWHA1PZ9iCK7DG1iFPaa
	tSQwEn5VzxCUxNT50mSly4KW4TEs=
X-Google-Smtp-Source: AGHT+IHx9QEuYpomCSuy/AQ5ViuNCow0gDRQDlzuXyvnGAsOyS0+452OrfOi+IpmB8bQ9WARQeP3HuK6mgnW2rxwtkI=
X-Received: by 2002:a05:6512:1045:b0:542:8a7c:509f with SMTP id
 2adb3069b0e04-542abf503d2mr6892244e87.2.1737369150134; Mon, 20 Jan 2025
 02:32:30 -0800 (PST)
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
 <ed7ad48f-2270-4966-bdba-ccd4592a0fd4@gmail.com>
In-Reply-To: <ed7ad48f-2270-4966-bdba-ccd4592a0fd4@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 20 Jan 2025 11:32:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFMxfOswAdBEVsCoVO90y_m1TUigWRG-3FJTsv4xOGTpw@mail.gmail.com>
X-Gm-Features: AbW1kvbSiocF5LdXALV9g5C9SpoIRpL6JzzoTt3_wpE-me8DVnzqOJgG_TGGx4s
Message-ID: <CAMj1kXFMxfOswAdBEVsCoVO90y_m1TUigWRG-3FJTsv4xOGTpw@mail.gmail.com>
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	hannes@cmpxchg.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	leitao@debian.org, gourry@gourry.net, kernel-team@meta.com, 
	Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jan 2025 at 11:27, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
...
> Hi Ard,
>
> Just wanted to check how should we proceed forward? Should we try and fix the warning
> and corruption during kexec as done in this series or not initialize memory attributes
> table at all in kexec boot? I would prefer fixing the issues as in this series.
>

I would prefer kexec boot on x86 to disregard the memory attributes
table entirely.

