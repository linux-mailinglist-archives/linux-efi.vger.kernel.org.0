Return-Path: <linux-efi+bounces-3176-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC18A78269
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 20:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 156327A3423
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 18:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B502220E33F;
	Tue,  1 Apr 2025 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2siRzmp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83C20D51E
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743533150; cv=none; b=eTVauEAmjh9NHDrvWRk7ueLngpzQQcoom1kVMCHIGD0CoCFOwEET51oDVwJmBca/35hmAeKLbzjc8BDewlQcav+xRF64L8wr0WDyl665SpASVQm6JoWFx7YA3eLaxRZkC7hVzLDlaesyA5L6fiTm1jIxHOTJjOKGorGptYIk8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743533150; c=relaxed/simple;
	bh=P1VJDqdlcScdk8mP/cMnGmVzjAvz0ds0HzSLfAdE4qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1fnhU41HqDsGfnav4E20ggHvX2+tk+US474WwlDvB6nvQZScT/h3U2xoeAWIGQKp0neETXg+lLL9lUCGkki5VJXhyHpPFhcaie01ioNM1ViqYXk59C4KD3yit20Haz1CZqAM/ELv6BE2pcRsaH7D1hJ7Ekpx5u7wrbSX1ob8xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2siRzmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1CBC4CEEA
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743533150;
	bh=P1VJDqdlcScdk8mP/cMnGmVzjAvz0ds0HzSLfAdE4qU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B2siRzmp5CcvgsI0DL11wSIVKXfl/mYkEkoJH8lSdrg9PwBRpVYONEhRWoJg3VqR8
	 UEBvh92feOn+WHCE+rpJMk84YDwUxUqOT1+uUXp5adRvBLR9ViqUHsSQNlDNyUMXWn
	 KSVhunpdwLERtqfKxVyNzz5BXYIh1zl7qNIfGmQaVJObHmqVqaE9UHfUCbldTNS/0G
	 JASv1XDBrQ0IS98b+DyZdw//sr382tyYk7ZOtekPMPExlHTm+fF8gXRunaSi6uV88D
	 sr9UUcl7I72g91kNCDpF2/1RbfrkP2oOqxQYtDHBEp4D/XixkDfvrUo9CHCahG3aTY
	 6PQoq5yec/OhA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54993c68ba0so1591726e87.2
        for <linux-efi@vger.kernel.org>; Tue, 01 Apr 2025 11:45:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXw9uO3OgWqdto6+TBi3HsofJ3Ea06Cw4C30CzR6Txjr8ywVkU7XSDZkO6fGfhuvaDfQ5hog4TnvdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiNT6OA4mNxY2xW6c+GDmOr5uJXVq5l7g8e8mohM07n0DPzc7k
	RfgOJ+TRkD/gKN/WTHRUjktQuR+QE4N2oxo+ic20utO6Oog9GDKEoO45oUngW3pZOerV0PsEu7v
	lgALRrFhUQb0xIDNN9R7RHq8pOIA=
X-Google-Smtp-Source: AGHT+IEYbRpldzYSsutlTu9wu42EqGv8gBSb+TaaAwLs88n2ixqNqz9FzG1J8RBFWf1ZDfWHnzHVAz3s0FlwHCR6UZU=
X-Received: by 2002:a05:651c:158b:b0:307:e368:6bd6 with SMTP id
 38308e7fff4ca-30eecd8cf02mr16542101fa.32.1743533148375; Tue, 01 Apr 2025
 11:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325091614.1203411-2-ardb+git@google.com> <32zavhk2moqarh4vd76rnhwte45kkc3gqy3shls7mp5lemhy4k@o4gibpdf4sj6>
 <CAMj1kXHkM2hBHkfjFuCKpOA2APX+BBR-zrPfRkpiEf609UMKjw@mail.gmail.com>
 <ervuw7mwzvcyizkchy3nz4357ahz5kdfzc227exlrc5yabq4im@g2kzsrdbkdf6>
 <CAMj1kXEzzNnohJat5REp5mAUCSd4v_ft6F=P6vB95z6+f1MMfw@mail.gmail.com>
 <4xm3bmuhmdbnn6fkmhmnrtkcdiwj76dcr7gujam45nqvgupvj3@caytleltmyzj>
 <CAMj1kXFERrdioZ8_07rwDVUAoq=OLDvLCRUS6BN3GXnJoJPuAA@mail.gmail.com>
 <d6eb83a9-d1b1-7028-9cfd-1ab3fa0d6269@amd.com> <CAMj1kXE35QQ7b3uSF4Ufv6VXyjCfPyveUO1KLPKwsgoHu8iE=w@mail.gmail.com>
 <121a6769-3b86-b1a7-1d90-524cdd82790b@amd.com>
In-Reply-To: <121a6769-3b86-b1a7-1d90-524cdd82790b@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 1 Apr 2025 21:45:37 +0300
X-Gmail-Original-Message-ID: <CAMj1kXEUARHvxQjucikoy_qWkrVnqsMGQyt7mUrBeV-f-_ZQJg@mail.gmail.com>
X-Gm-Features: AQ5f1JrD_yZ0dmD3gZOyVSC0d4NEy8CKTfymmvNCRvvJZWiVeu0lsanB8VHbd3o
Message-ID: <CAMj1kXEUARHvxQjucikoy_qWkrVnqsMGQyt7mUrBeV-f-_ZQJg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Do not accept parts of memory before ExitBootServices()
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-efi@vger.kernel.org, linux-coco@lists.linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Apr 2025 at 18:51, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 3/26/25 04:28, Ard Biesheuvel wrote:
> > On Tue, 25 Mar 2025 at 17:30, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>
> >> On 3/25/25 09:39, Ard Biesheuvel wrote:
> >>> On Tue, 25 Mar 2025 at 14:44, Kirill A. Shutemov
> >>> <kirill.shutemov@linux.intel.com> wrote:
> >>>>
> >>>> On Tue, Mar 25, 2025 at 02:09:54PM +0100, Ard Biesheuvel wrote:
> >>>>>> Since the problem happens before ExitBootServices(), can we allocate this
> >>>>>> memory range with EFI API and free it back?
> >>>>>>
> >>>>>
> >>>>> In principle, yes - we could allocate these misaligned chunks as
> >>>>> EfiLoaderData, and it wouldn't even be necessary to free them, as they
> >>>>> would become available to the OS automatically.
> >>>>>
> >>>>> But doing this in setup_e820() is tricky, because every page
> >>>>> allocation modifies the EFI memory map, and we may have to restart
> >>>>> from the beginning. And there is no guarantee that some asynchronous
> >>>>> event in the firmware context does not attempt to allocate some pages,
> >>>>> in a way that might result in another misaligned unaccepted region.
> >>>>
> >>>> Looking again at the code, setup_e820() (and therefore
> >>>> process_unaccepted_memory()) called after efi_exit_boot_services() in
> >>>> exit_boot(), so we can't use EFI API to allocate memory.
> >>>>
> >>>
> >>> Ah yes, I misremembered that. It also means that it is fine in
> >>> principle to take over the communication with the hypervisor.
> >>>
> >>> However, this is still tricky, because on SEV-SNP, accepting memory
> >>> appears to rely on the GHCB page based communication being enabled,
> >>> and this involves mapping it down to a single page so the C bit can be
> >>> cleared. It would be nice if we could simply use the MSR based
> >>> protocol for accepting memory.
> >>
> >> We can probably do something along this line since there is an existing
> >> function, __page_state_change(), that performs MSR protocol PSC. If we
> >> change the arch_accept_memory() calls in process_unaccepted_memory() to
> >> arch_accept_memory_early() then we can differentiate between this early
> >> alignment setup timeframe. The early function can also use
> >> sev_get_status() instead of sev_snp_enabled().
> >>
> >> Let me mess around with it a bit and see what I come up with.
> >>
> >
> > Cheers.
>
> This is what I came up with below. @Ard and @Kirill, let me know if it
> looks ok to you and, if so, I'll submit a formal patch where we can work
> on naming, etc.
>

Thanks for putting this together.

Some questions below.

> >
> > So IIUC, it would be sufficient to check sev_get_status() against
> > MSR_AMD64_SEV_SNP_ENABLED, and use the PSC MSR to transition each
> > unaccepted page that is in the misaligned head or tail of the region
> > to private.
> >
> > Pardon my ignorance, but does that mean that in principle,
> > sev_enable() et al could be deferred to early startup of the kernel
> > proper (where the other SEV startup code lives) ?
>
> I'm not sure if it can be. There is a bunch of code in the sev_enable()
> path that I'm not sure can be moved. I'd have to look a lot closer to
> determine that.
>
> Thanks,
> Tom
>
> >
> > We have been playing whack-a-mole with PIC codegen issues there, and
> > so it might make sense to consolidate that logic into a single [PIC]
> > chunk of code that is somewhat isolated from the rest of the code
> > (like the kernel/pi code on arm64)
>
> diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> index dbba332e4a12..b115a73ca25e 100644
> --- a/arch/x86/boot/compressed/mem.c
> +++ b/arch/x86/boot/compressed/mem.c
> @@ -32,19 +32,42 @@ static bool early_is_tdx_guest(void)
>         return is_tdx;
>  }
>
> -void arch_accept_memory(phys_addr_t start, phys_addr_t end)
> +static bool is_sev_snp_enabled(bool early)
> +{
> +       return early ? early_sev_snp_enabled() : sev_snp_enabled();

Why is the latter test not suitable early on? Simply because
sev_status is not initialized yet?

> +}
> +
> +static void __arch_accept_memory(phys_addr_t start, phys_addr_t end, bool early)
>  {
>         /* Platform-specific memory-acceptance call goes here */
>         if (early_is_tdx_guest()) {
>                 if (!tdx_accept_memory(start, end))
>                         panic("TDX: Failed to accept memory\n");
> -       } else if (sev_snp_enabled()) {
> -               snp_accept_memory(start, end);
> +       } else if (is_sev_snp_enabled(early)) {
> +               /*
> +                * Calls when memory acceptance is being setup require SNP
> +                * to use the GHCB protocol because the current pagetable
> +                * mappings can't change the early GHCB page to shared.
> +                */
> +               if (early)

I think it would be better to structure this slightly differently.
I'll have a stab at this myself and get back to you.

> +                       snp_accept_memory_early(start, end);
> +               else
> +                       snp_accept_memory(start, end);
>         } else {
>                 error("Cannot accept memory: unknown platform\n");
>         }
>  }
>
> +void arch_accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +       __arch_accept_memory(start, end, false);
> +}
> +
> +void arch_accept_memory_early(phys_addr_t start, phys_addr_t end)
> +{
> +       __arch_accept_memory(start, end, true);
> +}
> +
>  bool init_unaccepted_memory(void)
>  {
>         guid_t guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index bb55934c1cee..162484d662f1 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -157,6 +157,12 @@ static int svsm_perform_call_protocol(struct svsm_call *call)
>         return ret;
>  }
>
> +/* Used before sev_enable() has been called during unaccepted memory init */
> +bool early_sev_snp_enabled(void)
> +{
> +       return sev_get_status() & MSR_AMD64_SEV_SNP_ENABLED;
> +}
> +
>  bool sev_snp_enabled(void)
>  {
>         return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
> @@ -164,10 +170,7 @@ bool sev_snp_enabled(void)
>
>  static void __page_state_change(unsigned long paddr, enum psc_op op)
>  {
> -       u64 val;
> -
> -       if (!sev_snp_enabled())
> -               return;
> +       u64 val, msr;
>

Could you explain how the below code now knows how to decide whether
to use the MSR protocol or the GHCB page based one?

>         /*
>          * If private -> shared then invalidate the page before requesting the
> @@ -176,6 +179,9 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
>         if (op == SNP_PAGE_STATE_SHARED)
>                 pvalidate_4k_page(paddr, paddr, false);
>
> +       /* Save the current GHCB MSR value */
> +       msr = sev_es_rd_ghcb_msr();
> +
>         /* Issue VMGEXIT to change the page state in RMP table. */
>         sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
>         VMGEXIT();
> @@ -185,6 +191,9 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
>         if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
>                 sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
>
> +       /* Restore the GHCB MSR value */
> +       sev_es_wr_ghcb_msr(msr);
> +
>         /*
>          * Now that page state is changed in the RMP table, validate it so that it is
>          * consistent with the RMP entry.
> @@ -195,11 +204,17 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
>
>  void snp_set_page_private(unsigned long paddr)
>  {
> +       if (!sev_snp_enabled())
> +               return;
> +
>         __page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
>  }
>
>  void snp_set_page_shared(unsigned long paddr)
>  {
> +       if (!sev_snp_enabled())
> +               return;
> +
>         __page_state_change(paddr, SNP_PAGE_STATE_SHARED);
>  }
>
> @@ -261,6 +276,11 @@ static phys_addr_t __snp_accept_memory(struct snp_psc_desc *desc,
>         return pa;
>  }
>
> +/*
> + * The memory acceptance support uses the boot GHCB page to perform
> + * the required page state change operation before validating the
> + * pages.
> + */
>  void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>  {
>         struct snp_psc_desc desc = {};
> @@ -275,6 +295,23 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>                 pa = __snp_accept_memory(&desc, pa, end);
>  }
>
> +/*
> + * The early version of memory acceptance is needed when being called
> + * from the EFI stub driver. The pagetable manipulation to mark the
> + * boot GHCB page as shared can't be performed at this stage, so use
> + * the GHCB page state change MSR protocol instead.
> + */
> +void snp_accept_memory_early(phys_addr_t start, phys_addr_t end)
> +{
> +       phys_addr_t pa;
> +
> +       pa = start;
> +       while (pa < end) {

Nit: please make this

for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)

and drop the braces

> +               __page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
> +               pa += PAGE_SIZE;
> +       }
> +}
> +
>  void sev_es_shutdown_ghcb(void)
>  {
>         if (!boot_ghcb)
> diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
> index fc725a981b09..8a135c9c043a 100644
> --- a/arch/x86/boot/compressed/sev.h
> +++ b/arch/x86/boot/compressed/sev.h
> @@ -10,13 +10,17 @@
>
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>
> +bool early_sev_snp_enabled(void);
>  bool sev_snp_enabled(void);
>  void snp_accept_memory(phys_addr_t start, phys_addr_t end);
> +void snp_accept_memory_early(phys_addr_t start, phys_addr_t end);
>
>  #else
>
> +static inline bool early_sev_snp_enabled(void) { return false; }
>  static inline bool sev_snp_enabled(void) { return false; }
>  static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
> +static inline void snp_accept_memory_early(phys_addr_t start, phys_addr_t end) { }
>
>  #endif
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index d96d4494070d..676aa30df52e 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -1233,5 +1233,6 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
>  void process_unaccepted_memory(u64 start, u64 end);
>  void accept_memory(phys_addr_t start, unsigned long size);
>  void arch_accept_memory(phys_addr_t start, phys_addr_t end);
> +void arch_accept_memory_early(phys_addr_t start, phys_addr_t end);
>
>  #endif
> diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
> index 757dbe734a47..1955eddc85f1 100644
> --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
> @@ -118,7 +118,7 @@ void process_unaccepted_memory(u64 start, u64 end)
>          * immediately accepted in its entirety.
>          */
>         if (end - start < 2 * unit_size) {
> -               arch_accept_memory(start, end);
> +               arch_accept_memory_early(start, end);
>                 return;
>         }
>
> @@ -129,13 +129,13 @@ void process_unaccepted_memory(u64 start, u64 end)
>
>         /* Immediately accept a <unit_size piece at the start: */
>         if (start & unit_mask) {
> -               arch_accept_memory(start, round_up(start, unit_size));
> +               arch_accept_memory_early(start, round_up(start, unit_size));
>                 start = round_up(start, unit_size);
>         }
>
>         /* Immediately accept a <unit_size piece at the end: */
>         if (end & unit_mask) {
> -               arch_accept_memory(round_down(end, unit_size), end);
> +               arch_accept_memory_early(round_down(end, unit_size), end);
>                 end = round_down(end, unit_size);
>         }
>
> @@ -144,8 +144,8 @@ void process_unaccepted_memory(u64 start, u64 end)
>          * into the bitmap.
>          */
>         if (start < unaccepted_table->phys_base) {
> -               arch_accept_memory(start,
> -                                  min(unaccepted_table->phys_base, end));
> +               arch_accept_memory_early(start,
> +                                        min(unaccepted_table->phys_base, end));
>                 start = unaccepted_table->phys_base;
>         }
>
> @@ -165,7 +165,7 @@ void process_unaccepted_memory(u64 start, u64 end)
>                              unaccepted_table->phys_base;
>                 phys_end = end + unaccepted_table->phys_base;
>
> -               arch_accept_memory(phys_start, phys_end);
> +               arch_accept_memory_early(phys_start, phys_end);
>                 end = bitmap_size * unit_size * BITS_PER_BYTE;
>         }
>
>
>

