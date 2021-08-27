Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC4B3F9EFC
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 20:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhH0SjR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 14:39:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49674 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhH0SjR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Aug 2021 14:39:17 -0400
Received: from zn.tnic (p200300ec2f111700cf40790d4c46ba75.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:cf40:790d:4c46:ba75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CDB251EC0464;
        Fri, 27 Aug 2021 20:38:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630089499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=t+xxIP9uLE2qKNsNAixEL1iyf/pnnr0UZ4HpARN6vZw=;
        b=cYtBzViG3yaxSxZRiNDL6T0Nvgvute5y0a3ctlFxLvWQPZ+N1QIrcCL/yN9ZYuaxvfJa6+
        n6497xJ+QfBMS4n19u4Ex6hWGmdeVxeKygIDFV9ZHG1eYP+O/Td/9C63Anbs//jJKlNrEJ
        VUhzKTaU1dEPYymxXB43x1GQI//2a8I=
Date:   Fri, 27 Aug 2021 20:38:57 +0200
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
        Wanpeng Li <wanpengli@tencent.com>,
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
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 33/38] x86/sev: Provide support for SNP guest
 request NAEs
Message-ID: <YSkxQc8dk9G8Lt9F@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-34-brijesh.singh@amd.com>
 <YSkkaaXrg6+cnb9+@zn.tnic>
 <4acd17bc-bdb0-c4cc-97af-8842f8836c8e@amd.com>
 <YSkrPXLqg38txCqp@zn.tnic>
 <caffa9dc-06ca-e1d4-e887-fed51c389790@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <caffa9dc-06ca-e1d4-e887-fed51c389790@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 27, 2021 at 01:27:14PM -0500, Brijesh Singh wrote:
> Those definitions are present in <asm/xxx>. Somewhere I read said that
> if possible a new drivers should avoid including the <asm/xxx>. 

Where?

That is news to me. It is likely possible that I might've missed that
rule but it doesn't look like there's a rule like that at the moment:

$ git grep -E "include.*asm" drivers/ | wc -l
4475

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
