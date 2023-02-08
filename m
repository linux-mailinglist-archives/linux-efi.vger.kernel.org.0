Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF1B68EF73
	for <lists+linux-efi@lfdr.de>; Wed,  8 Feb 2023 14:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBHNAQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Feb 2023 08:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBHNAP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Feb 2023 08:00:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2BA76A4
        for <linux-efi@vger.kernel.org>; Wed,  8 Feb 2023 05:00:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61A09616CA
        for <linux-efi@vger.kernel.org>; Wed,  8 Feb 2023 13:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DB7C433D2;
        Wed,  8 Feb 2023 13:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675861213;
        bh=i2wyhlZLGEJYBJUAHMF2WHs1gWfyCC+jbEx2HGxuu9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n2z8RDLwCPHEVws1AqG9KxBnEqX4BXK47KA5yEkrkwTYiN53NaCM/G9GlrIRlp77G
         TB4XOVeVIqxDhHx9Zo9lN5WGLnvOkcPtvwTOdsOvYhyp0Dmh1DJ3KvBczT9SIpjZ0f
         PbqIK8B/mlo4SRU1Ua/QnmTUuRUQpNTN0VsO5WOYQgLNjA1sULlFl8g4EtMChjRg0N
         HYR9QadmddxcpprWFOjBHnM3+jq5MS0A4fK4zvnb8OBnWgcH/nKRiYqfAmdP1UEN3S
         XhrIwbI5bOUR69yqW8rybCez8noH2Pcule6lbkEXPnh1erLoBBpVw5LoAiCX15J9k0
         WZScX38Nz4paQ==
Date:   Wed, 8 Feb 2023 13:00:08 +0000
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 2/3] efi: arm64: Wire up BTI annotation in memory
 attributes table
Message-ID: <20230208130007.GA13529@willie-the-truck>
References: <20230206124938.272988-1-ardb@kernel.org>
 <20230206124938.272988-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206124938.272988-3-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 06, 2023 at 01:49:37PM +0100, Ard Biesheuvel wrote:
> UEFI v2.10 extends the EFI memory attributes table with a flag that
> indicates whether or not all RuntimeServicesCode regions were
> constructed with BTI landing pads, permitting the OS to map these
> regions with BTI restrictions enabled.
> 
> So let's take this into account on arm64.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/kernel/efi.c   | 14 ++++++++++++--
>  arch/arm64/kernel/traps.c |  6 ++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index 78ffd5aaddcbbaee..99971cd349f36310 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -96,15 +96,23 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
>  	return 0;
>  }
>  
> +struct set_perm_data {
> +	const efi_memory_desc_t	*md;
> +	bool			has_bti;
> +};
> +
>  static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
>  {
> -	efi_memory_desc_t *md = data;
> +	struct set_perm_data *spd = data;
> +	const efi_memory_desc_t *md = spd->md;
>  	pte_t pte = READ_ONCE(*ptep);
>  
>  	if (md->attribute & EFI_MEMORY_RO)
>  		pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
>  	if (md->attribute & EFI_MEMORY_XP)
>  		pte = set_pte_bit(pte, __pgprot(PTE_PXN));
> +	else if (system_supports_bti() && spd->has_bti)

system_supports_bti() seems to check CONFIG_ARM64_BTI rather than
CONFIG_ARM64_BTI_KERNEL. In theory, I think this means we could have
mismatched BTI support, so it might be slightly more robust to use the
latter option here even thought the runtime services aren't kernel code.

What do you think?

Will
