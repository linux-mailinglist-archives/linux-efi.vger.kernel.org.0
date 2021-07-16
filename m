Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8563CBCDE
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 21:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhGPTqS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 15:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhGPTqR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jul 2021 15:46:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429A6C061760
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 12:43:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c1so5960086pfc.13
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=83K5jMwRtU/8epKCi74MjZFtuEQ6yN7WQlDQ6zpTzOI=;
        b=lkbUEbSiAYqlKY11gnL039G8UTLE9ReSNGRswHTVCITBK249PJmM4zFH1PCO3bnAHq
         Gqpiug0qyGCG3JcFQ+pQ8DmFeGSoHMZ/InG+dRThu092lmCPhQnnjRO9PZPx6EtwJ1ak
         dDWsyzpHhKQTXIr5QN83tehLx5uPNETwEp8uFoGZxR3mpfBl8XieP9MbqVlKM3J+qeSI
         cQo2lUFtDrcBMVp1BBOcNblM5S+qeYM4ztZRNk5sSHwUGb5sRyLcBUdHDIpIBeNbhtcH
         c1++Zt9Nlev9yuAtbczha/ycvWPCxtGirSrfHxiMKhM/WXBYRH41G2aQxSpn75Rkx0bY
         jF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=83K5jMwRtU/8epKCi74MjZFtuEQ6yN7WQlDQ6zpTzOI=;
        b=tfBu+7GfBgklp7JkEvNZe6AUh2B52DURCADxwX3FaP6kSKNXcSgn00fG2A7F0tjTj3
         5dxr06cyVLhG4V8SuYzCrylYZZzllF08FgSfXd1wRXqAAoRTnQ/X7kYw+D2YW1rWQrdu
         4uQFpwZuQysOl7ImgOesLGNlZ2DwqnhsTTnhYLFH5M/T5t6UB0DGjPmaQYnJxRnW3l3J
         iTOIxpVE3CnenCRki0Tt6lQq0cLuGde+P4xHvlomB+VSKgkpzcYO+lbb1hTisyu5ueB9
         oWkXnVn5KflgVL9fvUEyDhALgWAZEGcxd9rN+1rrkBLpsYoGNMvBHhvQbVMfc8cs5C5w
         2jLg==
X-Gm-Message-State: AOAM530sr1ikgcHri2it5frhEU53OT9BX1fN9iAP9H/L4NEG3xy0/84m
        gcDbvzuPl+V0fi3/lMMWALuIlxz92uzn2g==
X-Google-Smtp-Source: ABdhPJw0RBlNvFNH44H1Ia7q4e99fb0NxAJaKlLkfahBZopN5tA1mS0rdxru5IIVVSKY/41JGCdbeQ==
X-Received: by 2002:a05:6a00:10cd:b029:30a:ea3a:4acf with SMTP id d13-20020a056a0010cdb029030aea3a4acfmr12500876pfu.51.1626464601496;
        Fri, 16 Jul 2021 12:43:21 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g9sm12163800pgh.40.2021.07.16.12.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 12:43:21 -0700 (PDT)
Date:   Fri, 16 Jul 2021 19:43:17 +0000
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
Subject: Re: [PATCH Part2 RFC v4 23/40] KVM: SVM: Add
 KVM_SEV_SNP_LAUNCH_START command
Message-ID: <YPHhVZLyb795z/88@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-24-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-24-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> @@ -1527,6 +1530,100 @@ static int sev_receive_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  	return sev_issue_cmd(kvm, SEV_CMD_RECEIVE_FINISH, &data, &argp->error);
>  }
>  
> +static void *snp_context_create(struct kvm *kvm, struct kvm_sev_cmd *argp)
> +{
> +	struct sev_data_snp_gctx_create data = {};
> +	void *context;
> +	int rc;
> +
> +	/* Allocate memory for context page */

Eh, I'd drop this comment.  It's quite obvious that a page is being allocated
and that it's being assigned to the context.

> +	context = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT);
> +	if (!context)
> +		return NULL;
> +
> +	data.gctx_paddr = __psp_pa(context);
> +	rc = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_GCTX_CREATE, &data, &argp->error);
> +	if (rc) {
> +		snp_free_firmware_page(context);
> +		return NULL;
> +	}
> +
> +	return context;
> +}
> +
> +static int snp_bind_asid(struct kvm *kvm, int *error)
> +{
> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +	struct sev_data_snp_activate data = {};
> +	int asid = sev_get_asid(kvm);
> +	int ret, retry_count = 0;
> +
> +	/* Activate ASID on the given context */
> +	data.gctx_paddr = __psp_pa(sev->snp_context);
> +	data.asid   = asid;
> +again:
> +	ret = sev_issue_cmd(kvm, SEV_CMD_SNP_ACTIVATE, &data, error);
> +
> +	/* Check if the DF_FLUSH is required, and try again */

Please provide more info on why this may be necessary.  I can see from the code
that it does a flush and retries, but I have no idea why a flush would be required
in the first place, e.g. why can't KVM guarantee that everything is in the proper
state before attempting to bind an ASID?

> +	if (ret && (*error == SEV_RET_DFFLUSH_REQUIRED) && (!retry_count)) {
> +		/* Guard DEACTIVATE against WBINVD/DF_FLUSH used in ASID recycling */
> +		down_read(&sev_deactivate_lock);
> +		wbinvd_on_all_cpus();
> +		ret = snp_guest_df_flush(error);
> +		up_read(&sev_deactivate_lock);
> +
> +		if (ret)
> +			return ret;
> +
> +		/* only one retry */

Again, please explain why.  Is this arbitrary?  Is retrying more than once
guaranteed to be useless?

> +		retry_count = 1;
> +
> +		goto again;
> +	}
> +
> +	return ret;
> +}

...

>  void sev_vm_destroy(struct kvm *kvm)
>  {
>  	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> @@ -1847,7 +1969,15 @@ void sev_vm_destroy(struct kvm *kvm)
>  
>  	mutex_unlock(&kvm->lock);
>  
> -	sev_unbind_asid(kvm, sev->handle);
> +	if (sev_snp_guest(kvm)) {
> +		if (snp_decommission_context(kvm)) {
> +			pr_err("Failed to free SNP guest context, leaking asid!\n");

I agree with Peter that this likely warrants a WARN.  If a WARN isn't justified,
e.g. this can happen without a KVM/CPU bug, then there absolutely needs to be a
massive comment explaining why we have code that result in memory leaks.

> +			return;
> +		}
> +	} else {
> +		sev_unbind_asid(kvm, sev->handle);
> +	}
> +
>  	sev_asid_free(sev);
>  }
>  
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index b9ea99f8579e..bc5582b44356 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -67,6 +67,7 @@ struct kvm_sev_info {
>  	u64 ap_jump_table;	/* SEV-ES AP Jump Table address */
>  	struct kvm *enc_context_owner; /* Owner of copied encryption context */
>  	struct misc_cg *misc_cg; /* For misc cgroup accounting */
> +	void *snp_context;      /* SNP guest context page */
>  };
>  
>  struct kvm_svm {
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 989a64aa1ae5..dbd05179d8fa 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1680,6 +1680,7 @@ enum sev_cmd_id {
>  
>  	/* SNP specific commands */
>  	KVM_SEV_SNP_INIT = 256,
> +	KVM_SEV_SNP_LAUNCH_START,
>  
>  	KVM_SEV_NR_MAX,
>  };
> @@ -1781,6 +1782,14 @@ struct kvm_snp_init {
>  	__u64 flags;
>  };
>  
> +struct kvm_sev_snp_launch_start {
> +	__u64 policy;
> +	__u64 ma_uaddr;
> +	__u8 ma_en;
> +	__u8 imi_en;
> +	__u8 gosvw[16];

Hmm, I'd prefer to pad this out to be 8-byte sized.

> +};
> +
>  #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
>  #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
>  #define KVM_DEV_ASSIGN_MASK_INTX	(1 << 2)
> -- 
> 2.17.1
> 
