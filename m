Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383F63CEE7F
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 23:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387723AbhGSU6p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 16:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387039AbhGSTp0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Jul 2021 15:45:26 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE14FC061786
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 13:20:50 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id y4so20310294pgl.10
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 13:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/ueH7e1R+Y/9Tjm+iXp9T6qooVmg3C+ED64P3I591HI=;
        b=rpRYvrfz6uIHeUpHKmujhCdwk9rbm/oL9LmMIjkgkvoLoy4OntrYE11Df5glviaYn+
         6C0Q64khcfMxVcXVTZZJn0FhXZsMIWu7qge2Ikf+ANhdDMCuolK0QajXqXOPTNNHQZdC
         y/xBvL7a5FL6SqIsOmmCdR8XBrRAJI17s57sbB5vZLH7VyKT5Kd02Df0zVHtq3PHedc2
         AYGbSnbqVtsE8UGU6HqfkIJfnpR8FHr2WEGoUKQqEJb0tyMcLPVkbr0kfMMru3LYCdSj
         TFMutp7A6eXjOdVSWKArL+d8R0xMsMIgFPkOWgSOt7A4IDqP9TdzUq3FT9hlrYbGTz3z
         kCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/ueH7e1R+Y/9Tjm+iXp9T6qooVmg3C+ED64P3I591HI=;
        b=N8W6NV3CfoFYqAKygOmoO7R5BMtYTg14TvZw9JPe22/nqjdYoFrisR/Z2NK3mA0N72
         l2Wbd30nR1wjuE5U7q/B/326IQI7dA+cy1U1PboRCmTBEJVKeohm/RYHYiZbSNFooONy
         hj6vPLubejM9SAzzNl2w9cogt0gnksqhltWYXNDgbBz1jMGyYkO7ZIjooDcy26QrmusK
         /+ysppz6ZJCYUMDGgJDdSg0YNXLbatmCdHwhY57IC4WmJWMf02lvN//kjTSBqru4JwQ+
         FdKd7TV9ftMAHuNLdp17oDveSnsEwxf/JVkOb0vrxKIsmYtpNckNQlEjbNXcMO5GHv1B
         ZeEA==
X-Gm-Message-State: AOAM530P4aJxJKmWe0BFJverdTPwplbenTzvU3lqHo6mnC/UqqpZkZgT
        EvJMgQbt3dBsP92HBk3+wQiMtA==
X-Google-Smtp-Source: ABdhPJx5z2KfcuWt/DfKkC4lsDSx4E1hp1htq+WW2Tom9he1jw05rOfD+bqBAYmCI98dUfs6qLi1hw==
X-Received: by 2002:a62:1a47:0:b029:328:cbf8:6d42 with SMTP id a68-20020a621a470000b0290328cbf86d42mr27228516pfa.37.1626726290119;
        Mon, 19 Jul 2021 13:24:50 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n6sm23363563pgb.60.2021.07.19.13.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 13:24:49 -0700 (PDT)
Date:   Mon, 19 Jul 2021 20:24:45 +0000
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
Message-ID: <YPXfjYsEepISApuf@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-23-brijesh.singh@amd.com>
 <YPHfC1mI8dQkkzyV@google.com>
 <3f12243a-dee3-2a97-9a1b-51f4f6095349@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f12243a-dee3-2a97-9a1b-51f4f6095349@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 16, 2021, Brijesh Singh wrote:
> 
> On 7/16/21 2:33 PM, Sean Christopherson wrote:
> > On Wed, Jul 07, 2021, Brijesh Singh wrote:
> >> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >> index 3fd9a7e9d90c..989a64aa1ae5 100644
> >> --- a/include/uapi/linux/kvm.h
> >> +++ b/include/uapi/linux/kvm.h
> >> @@ -1678,6 +1678,9 @@ enum sev_cmd_id {
> >>  	/* Guest Migration Extension */
> >>  	KVM_SEV_SEND_CANCEL,
> >>  
> >> +	/* SNP specific commands */
> >> +	KVM_SEV_SNP_INIT = 256,
> > Is there any meaning behind '256'?  If not, why skip a big chunk?  I wouldn't be
> > concerned if it weren't for KVM_SEV_NR_MAX, whose existence arguably implies that
> > 0-KVM_SEV_NR_MAX-1 are all valid SEV commands.
> 
> In previous patches, Peter highlighted that we should keep some gap
> between the SEV/ES and SNP to leave room for legacy SEV/ES expansion. I
> was not sure how many we need to reserve without knowing what will come
> in the future; especially recently some of the command additional  are
> not linked to the firmware. I am okay to reduce the gap or remove the
> gap all together.

Unless the numbers themselves have meaning, which I don't think they do, I vote
to keep the arbitrary numbers contiguous.  KVM_SEV_NR_MAX makes me nervous, and
there are already cases of related commands being discontiguous, e.g. KVM_SEND_CANCEL.

Peter or Paolo, any thoughts?
