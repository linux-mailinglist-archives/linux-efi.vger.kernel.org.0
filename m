Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB75844DE09
	for <lists+linux-efi@lfdr.de>; Thu, 11 Nov 2021 23:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhKKXBS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Nov 2021 18:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhKKXBS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 Nov 2021 18:01:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFA6C061766;
        Thu, 11 Nov 2021 14:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=4VEbIBkqcGJ3l7Zgq/uZwytuUTxQjnyHYFTzYLajeFM=; b=TRKP74wrJUWYaJp4HuEvwVy7CF
        YTjoRR5QTzBEeBxq3PCrmmtk8OoH2yjaSangsFbsIzdeSF3SLaE56izUwg7fntdvR2wOK/SS+BBoW
        mlw1ocs5fd6xel1vUL09N1TKuP894s35YGVDEpjPgpVFbveFsZ22oH/jfhCfNxY8cANsFbTSLGVAx
        K2DBb0Cg0FcItQGhKOg0hYwZVpeswRgpzsjAb1ohwaQTwk1JI+3g3tjD+fcTGOK18WGrRiP2XgaLJ
        80qxVMKle/wX4S20DP1RY6pgKSTZD0GwVGh8FXexqBMDy9+bYRS3kt0g4B2yElOISKUDDoO4fTzVX
        z6FuMwhQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlJ17-008w1k-MP; Thu, 11 Nov 2021 22:58:01 +0000
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
 <e8baf85f-8f17-d43e-4656-ed9003affaa8@infradead.org>
 <38e5047c-43a9-400b-c507-337011e0e605@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e6b412e4-f38e-d212-f52a-e7bdc9a26eff@infradead.org>
Date:   Thu, 11 Nov 2021 14:57:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <38e5047c-43a9-400b-c507-337011e0e605@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/11/21 11:27 AM, Brijesh Singh wrote:
> Hi Randy,
> 
> On 11/10/21 4:27 PM, Randy Dunlap wrote:
>> Hi,
>>
>> On 11/10/21 2:07 PM, Brijesh Singh wrote:
>>> diff --git a/drivers/virt/coco/sevguest/Kconfig b/drivers/virt/coco/sevguest/Kconfig
>>> new file mode 100644
>>> index 000000000000..96190919cca8
>>> --- /dev/null
>>> +++ b/drivers/virt/coco/sevguest/Kconfig
>>> @@ -0,0 +1,9 @@
>>> +config SEV_GUEST
>>> +    tristate "AMD SEV Guest driver"
>>> +    default y
>>
>> For this to remain as "default y", you need to justify it.
>> E.g., if a board cannot boot with an interrupt controller,
>> the driver for the interrupt controller can be "default y".
>>
>> So why is this default y?
>> No other drivers in drivers/virt/ are default y.
>>
> 
> I choose the default "y" for two reasons:
> 
> 1.  The driver is built if the user enables the AMD memory encryption support. If the user has selected the AMD memory encryption support, they will be querying an attestation report to verify that the guest is running on AMD memory encryption enabled hardware.

OK, I see. I'm OK with this.

> 2. Typically, an attestation report is retrieved from an initial ramdisk (before mounting the disk). IIUC, the standard initramfs build tools may not include the driver by default and requires the user to go through hoops.
> 
> However, I have no strong reason to keep it to "y" if other prefers "m".

"m" is no better than "y" in this case.

thanks.
-- 
~Randy
