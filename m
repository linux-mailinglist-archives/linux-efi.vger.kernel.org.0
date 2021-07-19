Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EB83CEE78
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 23:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354121AbhGSU6C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 16:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384800AbhGSShA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Jul 2021 14:37:00 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EE1C061788
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 12:05:03 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y4so17304325pfi.9
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 12:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tQHel7KfmZotRt+JL+tikCTH8i4jvKerKwX4Ykhe458=;
        b=XzM+UTgoPg+XkDOQ81Qyu9Aj1IHESyBIMhh/NFuqluTQUx/dfqwUh9CfJ7hyZrzFOq
         98OBWEJ8SBib/jcg/gWXAgVqsGzmGzVmU1OUdWlfXwZp6TOhQz8JOPY/LhU0HLup5t60
         MG09uBh/EZAN80GUdXbWAIzfSVF8OpL6KrxKsnW7KZT5qxtMjdXlgfFYJCVMyibNrxap
         bI8rESzefHOSN3QAHId4wLC6/nFzqtJ5ez4iL6x1w8/BsoenbhCPqleRFd2divXFsxNi
         r/lz770w0+7cZ8LA1ahJas+30qW/2CSV1uocE/OAPLcIqktisM8VvyTh0xw7f/nc4gbi
         Wsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tQHel7KfmZotRt+JL+tikCTH8i4jvKerKwX4Ykhe458=;
        b=ANOHTD1HkqiktRKTN4nkh3HpsGfiQig7jCepMblMb+Kev6BBawVgVc7PFozUSXF53s
         t25Gk/TyKNh8eRE5JtuIkuDt449Pn/i1QPiia2iuxRIwaKKsn5kmxeauz4UJf9WwIXYY
         /WCl7BjaUv5nz08WFalFev+0MZUr2hetHd//3eCrxd51pxQluloI/0oDCRRLgDNwXLFY
         N8vZulKnezDWGcNoMsBtJzH+mNNJ3JGEV8fTpJA84sib2yqs0yDR8/mTKYKcv4Xz8FE5
         Y/w3IsjNUaEUBsw+oIWgt5+80lbRxmJSBzVbHAO4nzEDQO6+9m6GW/AmxSZ/bsZCr4Fx
         BGNw==
X-Gm-Message-State: AOAM532PS3vXpya1W4E9dJlgpuL3jmYmbNL52e8fLhN+Hs+p1v57IBCs
        1QJn7ZZupe3P3XLhFEg0QbL1IA==
X-Google-Smtp-Source: ABdhPJwrFVVD96rnIFIK2jlY/ieHH+6lfcSv1ywrpxxBKG4B8nAAH7dSYEIACsmYQwT8smdf5ajGig==
X-Received: by 2002:a65:5bc6:: with SMTP id o6mr3241244pgr.43.1626722092334;
        Mon, 19 Jul 2021 12:14:52 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x10sm22140073pgj.73.2021.07.19.12.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:14:51 -0700 (PDT)
Date:   Mon, 19 Jul 2021 19:14:48 +0000
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
Message-ID: <YPXPKLW8DvqK7yak@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-27-brijesh.singh@amd.com>
 <YPHpk3RFSmE13ZXz@google.com>
 <9ee5a991-3e43-3489-5ee1-ff8c66cfabc1@amd.com>
 <YPWuVY+rKU2/DVUS@google.com>
 <379fd4da-3ca9-3205-535b-8d1891b3a75a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <379fd4da-3ca9-3205-535b-8d1891b3a75a@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 19, 2021, Brijesh Singh wrote:
> 
> 
> On 7/19/21 11:54 AM, Sean Christopherson wrote:
> > > As I said in previous comments that by default all the memory is in the
> > > hypervisor state. if the rmpupdate() failed that means nothing is changed in
> > > the RMP and there is no need to reclaim. The reclaim is required only if the
> > > pages are assigned in the RMP table.
> > 
> > I wasn't referring to RMPUPDATE failing here (or anywhere).  This is the vCPU free
> > path, which I think means the svm->vmsa page was successfully updated in the RMP
> > during LAUNCH_UPDATE.  snp_launch_update_vmsa() goes through snp_page_reclaim()
> > on LAUNCH_UPDATE failure, whereas this happy path does not.  Is there some other
> > transition during teardown that obviastes the need for reclaim?  If so, a comment
> > to explain that would be very helpful.
> > 
> 
> In this patch, the sev_free_vcpu() hunk takes care of reclaiming the vmsa
> pages before releasing it. I think it will make it more obvious after I add
> a helper so that we don't depend on user reading the comment block to see
> what its doing.

Where?  I feel like I'm missing something.  The only change to sev_free_vcpu() I
see is that addition of the rmpupdate(), I don't see any reclaim path.

@@ -2346,8 +2454,25 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)

        if (vcpu->arch.guest_state_protected)
                sev_flush_guest_memory(svm, svm->vmsa, PAGE_SIZE);
+
+       /*
+        * If its an SNP guest, then VMSA was added in the RMP entry as a guest owned page.
+        * Transition the page to hyperivosr state before releasing it back to the system.
+        */
+       if (sev_snp_guest(vcpu->kvm)) {
+               struct rmpupdate e = {};
+               int rc;
+
+               rc = rmpupdate(virt_to_page(svm->vmsa), &e);
+               if (rc) {
+                       pr_err("Failed to release SNP guest VMSA page (rc %d), leaking it\n", rc);
+                       goto skip_vmsa_free;
+               }
+       }
+
        __free_page(virt_to_page(svm->vmsa));

+skip_vmsa_free:
        if (svm->ghcb_sa_free)
                kfree(svm->ghcb_sa);
 }
