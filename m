Return-Path: <linux-efi+bounces-3435-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8719AA9945D
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 18:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9C91B884AC
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 16:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1238264A95;
	Wed, 23 Apr 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IM3VirT1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C0928B4E6;
	Wed, 23 Apr 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423413; cv=none; b=S59gZvBPcNtU/hs9oLhshomZUDSmpymIoFNwW/Jd7rFb75KZML4LuVxD6+gxii5oII/h54/ijFQr59dLmyWo2Di7L4ZirzYOV6GTmr9x+56hIJbQqSEPAvd/GUYM3huekGX9VW0QgVnxEwP26eaBa8Cm39/yTSMTukGcGmkbooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423413; c=relaxed/simple;
	bh=Fa+PXibvXrxCCcV4W6GLI93MbvVmhGXd8DSbkWF71F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCDqpc3GnLUGaFHw7tz3jWNSkl2NxZbv0Dtn9Iuz5wWhHFqUiAPD6LnSKUZoTXJnOoJkyOYiHuSe0eOflEqMucmKqhENK+MtWuvj2gsWGY+C/xdUW3JNh2Hrsz1rpPx7fh+UZJUTCSLyHccevSYtq+EGCSDQL6SjVS1AuPxE2P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IM3VirT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C73C4CEE8;
	Wed, 23 Apr 2025 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745423413;
	bh=Fa+PXibvXrxCCcV4W6GLI93MbvVmhGXd8DSbkWF71F8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IM3VirT1GCLdpUWumjiEIQBBP6rEFB0Qkq8Nrq/DxatvqXR2/nHyjfCjvRd3OIrAJ
	 g1QLm8T11TqC6QWNzIRojs5wcE80r6maY82RhYQhN2bhfbHoax2HQStzzOsn848I7c
	 Qg5HM+7K+/uEe+e2ky383M530lHz2zQofT+v8e+mZGe2X/axgEfwviMCjWsuK5Gfj/
	 8olmnuXWJtkMDX3XrHfnKpqJOEKv2sTiVOa1nngV9UM4hRUb3gGcy7Zi15CYO6eaV1
	 4hTixLiM5MXXYX8MAnZe5GFlu/2W/UEHLkEuHFlE1bpMTtRXeMdwHEL9wXAxT5QZB7
	 9c+ZZIkU6xXYQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30dd5a93b49so692471fa.0;
        Wed, 23 Apr 2025 08:50:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJxnyY+YPMdMbD4lfmAVInh6BtNDMIqxH239FDCmLfPnxUlHPGffB7mugPKGCjx03SAKW6fjH05RES/r+s@vger.kernel.org, AJvYcCVG7i27uVlfwwuNQsvnHWSX1bW1ObklvSCjMGvgDBVv9E4TIV25/KRJahxp7aJn5PkFRa1Ryxxwbys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyonft45XlerO/69w6Q4ewsuoDXcpgAmsNMn9a3QkIxSRmTRERP
	9BnmYdgLdprmt3KQOHQGCLdez7m1uuo9bZ+QWMH21aDa3Y14uz86Pi9Aq0SvaUwT1d5C6pT7L4y
	fcv5gk4YptGrQzn/mFnxn5sjCYl4=
X-Google-Smtp-Source: AGHT+IGVwIf9+lBNVcSQ5X7gdZBSr7LfTa4BLGGADmZZiuPVg72vW71YQfuhY0ZP6YfYdzgScoBjHf5DE11HEX6F/ww=
X-Received: by 2002:a2e:b892:0:b0:308:f4cc:9519 with SMTP id
 38308e7fff4ca-310904b8545mr50500811fa.5.1745423411571; Wed, 23 Apr 2025
 08:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418141253.2601348-8-ardb+git@google.com> <20250418141253.2601348-11-ardb+git@google.com>
 <cf878810-81ed-3017-52c6-ce6aa41b5f01@amd.com>
In-Reply-To: <cf878810-81ed-3017-52c6-ce6aa41b5f01@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 23 Apr 2025 17:50:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGDyM-W1umDsBGO17+UqczhODBcb73StPELfOAQN2_V2A@mail.gmail.com>
X-Gm-Features: ATxdqUGXliD83dE5faxOPvQJQzy9RCZaO4k0iC9l4w0xrGgHzIW_T4_87Kjf41s
Message-ID: <CAMj1kXGDyM-W1umDsBGO17+UqczhODBcb73StPELfOAQN2_V2A@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] x86/sev: Split off startup code from core code
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 17:22, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 4/18/25 09:12, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Disentangle the SEV core code and the SEV code that is called during
> > early boot. The latter piece will be moved into startup/ in a subsequent
> > patch.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> This patch breaks SNP guests. The SNP guest boots, but no longer has
> access to the VMPCK keys needed to communicate with the ASP, which is
> used, for example, to obtain an attestation report.
>
> It looks like the secrets_pa is defined as static in both startup.c and
> core.c. It is set by a function in startup.c and so when used in core.c
> its value will be 0.
>
> The following fixed the issue for me. Let me know if it can be squashed
> in or a full patch is needed. Although, it likely should be named
> sev_secrets_pa since it is no longer static.
>

Thanks for the fix, and apologies for using you as a guinea pig - I've
been struggling to get access to SEV-SNP capable hardware, although a
suitable EPYC based machine should be arriving in a month or 2.

I'd assume a proper patch is better, and renaming it to sev_secrets_pa
doesn't seem that intrusive. But it is ultimately Ingo's call.

