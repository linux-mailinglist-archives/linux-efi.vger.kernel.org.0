Return-Path: <linux-efi+bounces-6006-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD8AD2EE7F
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jan 2026 10:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D50F3008F67
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jan 2026 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA3C318121;
	Fri, 16 Jan 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puKnPhOk"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17496274FE3
	for <linux-efi@vger.kernel.org>; Fri, 16 Jan 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556520; cv=none; b=KtLvt5+zWqkGW1RMpjI3nvtW8+bTQMSpO7DBIW8NlHy6pl/t+D11UAqSI3WSeeCBZCU8lzES9AyVBDni5hF/tkJo4Q0MSbHoM/m+JblmltDmtIdP4ykD3fcti+JJ1sXPUQJsXeqRx217VUgUHsvdY0/aGAPTxv8z9PtmUhCV8P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556520; c=relaxed/simple;
	bh=/E8pjL1Rg4kjh10yWKXAfqGFi3+btd20CKL87Qc6xYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+q6iXRQSExSycFq64PBO8lMCOxTfD+oSZNt9lZTkIATEXakMOfee7n+TnZhsJvwH+Vr0nTJ6V99/42O/J8/0evWB3gcGVL6jiPAtyrciK8B7T1dlHIXSVoSWsMMPPhWYsBFpXHDdMGk/8BOfPLPqQakx/jNpx6/JtmuYmQiWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puKnPhOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C42C2BC87
	for <linux-efi@vger.kernel.org>; Fri, 16 Jan 2026 09:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768556519;
	bh=/E8pjL1Rg4kjh10yWKXAfqGFi3+btd20CKL87Qc6xYk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=puKnPhOk3owN3Sj4LnlRh8Q5bdF/lvK/xmQPnPcVkGBhBg6Hbtac8bkfEOz7zhezm
	 AbfSg9/ibyoePfnv3Nk5WCsNImTd8tXKNmHWYVKDYQMsZNKDcLiROGajxYxymeq5t6
	 lZO5aV56/7MThnUpqBrdvdCEFe37U1HFJgbiAi33eyvFRP8EMj51ReE9Bv8KZf4zrc
	 OVog7LVJe7HVJa4LCSvEGjUuSMjol80EVN3efhpsSaFW68fLTz8KhPPy+6AjTqB5Z0
	 4xQK8+qxnovH1eiqTo+KWzA1BPLr4ixYD/5/FZoPRIKl7o0gt7XB5QMmVGUuU27p63
	 t/VlQCkOF3r0A==
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso1132296a91.2
        for <linux-efi@vger.kernel.org>; Fri, 16 Jan 2026 01:41:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/e8M1c9EXP4KcqKj9AO5RFJmUpf6zspwbQmYGpth/vj+DkUy1tFQBD+8EUWyWBZsoU9Wc05pLVmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRZBEcgJivgf7UdRma+Z+si/fApBXVrBTnRZbZmlg8e3AurGO
	OmeaWblTdhU6Qz23wv0mdeOk9Xun1Kkg1Ox320YZqC1tJCZqW9KTh356L21zUFZ++0HPedYk8wo
	a24gXTerou3zN5wi6jsDh/CNEKnr1g5U=
X-Received: by 2002:a17:90b:3dcc:b0:340:c4dc:4b70 with SMTP id
 98e67ed59e1d1-3527315e60dmr2091280a91.6.1768556519441; Fri, 16 Jan 2026
 01:41:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115004328.194142-1-coxu@redhat.com> <20260115004328.194142-2-coxu@redhat.com>
In-Reply-To: <20260115004328.194142-2-coxu@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 16 Jan 2026 10:41:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
X-Gm-Features: AZwV_QjmUt_PmrwfWvkU01-td52KzVOAwQnoeyg_Oar6lj-mB--Ez-fk2UXAfCg
Message-ID: <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
Subject: Re: [PATCH 1/3] integrity: Make arch_ima_get_secureboot integrity-wide
To: Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, 
	"open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>, 
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	"open list:KEYS/KEYRINGS_INTEGRITY" <keyrings@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 at 01:43, Coiby Xu <coxu@redhat.com> wrote:
>
> EVM and other LSMs need the ability to query the secure boot status of
> the system, without directly calling the IMA arch_ima_get_secureboot
> function. Refactor the secure boot status check into a general,
> integrity-wide function named arch_integrity_get_secureboot.
>
> Define a new Kconfig option CONFIG_INTEGRITY_SECURE_BOOT, which is
> automatically configured by the supported architectures. The existing
> IMA_SECURE_AND_OR_TRUSTED_BOOT Kconfig loads the architecture specific
> IMA policy based on the refactored secure boot status code.
>
> Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Suggested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/arm64/Kconfig                            |  1 +
>  arch/powerpc/Kconfig                          |  1 +
>  arch/powerpc/kernel/Makefile                  |  2 +-
>  arch/powerpc/kernel/ima_arch.c                |  5 --
>  arch/powerpc/kernel/integrity_sb_arch.c       | 13 +++++
>  arch/s390/Kconfig                             |  1 +
>  arch/s390/kernel/Makefile                     |  1 +
>  arch/s390/kernel/ima_arch.c                   |  6 --
>  arch/s390/kernel/integrity_sb_arch.c          |  9 +++
>  arch/x86/Kconfig                              |  1 +
>  arch/x86/include/asm/efi.h                    |  4 +-
>  arch/x86/platform/efi/efi.c                   |  2 +-
>  include/linux/ima.h                           |  7 +--
>  include/linux/integrity.h                     |  8 +++
>  security/integrity/Kconfig                    |  6 ++
>  security/integrity/Makefile                   |  3 +
>  security/integrity/efi_secureboot.c           | 56 +++++++++++++++++++
>  security/integrity/ima/ima_appraise.c         |  2 +-
>  security/integrity/ima/ima_efi.c              | 47 +---------------
>  security/integrity/ima/ima_main.c             |  4 +-
>  security/integrity/platform_certs/load_uefi.c |  2 +-
>  21 files changed, 111 insertions(+), 70 deletions(-)
>  create mode 100644 arch/powerpc/kernel/integrity_sb_arch.c
>  create mode 100644 arch/s390/kernel/integrity_sb_arch.c
>  create mode 100644 security/integrity/efi_secureboot.c
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 93173f0a09c7..4c265b7386bb 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2427,6 +2427,7 @@ config EFI
>         select EFI_STUB
>         select EFI_GENERIC_STUB
>         imply IMA_SECURE_AND_OR_TRUSTED_BOOT
> +       imply INTEGRITY_SECURE_BOOT

This allows both to be en/disabled individually, which I don't think
is what we want. It also results in more churn across the
arch-specific Kconfigs than needed.

Wouldn't it be better if IMA_SECURE_AND_OR_TRUSTED_BOOT 'select'ed
INTEGRITY_SECURE_BOOT in its Kconfig definition?

