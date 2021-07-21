Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C3B3D17CD
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jul 2021 22:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhGUTeu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Jul 2021 15:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhGUTer (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Jul 2021 15:34:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E340C061575
        for <linux-efi@vger.kernel.org>; Wed, 21 Jul 2021 13:15:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id i16-20020a17090acf90b02901736d9d2218so2006103pju.1
        for <linux-efi@vger.kernel.org>; Wed, 21 Jul 2021 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JYgF6/pkTp1ByHMaAngGJCR/bmJodLde5csRbzkM0r4=;
        b=UhVUzEOtC4uWKpgp+8WrUnRj1KkG0NU0qXSw6K31wuPNQzTvnMNYXNk0eEmIJ/deHp
         4urTjpJN9QlonhLvFzYlpUnuaGRNEo+n8pboDfPEBiftxqMsxcSi9fVEIq95RLJ4G1C5
         epEUNX99hjz9o/cShG6PGS+S/7maU+ahD19VoTNjj9dlslgE/D3EzMiMs21uwSzAIjt+
         6lsdpmyaBa04q38/Faqo8JjVQP6rzU+ED4+vprLPalQdgDC/HYqfMyRd5NW9hxUEdkTZ
         Tky/uifJKxgKmBQfc46OSY7qMfNDkxQJ/Jz78Z2rYwL7c8D3jJXBrrRWMuAjkEO6jZIo
         3NLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JYgF6/pkTp1ByHMaAngGJCR/bmJodLde5csRbzkM0r4=;
        b=gKy+APyUsffHtncznBuzHKm4xAdmipfp3WI6BwruZBYsYp9tX0oE9lC2KVE7LOmhYN
         kewtpFshFW3JUXJb9RQq7uzM59eEuK6Xn61uYNnteeTwel3MXAiVjob5BYLCSU2LzcmG
         ESS5M5lkPSFA7Xkggzx9EDnZL0fOSps1gBoVkl9il76+My7oYImgHd9+M/TYDEqIiOVC
         HXscK8NspjFNhmH81ymRB0GEI4EgMjwJEFPXojFF23LpS/xWCfkEI50NF8f8YZpA+435
         mark3QWCEuqhuWCz2CcGo41S4yD1FZAZSDYP8o181AuYKVkSi2CK7uJ2jp+EcxaU4M1B
         Lezg==
X-Gm-Message-State: AOAM530s5O8ry/ofeBbZUzlznxlgXsSwIKylAYKKY5rbgObX0Vxr4O9J
        HPetislxiR35NcogtKgvQ6l+Tw==
X-Google-Smtp-Source: ABdhPJwl1I+ugWhiFqcmskmLa+S1KfP1gCUBBWpNkdILi0W0UrSnBIhERqyC8NYVuMxc+aNo5sruIA==
X-Received: by 2002:a05:6a00:d53:b029:32a:2db6:1be3 with SMTP id n19-20020a056a000d53b029032a2db61be3mr37731045pfv.71.1626898521394;
        Wed, 21 Jul 2021 13:15:21 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q18sm27746006pfj.178.2021.07.21.13.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 13:15:20 -0700 (PDT)
Date:   Wed, 21 Jul 2021 20:15:16 +0000
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
Subject: Re: [PATCH Part2 RFC v4 37/40] KVM: SVM: Add support to handle the
 RMP nested page fault
Message-ID: <YPiAVEuAuDS3neyx@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-38-brijesh.singh@amd.com>
 <YPYUe8hAz5/c7IW9@google.com>
 <bff43050-aed7-011c-89e5-9899bd1df414@amd.com>
 <YPdOxrIA6o3uymq2@google.com>
 <03f42d61-fa32-38d0-7e14-17ee6f1d7dad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f42d61-fa32-38d0-7e14-17ee6f1d7dad@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 20, 2021, Brijesh Singh wrote:
> 
> On 7/20/21 5:31 PM, Sean Christopherson wrote:
> ...
> >> This is a good question, the GHCB spec does not enforce that a guest *must*
> >> use page state. If the page state changes is not done by the guest then it
> >> will cause #NPF and its up to the hypervisor to decide on what it wants to
> >> do.
> > Drat.  Is there any hope of pushing through a GHCB change to require the guest
> > to use PSC?
> 
> Well, I am not sure if we can push it through GHCB. Other hypervisor
> also need to agree to it. We need to define them some architectural way
> for hypervisor to detect the violation and notify guest about it.

And other guest's, too :-/

> >>> It would simplify KVM (albeit not much of a simplificiation) and would also
> >>> make debugging easier since transitions would require an explicit guest
> >>> request and guest bugs would result in errors instead of random
> >>> corruption/weirdness.
> >> I am good with enforcing this from the KVM. But the question is, what fault
> >> we should inject in the guest when KVM detects that guest has issued the
> >> page state change.
> > Injecting a fault, at least from KVM, isn't an option since there's no architectural
> > behavior we can leverage.  E.g. a guest that isn't enlightened enough to properly
> > use PSC isn't going to do anything useful with a #MC or #VC.
> >
> > Sadly, as is I think our only options are to either automatically convert RMP
> > entries as need, or to punt the exit to userspace.  Maybe we could do both, e.g.
> > have a module param to control the behavior?  The problem with punting to userspace
> > is that KVM would also need a way for userspace to fix the issue, otherwise we're
> > just taking longer to kill the guest :-/
> >
> I think we should automatically convert the RMP entries at time, its
> possible that non Linux guest may access the page without going through
> the PSC.

Agreed.  I don't love that KVM will disallow automatic conversions when the host
is accessing guest memory, but not when the guest is accessing memory.  On the
other hand, auto-converting when accessing from the host is far, far worse.

And FWIW, IIRC this is also aligns with the expected/proposed TDX behavior, so
that's a plus.
