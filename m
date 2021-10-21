Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E07436926
	for <lists+linux-efi@lfdr.de>; Thu, 21 Oct 2021 19:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJURjW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Oct 2021 13:39:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57572 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231567AbhJURjV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 21 Oct 2021 13:39:21 -0400
Received: from zn.tnic (p200300ec2f1912009d2c3fdc96041a10.dip0.t-ipconnect.de [IPv6:2003:ec:2f19:1200:9d2c:3fdc:9604:1a10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8838A1EC0298;
        Thu, 21 Oct 2021 19:37:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634837823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=00cbYgpw2dYSkF28MjWjljWuNsD4cmUAI68U4oIyQGk=;
        b=D7PSMCkJQL+v+1ot4TxJ+1kfVS4aSDOp1t/3Qw7drrEY4xHhy8cXgf4p4PWGAEFQUcfMEM
        BrHQk3X/xxlgVn8o+Ho9se8qQoRiD84RfQDQQ3aUXdbtb0MXUbHVtEBXogaegim8IH3/U+
        eYTYjhcKwS9RFw0qUW7F9IQPdqpiYlM=
Date:   Thu, 21 Oct 2021 19:37:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 08/42] x86/sev-es: initialize sev_status/features
 within #VC handler
Message-ID: <YXGlPf5OTPzp09qr@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
 <YXF9sCbPDsLwlm42@zn.tnic>
 <YXGNmeR/C33HvaBi@work-vm>
 <YXGbcqN2IRh9YJk9@zn.tnic>
 <YXGflXdrAXH5fE5H@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXGflXdrAXH5fE5H@work-vm>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 21, 2021 at 06:12:53PM +0100, Dr. David Alan Gilbert wrote:
> OK, so that bit is 8...21 Eax ext2eax bit 6 page 1-109
> 
> then 2.1.5.3 CPUID policy enforcement shows 8...21 EAX as
> 'bitmask'
> 'bits set in the GuestVal must also be set in HostVal.
> This is often applied to feature fields where each bit indicates
> support for a feature'
> 
> So that's right isn't it?

Yap, AFAIRC, it would fail the check if:

(GuestVal & HostVal) != GuestVal

and GuestVal is "the CPUID result value created by the hypervisor that
it wants to give to the guest". Let's say it clears bit 6 there.

Then HostVal comes in which is "the actual CPUID result value specified
in this PPR" and there the guest catches the HV lying its *ss off.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
