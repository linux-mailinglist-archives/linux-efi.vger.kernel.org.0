Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CF9702F55
	for <lists+linux-efi@lfdr.de>; Mon, 15 May 2023 16:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjEOOON (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 10:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbjEOOOM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 10:14:12 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905AB1BC6;
        Mon, 15 May 2023 07:14:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0685A5C0195;
        Mon, 15 May 2023 10:14:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 May 2023 10:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684160051; x=
        1684246451; bh=8NJYIEmbiIkpWsu+/ofSKGEy0pPwTx2rBL3P2/pMpTo=; b=Q
        EJT7kK3SHAjLT3qjXYjWH1VDIAYNnsdCYVrOvC5QsyPBNxbQJfyfr+3G7Je1ro5/
        f2MbLZ07yj+B8Z76l918KNzgEK3Uz0yy+ClnN44SfrQHdnrk6mlOzwnhdAXYc7BS
        1tVS1doK829JwQL0HeFCwWbdMMVbR+7v0yKedAMoy5eLal12yajct1w2r/O9OdnW
        iJr8ET36v7YU72fyRMDbre39KE04VTe51P9PKUW/ZFWIx6O+W1MCwNqPJR37miQl
        UsO4qlsKZ3oviidexWAYEYEu1TBq/jqur+/QvAbOC0lcQ3dj+D7Naf9QFZyFtzNR
        sGTWvehN2OL6xlA5AQvjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684160051; x=1684246451; bh=8NJYIEmbiIkpW
        su+/ofSKGEy0pPwTx2rBL3P2/pMpTo=; b=pNj8ohMjr5vfiyyDV5hr0NEDMPVUU
        04yTQmYOuEIEPWLt3XU9yfxeNIFTDeIYKXTGXFEEIvNJ9O7dV/++cegpVkVvQGP3
        Ys9PnpG0+CioNt4NeJUN2/GgtP0GzbRs1IokAPt2yY7/FmF1ayqHi4F6XSiCWS/S
        wv9pl/xFZGDpdsbozdRuAwniPmjguY017hhVh+zkdnne0HAnGeqHYomc1bZdXngR
        nBDYbnpqOdiN3lOYy54Dx6w6k05z/56x7nVaZUmFDkdAvAzTi5ev5PDT9pWgPCO+
        8KjOcbqNsZqjyrBDwut58uP71FzaqqSRJGXNipybSDN0XajLZE82LQ+yA==
X-ME-Sender: <xms:Mj5iZBP4c6PhuLXJWmsk6uIpPAUgOn1dsV_IFHpNgyf8HxJQIb7OKw>
    <xme:Mj5iZD_OuzzIeIsxxvodmiYwE4htvZ6-P3K65OYezaVNjdfW0CN7B5ouexVspyUbE
    pOisOZJ_-mN6AaoHSc>
X-ME-Received: <xmr:Mj5iZATDt1LLzwYgJcvWrYbQ5Kzt4X2FsoNXQ3sUpQQWK0oj1gbxEsb-pVqTkLmby0moAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:Mj5iZNsMB9ZnYTROf8BvRtzY9FU__X55xSrlTBoXiIigtXyK4BuQbw>
    <xmx:Mj5iZJf_tHYYUVJIc53uvXREYTkoRJ6_eVfdIJGVjm0P3pht7zI6Ow>
    <xmx:Mj5iZJ0ZzToGS79JVNxJiCK_r9G7ywjdgCPBcLV246-eWdhxVEsY1g>
    <xmx:Mz5iZMAj4YUc2HrT0DGOhO7TGm8CnGLZeHEKwoKzbRiIQ71nxfAh3Q>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 10:14:10 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9FE6310D1DE; Mon, 15 May 2023 17:14:08 +0300 (+03)
Date:   Mon, 15 May 2023 17:14:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 09/20] x86: efistub: Perform 4/5 level paging switch
 from the stub
Message-ID: <20230515141408.37aoipn4jfu5qcdd@box.shutemov.name>
References: <20230508070330.582131-1-ardb@kernel.org>
 <20230508070330.582131-10-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508070330.582131-10-ardb@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 08, 2023 at 09:03:19AM +0200, Ard Biesheuvel wrote:
> In preparation for updating the EFI stub boot flow to avoid the bare
> metal decompressor code altogether, implement the support code for
> switching between 4 and 5 levels of paging before jumping to the kernel
> proper.
> 
> This reuses the newly refactored trampoline that the bare metal
> decompressor uses, but relies on EFI APIs to allocate 32-bit addressable
> memory and remap it with the appropriate permissions. Given that the
> bare metal decompressor will no longer call into the trampoline if the
> number of paging levels is already set correctly, we no longer need to
> remove NX restrictions from the memory range where this trampoline may
> end up.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c |   4 +
>  drivers/firmware/efi/libstub/x86-stub.c        | 119 ++++++++++++++++----
>  2 files changed, 102 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 1e0203d74691ffcc..fc5f3b4c45e91401 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -16,6 +16,8 @@
>  
>  #include "efistub.h"
>  
> +extern bool efi_no5lvl;
> +
>  bool efi_nochunk;
>  bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
>  bool efi_novamap;
> @@ -73,6 +75,8 @@ efi_status_t efi_parse_options(char const *cmdline)
>  			efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
>  		} else if (!strcmp(param, "noinitrd")) {
>  			efi_noinitrd = true;
> +		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
> +			efi_no5lvl = true;
>  		} else if (!strcmp(param, "efi") && val) {
>  			efi_nochunk = parse_option_str(val, "nochunk");
>  			efi_novamap |= parse_option_str(val, "novamap");
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index a0bfd31358ba97b1..fb83a72ad905ad6e 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -267,32 +267,11 @@ adjust_memory_range_protection(unsigned long start, unsigned long size)
>  	}
>  }
>  
> -/*
> - * Trampoline takes 2 pages and can be loaded in first megabyte of memory
> - * with its end placed between 128k and 640k where BIOS might start.
> - * (see arch/x86/boot/compressed/pgtable_64.c)
> - *
> - * We cannot find exact trampoline placement since memory map
> - * can be modified by UEFI, and it can alter the computed address.
> - */
> -
> -#define TRAMPOLINE_PLACEMENT_BASE ((128 - 8)*1024)
> -#define TRAMPOLINE_PLACEMENT_SIZE (640*1024 - (128 - 8)*1024)
> -
>  void startup_32(struct boot_params *boot_params);
>  
>  static void
>  setup_memory_protection(unsigned long image_base, unsigned long image_size)
>  {
> -	/*
> -	 * Allow execution of possible trampoline used
> -	 * for switching between 4- and 5-level page tables
> -	 * and relocated kernel image.
> -	 */
> -
> -	adjust_memory_range_protection(TRAMPOLINE_PLACEMENT_BASE,
> -				       TRAMPOLINE_PLACEMENT_SIZE);
> -
>  #ifdef CONFIG_64BIT
>  	if (image_base != (unsigned long)startup_32)
>  		adjust_memory_range_protection(image_base, image_size);
> @@ -760,6 +739,96 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
>  	return EFI_SUCCESS;
>  }
>  
> +bool efi_no5lvl;
> +
> +static void (*la57_toggle)(void *trampoline, bool enable_5lvl);
> +
> +extern void trampoline_32bit_src(void *, bool);
> +extern const u16 trampoline_ljmp_imm_offset;
> +
> +/*
> + * Enabling (or disabling) 5 level paging is tricky, because it can only be
> + * done from 32-bit mode with paging disabled. This means not only that the
> + * code itself must be running from 32-bit addressable physical memory, but
> + * also that the root page table must be 32-bit addressable, as we cannot
> + * program a 64-bit value into CR3 when running in 32-bit mode.
> + */
> +static efi_status_t efi_setup_5level_paging(void)
> +{
> +	u8 tmpl_size = (u8 *)&trampoline_ljmp_imm_offset - (u8 *)&trampoline_32bit_src;
> +	efi_status_t status;
> +	u8 *la57_code;
> +
> +	if (!efi_is_64bit())
> +		return EFI_SUCCESS;
> +
> +	/* check for 5 level paging support */
> +	if (native_cpuid_eax(0) < 7 ||
> +	    !(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
> +		return EFI_SUCCESS;
> +
> +	/* allocate some 32-bit addressable memory for code and a page table */
> +	status = efi_allocate_pages(2 * PAGE_SIZE, (unsigned long *)&la57_code,
> +				    U32_MAX);
> +	if (status != EFI_SUCCESS)
> +		return status;
> +
> +	la57_toggle = memcpy(la57_code, trampoline_32bit_src, tmpl_size);
> +	memset(la57_code + tmpl_size, 0x90, PAGE_SIZE - tmpl_size);
> +
> +	/*
> +	 * To avoid having to allocate a 32-bit addressable stack, we use a
> +	 * ljmp to switch back to long mode. However, this takes an absolute
> +	 * address, so we have to poke it in at runtime.
> +	 */
> +	*(u32 *)&la57_code[trampoline_ljmp_imm_offset] += (unsigned long)la57_code;
> +
> +	adjust_memory_range_protection((unsigned long)la57_toggle, PAGE_SIZE);
> +
> +	return EFI_SUCCESS;
> +}
> +
> +static void efi_5level_switch(void)
> +{
> +#ifdef CONFIG_X86_64
> +	static const struct desc_struct gdt[] = {
> +		[GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
> +		[GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
> +	};
> +
> +	bool want_la57 = IS_ENABLED(CONFIG_X86_5LEVEL) && !efi_no5lvl;
> +	bool have_la57 = native_read_cr4() & X86_CR4_LA57;
> +	bool need_toggle = want_la57 ^ have_la57;
> +	u64 *pgt = (void *)la57_toggle + PAGE_SIZE;
> +	u64 *cr3 = (u64 *)__native_read_cr3();
> +	u64 *new_cr3;
> +
> +	if (!la57_toggle || !need_toggle)
> +		return;
> +
> +	if (!have_la57) {
> +		/*
> +		 * We are going to enable 5 level paging, so we need to
> +		 * allocate a root level page from the 32-bit addressable
> +		 * physical region, and plug the existing hierarchy into it.
> +		 */
> +		new_cr3 = memset(pgt, 0, PAGE_SIZE);
> +		new_cr3[0] = (u64)cr3 | _PAGE_TABLE_NOENC;
> +	} else {
> +		// take the new root table pointer from the current entry #0
> +		new_cr3 = (u64 *)(cr3[0] & PAGE_MASK);
> +
> +		// copy the new root level table if it is not 32-bit addressable
> +		if ((u64)new_cr3 > U32_MAX)
> +			new_cr3 = memcpy(pgt, new_cr3, PAGE_SIZE);
> +	}
> +
> +	native_load_gdt(&(struct desc_ptr){ sizeof(gdt) - 1, (u64)gdt });
> +
> +	la57_toggle(new_cr3, want_la57);
> +#endif
> +}
> +

Nit: I would prefer to have the #ifdef around whole function with dummy
function for !CONFIG_X86_64 case, if IS_ENABLED(CONFIG_X86_64) is not an
option.

Otherwise:

	Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
