Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E974F4A8763
	for <lists+linux-efi@lfdr.de>; Thu,  3 Feb 2022 16:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbiBCPNm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 10:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351724AbiBCPNl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Feb 2022 10:13:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA67C061714;
        Thu,  3 Feb 2022 07:13:41 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 06EFB1EC058A;
        Thu,  3 Feb 2022 16:13:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643901215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=su0chIW0cbLPhkXWhBMbksAxZ8gJeI5gzh3NlG+Xo84=;
        b=IR0S7zOkfUWi6s+H1hW6QRZqmnqKiQr+TTTkruM9jmVAPrd6LPVMOz/kLFqsEMBL6OHUdb
        0RirvheWyH6ntw7tYuI3euDtmJu0KSSIcQ2UrY+HQkOAfjVqNXUkgvupXLWO5B8tEQ0tDr
        MFvLcIG8N1QcnGZL9J29hBqtFkThfxs=
Date:   Thu, 3 Feb 2022 16:13:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 26/43] x86/compressed/acpi: Move EFI config table
 lookup to helper
Message-ID: <YfvxGXNB8cCUT/Ia@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-27-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-27-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:47AM -0600, Brijesh Singh wrote:
> +int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
> +		       unsigned int *cfg_tbl_len)
> +{
> +	unsigned long sys_tbl_pa = 0;
> +	enum efi_type et;
> +	int ret;
> +
> +	if (!cfg_tbl_pa || !cfg_tbl_len)
> +		return -EINVAL;
> +
> +	sys_tbl_pa = efi_get_system_table(boot_params);
> +	if (!sys_tbl_pa)
> +		return -EINVAL;
> +
> +	/* Handle EFI bitness properly */
> +	et = efi_get_type(boot_params);
> +	if (et == EFI_TYPE_64) {
> +		efi_system_table_64_t *stbl =
> +			(efi_system_table_64_t *)sys_tbl_pa;
> +
> +		*cfg_tbl_pa = stbl->tables;
> +		*cfg_tbl_len = stbl->nr_tables;
> +	} else if (et == EFI_TYPE_32) {
> +		efi_system_table_32_t *stbl =
> +			(efi_system_table_32_t *)sys_tbl_pa;

You don't have to break those assignment lines - the 80 cols rule is not
a hard one. Readability is more important.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
