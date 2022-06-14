Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D63954A334
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jun 2022 02:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiFNAqq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jun 2022 20:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiFNAqo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Jun 2022 20:46:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E612FFEA
        for <linux-efi@vger.kernel.org>; Mon, 13 Jun 2022 17:46:43 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w21so7260082pfc.0
        for <linux-efi@vger.kernel.org>; Mon, 13 Jun 2022 17:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s2FWD/PtgY9oueUwTZqKdyU1Zetmw+d/ZG43eXlDlcM=;
        b=YgSLK9gviQctEV72wBcPKr3rDhijCNprOQ+gp2fOSYMwl+z8m/ywJFJNdRTPfdRN6x
         iDRg42v/QZUmhq4AMxM+546r3kFUi55RAc+j47EeF+C6skbeoGymucTmWpWLGBIjymwN
         uCP4s+WQkriW77kbjxxgNIF7QaYBwwsZzcUDKSti8Czi1gIsPCEV4pAVmZvrc7Ueaqhw
         lOHhx1muh9QhVGl7UTGDpBBFbxdvLgwbahBIYa67KFXU4u9bWvK0IQr6jEiB+VXErtmh
         6ToX5gd8nYLLeOC0TQ5G60KE/adZglCpxc3QxuFm4VL16SHCtIdEzNaKBM/HaQhyF4O5
         +Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s2FWD/PtgY9oueUwTZqKdyU1Zetmw+d/ZG43eXlDlcM=;
        b=6JFbzkEyqT10TjgLcM+TDN2hj26RtDFKJ2y4Ckczdfldf+4eeieXubMiTxJCok0/ox
         zQRBeJsR2ns/pRtCVj6+HzUccwYrqxz5v05+FdN7rxRxDXfOtjMRwJPi2Gmq69dT6zie
         96h8DAlewvWTpxNhQPPGWUVl++mPZ2JHpUv4vstd3CixrWQBB0oW4P/PDC1NseTKd8/v
         5bK+6wEtPvG0TMWNRAC3jr9FGUyIZ7atUQc/w47w4kAdvNcajWwjCL3gLco0D5RSNdg1
         qKBL54rer+SseVCRk41nWjck4lNOmjtHnO2i0P7g4pA+D57Xh/GNGVX9IP8ojHuX9IiG
         Pgxw==
X-Gm-Message-State: AOAM533pdIH9XcIZ/Xcf6xyV5DxZzGAgr+qkij8xhWNZzF4/mJ9jMOOc
        TZ/4iSX0qnsGOtKw1z1KwyveCm0Z5RJ5Rg==
X-Google-Smtp-Source: ABdhPJyqpKu6p1u5KzVVLMZAfN9ra4WcAcLZdMNT/RwAJ4w3TWcPwfXbJl2ut/OvLAU1lo600eJCYA==
X-Received: by 2002:a05:6a00:179b:b0:51b:f51f:992e with SMTP id s27-20020a056a00179b00b0051bf51f992emr2018667pfg.60.1655167602802;
        Mon, 13 Jun 2022 17:46:42 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a2b8400b001e31fea8c85sm8035481pjd.14.2022.06.13.17.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 17:46:42 -0700 (PDT)
Date:   Tue, 14 Jun 2022 00:46:38 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v12 19/46] x86/kernel: Make the .bss..decrypted section
 shared in RMP table
Message-ID: <YqfabnTRxFSM+LoX@google.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-20-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307213356.2797205-20-brijesh.singh@amd.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

s/Brijesh/Michael

On Mon, Mar 07, 2022, Brijesh Singh wrote:
> The encryption attribute for the .bss..decrypted section is cleared in the
> initial page table build. This is because the section contains the data
> that need to be shared between the guest and the hypervisor.
> 
> When SEV-SNP is active, just clearing the encryption attribute in the
> page table is not enough. The page state need to be updated in the RMP
> table.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/head64.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 83514b9827e6..656d2f3e2cf0 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -143,7 +143,20 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
>  	if (sme_get_me_mask()) {
>  		vaddr = (unsigned long)__start_bss_decrypted;
>  		vaddr_end = (unsigned long)__end_bss_decrypted;
> +
>  		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
> +			/*
> +			 * On SNP, transition the page to shared in the RMP table so that
> +			 * it is consistent with the page table attribute change.
> +			 *
> +			 * __start_bss_decrypted has a virtual address in the high range
> +			 * mapping (kernel .text). PVALIDATE, by way of
> +			 * early_snp_set_memory_shared(), requires a valid virtual
> +			 * address but the kernel is currently running off of the identity
> +			 * mapping so use __pa() to get a *currently* valid virtual address.
> +			 */
> +			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);

This breaks SME on Rome and Milan when compiling with clang-13.  I haven't been
able to figure out exactly what goes wrong.  printk isn't functional at this point,
and interactive debug during boot on our test systems is beyond me.  I can't even
verify that the bug is specific to clang because the draconian build system for our
test systems apparently is stuck pointing at gcc-4.9.

I suspect the issue is related to relocation and/or encrypting memory, as skipping
the call to early_snp_set_memory_shared() if SNP isn't active masks the issue.
I've dug through the assembly and haven't spotted a smoking gun, e.g. no obvious
use of absolute addresses.

Forcing a VM through the same path doesn't fail.  I can't test an SEV guest at the
moment because INIT_EX is also broken.

The crash incurs a very, very slow reboot, and I was out of cycles to work on this
about three hours ago.  If someone on the AMD side can repro, it would be much
appreciated.
