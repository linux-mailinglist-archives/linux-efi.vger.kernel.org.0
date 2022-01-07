Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7964876E5
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jan 2022 12:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbiAGLyc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jan 2022 06:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbiAGLyb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jan 2022 06:54:31 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7C5C061245;
        Fri,  7 Jan 2022 03:54:30 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EAEDB1EC050F;
        Fri,  7 Jan 2022 12:54:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1641556464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3MIYGxgH8IVPjiqqCa7t3Lo2u7g3b4PoNQjM+91zpCA=;
        b=FU1VPAiZExsp8CWcc+5uBx2KE8ofLRKwYAEacXKc/WoJmG5ix8y6YepFTfg6BrR2tFRIRc
        8z842ggZG/47ZdrSHS02L3fV+tCk1vJb09JWLACRvLM0eEMcdDwYtkbv67Urt3x5VGyg9k
        05DcM2HDWfspdY8zhbyqugm2KSUdDW4=
Date:   Fri, 7 Jan 2022 12:54:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 27/40] x86/boot: Add Confidential Computing type to
 setup_data
Message-ID: <Ydgp8bjPdFTpD9KC@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-28-brijesh.singh@amd.com>
 <1fdaca61-884a-ac13-fb33-a47db198f050@intel.com>
 <ba485a09-9c35-4115-decc-1b9c25519358@amd.com>
 <2a5cfbd0-865c-2a8b-b70b-f8f64aba5575@intel.com>
 <f442ca7f-4530-1443-27eb-206d6ca0e7a4@amd.com>
 <48625a39-9e31-d7f2-dccf-74e9c27126f5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48625a39-9e31-d7f2-dccf-74e9c27126f5@intel.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 13, 2021 at 07:08:07AM -0800, Dave Hansen wrote:
> Could you please make the structure's size invariant?  That's great if
> there's no problem in today's implementation, but it's best no to leave
> little land mines like this around.  Let's say someone copies your code
> as an example of something that interacts with a firmware table a few
> years or months down the road.

Btw, about that cc blob thing: is TDX going to need something like that
too and if so, can they use it too?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
