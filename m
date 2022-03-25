Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010004E6FF5
	for <lists+linux-efi@lfdr.de>; Fri, 25 Mar 2022 10:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356624AbiCYJ0f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Mar 2022 05:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243091AbiCYJ0b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Mar 2022 05:26:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA8ECF4B1;
        Fri, 25 Mar 2022 02:24:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 250B01F745;
        Fri, 25 Mar 2022 09:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648200296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvN7myr0MDfmtMFkdZ1k/72coAzlBsKoPtLN6KtQ1CQ=;
        b=v7ByO0o1ZIbFE5mwJyFIHpW2wINXiMWRB8n9NTThT5QJklwm6VB3tMgmaRuw+BNeQ0mIaN
        Jra5pct2F+ssPqGHTFKPmuvlUlbIXuuHfP7ZhD13c++eR5WgQH6r+oHxYAsW3qQmYfS9EK
        fRwHZZabz/9vqllHvpg8l/abeRokoCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648200296;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvN7myr0MDfmtMFkdZ1k/72coAzlBsKoPtLN6KtQ1CQ=;
        b=QRumQzO+afwTgRwYz9SpOF+rQLK40HkIs3BRJSzs/Q2UZ3AYLDcTAHwYgb+zNjJPFOPBGT
        mt53x2Wzp/5juLAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12EAE132E9;
        Fri, 25 Mar 2022 09:24:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TmabBGiKPWIRfwAAMHmgww
        (envelope-from <bp@suse.de>); Fri, 25 Mar 2022 09:24:56 +0000
Date:   Fri, 25 Mar 2022 10:24:50 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v12 40/46] x86/sev: add sev=debug cmdline option to dump
 SNP CPUID table
Message-ID: <Yj2KYsdvz7NOtF7w@zn.tnic>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-41-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220307213356.2797205-41-brijesh.singh@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 07, 2022 at 03:33:50PM -0600, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> For debugging purposes it is very useful to have a way to see the full
> contents of the SNP CPUID table provided to a guest. Add an sev=debug
> kernel command-line option to do so.
> 
> Also introduce some infrastructure so that additional options can be
> specified via sev=option1[,option2] over time in a consistent manner.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  2 +
>  Documentation/x86/x86_64/boot-options.rst     | 14 +++++
>  arch/x86/kernel/sev.c                         | 58 +++++++++++++++++++
>  3 files changed, 74 insertions(+)

I simplified the string parsing:

---
From: Michael Roth <michael.roth@amd.com>
Date: Mon, 7 Mar 2022 15:33:50 -0600
Subject: [PATCH] x86/sev: Add a sev= cmdline option

For debugging purposes it is very useful to have a way to see the full
contents of the SNP CPUID table provided to a guest. Add an sev=debug
kernel command-line option to do so.

Also introduce some infrastructure so that additional options can be
specified via sev=option1[,option2] over time in a consistent manner.

  [ bp: Massage, simplify string parsing. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-41-brijesh.singh@amd.com
---
 .../admin-guide/kernel-parameters.txt         |  2 +
 Documentation/x86/x86_64/boot-options.rst     | 14 ++++++
 arch/x86/kernel/sev.c                         | 44 +++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7123524a86b8..5f7fa7c141dc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5229,6 +5229,8 @@
 
 	serialnumber	[BUGS=X86-32]
 
+	sev=option[,option...] [X86-64] See Documentation/x86/x86_64/boot-options.rst
+
 	shapers=	[NET]
 			Maximal number of shapers.
 
diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index ccb7e86bf8d9..eaecb5d89167 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -317,3 +317,17 @@ Miscellaneous
     Do not use GB pages for kernel direct mappings.
   gbpages
     Use GB pages for kernel direct mappings.
+
+
+AMD SEV (Secure Encrypted Virtualization)
+=========================================
+Options relating to AMD SEV, specified via the following format:
+
+::
+
+   sev=option1[,option2]
+
+The available options are:
+
+   debug
+     Enable debug messages.
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c8733725d8bf..70ecc6e2f251 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -112,6 +112,13 @@ DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 
 static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 
+struct sev_config {
+	__u64 debug		: 1,
+	      __reserved	: 63;
+};
+
+static struct sev_config sev_cfg __read_mostly;
+
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -2042,6 +2049,23 @@ void __init snp_abort(void)
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
 
+static void dump_cpuid_table(void)
+{
+	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+	int i = 0;
+
+	pr_info("count=%d reserved=0x%x reserved2=0x%llx\n",
+		cpuid_table->count, cpuid_table->__reserved1, cpuid_table->__reserved2);
+
+	for (i = 0; i < SNP_CPUID_COUNT_MAX; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
+
+		pr_info("index=%3d fn=0x%08x subfn=0x%08x: eax=0x%08x ebx=0x%08x ecx=0x%08x edx=0x%08x xcr0_in=0x%016llx xss_in=0x%016llx reserved=0x%016llx\n",
+			i, fn->eax_in, fn->ecx_in, fn->eax, fn->ebx, fn->ecx,
+			fn->edx, fn->xcr0_in, fn->xss_in, fn->__reserved);
+	}
+}
+
 /*
  * It is useful from an auditing/testing perspective to provide an easy way
  * for the guest owner to know that the CPUID table has been initialized as
@@ -2059,6 +2083,26 @@ static int __init report_cpuid_table(void)
 	pr_info("Using SNP CPUID table, %d entries present.\n",
 		cpuid_table->count);
 
+	if (sev_cfg.debug)
+		dump_cpuid_table();
+
 	return 0;
 }
 arch_initcall(report_cpuid_table);
+
+static int __init init_sev_config(char *str)
+{
+	char *s;
+
+	while ((s = strsep(&str, ","))) {
+		if (!strcmp(s, "debug")) {
+			sev_cfg.debug = true;
+			continue;
+		}
+
+		pr_info("SEV command-line option '%s' was not recognized\n", s);
+	}
+
+	return 1;
+}
+__setup("sev=", init_sev_config);
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
