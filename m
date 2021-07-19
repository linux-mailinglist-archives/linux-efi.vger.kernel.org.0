Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96583CEE7C
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358124AbhGSU62 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 16:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386034AbhGSTYM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Jul 2021 15:24:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7E8C061768
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 12:59:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p9so12248900pjl.3
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 13:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6mrIddCBqzP9Q52MJPTxcpi1gB+yoljcisd3OcU3iwY=;
        b=UWN1mAIBvoS4DLrVaNW+rWGV/OZ2BCPW1+LGCZCkgQnV1zqBepdR60rAsAMa59hVmO
         nAUA+PfURyO6iS6RnTJ/RAb2NwXk0KVXwdW6NfzkuMsV4Cqx+o0gFm9aqhJKswk+l3nR
         bNjZdMU+6WNseInEDkXhoGcgSsbVi+7dW6ND228Zz6niJ42x7HaEbUYFZznbuHQ2TRap
         gb8xMjdUuXKbVf9BD8weBoqPaxhQIyDMb9WWs558ZtLU6bie+ua0+N2mEt2UC4UUjikh
         UUTmXFdsL7HEujwsHb18XcFjh0PkGuAP9CZjgUN8nmIpuMxfPEwOGH3SSjtoD0x3IvKQ
         HtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6mrIddCBqzP9Q52MJPTxcpi1gB+yoljcisd3OcU3iwY=;
        b=ucIukQTeAD5so34xhsp2O18+xWnqu/isCY1eG9BcdTYT2LuETGFhp9PBlHUreY9sHx
         DuW0pEBKys7xjNHc6/h1Uf8UZ1OBJsjpP5fyzZgSLqi0tbyNKFl3XwRKpRc02ssIQxYf
         gGxxk6UkWu48zKUO9DJp1rCoUmcC264iefPck59iXGwbfXxxUO3bOATlPRfiXga533BQ
         l0zYR05wq5xDkcNialpMUIEKqhz5ZlH1Q3w5E2PtxAxBbqJcAdotrYxGVwRSWGMHCxLg
         8eDoDmpkeamW2H7kelaREczFhkuPwpOBRIi20P4yymFcVK0kuATbGt4k7zObRxdylGiU
         IyGQ==
X-Gm-Message-State: AOAM532WbWcvibSHLuk3NTZV8YVWoAKyG/RYRvEawN1SWghqpbFPDuDH
        GVLr2yYbSWCxQZRSrdCtmHAcIw==
X-Google-Smtp-Source: ABdhPJyWwkctPggHtVzSznHpuN2o7lMFAaGwb6T+Lhzg1Hc0ZtDLw1R7db1DHG1Rcj+uWzfPnXseTw==
X-Received: by 2002:a17:902:bcc3:b029:11c:5ffb:61fb with SMTP id o3-20020a170902bcc3b029011c5ffb61fbmr20657848pls.18.1626725091240;
        Mon, 19 Jul 2021 13:04:51 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w5sm21451077pfq.130.2021.07.19.13.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 13:04:50 -0700 (PDT)
Date:   Mon, 19 Jul 2021 20:04:46 +0000
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
Subject: Re: [PATCH Part2 RFC v4 32/40] KVM: SVM: Add support to handle GHCB
 GPA register VMGEXIT
Message-ID: <YPXa3gWrBW9fdGXK@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-33-brijesh.singh@amd.com>
 <YPHv0eCCOZQKne0O@google.com>
 <35b1c6c6-b8f1-6ec6-e55c-f2e552e29527@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35b1c6c6-b8f1-6ec6-e55c-f2e552e29527@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 16, 2021, Brijesh Singh wrote:
> 
> On 7/16/21 3:45 PM, Sean Christopherson wrote:
> > On Wed, Jul 07, 2021, Brijesh Singh wrote:
> >> +	/* SEV-SNP guest requires that the GHCB GPA must be registered */
> >> +	if (sev_snp_guest(svm->vcpu.kvm) && !ghcb_gpa_is_registered(svm, ghcb_gpa)) {
> >> +		vcpu_unimpl(&svm->vcpu, "vmgexit: GHCB GPA [%#llx] is not registered.\n", ghcb_gpa);
> > I saw this a few other place.  vcpu_unimpl() is not the right API.  KVM supports
> > the guest request, the problem is that the GHCB spec _requires_ KVM to terminate
> > the guest in this case.
> 
> What is the preferred method to log it so that someone debugging know
> what went wrong.

Using the kernel log is probably a bad choice in general for this error.  Because
this and the other GHCB GPA sanity checks can be triggered from the guest, any
kernel logging needs to be ratelimited.  Ratelimiting is problematic because it
means some errors may not be logged; that's quite unlikely in this case, but it's
less than ideal.

The other issue is that KVM can't dump the RIP because guest state is encrypted,
e.g. KVM can provide the task PID, but that's it.

The best solution I can think of at the moment would be some form of
KVM_EXIT_INTERNAL_ERROR, i.e. kick out to userspace with a meaningful error code
and the bad GPA so that userspace can take action.

I believe Jim also has some thoughts on how to improve "logging" of guest errors,
but he's on vacation for a few weeks.
