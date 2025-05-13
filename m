Return-Path: <linux-efi+bounces-3686-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C364EAB5695
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 15:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B6B863A4A
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559122BD020;
	Tue, 13 May 2025 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPyVBXrz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7602BD01D
	for <linux-efi@vger.kernel.org>; Tue, 13 May 2025 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144555; cv=none; b=D2XdEXSqQNCuuJojnfJqGIwV93kuQRu1UAc993F4d2/WGCVw6V4cAgz2JoE4mFxWP4zES//HV0HUSo7KiaFfscuiFSttjiyWOlLwGjxuIj9jsY9077z7biPy9Aj1s+OLu5dG8UGXSFbEFHxC/1vK3W5Xyayjo3v6gTl3oQn96cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144555; c=relaxed/simple;
	bh=qbGVvmAOrG31RsDKWBfJYqw5WZHQKFePTXbTIdTXzpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=X7ufpeVHogq8YHcniXdR7SrS+TIw+zACADTGtslQbLTGpXwFkBfMpIEoiZBP/DwVFgbRYeW8Yl+VFHXt1fZ8GN4WdNtpmUm5t8p27SEy7MwJ0NQrPm7OIuq0zEdEhsqKiLM+BnewpAfCn1JOYLADu+x69/3/lZ5z6LxyvgJP6kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPyVBXrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBA7C4CEEF
	for <linux-efi@vger.kernel.org>; Tue, 13 May 2025 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747144554;
	bh=qbGVvmAOrG31RsDKWBfJYqw5WZHQKFePTXbTIdTXzpA=;
	h=References:In-Reply-To:From:Date:Subject:Cc:From;
	b=OPyVBXrzXO2J5NyLjsMgmPoX/Vx6NeE4YoUlKAkwOLopqAjnAeSQ1omHR8a5aoEeG
	 fAEtP4wRK0XJl6/dXCbWn1IOB8CIWpOgzcY+m0xAueknaGHxxSgG7Wd+ed0KR+rK1l
	 YDpW8zfZqu+P8E/eUxaDcrUYMCqEe6rXo74J+pZd2BpBsCeWBIOIrO4a777tjaNNwc
	 suC5CUJSWQEwwLSgAwyAY1Qmyr/2BLCqKIt3YVKJi6inrcUJzHI+b3463t2vh4+961
	 LLquP7hUu02S/cBTZNvDm+49vt9ZGL9H8JfaUsY3DmYoaTz/fY7TuQvtdTKOSpUXMF
	 oEmY/IbBH3TkQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso7318027e87.3
        for <linux-efi@vger.kernel.org>; Tue, 13 May 2025 06:55:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZSFpRZA0JI/t8HsP/DmtCZGEgZjrOFryePTR92IkL41L4+JPqg3npJXL1+k/5pEK+loJvjS2uur8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlbnXM3xhjPGxIHF4InsNte6lE1COA2uUxZOyvNR9aZNCZMvqX
	t0XzdGk8gh4girktdL84Vgrw/Pb3JtPcKRv7frnVDyZ0jrjzzHuqfXKhfkQL4S76hXlPZhnZa5K
	yPfIaSPLKcS0rq5Iv6k1v2oZa9/A=
X-Received: by 2002:a05:6512:4201:b0:54b:f33:cc16 with SMTP id
 2adb3069b0e04-54fc67bf61dmt5886704e87.16.1747144552936; Tue, 13 May 2025
 06:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com> <20250512190834.332684-32-ardb+git@google.com>
In-Reply-To: <20250512190834.332684-32-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 13 May 2025 14:55:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH5C6FzMyrki_23TTk_Yma5NJdHTo-nv4DmZoz_qaGbVQ@mail.gmail.com>
X-Gm-Features: AX0GCFs1vbDQW8KIkO0cVrFcma02njrKTq6Yx0SnXaMWrHpq2jbGsv6uxRm2K1k
Message-ID: <CAMj1kXH5C6FzMyrki_23TTk_Yma5NJdHTo-nv4DmZoz_qaGbVQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 09/21] x86/sev: Pass SVSM calling area down to
 early page state change API
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 20:11, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The early page state change API is mostly only used very early, when
> only the boot time SVSM calling area is in use. However, this API is
> also called by the kexec finishing code, which runs very late, and
> potentially from a different CPU (which uses a different calling area).
>
> To avoid pulling the per-CPU SVSM calling area pointers and related SEV
> state into the startup code, refactor the page state change API so the
> SVSM calling area virtual and physical addresses can be provided by the
> caller.
>
> No functional change intended.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

This patch is broken - I'll send a followup fix asap.



> ---
>  arch/x86/boot/compressed/sev.c      | 12 +++++++++---
>  arch/x86/boot/startup/sev-shared.c  | 18 ++++++++++--------
>  arch/x86/boot/startup/sev-startup.c | 11 +++++++----
>  arch/x86/coco/sev/core.c            |  3 ++-
>  arch/x86/include/asm/sev-internal.h |  3 ++-
>  5 files changed, 30 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 7a01eef9ae01..04bc39d065ff 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -68,7 +68,9 @@ void snp_set_page_private(unsigned long paddr)
>                 return;
>
>         msr = sev_es_rd_ghcb_msr();
> -       __page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
> +       __page_state_change(paddr, SNP_PAGE_STATE_PRIVATE,
> +                           (struct svsm_ca *)boot_svsm_caa_pa,
> +                           boot_svsm_caa_pa);
>         sev_es_wr_ghcb_msr(msr);
>  }
>
> @@ -80,7 +82,9 @@ void snp_set_page_shared(unsigned long paddr)
>                 return;
>
>         msr = sev_es_rd_ghcb_msr();
> -       __page_state_change(paddr, SNP_PAGE_STATE_SHARED);
> +       __page_state_change(paddr, SNP_PAGE_STATE_SHARED,
> +                           (struct svsm_ca *)boot_svsm_caa_pa,
> +                           boot_svsm_caa_pa);
>         sev_es_wr_ghcb_msr(msr);
>  }
>
> @@ -109,7 +113,9 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>         u64 msr = sev_es_rd_ghcb_msr();
>
>         for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
> -               __page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
> +               __page_state_change(pa, SNP_PAGE_STATE_PRIVATE,
> +                                   (struct svsm_ca *)boot_svsm_caa_pa,
> +                                   boot_svsm_caa_pa);
>         sev_es_wr_ghcb_msr(msr);
>  }
>
> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> index dae770327b50..70ad9a0aa023 100644
> --- a/arch/x86/boot/startup/sev-shared.c
> +++ b/arch/x86/boot/startup/sev-shared.c
> @@ -538,7 +538,8 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
>         }
>  }
>
> -static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
> +static void __head svsm_pval_4k_page(unsigned long paddr, bool validate,
> +                                    struct svsm_ca *caa, u64 caa_pa)
>  {
>         struct svsm_pvalidate_call *pc;
>         struct svsm_call call = {};
> @@ -552,10 +553,10 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
>          */
>         flags = native_local_irq_save();
>
> -       call.caa = svsm_get_caa();
> +       call.caa = caa;
>
>         pc = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
> -       pc_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
> +       pc_pa = caa_pa + offsetof(struct svsm_ca, svsm_buffer);
>
>         pc->num_entries = 1;
>         pc->cur_index   = 0;
> @@ -578,12 +579,12 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
>  }
>
>  static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
> -                                    bool validate)
> +                                    bool validate, struct svsm_ca *caa, u64 caa_pa)
>  {
>         int ret;
>
>         if (snp_vmpl) {
> -               svsm_pval_4k_page(paddr, validate);
> +               svsm_pval_4k_page(paddr, validate, caa, caa_pa);
>         } else {
>                 ret = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
>                 if (ret)
> @@ -591,7 +592,8 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
>         }
>  }
>
> -static void __head __page_state_change(unsigned long paddr, enum psc_op op)
> +static void __head __page_state_change(unsigned long paddr, enum psc_op op,
> +                                      struct svsm_ca *caa, u64 caa_pa)
>  {
>         u64 val;
>
> @@ -600,7 +602,7 @@ static void __head __page_state_change(unsigned long paddr, enum psc_op op)
>          * state change in the RMP table.
>          */
>         if (op == SNP_PAGE_STATE_SHARED)
> -               pvalidate_4k_page(paddr, paddr, false);
> +               pvalidate_4k_page(paddr, paddr, false, caa, caa_pa);
>
>         /* Issue VMGEXIT to change the page state in RMP table. */
>         sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
> @@ -616,7 +618,7 @@ static void __head __page_state_change(unsigned long paddr, enum psc_op op)
>          * consistent with the RMP entry.
>          */
>         if (op == SNP_PAGE_STATE_PRIVATE)
> -               pvalidate_4k_page(paddr, paddr, true);
> +               pvalidate_4k_page(paddr, paddr, true, caa, caa_pa);
>  }
>
>  /*
> diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
> index 28bf68753580..7a3ad17d06f6 100644
> --- a/arch/x86/boot/startup/sev-startup.c
> +++ b/arch/x86/boot/startup/sev-startup.c
> @@ -132,7 +132,8 @@ noinstr void __sev_put_ghcb(struct ghcb_state *state)
>
>  void __head
>  early_set_pages_state(unsigned long vaddr, unsigned long paddr,
> -                     unsigned long npages, enum psc_op op)
> +                     unsigned long npages, enum psc_op op,
> +                     struct svsm_ca *caa, u64 caa_pa)
>  {
>         unsigned long paddr_end;
>
> @@ -142,7 +143,7 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
>         paddr_end = paddr + (npages << PAGE_SHIFT);
>
>         while (paddr < paddr_end) {
> -               __page_state_change(paddr, op);
> +               __page_state_change(paddr, op, caa, caa_pa);
>
>                 vaddr += PAGE_SIZE;
>                 paddr += PAGE_SIZE;
> @@ -165,7 +166,8 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
>           * Ask the hypervisor to mark the memory pages as private in the RMP
>           * table.
>           */
> -       early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE);
> +       early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE,
> +                             svsm_get_caa(), svsm_get_caa_pa());
>  }
>
>  void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
> @@ -181,7 +183,8 @@ void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
>                 return;
>
>          /* Ask hypervisor to mark the memory pages shared in the RMP table. */
> -       early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
> +       early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED,
> +                             svsm_get_caa(), svsm_get_caa_pa());
>  }
>
>  /*
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 0e0ddf4c92aa..39bbbea09c24 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -584,7 +584,8 @@ static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
>
>         /* Use the MSR protocol when a GHCB is not available. */
>         if (!boot_ghcb)
> -               return early_set_pages_state(vaddr, __pa(vaddr), npages, op);
> +               return early_set_pages_state(vaddr, __pa(vaddr), npages, op,
> +                                            svsm_get_caa(), svsm_get_caa_pa());
>
>         vaddr = vaddr & PAGE_MASK;
>         vaddr_end = vaddr + (npages << PAGE_SHIFT);
> diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
> index e3b203c280aa..08e2cfdef512 100644
> --- a/arch/x86/include/asm/sev-internal.h
> +++ b/arch/x86/include/asm/sev-internal.h
> @@ -55,7 +55,8 @@ DECLARE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>  DECLARE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
>
>  void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
> -                          unsigned long npages, enum psc_op op);
> +                          unsigned long npages, enum psc_op op,
> +                          struct svsm_ca *ca, u64 caa_pa);
>
>  DECLARE_PER_CPU(struct svsm_ca *, svsm_caa);
>  DECLARE_PER_CPU(u64, svsm_caa_pa);
> --
> 2.49.0.1045.g170613ef41-goog
>

