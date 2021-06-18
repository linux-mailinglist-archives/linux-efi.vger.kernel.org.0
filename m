Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3968B3AC320
	for <lists+linux-efi@lfdr.de>; Fri, 18 Jun 2021 08:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhFRGKg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Jun 2021 02:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhFRGKg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Jun 2021 02:10:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C47C061574;
        Thu, 17 Jun 2021 23:08:27 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0dd800c1c0f109d0ca36f4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d800:c1c0:f109:d0ca:36f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C0031EC0527;
        Fri, 18 Jun 2021 08:08:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623996506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8nhiIyd0UfJ51I2mU8e1o3cOfn6a+lJAiwXGrRATjfQ=;
        b=gLOiSEFoAu3J7Hu9gnfMHFwA24+s3/87n4JIQn9IVDbmQVOI/gWUr6HIJ+qJpXJd0+Amid
        rFN/qnWzoWxg0GTgjsGo+YkQHI4ObOZHxfJpgWdzJGZPR3N1hPHmmlGKVT57c9THN1OEkG
        2u2NqZqAOMZN3IY2Fi+OvPgnMh/6S1Y=
Date:   Fri, 18 Jun 2021 08:08:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 20/22] x86/boot: Add Confidential Computing
 address to setup_header
Message-ID: <YMw4UZn6AujpPSZO@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-21-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-21-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 02, 2021 at 09:04:14AM -0500, Brijesh Singh wrote:
> While launching the encrypted guests, the hypervisor may need to provide
> some additional information that will used during the guest boot. In the
> case of AMD SEV-SNP the information includes the address of the secrets
> and CPUID pages. The secrets page contains information such as a VM to
> PSP communication key and CPUID page contain PSP filtered CPUID values.
> 
> When booting under the EFI based BIOS, the EFI configuration table
> contains an entry for the confidential computing blob. In order to support
> booting encrypted guests on non EFI VM, the hypervisor to pass these
> additional information to the kernel with different method.
> 
> For this purpose expand the struct setup_header to hold the physical
> address of the confidential computing blob location. Being zero means it
> isn't passed.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  Documentation/x86/boot.rst            | 27 +++++++++++++++++++++++++++
>  arch/x86/boot/header.S                |  7 ++++++-
>  arch/x86/include/uapi/asm/bootparam.h |  1 +
>  3 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
> index fc844913dece..9b32805617bb 100644
> --- a/Documentation/x86/boot.rst
> +++ b/Documentation/x86/boot.rst
> @@ -75,6 +75,8 @@ Protocol 2.14	BURNT BY INCORRECT COMMIT
>  		DO NOT USE!!! ASSUME SAME AS 2.13.
>  
>  Protocol 2.15	(Kernel 5.5) Added the kernel_info and kernel_info.setup_type_max.
> +
> +Protocol 2.16	(Kernel 5.14) Added the confidential computing blob address
>  =============	============================================================
>  
>  .. note::
> @@ -226,6 +228,7 @@ Offset/Size	Proto		Name			Meaning
>  0260/4		2.10+		init_size		Linear memory required during initialization
>  0264/4		2.11+		handover_offset		Offset of handover entry point
>  0268/4		2.15+		kernel_info_offset	Offset of the kernel_info
> +026C/4		2.16+		cc_blob_address	        Physical address of the confidential computing blob

Why is this a separate thing instead of being passed as setup_data?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
