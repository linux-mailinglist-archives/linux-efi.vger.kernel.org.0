Return-Path: <linux-efi+bounces-2567-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4945BA08F90
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 12:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8C63A5D13
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE3205AB1;
	Fri, 10 Jan 2025 11:36:44 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713D1F5435;
	Fri, 10 Jan 2025 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509004; cv=none; b=tqyiEme5B6tgyGEYVWXZw2l4mWi7bdErSidliTQre3cD/1DUMpSWoo6w1/D5s0VwuyT77gUxlUjU/8GQQk/Utbv0cvIfxZnDCsCsrwinaufIZ0K3izZy1n2+Ho378CpVXbuseJSj2bX90q/nvMgeVQ7Imz8fVIkQgqLr08E/HRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509004; c=relaxed/simple;
	bh=qDGrMfHmx1rR7hUQzYYruZ4g+XZ+A+QQq1r7QplZ3bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHOwL3YvUTkJfqlvD54jf2NXEjlxT3EAuwYZzcKW5G22A7GAjxSX3IPZd+zGhWQ0gG4bWnHoHSA5I/VSpDwMH/87WoL0E2z2K7bA9JRlWj4QewJDehlZCjL7e8ZI8O1G4A2zn1ePS2k45L2Md2Qn9zqRJFmBU4EAflC9RVbJmv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so274217866b.2;
        Fri, 10 Jan 2025 03:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736509001; x=1737113801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSxjuNyxDuPeZYeh/mDIk1/h0nKxV8R1eU/I8hrKgcA=;
        b=MMlFPM1iha/s2SUFQkXGwM08YV5MHjaOZccyQffIS+pEymOcdJgF6FL4c2ufmSzL3M
         NbwdLbAA0unbnWvv7Umxkqni1c+58tKvz5KOQhX+OqKgDybaNsOJMjPRApamA+rWZxaz
         7H2biZGZjrwBZ5weYobcW+hxfMe/dVNji8BYc2hW7qi9Wdxi55da1Y0EYEp1Z0wHWR3i
         upE89hwnbIWf3d9Pneb09f3bEPqg9TC7V3vGZNerxrBZU7C6OEOQkWf3JoezIh3G77JJ
         qpiaSbBQw6NuspMy4BD5LJzGfH/aujL+ILY3g9UCDuHBAlwdoiKdGgAfjVEApVIovoQO
         l8Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVJdsi92Lhfm9egfBbO5mifM0uyyGnF5FugaFWo+T8VyDL82nkFt3iars0rBky3qjiqJVy/fFpGO9yvKNsf@vger.kernel.org, AJvYcCWhZlrnHctQ/hWAVuU8ovmxqqs0V0aqy+pSCg0ZVi0MUNfvjnkmtbYltUHRBJQaZBsb5lw1uLemGLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxsWkCU1eVnHFuHiNAvSZtj41oIDpaawl+4ct8n7jl0QrR+HU4
	z9BvMnDIN1oXjedEMFy+/+2PFV23q3FiSrthKLg8NXXsHa7Em9W+
X-Gm-Gg: ASbGncvJY9mmtm18v+EPrTS+YOO7EvdWdAi+6rtt+eSLKfegunRgS4DsiqsTsIGh1mT
	w7uEy0z2ppetk2P0H2MZ5UT4i8Dj/lBGuhUEsAMhHx6CmB8giSbXOt4UniF43pBpAcu0o0SEP+W
	8U9/Q7r2vjELlP4qbYTduGxmMaofTORE8zkQUCwfKlxkZXRZulwxGHgKIK0iE8N17OfqOiqx0Xi
	zTstuyxss4Npkta+V1kFKHzIXu1COT1kRqC1gnBJwAinho=
X-Google-Smtp-Source: AGHT+IGIZlaaiO27kV1c6pYvSmK5yivViBw4/s4Cw1C7tk9hpsncmsora6RSQ36sS5AvV4d5XB7zDw==
X-Received: by 2002:a17:906:7311:b0:aab:7467:3f6a with SMTP id a640c23a62f3a-ab2ab6a45f5mr887149666b.21.1736509000764;
        Fri, 10 Jan 2025 03:36:40 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c905ec09sm157964566b.32.2025.01.10.03.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 03:36:40 -0800 (PST)
Date: Fri, 10 Jan 2025 03:36:38 -0800
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org,
	devel@edk2.groups.io, kexec@lists.infradead.org, hannes@cmpxchg.org,
	dyoung@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
	gourry@gourry.net, kernel-team@meta.com
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
Message-ID: <20250110-tricky-grasshopper-of-maturity-21771f@leitao>
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com>
 <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
 <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com>
 <CAMj1kXFwgnQT4jQF8zsX05PdrF_QDXK0+Z-6DD6LiSgjqY738A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFwgnQT4jQF8zsX05PdrF_QDXK0+Z-6DD6LiSgjqY738A@mail.gmail.com>

Hello Ard,

On Fri, Jan 10, 2025 at 08:32:08AM +0100, Ard Biesheuvel wrote:
> On Thu, 9 Jan 2025 at 17:32, Usama Arif <usamaarif642@gmail.com> wrote:

> > I think in the end whoevers' responsibility it is, the easiest path forward
> > seems to be in kernel? (and not firmware or libstub)
> >
> 
> Agreed. But as I pointed out in the other thread, the memory
> attributes table only augments the memory map with permission
> information, and can be disregarded, and given how badly we mangle the
> memory map on x86, maybe this is the right choice here.

If this augmented memory is not preserved accross kexec, then the next
kexec'ed kernel will be able to find the original table?

I understand that the memattr region(s) need to be always (in each kexec
instances) `memblocked_reserved` to protect it from being used as a
System RAM, right?

Thus, if it is not passed throught e820, kexec'ed kernel needs to fetch
it again from original EFI table at kexec/boot time. 

This brings me another question.

If the kexec'ed kernel sees the original memory, why can't it
augment/update the RX permissions *again*, instead of passing the
previous augmented version from previous kernel in this crazy dance.

> This is a kexec problem (on x86 only) so let's fix it there.

Would you mind explaining what kexec needs to be done differently?
Should it preserve the augmented memattr table independently if it is
mapped in e820?

Thank you!
--breno

