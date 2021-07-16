Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D013CBCAD
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 21:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhGPTgc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 15:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhGPTgb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jul 2021 15:36:31 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C420C061765
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 12:33:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 21so9773822pfp.3
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 12:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bTfimW7x83FCVFcfi2WAn0Cbjb2ZgRjY254vPotYxPM=;
        b=gLImRTTcl99pctFwFn9UCqCov03WvN5lkMsW6nWwr384I/+cmwj+1ZHSGlrrZdl7d5
         TLN+/m5Nfv5qKcE2GQunEOLzJB7L3PP6ZDyVbn6JNFdvHjmFxu78glmP3iIRHsw9wr+a
         H824qnog8pZlEDCRCTJ6HOP2L3o2UP8efLhLfBaXUcKxAoDb5znXSQWleWyBbWLEJj9B
         jvBCxQWNgzkeVM92UjyzQFGU1mQBnWXpAZcxh7SQ0MCcRlHittiWeZLW69P6RW1mT8FQ
         u3D6YbSXZKiUPT2FPaQRh65zBcahuVR55fkNhWuKOqwKOyjpx+kmRB+UTrj4/4D9JKvI
         s10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bTfimW7x83FCVFcfi2WAn0Cbjb2ZgRjY254vPotYxPM=;
        b=ru2etxVd4u/5eX0DHxC/TqpaIAgD1q7KkroDVGH/SBpVFilpeVX5QLcMnySzoGGpLR
         pez5cUU8dsFXyu9a7Vo38QvYnBXmBiKCw/V6u9zKT71skkgir4Ol7zcmDNk+F+ANUBmw
         VqVbazqDB0klmgI1wsCjguQAVxuD/SDyC49IrvAatctCfYJBkaLbXi7StIHr/DmeH+P1
         +ik5ycCMtw5uEzwduKgTdMftsEiv3ukCYx8M673I5zIl6Ezx5yEal/WGfNuqW6Mw+5Mr
         5uJjRxhlXyvqXmci7vuaLsjGmrzf5hpdo50TinXIHxk7eR5RFPxY+mQIgcqzrXaKyCDe
         fiMg==
X-Gm-Message-State: AOAM531I/XTLNtD1g2fp/bQrQjZuEfUS3605e1+U3/4jEPWzJzqkohfw
        i13AUWE2SG/DAT1Hf2kjUpbU8g==
X-Google-Smtp-Source: ABdhPJzOniqffULuzP8aWisOtiLK+NTXPgX8ACLtySTB0tER8yPBpCPFaT3MWTs6mE953cLz2x0NBQ==
X-Received: by 2002:a63:f901:: with SMTP id h1mr11601639pgi.69.1626464015722;
        Fri, 16 Jul 2021 12:33:35 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id c10sm10695587pfo.129.2021.07.16.12.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 12:33:35 -0700 (PDT)
Date:   Fri, 16 Jul 2021 19:33:31 +0000
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
Subject: Re: [PATCH Part2 RFC v4 22/40] KVM: SVM: Add KVM_SNP_INIT command
Message-ID: <YPHfC1mI8dQkkzyV@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-23-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-23-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 3fd9a7e9d90c..989a64aa1ae5 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1678,6 +1678,9 @@ enum sev_cmd_id {
>  	/* Guest Migration Extension */
>  	KVM_SEV_SEND_CANCEL,
>  
> +	/* SNP specific commands */
> +	KVM_SEV_SNP_INIT = 256,

Is there any meaning behind '256'?  If not, why skip a big chunk?  I wouldn't be
concerned if it weren't for KVM_SEV_NR_MAX, whose existence arguably implies that
0-KVM_SEV_NR_MAX-1 are all valid SEV commands.

> +
>  	KVM_SEV_NR_MAX,
>  };
