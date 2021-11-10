Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D4444CCAA
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhKJWao (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbhKJWao (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 Nov 2021 17:30:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49C1C061766;
        Wed, 10 Nov 2021 14:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ajE2E1oSo9dMdca3nNcODp4DAhXTWNhCgu0RAXyw3Ts=; b=zZ9gUMnX+5lgCf/ZDSs2giGD2x
        pYvIHVANyt+wE9U86AVXKNBSFYn2SLmKPKhTE6Ek4pOcdOtRG2KLOFqI1LF0XYp/+yNnj6do2TwyP
        qb82kSIOdOwCqoLvUuJIndcEJo+8rihYLaaIad1cR4sk2T3Db5bh73eRBNwPHBYnu0xMVy3BSg9TD
        qQIOVkzo6aXJM8ba1+5AleepYAoLPnRskqqJEsuhcwxoJHFQlJ8iqSpHX0E3JRwkYml/JtYEyy+Lb
        4/claBL7QjKZDCOnJfYjui1utRDVX7teIlBW3dp2cW1jmIBg0rmp2Jq8PsFPp3WoqbmXYvn2A16F1
        Tfxz46FQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkw3z-006Xsi-SV; Wed, 10 Nov 2021 22:27:27 +0000
Subject: Re: [PATCH v7 43/45] virt: Add SEV-SNP guest driver
To:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-44-brijesh.singh@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e8baf85f-8f17-d43e-4656-ed9003affaa8@infradead.org>
Date:   Wed, 10 Nov 2021 14:27:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211110220731.2396491-44-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 11/10/21 2:07 PM, Brijesh Singh wrote:
> diff --git a/drivers/virt/coco/sevguest/Kconfig b/drivers/virt/coco/sevguest/Kconfig
> new file mode 100644
> index 000000000000..96190919cca8
> --- /dev/null
> +++ b/drivers/virt/coco/sevguest/Kconfig
> @@ -0,0 +1,9 @@
> +config SEV_GUEST
> +	tristate "AMD SEV Guest driver"
> +	default y

For this to remain as "default y", you need to justify it.
E.g., if a board cannot boot with an interrupt controller,
the driver for the interrupt controller can be "default y".

So why is this default y?
No other drivers in drivers/virt/ are default y.

> +	depends on AMD_MEM_ENCRYPT && CRYPTO_AEAD2
> +	help
> +	  The driver can be used by the SEV-SNP guest to communicate with the PSP to
> +	  request the attestation report and more.
> +
> +	  If you choose 'M' here, this module will be called sevguest.

thanks.
-- 
~Randy
