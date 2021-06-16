Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57773A9B83
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jun 2021 15:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhFPNJH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Jun 2021 09:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232978AbhFPNJD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Jun 2021 09:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623848816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4FsZ+W5sZrXednhxFcSgtJDgo1UvbrnapydD3pMYxu0=;
        b=SbnoJVFbPc5m3jCfd3MfFq2/voG3/eKBafj6zQrzQ2K0/I5sr24JLyXz7iYGKn79hrhPIP
        F7vzhX9mVE5BUH25HHwyh1ihfYiAi/yLv/HwklIECiDwzSQ0C4xgJ3JM2X86NjuNwkKpn7
        5SdknqJzhttPYRokwApNi9imHBNGmeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-sU_-JDyPP9G0uvfGozhLNg-1; Wed, 16 Jun 2021 09:06:55 -0400
X-MC-Unique: sU_-JDyPP9G0uvfGozhLNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAC9E801B3E;
        Wed, 16 Jun 2021 13:06:51 +0000 (UTC)
Received: from work-vm (ovpn-115-42.ams2.redhat.com [10.36.115.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA5666062C;
        Wed, 16 Jun 2021 13:06:44 +0000 (UTC)
Date:   Wed, 16 Jun 2021 14:06:42 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 11/22] x86/sev: Add helper for validating
 pages in early enc attribute changes
Message-ID: <YMn3Yqp8Jq3TUhvv@work-vm>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-12-brijesh.singh@amd.com>
 <YMI02+k2zk9eazjQ@zn.tnic>
 <d0759889-94df-73b0-4285-fa064eb187cd@amd.com>
 <YMen5wVqR31D/Q4z@zn.tnic>
 <70db789d-b1aa-c355-2d16-51ace4666b3f@amd.com>
 <YMnNYNBvEEAr5kqd@zn.tnic>
 <f7e70782-701c-13dd-43d2-67c92f8cf36f@amd.com>
 <YMnoeRcuMfAqX5Vf@zn.tnic>
 <9f012bcb-4756-600d-6fe8-b1db9b972f17@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f012bcb-4756-600d-6fe8-b1db9b972f17@amd.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

* Brijesh Singh (brijesh.singh@amd.com) wrote:
> 
> On 6/16/21 7:03 AM, Borislav Petkov wrote:
> > On Wed, Jun 16, 2021 at 06:00:09AM -0500, Brijesh Singh wrote:
> >> I am trying to be consistent with previous VMGEXIT implementations. If
> >> the command itself failed then use the command specific error code to
> >> tell hypervisor why we terminated but if the hypervisor violated the
> >> GHCB specification then use the "general request termination".
> > I feel like we're running in circles here: I ask about debuggability
> > and telling the user what exactly failed and you're giving me some
> > explanation about what the error codes mean. I can see what they mean.
> >
> > So let me try again:
> >
> > Imagine you're a guest owner and you haven't written the SNP code and
> > you don't know how it works.
> >
> > You start a guest in the public cloud and it fails because the
> > hypervisor violates the GHCB protocol and all that guest prints before
> > it dies is
> >
> > "general request termination"
> 
> 
> The GHCB specification does not define a unique error code for every
> possible condition. Now that we have reserved reason set 1 for the
> Linux-specific error code, we could add a new error code to cover the
> cases for the protocol violation. I was highlighting that we should not
> overload the meaning of GHCB_TERM_PSC. In my mind, the GHCB_TERM_PSC
> error code is used when the guest sees that the hypervisor failed to
> change the state . The failure maybe because the guest provided a bogus
> GPA or invalid operation code, or RMPUPDATE failure or HV does not
> support SNP feature etc etc. But in this case, the failure was due to
> the protocol error, and IMO we should not use the GHCB_TERM_PSC.
> Additionally, we should also update CPUID and other VMGEXITs to use the
> new error code instead of "general request termination" so that its
> consistent.
> 
> 
> If you still think that GHCB_TERM_PSC is valid here, then I am okay with it.

I'd kind of agree with Borislav, the more hints we can have as to the
actual failure reason the better - so if you've got multiple cases
where the guest thinks the hypervisor has screwed up, find a way to give
an error code to tell us which one.

Dave

> -Brijesh
> 
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

