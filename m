Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1728B3B47EF
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jun 2021 19:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhFYRES (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Jun 2021 13:04:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47780 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhFYRER (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 25 Jun 2021 13:04:17 -0400
Received: from zn.tnic (p200300ec2f0dae00689ae3531874a6f6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:ae00:689a:e353:1874:a6f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E9001EC059E;
        Fri, 25 Jun 2021 19:01:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624640515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pu13lrRI0VXpD1HEqkvclBljYf9ytk96hnSQt+aGmXw=;
        b=H1Yh4uzkPMKaMMOc+J9XbxrYO+z86o2WWlQVVxl82WbgjTqaiX3mkttyZllUnBddq7N0N5
        Ukg5SxlpmjgUH+BM5DHkGprnwGt82c60n9RwtC8HblbAy8IVmFIKukkbfNCcCN5GRRyjPm
        wkzuNTYqCqf0MUdFLijx97OgboDYlW8=
Date:   Fri, 25 Jun 2021 19:01:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Michael Roth <michael.roth@amd.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 20/22] x86/boot: Add Confidential Computing
 address to setup_header
Message-ID: <YNYMAkoSoMnfhBnJ@zn.tnic>
References: <YMy2OGwsRzrR5bwD@zn.tnic>
 <162442264313.98837.16983159316116149849@amd.com>
 <YNMLX6fbB3PQwSpv@zn.tnic>
 <20210624031911.eznpkbgjt4e445xj@amd.com>
 <YNQz7ZxEaSWjcjO2@zn.tnic>
 <20210624123447.zbfkohbtdusey66w@amd.com>
 <YNSAlJnXMjigpqu1@zn.tnic>
 <20210624141111.pzvb6gk5lzfelx26@amd.com>
 <YNXs1XRu31dFiR2Z@zn.tnic>
 <8faad91a-f229-dee3-0e1f-0b613596db17@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8faad91a-f229-dee3-0e1f-0b613596db17@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 25, 2021 at 10:24:01AM -0500, Brijesh Singh wrote:
> In the case of EFI, the CC blob structure is dynamically allocated
> and passed through the EFI configuration table. The grub will not
> know what value to pass in the cmdline unless we improve it to read
> the EFI configuration table and rebuild the cmdline.

Or simply parse the EFI table.

To repeat my question: why do you need the CC blob in the boot kernel?

Then, how does it work then in the !EFI case?

The script glue that starts the lightweight container goes and
"prepares" that blob and passes it to guest kernel? In which case
setup_data should do the job, methinks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
