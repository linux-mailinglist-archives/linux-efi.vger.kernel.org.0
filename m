Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527E33CEE7D
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 23:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383757AbhGSU6j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 16:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386533AbhGSTez (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Jul 2021 15:34:55 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EECEC0613AB
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 13:08:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m83so17607995pfd.0
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r/EnTR5HRnLRPbtfmcrWf34QUCEOk8jn8W/r6abFvvg=;
        b=Ci3kpL9CZ6X85DeWmauzm5v8gjjaCLEZN36CGhMDHs3xJ1XgcgIVr1r10GUzNeok1u
         3VOID1uAgVhMS8ZqHPnAsbO8+6eyv0+7DwTiK+vFJp2bfdDHPCOiv9oHGyS35/Xsllmj
         N7HnSARfQZcqzTFqUj4+6mSFyU/XGyTHkLI4q57WF29r38IawgIRHzyHhaARFyQ2d9yW
         N2HAEM+SVmc7JmTshyFQYOGyG7ir1hhM8bFiyPCSmLeMDb4G0e9SchZ4xRZaTEn+LbNg
         sjXTjzfjIP+m8cFGo5Z4VyTOADc3bNSFapplT4SotCIq6/ogCksebNf2sUcLSswRH0DO
         aoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r/EnTR5HRnLRPbtfmcrWf34QUCEOk8jn8W/r6abFvvg=;
        b=YM5blP3m0g+fUgBMj6bdhAc3IFQA3TGgHAQnUaWSrxnSoX5JwgagPA45soe8tR0C5N
         P+fSA8FU6DjccHJswju+ZemLp4P1lwNthFxHaYd6AKKWkscc/KhJuq+8S96GpJvi6YOb
         lE+cObrCd/h2efZFT0jLxa3Qsrj4O1fXApSnfhg97J+tSwtzX8DAQEKvtdFcl1h/y5IC
         HKiYzhTIaENXUgmHubrNxVcisNXdIx7YJ3KvbCtto7ZtQ74nx/4hDSl4ooCoKrV6bTdD
         HIQJwMyaTRQmWmMRiP9exeRz0K3c2L/O9eT3D2Nyh/FakApnvHodQ+KoHcYVeAhjnK0g
         ovXg==
X-Gm-Message-State: AOAM530gDp8eeoZMpvbwMJ7SjjyPaHa1PjoF2LdE8BTbVRxxEyualBom
        eBjXEIobT8SSxoSCaO/rPbV3kg==
X-Google-Smtp-Source: ABdhPJw6c0LUvD49cuzprQ9WIbuUefstwL+8gGNos16WYz12XvCL7/lToKmBY8QygLEtkXZ0mGyYVA==
X-Received: by 2002:a63:4e4d:: with SMTP id o13mr12139870pgl.300.1626725612500;
        Mon, 19 Jul 2021 13:13:32 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q17sm24791033pgd.39.2021.07.19.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 13:13:32 -0700 (PDT)
Date:   Mon, 19 Jul 2021 20:13:28 +0000
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
Subject: Re: [PATCH Part2 RFC v4 26/40] KVM: SVM: Add
 KVM_SEV_SNP_LAUNCH_FINISH command
Message-ID: <YPXc6M4jTS68swaV@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-27-brijesh.singh@amd.com>
 <YPHpk3RFSmE13ZXz@google.com>
 <9ee5a991-3e43-3489-5ee1-ff8c66cfabc1@amd.com>
 <YPWuVY+rKU2/DVUS@google.com>
 <379fd4da-3ca9-3205-535b-8d1891b3a75a@amd.com>
 <YPXPKLW8DvqK7yak@google.com>
 <f056d0ea-42ff-bc35-8154-a528105309a4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f056d0ea-42ff-bc35-8154-a528105309a4@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 19, 2021, Brijesh Singh wrote:
> 
> On 7/19/21 2:14 PM, Sean Christopherson wrote:
> > 
> > Where?  I feel like I'm missing something.  The only change to sev_free_vcpu() I
> > see is that addition of the rmpupdate(), I don't see any reclaim path.
> 
> Clearing of the immutable bit (aka reclaim) is done by the firmware after
> the command was successful.

Ah, which is why the failure path has to do manual reclaim of the immutable page.
Thanks!
