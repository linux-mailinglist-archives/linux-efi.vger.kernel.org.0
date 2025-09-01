Return-Path: <linux-efi+bounces-4666-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED07AB3E70D
	for <lists+linux-efi@lfdr.de>; Mon,  1 Sep 2025 16:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC551A852B5
	for <lists+linux-efi@lfdr.de>; Mon,  1 Sep 2025 14:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8FD33A025;
	Mon,  1 Sep 2025 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHeHYpPz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806BD248F66;
	Mon,  1 Sep 2025 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736813; cv=none; b=MMPrdKkpwv9fzXQKSLB+4gFMyDBEapA31h2N55dUm+70UmBlhRGfIfcW3ivn8G4/kvmFaoWqGPORwNUgNW+5ogJz1sZ5DPHjZaX0HrgNmJsGrLvELetBONbQcpom9ZctHhc4rSE+Waq1g5spEY8P+jjEQBAPpPK1Nn2hS7APhrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736813; c=relaxed/simple;
	bh=LXjC1NQJ6fIpfpom6jrKjc2aXq5sLmIuoV+slvDg/+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMz1Fy+qaF3qi66uT4Wq3GBk30s5eA0Jha3j23LsIQbLsJdJQB1tuDBkxcFmdx81w7UBgV4BFeSXi913kYV7iTffd4bDVONULFpB57PQFHVJhaenCKm7KCewLAdsudWztSzS6hnhNHQIuFtjKKG4xZavgZKMRThPCZ0hfd+8t2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHeHYpPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EDEC4CEF5;
	Mon,  1 Sep 2025 14:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756736813;
	bh=LXjC1NQJ6fIpfpom6jrKjc2aXq5sLmIuoV+slvDg/+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NHeHYpPzO94hfPPVHJCtXSkApwsTA1DzhhaskN7I4UHG+/Ko09dt1Gwm0e5Gyc9tu
	 +jAeJvx/Rm79kJXuHjhZQz8bLcgLtMR/7XE0Rva80iYqJ70ucpJvee0fD16lX4NzTD
	 1qJo2KUf5v72QIOPrUD+WzbSIOw66Fm0aP/skR8VvCiH5rBqUV0j2lCUTCrCH/w+cw
	 mlDNmSr5eBCDYIWiPIjNuxSLVR8W9spS1InyzJndhiWpjOzfov/s7poBy8iqJH9t2+
	 pdk4I9fqZQITUISsiDOnR2pipPyE9XHv6kF+2P58i18pO5MvQajtSUnZRP1xaua7/X
	 AJPgoQ5TyC0kw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f78f32580so959359e87.3;
        Mon, 01 Sep 2025 07:26:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXN+K7s3SlMmla2EXBZJ3INwPtuxGSUIZn4sR9stkFtUXHe3R1dHCf3XChhUJ5VqhxdDZ7Ht+yFSf4=@vger.kernel.org, AJvYcCXu1k9vgvtEsanHgeCK9/JsO3oAs63Aem2W3/4AmOvA65+/hwhTfvYXBKd/t9JLjGDO31Rah2m9558v3pJj@vger.kernel.org
X-Gm-Message-State: AOJu0YxuuV6zO6MIrxkRsIzc5NA/aQSFgDdRjtLkoWvwmImFXm1Qwokr
	HTn0AUZfk3cWGbEzAWSoGIJzhYQyriosKKhIery0gIHnfrmdSBLWL4rUHr3xQnQAbxbfwJNE0s5
	0gOXa8nD+AgdHkKQDXX+lYDHE9WtUmR0=
X-Google-Smtp-Source: AGHT+IHGpTPGkjK6uGhIf8DLiHwqmQK1RZXPdIJk2HIB90PjPy2+9jpV8BnQ3WaX5u33p3mm1o3ls0RCGCzxZS4PeAc=
X-Received: by 2002:a05:6512:3e15:b0:55f:6db5:748d with SMTP id
 2adb3069b0e04-55f7089c530mr2585393e87.4.1756736811430; Mon, 01 Sep 2025
 07:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-29-ardb+git@google.com> <20250831104945.GAaLQoyYmr316kHrKs@fat_crate.local>
 <CAMj1kXF-aD74+O_xf_f902wq2RdPpiXCEjJ9osbnEwAMoN_5Rw@mail.gmail.com>
 <CAMj1kXEQghhi4qCdV6PrYK-mTYFu5yVcn3fEOSZsC6vR7TiMEg@mail.gmail.com>
 <20250831111521.GAaLQuyYLUSN24_ZmT@fat_crate.local> <CAMj1kXFHrkY9R8xjrB_PFqswc2yOHGpPfEBq5WZ0rH_vbo55Mw@mail.gmail.com>
 <CAMj1kXHzK0pSjuRYcZ3E2PQzCx4PTAC-UDHirgFDPYEyLMtoeA@mail.gmail.com>
 <20250901135459.GAaLWlsx75fnPHveLl@fat_crate.local> <CAMj1kXFRSJ1zT5XvBE2JT1jm2peOs9aymHeydOYk8AZRO=JDbQ@mail.gmail.com>
 <20250901142538.GEaLWs4i5CVcdIJvC-@fat_crate.local>
In-Reply-To: <20250901142538.GEaLWs4i5CVcdIJvC-@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 1 Sep 2025 16:26:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHrsR+qGA5a8s1GWsramZ_QEdKWgG2ehb3+kE=5+vaicw@mail.gmail.com>
X-Gm-Features: Ac12FXwXjjFIMDJQmTU6935iCS3FBewSxEwaX6AHE9rAHIujpLQr92kpO-ceJPc
Message-ID: <CAMj1kXHrsR+qGA5a8s1GWsramZ_QEdKWgG2ehb3+kE=5+vaicw@mail.gmail.com>
Subject: Re: [PATCH v7 05/22] x86/sev: Move GHCB page based HV communication
 out of startup code
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Sept 2025 at 16:26, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Sep 01, 2025 at 04:02:04PM +0200, Ard Biesheuvel wrote:
> > Are you sure this can be removed? It is tested in other places too
> > (arch/x86/coco/sev/core.c), and AIUI, it is a Linux defined CPU
> > feature so it will never be set automatically.
>
> It it set in scattered.c for the "late" code like sev/core.c:
>
> arch/x86/kernel/cpu/scattered.c:51:     { X86_FEATURE_COHERENCY_SFW_NO,         CPUID_EBX, 31, 0x8000001f, 0 },
>
> Tom added it to boot/cpuflags.c, in addition, for the early testing which
> we're doing differently now.
>

Ah ok, yes that makes sense.

