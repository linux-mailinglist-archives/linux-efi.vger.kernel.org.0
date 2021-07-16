Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7513CBDC0
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 22:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhGPU3A (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 16:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbhGPU27 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jul 2021 16:28:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92925C061765
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 13:26:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gp5-20020a17090adf05b0290175c085e7a5so2412905pjb.0
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8tvSxeWjAmiPV1ecaOaeAqaw4ZJnCIRGxkWGCmBjbA8=;
        b=jIlbt7ooesOkOpbmts5nBhgs9jIU/SiAau352QIY0Hgeubf1kEbT+OcR/XjVd4kT+v
         3fD8lV4szvIhxFXyM+uYYrQGWrg5wBxeuQ2S0VFf48AH+i4/ScDMvZ/wpqxl8XaLtWB1
         5sBw774M3CLXtT+Vj+GS9UQahjyyarePM6P/ZXZBxsr54dQm0m5kpkcDppT69Py56TWs
         57gCQFY57LOuhVvwhFAZTfqiyYlRvDo2aFfrRtqAV3Gj+D7CgmOqL2nfkKqI7gWSNwWP
         Evl25i5YTmPuqDf/s9LZtr9s03mx1pQcAG1vJ40a1kDU8OqGPXFnRlemxj0KkvtmTLYB
         bqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8tvSxeWjAmiPV1ecaOaeAqaw4ZJnCIRGxkWGCmBjbA8=;
        b=e3/vjdpLqeTNi4yRMyTkMUlYt3qA1f+qJU3gIK/23M4+BlFoCmCHmivuLqcee6ccb1
         De12VB+r1jKmit89BaazZqhErusnny5MF/s3AqxUwOwC9giDt8hJLurlFH8xtQeZjgcU
         ghmo2JY9ejmPayvRSKueAnm2wmVXjMgzRzvIilIQIvJsiaR1vvYT4afINl9CSPtYU0fi
         slv+RS4wGv2zQbn1i7OZ7z7bmW1yAKaduHfKeFVho22ChHyG/ntQOC/7+BByluhhYkIL
         sZH3MmWWKGZiMH+FgbvV0Iv/qHINBM84mEwsv5ntTNKsQijvM5pkr7cR6jzpcJRRnUYO
         f2jg==
X-Gm-Message-State: AOAM531yuR+huua1Ggqr15NwrNmFAULPHj27bATQaVTROYBwUL2qNDrh
        /7sDduUgjEfP911TyVc/Ho/Jtg==
X-Google-Smtp-Source: ABdhPJyV16kybEQiRhFSioiQewGBf027oKkuUbSPAPg4nYD34PcD9PtL9JdNgcXLrSoQ1Ly4eisLjQ==
X-Received: by 2002:a17:90a:4893:: with SMTP id b19mr11380703pjh.45.1626467162727;
        Fri, 16 Jul 2021 13:26:02 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b15sm11895147pgm.15.2021.07.16.13.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:26:02 -0700 (PDT)
Date:   Fri, 16 Jul 2021 20:25:58 +0000
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
Subject: Re: [PATCH Part2 RFC v4 31/40] KVM: X86: update page-fault trace to
 log the 64-bit error code
Message-ID: <YPHrVkFJwRsMm9V2@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-32-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-32-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> The page-fault error code is a 64-bit value, but the trace prints only

It's worth clarifying that #NPT has a 64-bit error code, and so KVM also passes
around a 64-bit PFEC.  E.g. the above statement is wrong for legacy #PF.

> the lower 32-bits. Some of the SEV-SNP RMP fault error codes are
> available in the upper 32-bits.

Can you send this separately with Cc: stable@?  And I guess tweak the changelog
to replace "SEV-SNP RMP" with a reference to e.g. PFERR_GUEST_FINAL_MASK.  KVM
already has error codes that can set the upper bits.
