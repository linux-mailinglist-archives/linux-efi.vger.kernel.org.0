Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C844D4C6F
	for <lists+linux-efi@lfdr.de>; Thu, 10 Mar 2022 16:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244929AbiCJOzt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Mar 2022 09:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344073AbiCJOwn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Mar 2022 09:52:43 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777A1158783
        for <linux-efi@vger.kernel.org>; Thu, 10 Mar 2022 06:51:32 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id o6so8080679ljp.3
        for <linux-efi@vger.kernel.org>; Thu, 10 Mar 2022 06:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nX8DHqzGGIh8VXWXli7Q9VWCrZ0diUnq6RW+HJu2z+w=;
        b=k8bpp3Qz6w1Ori2GaIS3vAJnymoKizHkjSM2pbKS5HLEWs61RqC8rcJaJz6q5CWxtC
         GXG5sUn2Thmz5tBFiT3j2HthVKklGd2B/mlhN3G4qkWP4XLVSZftQiGImoG6pJWAa48l
         nrknDuPIJ9/0vZvmbgfOCHA5P98NprkdmhnP2nGksyh84eA+kFxeu5ml9tQXFl5jFih3
         pzjTTOj34nWAAyBl8nyb4DwSCSdVvCgNsvWR9hncOFUF0h6o3rcUchervhGG9m0yYbhs
         t5nd2IWuuuyTEprSuF2ReL2VAm6m3335jTuiz5fs6QqaKjuS9bm87uNH3rQFq6/yLA9b
         S9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nX8DHqzGGIh8VXWXli7Q9VWCrZ0diUnq6RW+HJu2z+w=;
        b=yifO8MdKJL4UI4aXMUtnOSEXLA9+lZxhjkWnZ4+MGnq5c14C98wd5GDLgEKU24Vv+R
         ktwvz6yFtkQ+oPxfCtqIvO5FYFj5NVqFWHGkuZCa6g7Sx1Flk/hMi30VNSLRE/DueX3N
         gtRMPUYcRD4Yxdxq140Iwa9aI8VsB/+uHeQglHHC4ldHPRBJ+t+1aMtWlu3p9LIS0TNu
         HSUtBYLBSvQOwi5QQJU/aiq+++l0RMqLvRqOi62hNmPnSXaXV//qNkCKV/C/mKsG72HK
         pmeN9l5kjg23e3crcc4Nv7phihtBkNcNqqJnSdw/xGyO5+UeQQ9v8xfx4m+/jw4t3VAu
         Urbw==
X-Gm-Message-State: AOAM531ZrzEQ8Yj9SXzLyUZyKsHmD3G5jGribyAAxw43LjVzmZImZt9b
        eIqF1xJbYSnAizPMnGCtvEdIzt2Ch6gQO0rWpgN9gw==
X-Google-Smtp-Source: ABdhPJzuHjyFVpmAlqMYopymRxphckm6YKWg8DSSI/RCaYrUp1EcYkyVPnDt0L4CVC1s5g5fjoqDBYSo7ut3HvLFmqM=
X-Received: by 2002:a05:651c:b07:b0:247:e06d:8943 with SMTP id
 b7-20020a05651c0b0700b00247e06d8943mr3100152ljr.426.1646923890370; Thu, 10
 Mar 2022 06:51:30 -0800 (PST)
MIME-Version: 1.0
References: <20220307213356.2797205-1-brijesh.singh@amd.com> <20220307213356.2797205-33-brijesh.singh@amd.com>
In-Reply-To: <20220307213356.2797205-33-brijesh.singh@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 10 Mar 2022 07:51:17 -0700
Message-ID: <CAMkAt6pO0xZb2pye-VEKdFQ_dYFgLA21fkYmnYPTWo8mzPrKDQ@mail.gmail.com>
Subject: Re: [PATCH v12 32/46] x86/compressed/64: Add support for SEV-SNP
 CPUID table in #VC handlers
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, Tony Luck <tony.luck@intel.com>,
        Marc Orr <marcorr@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

()

On Mon, Mar 7, 2022 at 2:35 PM Brijesh Singh <brijesh.singh@amd.com> wrote:
>
> From: Michael Roth <michael.roth@amd.com>
>
> CPUID instructions generate a #VC exception for SEV-ES/SEV-SNP guests,
> for which early handlers are currently set up to handle. In the case
> of SEV-SNP, guests can use a configurable location in guest memory
> that has been pre-populated with a firmware-validated CPUID table to
> look up the relevant CPUID values rather than requesting them from
> hypervisor via a VMGEXIT. Add the various hooks in the #VC handlers to
> allow CPUID instructions to be handled via the table. The code to
> actually configure/enable the table will be added in a subsequent
> commit.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/sev-common.h |   2 +
>  arch/x86/kernel/sev-shared.c      | 324 ++++++++++++++++++++++++++++++
>  2 files changed, 326 insertions(+)
>
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index e9b6815b3b3d..0759af9b1acf 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -152,6 +152,8 @@ struct snp_psc_desc {
>  #define GHCB_TERM_PSC                  1       /* Page State Change failure */
>  #define GHCB_TERM_PVALIDATE            2       /* Pvalidate failure */
>  #define GHCB_TERM_NOT_VMPL0            3       /* SNP guest is not running at VMPL-0 */
> +#define GHCB_TERM_CPUID                        4       /* CPUID-validation failure */
> +#define GHCB_TERM_CPUID_HV             5       /* CPUID failure during hypervisor fallback */
>
>  #define GHCB_RESP_CODE(v)              ((v) & GHCB_MSR_INFO_MASK)
>
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index b4d5558c9d0a..0f1375164ff0 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -24,6 +24,36 @@ struct cpuid_leaf {
>         u32 edx;
>  };
>
> +/*
> + * Individual entries of the SNP CPUID table, as defined by the SNP
> + * Firmware ABI, Revision 0.9, Section 7.1, Table 14.
> + */
> +struct snp_cpuid_fn {
> +       u32 eax_in;
> +       u32 ecx_in;
> +       u64 xcr0_in;
> +       u64 xss_in;
> +       u32 eax;
> +       u32 ebx;
> +       u32 ecx;
> +       u32 edx;
> +       u64 __reserved;
> +} __packed;
> +
> +/*
> + * SNP CPUID table, as defined by the SNP Firmware ABI, Revision 0.9,
> + * Section 8.14.2.6. Also noted there is the SNP firmware-enforced limit
> + * of 64 entries per CPUID table.
> + */
> +#define SNP_CPUID_COUNT_MAX 64
> +
> +struct snp_cpuid_table {
> +       u32 count;
> +       u32 __reserved1;
> +       u64 __reserved2;
> +       struct snp_cpuid_fn fn[SNP_CPUID_COUNT_MAX];
> +} __packed;
> +
>  /*
>   * Since feature negotiation related variables are set early in the boot
>   * process they must reside in the .data section so as not to be zeroed
> @@ -33,6 +63,19 @@ struct cpuid_leaf {
>   */
>  static u16 ghcb_version __ro_after_init;
>
> +/* Copy of the SNP firmware's CPUID page. */
> +static struct snp_cpuid_table cpuid_table_copy __ro_after_init;
> +
> +/*
> + * These will be initialized based on CPUID table so that non-present
> + * all-zero leaves (for sparse tables) can be differentiated from
> + * invalid/out-of-range leaves. This is needed since all-zero leaves
> + * still need to be post-processed.
> + */
> +static u32 cpuid_std_range_max __ro_after_init;
> +static u32 cpuid_hyp_range_max __ro_after_init;
> +static u32 cpuid_ext_range_max __ro_after_init;
> +
>  static bool __init sev_es_check_cpu_features(void)
>  {
>         if (!has_cpuflag(X86_FEATURE_RDRAND)) {
> @@ -242,6 +285,252 @@ static int sev_cpuid_hv(struct cpuid_leaf *leaf)
>         return ret;
>  }
>
> +/*
> + * This may be called early while still running on the initial identity
> + * mapping. Use RIP-relative addressing to obtain the correct address
> + * while running with the initial identity mapping as well as the
> + * switch-over to kernel virtual addresses later.
> + */
> +static const struct snp_cpuid_table *snp_cpuid_get_table(void)
> +{
> +       void *ptr;
> +
> +       asm ("lea cpuid_table_copy(%%rip), %0"
> +            : "=r" (ptr)
> +            : "p" (&cpuid_table_copy));
> +
> +       return ptr;
> +}
> +
> +/*
> + * The SNP Firmware ABI, Revision 0.9, Section 7.1, details the use of
> + * XCR0_IN and XSS_IN to encode multiple versions of 0xD subfunctions 0
> + * and 1 based on the corresponding features enabled by a particular
> + * combination of XCR0 and XSS registers so that a guest can look up the
> + * version corresponding to the features currently enabled in its XCR0/XSS
> + * registers. The only values that differ between these versions/table
> + * entries is the enabled XSAVE area size advertised via EBX.
> + *
> + * While hypervisors may choose to make use of this support, it is more
> + * robust/secure for a guest to simply find the entry corresponding to the
> + * base/legacy XSAVE area size (XCR0=1 or XCR0=3), and then calculate the
> + * XSAVE area size using subfunctions 2 through 64, as documented in APM
> + * Volume 3, Rev 3.31, Appendix E.3.8, which is what is done here.
> + *
> + * Since base/legacy XSAVE area size is documented as 0x240, use that value
> + * directly rather than relying on the base size in the CPUID table.
> + *
> + * Return: XSAVE area size on success, 0 otherwise.
> + */
> +static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
> +{
> +       const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
> +       u64 xfeatures_found = 0;
> +       u32 xsave_size = 0x240;
> +       int i;
> +
> +       for (i = 0; i < cpuid_table->count; i++) {
> +               const struct snp_cpuid_fn *e = &cpuid_table->fn[i];
> +
> +               if (!(e->eax_in == 0xD && e->ecx_in > 1 && e->ecx_in < 64))
> +                       continue;
> +               if (!(xfeatures_en & (BIT_ULL(e->ecx_in))))
> +                       continue;
> +               if (xfeatures_found & (BIT_ULL(e->ecx_in)))
> +                       continue;
> +
> +               xfeatures_found |= (BIT_ULL(e->ecx_in));
> +
> +               if (compacted)
> +                       xsave_size += e->eax;
> +               else
> +                       xsave_size = max(xsave_size, e->eax + e->ebx);
> +       }
> +
> +       /*
> +        * Either the guest set unsupported XCR0/XSS bits, or the corresponding
> +        * entries in the CPUID table were not present. This is not a valid
> +        * state to be in.
> +        */
> +       if (xfeatures_found != (xfeatures_en & GENMASK_ULL(63, 2)))
> +               return 0;
> +
> +       return xsave_size;
> +}
> +
> +static bool
> +snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
> +{
> +       const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
> +       int i;
> +
> +       for (i = 0; i < cpuid_table->count; i++) {
> +               const struct snp_cpuid_fn *e = &cpuid_table->fn[i];
> +
> +               if (e->eax_in != leaf->fn)
> +                       continue;
> +
> +               if (cpuid_function_is_indexed(leaf->fn) && e->ecx_in != leaf->subfn)
> +                       continue;
> +
> +               /*
> +                * For 0xD subfunctions 0 and 1, only use the entry corresponding
> +                * to the base/legacy XSAVE area size (XCR0=1 or XCR0=3, XSS=0).
> +                * See the comments above snp_cpuid_calc_xsave_size() for more
> +                * details.
> +                */
> +               if (e->eax_in == 0xD && (e->ecx_in == 0 || e->ecx_in == 1))
> +                       if (!(e->xcr0_in == 1 || e->xcr0_in == 3) || e->xss_in)
> +                               continue;
> +
> +               leaf->eax = e->eax;
> +               leaf->ebx = e->ebx;
> +               leaf->ecx = e->ecx;
> +               leaf->edx = e->edx;
> +
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static void snp_cpuid_hv(struct cpuid_leaf *leaf)
> +{
> +       if (sev_cpuid_hv(leaf))
> +               sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
> +}
> +
> +static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
> +{
> +       struct cpuid_leaf leaf_hv = *leaf;
> +
> +       switch (leaf->fn) {
> +       case 0x1:
> +               snp_cpuid_hv(&leaf_hv);
> +
> +               /* initial APIC ID */
> +               leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
> +               /* APIC enabled bit */
> +               leaf->edx = (leaf_hv.edx & BIT(9)) | (leaf->edx & ~BIT(9));
> +
> +               /* OSXSAVE enabled bit */
> +               if (native_read_cr4() & X86_CR4_OSXSAVE)
> +                       leaf->ecx |= BIT(27);
> +               break;
> +       case 0x7:
> +               /* OSPKE enabled bit */
> +               leaf->ecx &= ~BIT(4);
> +               if (native_read_cr4() & X86_CR4_PKE)
> +                       leaf->ecx |= BIT(4);
> +               break;
> +       case 0xB:
> +               leaf_hv.subfn = 0;
> +               snp_cpuid_hv(&leaf_hv);
> +
> +               /* extended APIC ID */
> +               leaf->edx = leaf_hv.edx;
> +               break;
> +       case 0xD: {
> +               bool compacted = false;
> +               u64 xcr0 = 1, xss = 0;
> +               u32 xsave_size;
> +
> +               if (leaf->subfn != 0 && leaf->subfn != 1)
> +                       return 0;
> +
> +               if (native_read_cr4() & X86_CR4_OSXSAVE)
> +                       xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
> +               if (leaf->subfn == 1) {
> +                       /* Get XSS value if XSAVES is enabled. */
> +                       if (leaf->eax & BIT(3)) {
> +                               unsigned long lo, hi;
> +
> +                               asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
> +                                                    : "c" (MSR_IA32_XSS));
> +                               xss = (hi << 32) | lo;
> +                       }
> +
> +                       /*
> +                        * The PPR and APM aren't clear on what size should be
> +                        * encoded in 0xD:0x1:EBX when compaction is not enabled
> +                        * by either XSAVEC (feature bit 1) or XSAVES (feature
> +                        * bit 3) since SNP-capable hardware has these feature
> +                        * bits fixed as 1. KVM sets it to 0 in this case, but
> +                        * to avoid this becoming an issue it's safer to simply
> +                        * treat this as unsupported for SNP guests.
> +                        */
> +                       if (!(leaf->eax & (BIT(1) | BIT(3))))
> +                               return -EINVAL;

I couldn't get this patch set to boot and I found that I was setting
these XSAVE cpuid bits wrong. This took me a while to debug because
inside of handle_vc_boot_ghcb() this -EINVAL means we jump into the
halt loop, in addition the early_printk()s inside of that function
don't seem to  be working for me but should the halt in
handle_vc_boot_ghcb() be replaced with an sev_es_terminate() or
something?

I am still working on why the early_printk()s in that function are not
working, it seems that they lead to a different halt. Have you tested
any of those error paths manually? For example if you set your CPUID
bits to explicitly fail here do you see the expected printks?

> +
> +                       compacted = true;
> +               }
> +
> +               xsave_size = snp_cpuid_calc_xsave_size(xcr0 | xss, compacted);
> +               if (!xsave_size)
> +                       return -EINVAL;
> +
> +               leaf->ebx = xsave_size;
> +               }
> +               break;
> +       case 0x8000001E:
> +               snp_cpuid_hv(&leaf_hv);
> +
> +               /* extended APIC ID */
> +               leaf->eax = leaf_hv.eax;
> +               /* compute ID */
> +               leaf->ebx = (leaf->ebx & GENMASK(31, 8)) | (leaf_hv.ebx & GENMASK(7, 0));
> +               /* node ID */
> +               leaf->ecx = (leaf->ecx & GENMASK(31, 8)) | (leaf_hv.ecx & GENMASK(7, 0));
> +               break;
> +       default:
> +               /* No fix-ups needed, use values as-is. */
> +               break;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
> + * should be treated as fatal by caller.
> + */
> +static int snp_cpuid(struct cpuid_leaf *leaf)
> +{
> +       const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
> +
> +       if (!cpuid_table->count)
> +               return -EOPNOTSUPP;
> +
> +       if (!snp_cpuid_get_validated_func(leaf)) {
> +               /*
> +                * Some hypervisors will avoid keeping track of CPUID entries
> +                * where all values are zero, since they can be handled the
> +                * same as out-of-range values (all-zero). This is useful here
> +                * as well as it allows virtually all guest configurations to
> +                * work using a single SNP CPUID table.
> +                *
> +                * To allow for this, there is a need to distinguish between
> +                * out-of-range entries and in-range zero entries, since the
> +                * CPUID table entries are only a template that may need to be
> +                * augmented with additional values for things like
> +                * CPU-specific information during post-processing. So if it's
> +                * not in the table, set the values to zero. Then, if they are
> +                * within a valid CPUID range, proceed with post-processing
> +                * using zeros as the initial values. Otherwise, skip
> +                * post-processing and just return zeros immediately.
> +                */
> +               leaf->eax = leaf->ebx = leaf->ecx = leaf->edx = 0;
> +
> +               /* Skip post-processing for out-of-range zero leafs. */
> +               if (!(leaf->fn <= cpuid_std_range_max ||
> +                     (leaf->fn >= 0x40000000 && leaf->fn <= cpuid_hyp_range_max) ||
> +                     (leaf->fn >= 0x80000000 && leaf->fn <= cpuid_ext_range_max)))
> +                       return 0;
> +       }
> +
> +       return snp_cpuid_postprocess(leaf);
> +}
> +
>  /*
>   * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
>   * page yet, so it only supports the MSR based communication with the
> @@ -252,6 +541,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>         unsigned int subfn = lower_bits(regs->cx, 32);
>         unsigned int fn = lower_bits(regs->ax, 32);
>         struct cpuid_leaf leaf;
> +       int ret;
>
>         /* Only CPUID is supported via MSR protocol */
>         if (exit_code != SVM_EXIT_CPUID)
> @@ -259,9 +549,18 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>
>         leaf.fn = fn;
>         leaf.subfn = subfn;
> +
> +       ret = snp_cpuid(&leaf);
> +       if (!ret)
> +               goto cpuid_done;
> +
> +       if (ret != -EOPNOTSUPP)
> +               goto fail;
> +
>         if (sev_cpuid_hv(&leaf))
>                 goto fail;
>
> +cpuid_done:
>         regs->ax = leaf.eax;
>         regs->bx = leaf.ebx;
>         regs->cx = leaf.ecx;
> @@ -556,12 +855,37 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>         return ret;
>  }
>
> +static int vc_handle_cpuid_snp(struct pt_regs *regs)
> +{
> +       struct cpuid_leaf leaf;
> +       int ret;
> +
> +       leaf.fn = regs->ax;
> +       leaf.subfn = regs->cx;
> +       ret = snp_cpuid(&leaf);
> +       if (!ret) {
> +               regs->ax = leaf.eax;
> +               regs->bx = leaf.ebx;
> +               regs->cx = leaf.ecx;
> +               regs->dx = leaf.edx;
> +       }
> +
> +       return ret;
> +}
> +
>  static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
>                                       struct es_em_ctxt *ctxt)
>  {
>         struct pt_regs *regs = ctxt->regs;
>         u32 cr4 = native_read_cr4();
>         enum es_result ret;
> +       int snp_cpuid_ret;
> +
> +       snp_cpuid_ret = vc_handle_cpuid_snp(regs);
> +       if (!snp_cpuid_ret)
> +               return ES_OK;
> +       if (snp_cpuid_ret != -EOPNOTSUPP)
> +               return ES_VMM_ERROR;
>
>         ghcb_set_rax(ghcb, regs->ax);
>         ghcb_set_rcx(ghcb, regs->cx);
> --
> 2.25.1
>
