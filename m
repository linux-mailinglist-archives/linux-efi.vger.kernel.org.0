Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8653CFF70
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 18:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhGTPsv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 11:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhGTPsY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Jul 2021 11:48:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FD4C0613DC
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 09:29:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so2755190pjo.3
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5BH3R6Avka1nQpq+/eM8bvTfGscM9D0ho6TsiS6Akvo=;
        b=aSu+zS46PGf/WuVBEqvyZ3YlJH7UpgN7b7W55IBVQfm+nRT8TnxJpUy085DLjvw2OO
         f8ZqvaOXbjfbEgb5gDz9C81NKjhq0Q3tWLCyTwqLgROT6kmsDrpjqaF+WcZn3VUeTi1F
         c6NPte8/92ZnB/pvUIh6L8cq5aU84BK8G4VIhr+QbdRTZgs4BS4djKUHt5F7ggk5sYmf
         0aCJCVM7OKC+nORGR3v0q/mVmnbXfTUkIcNRSGMjiVurYAnML24JrtNzDjGOP1Glm214
         ieLZLBxWJWIR1WMAJZSv6ETDq5cLF3+g0WdMwV3dVwux3n05hX4GLOX3qsbKfVxV6+gD
         3PAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5BH3R6Avka1nQpq+/eM8bvTfGscM9D0ho6TsiS6Akvo=;
        b=XzKAMbOqGxcmwKqjpfvG7oB4o7q77aBRissk9fAnJArPvcqSTV40qnBVxPu6lIvJms
         7HAGyl+CT1Lg32auX/i/DEFWxjTAwddkbr0EqFO7rNIBrqAKLRKt3Fjhe+oVqiTvzG62
         VHl5jGAhIraYpumfBrta/W2vNXASJO/yvaYdJWwmTqX5qSAtq0Hg0Uk+Sf0Vdu8EwMsQ
         qk7rbudCox83ga3FJ9uTl/QZzmdv1lmP/Jv80Oj+f7aYXt0j17+6kF0wAsN3vxYdsY99
         8VJByFzCfoGvpDFo5ce71YXGUyH5/8oA4uE6glJ4f5/DsxkADkbaC+qHxjuWbjA6HJd0
         q7bw==
X-Gm-Message-State: AOAM532uq78YZcO/rMfNj+10sWBTG7OZSwuHsElBSO+iOCY0U1UO/Bi6
        7ttEI2zg0ao6yOUAyNYyp6j5uw==
X-Google-Smtp-Source: ABdhPJyBMjFHfdhrrQYz6sljADtLM0FyBdqBN9AsTvuwzS0vivWnLCYQIoLuo5sdH5eRngpRMsyuHg==
X-Received: by 2002:a17:90a:5b04:: with SMTP id o4mr31185589pji.210.1626798541972;
        Tue, 20 Jul 2021 09:29:01 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l1sm135113pjq.1.2021.07.20.09.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 09:29:01 -0700 (PDT)
Date:   Tue, 20 Jul 2021 16:28:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 38/40] KVM: SVM: Provide support for
 SNP_GUEST_REQUEST NAE event
Message-ID: <YPb5yfKEyJjvDbOl@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-39-brijesh.singh@amd.com>
 <YPYBmlCuERUIO5+M@google.com>
 <68ea014c-51bc-6ed4-a77e-dd7ce1a09aaf@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ea014c-51bc-6ed4-a77e-dd7ce1a09aaf@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 20, 2021, Brijesh Singh wrote:
> 
> On 7/19/21 5:50 PM, Sean Christopherson wrote:
> ...
> > 
> > IIUC, this snippet in the spec means KVM can't restrict what requests are made
> > by the guests.  If so, that makes it difficult to detect/ratelimit a misbehaving
> > guest, and also limits our options if there are firmware issues (hopefully there
> > aren't).  E.g. ratelimiting a guest after KVM has explicitly requested it to
> > migrate is not exactly desirable.
> > 
> 
> The guest message page contains a message header followed by the encrypted
> payload. So, technically KVM can peek into the message header format to
> determine the message request type. If needed, we can ratelimit based on the
> message type.

Ah, I got confused by this code in snp_build_guest_buf():

	data->req_paddr = __sme_set(req_pfn << PAGE_SHIFT);

I was thinking that setting the C-bit meant the memory was guest private, but
that's setting the C-bit for the HPA, which is correct since KVM installs guest
memory with C-bit=1 in the NPT, i.e. encrypts shared memory with the host key.

Tangetially related question, is it correct to say that the host can _read_ memory
from a page that is assigned=1, but has asid=0?  I.e. KVM can read the response
page in order to copy it into the guest, even though it is a firmware page?

	/* Copy the response after the firmware returns success. */
	rc = kvm_write_guest(kvm, resp_gpa, sev->snp_resp_page, PAGE_SIZE);

> In the current series we don't support migration etc so I decided to
> ratelimit unconditionally.

Since KVM can peek at the request header, KVM should flat out disallow requests
that KVM doesn't explicitly support.  E.g. migration requests should not be sent
to the PSP.

One concern though: How does the guest query what requests are supported?  This
snippet implies there's some form of enumeration:

  Note: This guest message may be removed in future versions as it is redundant
  with the CPUID page in SNP_LAUNCH_UPDATE (see Section 8.14).

But all I can find is a "Message Version" in "Table 94. Message Type Encodings",
which implies that request support is all or nothing for a given version.  That
would be rather unfortunate as KVM has no way to tell the guest that something
is unsupported :-(

> > Is this exposed to userspace in any way?  This feels very much like a knob that
> > needs to be configurable per-VM.
> 
> It's not exposed to the userspace and I am not sure if userspace care about
> this knob.

Userspace definitely cares, otherwise the system would need to be rebooted just to
tune the ratelimiting.  And userspace may want to disable ratelimiting entirely,
e.g. if the entire system is dedicated to a single VM.

> > Also, what are the estimated latencies of a guest request?  If the worst case
> > latency is >200ms, a default ratelimit frequency of 5hz isn't going to do a whole
> > lot.
> > 
> 
> The latency will depend on what else is going in the system at the time the
> request comes to the hypervisor. Access to the PSP is serialized so other
> parallel PSP command execution will contribute to the latency.

I get that it will be variable, but what are some ballpark latencies?  E.g. what's
the latency of the slowest command without PSP contention?

> > Question on the VMPCK sequences.  The firmware ABI says:
> > 
> >     Each guest has four VMPCKs ... Each message contains a sequence number per
> >     VMPCK. The sequence number is incremented with each message sent. Messages
> >     sent by the guest to the firmware and by the firmware to the guest must be
> >     delivered in order. If not, the firmware will reject subsequent messages ...
> > 
> > Does that mean there are four independent sequences, i.e. four streams the guest
> > can use "concurrently", or does it mean the overall freshess/integrity check is
> > composed from four VMPCK sequences, all of which must be correct for the message
> > to be valid?
> > 
> 
> There are four independent sequence counter and in theory guest can use them
> concurrently. But the access to the PSP must be serialized.

Technically that's not required from the guest's perspective, correct?  The guest
only cares about the sequence numbers for a given VMPCK, e.g. it can have one
in-flight request per VMPCK and expect that to work, even without fully serializing
its own requests.

Out of curiosity, why 4 VMPCKs?  It seems completely arbitrary.

> Currently, the guest driver uses the VMPCK0 key to communicate with the PSP.
> 
> 
> > If it's the latter, then a traditional mutex isn't really necessary because the
> > guest must implement its own serialization, e.g. it's own mutex or whatever, to
> > ensure there is at most one request in-flight at any given time.
> 
> The guest driver uses the its own serialization to ensure that there is
> *exactly* one request in-flight.

But KVM can't rely on that because it doesn't control the guest, e.g. it may be
running a non-Linux guest.

> The mutex used here is to protect the KVM's internal firmware response
> buffer.

Ya, where I was going with my question was that if the guest was architecturally
restricted to a single in-flight request, then KVM could do something like this
instead of taking kvm->lock (bad pseudocode):

	if (test_and_set(sev->guest_request)) {
		rc = AEAD_OFLOW;
		goto fail;
	}

	<do request>

	clear_bit(...)

I.e. multiple in-flight requests can't work because the guest can guarantee
ordering between vCPUs.  But, because the guest can theoretically have up to four
in-flight requests, it's not that simple.

The reason I'm going down this path is that taking kvm->lock inside vcpu->mutex
violates KVM's locking rules, i.e. is susceptibl to deadlocks.  Per kvm/locking.rst,

  - kvm->lock is taken outside vcpu->mutex

That means a different mutex is needed to protect the guest request pages.

	
> > And on the KVM side it means KVM can simpy reject requests if there is
> > already an in-flight request.  It might also give us more/better options
> > for ratelimiting?
> 
> I don't think we should be running into this scenario unless there is a bug
> in the guest kernel. The guest kernel support and CCP driver both ensure
> that request to the PSP is serialized.

Again, what the Linux kernel does is irrelevant.  What matters is what is
architecturally allowed.

> In normal operation we may see 1 to 2 quest requests for the entire guest
> lifetime. I am thinking first request maybe for the attestation report and
> second maybe to derive keys etc. It may change slightly when we add the
> migration command; I have not looked into a great detail yet.


