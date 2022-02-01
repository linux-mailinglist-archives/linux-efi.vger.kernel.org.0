Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D034A658A
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 21:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbiBAURQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 15:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239467AbiBAURQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 15:17:16 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF694C06173B
        for <linux-efi@vger.kernel.org>; Tue,  1 Feb 2022 12:17:15 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id q22so25760170ljh.7
        for <linux-efi@vger.kernel.org>; Tue, 01 Feb 2022 12:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1G+U9mCR+9y3z9D1TzfeiUfdMNDGnmglMpEe2+/2LE=;
        b=VpWU+oS1r5knoJXzOyILe4moOYE+R2uHT5zRZ2Jk6DhbUyjF27qJ3+INmDQ6fgW21h
         Tbks8twIhWx83GEmJz8SvyDl28seEQXqJqh3NV9g5rTHkqsOws4rhC3I/N/p7qcc254t
         dO5dfpzfe+UZ1qwnCXB5UZJSurEkkiBYs4s3D9Zas6b0x9z+x5I85DrD9l2VaSp+bKq7
         SMWCvA1VLe6N2jnWSR72sRQz1JDnI/ile1y5D0ika7OBCB6qjHvaKnf83FjnjAl6pUlX
         yedLGvX4pfjFeVB5yjbxiMrAQ/0ETQPPiMCTCVHV0Dt1fljCfrW3KHBEl8XoGKzF8eOV
         yQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1G+U9mCR+9y3z9D1TzfeiUfdMNDGnmglMpEe2+/2LE=;
        b=yhLpwnklHjanmTL3CKZAkSD0iVIWoebVaiWXZ+g8PfZuIlQ6nAg6ppuEQNckkKACQZ
         ccHBVHxQUy+k2CKtrPiz3NBW72ARjNjK8XoOeiwGbSQlrKgzMJoUWzxjNzE7D5AX3Ku3
         wiZi4yyxoDbpAiCixkCc5XjvWdHgKtrM7V8Y+huIOmIVLm+un218cxw6w+KFy0RG9NHF
         Cjhnx6md6LSmUQ8wab3PhMLBeo0YHFOOQmdRwbiweOi/82/KgVAhOB1CXZxZxKxf3Iy1
         bgw4Ci/bNEHfSDMFOHoSR18FxEhQwbjC71WfSxsDwV+BMsQaruAY1aFHDPXr+rw0RiXw
         S9YA==
X-Gm-Message-State: AOAM533pF+tTiVn9zVpOTeOlrqFRg+mmYqscKXtEOnd4fMIL/wZcKcIx
        2mFIuPEz6Z5xJXbIFW9FOzpL2pJDHwzYjnTd05sZ1Q==
X-Google-Smtp-Source: ABdhPJw/gG064uPw6B2Edvi7SJHms7j1vwY6jMCGatl6ahEztehk1/Zegz8WhJ1BfcdyuJ3eUs0emystXh2QL2v0bB8=
X-Received: by 2002:a2e:a781:: with SMTP id c1mr16364597ljf.527.1643746633936;
 Tue, 01 Feb 2022 12:17:13 -0800 (PST)
MIME-Version: 1.0
References: <20220128171804.569796-1-brijesh.singh@amd.com> <20220128171804.569796-40-brijesh.singh@amd.com>
In-Reply-To: <20220128171804.569796-40-brijesh.singh@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 1 Feb 2022 13:17:02 -0700
Message-ID: <CAMkAt6oycVLNwMbe=QD_x_jGVFmkNK+OSKqd9GhcMjD3Qo3ZJg@mail.gmail.com>
Subject: Re: [PATCH v9 39/43] x86/sev: Provide support for SNP guest request NAEs
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, Tony Luck <tony.luck@intel.com>,
        Marc Orr <marcorr@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 10:19 AM Brijesh Singh <brijesh.singh@amd.com> wrote:
>
> Version 2 of GHCB specification provides SNP_GUEST_REQUEST and
> SNP_EXT_GUEST_REQUEST NAE that can be used by the SNP guest to communicate
> with the PSP.
>
> While at it, add a snp_issue_guest_request() helper that will be used by
> driver or other subsystem to issue the request to PSP.
>
> See SEV-SNP firmware and GHCB spec for more details.
>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/sev-common.h |  3 ++
>  arch/x86/include/asm/sev.h        | 14 ++++++++
>  arch/x86/include/uapi/asm/svm.h   |  4 +++
>  arch/x86/kernel/sev.c             | 55 +++++++++++++++++++++++++++++++
>  4 files changed, 76 insertions(+)
>
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index cd769984e929..442614879dad 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -128,6 +128,9 @@ struct snp_psc_desc {
>         struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
>  } __packed;
>
> +/* Guest message request error code */
> +#define SNP_GUEST_REQ_INVALID_LEN      BIT_ULL(32)
> +
>  #define GHCB_MSR_TERM_REQ              0x100
>  #define GHCB_MSR_TERM_REASON_SET_POS   12
>  #define GHCB_MSR_TERM_REASON_SET_MASK  0xf
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 219abb4590f2..9830ee1d6ef0 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -87,6 +87,14 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
>
>  #define RMPADJUST_VMSA_PAGE_BIT                BIT(16)
>
> +/* SNP Guest message request */
> +struct snp_req_data {
> +       unsigned long req_gpa;
> +       unsigned long resp_gpa;
> +       unsigned long data_gpa;
> +       unsigned int data_npages;
> +};
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  extern struct static_key_false sev_es_enable_key;
>  extern void __sev_es_ist_enter(struct pt_regs *regs);
> @@ -154,6 +162,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
>  void snp_set_wakeup_secondary_cpu(void);
>  bool snp_init(struct boot_params *bp);
>  void snp_abort(void);
> +int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
>  #else
>  static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>  static inline void sev_es_ist_exit(void) { }
> @@ -173,6 +182,11 @@ static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npag
>  static inline void snp_set_wakeup_secondary_cpu(void) { }
>  static inline bool snp_init(struct boot_params *bp) { return false; }
>  static inline void snp_abort(void) { }
> +static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
> +                                         unsigned long *fw_err)
> +{
> +       return -ENOTTY;
> +}
>  #endif
>
>  #endif
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
> index 8b4c57baec52..5b8bc2b65a5e 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -109,6 +109,8 @@
>  #define SVM_VMGEXIT_SET_AP_JUMP_TABLE          0
>  #define SVM_VMGEXIT_GET_AP_JUMP_TABLE          1
>  #define SVM_VMGEXIT_PSC                                0x80000010
> +#define SVM_VMGEXIT_GUEST_REQUEST              0x80000011
> +#define SVM_VMGEXIT_EXT_GUEST_REQUEST          0x80000012
>  #define SVM_VMGEXIT_AP_CREATION                        0x80000013
>  #define SVM_VMGEXIT_AP_CREATE_ON_INIT          0
>  #define SVM_VMGEXIT_AP_CREATE                  1
> @@ -225,6 +227,8 @@
>         { SVM_VMGEXIT_AP_HLT_LOOP,      "vmgexit_ap_hlt_loop" }, \
>         { SVM_VMGEXIT_AP_JUMP_TABLE,    "vmgexit_ap_jump_table" }, \
>         { SVM_VMGEXIT_PSC,      "vmgexit_page_state_change" }, \
> +       { SVM_VMGEXIT_GUEST_REQUEST,            "vmgexit_guest_request" }, \
> +       { SVM_VMGEXIT_EXT_GUEST_REQUEST,        "vmgexit_ext_guest_request" }, \
>         { SVM_VMGEXIT_AP_CREATION,      "vmgexit_ap_creation" }, \
>         { SVM_VMGEXIT_HV_FEATURES,      "vmgexit_hypervisor_feature" }, \
>         { SVM_EXIT_ERR,         "invalid_guest_state" }
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index cb97200bfda7..1d3ac83226fc 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -2122,3 +2122,58 @@ static int __init snp_check_cpuid_table(void)
>  }
>
>  arch_initcall(snp_check_cpuid_table);
> +
> +int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err)
> +{
> +       struct ghcb_state state;
> +       struct es_em_ctxt ctxt;
> +       unsigned long flags;
> +       struct ghcb *ghcb;
> +       int ret;
> +
> +       if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +               return -ENODEV;
> +
> +       /*
> +        * __sev_get_ghcb() needs to run with IRQs disabled because it is using
> +        * a per-CPU GHCB.
> +        */
> +       local_irq_save(flags);
> +
> +       ghcb = __sev_get_ghcb(&state);
> +       if (!ghcb) {
> +               ret = -EIO;
> +               goto e_restore_irq;
> +       }
> +
> +       vc_ghcb_invalidate(ghcb);
> +
> +       if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
> +               ghcb_set_rax(ghcb, input->data_gpa);
> +               ghcb_set_rbx(ghcb, input->data_npages);
> +       }
> +
> +       ret = sev_es_ghcb_hv_call(ghcb, true, &ctxt, exit_code, input->req_gpa, input->resp_gpa);
> +       if (ret)
> +               goto e_put;
> +
> +       if (ghcb->save.sw_exit_info_2) {
> +               /* Number of expected pages are returned in RBX */
> +               if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
> +                   ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
> +                       input->data_npages = ghcb_get_rbx(ghcb);
> +
> +               if (fw_err)
> +                       *fw_err = ghcb->save.sw_exit_info_2;

In the PSP driver we've had a bit of discussion around the fw_err and
the return code and that it would be preferable to have fw_err be a
required parameter. And then we can easily make sure fw_err is always
non-zero when the return code is non-zero. Thoughts about doing the
same inside the guest?


> +
> +               ret = -EIO;
> +       }
> +
> +e_put:
> +       __sev_put_ghcb(&state);
> +e_restore_irq:
> +       local_irq_restore(flags);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(snp_issue_guest_request);
> --
> 2.25.1
>
