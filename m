Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D428C3F2F00
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241095AbhHTPWi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:22:38 -0400
Received: from mail-bn8nam08on2087.outbound.protection.outlook.com ([40.107.100.87]:15585
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241118AbhHTPWI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+xrbZmD2XobuBAqdvkF6r10vmQpWggdV7JgVmPmNeajCxikGNdbobh6eJmwITaSgd3id57gFJ/6/I2c4uxYg0S1pqRqCvsf1zukTJWpCLWoGLhzISk8LNenqNW9jMKojjT9wGIHw/NmyKhAKu+Vcms0ZN75NnB4OmpEDdUOSRTEvbZRQiNoqJNF4iAGE/tQRTOXLfATMX2JoZ3nymGhR/6l6oIdA1vqMNpXnqJAwu4MrkMFy1xJ7O45NrskN2mvJM+bWs5niWiNJeVefmq3pWnz4p3B/W7aC/8g3yrA+Ac1VTusP8yRm7gIEPpP6Cce9Peovd22TMIm0dFAEJkO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evrmQ0dNpEqVvr3I01KIDOwQFoxzpcbaf5oU9vPkZcA=;
 b=nR8cQ5CR2B8apjdu+f2VRrSrKf7j7ik+T+I12WBi89/iqZWxXnE9sISZRRJU4xBB9EvR4u+Txg/Ibx3VSOWLhcRZtnPn2rwxdYaPmSVLGGzanpLNEvj/LyK1GVXFmpKL2vg+zdjvY8L6VcZlbRqBNtsTz6OO6Q8HYX1VtWZbOqNpn6YwwQNzgzMAXrixm0boMh2ALFvQ7BbevX8LlnNBqiX+NYY/oT5VYVFyqn+f0+eSnJoPMpsXhxD15bAfPn/VKEP85YvQqBMOG3jI8NiAtKF6ZkATvho05rRNHMU8HqZq3lhp6OzR5vaLOh4jMEyEcE5brUXVfFePFJzSGPtSUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evrmQ0dNpEqVvr3I01KIDOwQFoxzpcbaf5oU9vPkZcA=;
 b=vCJ6P/yObDf7LR1/hWIelTIIbS0WLJL5uI5m28tDLQhxPPvDesjuvtSNkaZvliUonWVot1N7jbeoHPS/EMeDyPcF4zyj68hnzdonWeJ+MIrd2QuZSP4lQ2UN6suSwA+TDd7e+exPaQHnlQIyv46XO4Ax8EuKAj0OMeLHszwDkac=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:21:17 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:17 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 v5 23/38] x86/head/64: set up a startup %gs for stack protector
Date:   Fri, 20 Aug 2021 10:19:18 -0500
Message-Id: <20210820151933.22401-24-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 978f47c1-8c2e-4517-7fb6-08d963ee27d6
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4557CF15D48E4CE6B2AC3C1AE5C19@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grZ3zsc3t1z7vJgpdhrVGgn5fAvZeSJ2CzmvtFvGsjGFywdSe/+QXMgNncl9k2UO+M/mINRuNhyU1+eFjf/zB0VcYEa+KUJ8U9GYsmbbYc7yZJx1AT/E9Xgyy6KKZQ3F4cNHnf0R0YZ5wtTG1ld87rbiBLvA+ev+KXjYYxqzdQ4uHltFotghJf5JuVxYlpLy+nUpyEj5hi5qcQfLhlzaPICX8REgbF/r8CY2u6dON6ZiCF9En4tklI7n6TtJhw63ejI/no5MxwdxRZjdMyaJc31HSdfNe5fyLzD8ewwe5zIZzXr6oARKeBbRTU/pU2cVSWfFF/14mmXMZQuUn22jtDOvbnJXtSA/kE3cS8HqvGTbOSrlBS9D7b6vFrNfS75FPZ9YPba95kqFqTbfvL9ZQn/Y7GHtzbU6W3TdtBK7K8tc8qDG4rPBC7qGr8Q0ihagg6CzHfgSRLi3q5DxC6zMD/vKXqDKbAwItc0kHDbqqSezpkF2t7siF6SP39IX/ngTuFJU/1tQVfpZB66/S8o2B/dBz9kIvqk+vNyssBs9vpaYW2jIoZQGXHGogbX8Zf/gqoZwNFOJl3x1FLZ7vQm22yv//8euHyJgMPmYMH4HjJaUoY3OperQV5CeMMIolxh6bL20nEbBve89F06m/9v6HkAisFEhFhBdJTBJOgZPc+mJhz5V/A9M79F8QXoVbto1co47B6rmyHBZU3L4H6xqWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(66476007)(66946007)(4326008)(478600001)(44832011)(956004)(2616005)(7696005)(7406005)(38350700002)(52116002)(66556008)(7416002)(38100700002)(36756003)(186003)(316002)(8936002)(2906002)(83380400001)(86362001)(26005)(54906003)(1076003)(6486002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C00X63XgG9A5USk27K9qZYq2fw9q3/6Cpvi4HlrPjxob+46ue5uzfaOzFjtr?=
 =?us-ascii?Q?HpM4jC7RT1SsT7NJoMe3DCtTlm1WKAlUFnUn8QR2+jxqIficBzhk9YUAXNwk?=
 =?us-ascii?Q?RCYkKGExzejlNOs3Ds9hawYjUgaXvWC0ZhBR3lMihM7zCDHuFrqJ2JqifBog?=
 =?us-ascii?Q?K9t2FRdn+YvWa41A5JJUYPZy7+k+ucjMZEfqr5WnthsCt93e9QiuY4mFp0lW?=
 =?us-ascii?Q?I3N7aYP23/WS06pNBXn5v3UFLwW54pgpfEcGQjBTvhpOEQiDlixU6ivjT+Xy?=
 =?us-ascii?Q?DjsXTeF4t0ySdQiAQ7GR0tmjZE+oifqmyUmhZA8Xd9ooZaYBYg/Jzsxd7mEA?=
 =?us-ascii?Q?pZoe/7EH5Y4roQWwaT0QuiYbU3RE86RR61I9EXKwmkps5U/Hb/SdtpbK5fHX?=
 =?us-ascii?Q?S7aKF47z3LMdhVn7NZq7f/7ecZrqONDXturysavZHgKHLlYXjkZih6wvj+K8?=
 =?us-ascii?Q?jBY2eUB14leZXvJprapngQPdHNDOcVUvae+ZevI/XINaTamDKiuPAGOisJXk?=
 =?us-ascii?Q?dVVf30msbsZIZDd9H6dm0eAKe12PIfkA+Nu2UOqZp54JVR451aQo4GS7Pnor?=
 =?us-ascii?Q?Z+2Q4H66Dc7afMICxCUsO+83adxk9FJINIkR7GE8xpIwLbx79FE/b3rbPY0q?=
 =?us-ascii?Q?pgCdBt1MQXfNe9+QD8tJryCigyFvBOy3AjyAaUtAOH1RzMVjEN83PgKNFQON?=
 =?us-ascii?Q?/vB6htGeC2awrXGwm18ptefThHLl5ExRtzZmtAlzYy8nZcTZFVJIMQ72eK/3?=
 =?us-ascii?Q?EjRTz09GFSHTh4VE2SzADpi8yBT0S0N6p+rjpeAFrtFpgNsSS01lcpVmIPhD?=
 =?us-ascii?Q?ugrcuDiRdenoAGwNufgXAsSq6iueJnnTLifh1mD0JTIhyerDG+Hh6gWmTyPi?=
 =?us-ascii?Q?AJuvxKetONR+kAQK3O1abLqRT1d+0hTqUEmhtXWA0zFia0VFn6ilGtlp+BSW?=
 =?us-ascii?Q?Ia4Ciq1ke9JkKQ+PSZRAq9TSF5LiVfkxyWP73x+/+MniG4i5VLxUNUGcYPc4?=
 =?us-ascii?Q?S4ReswsP93oln1nSKOe9kopBETV3c4TBrd1M9oK6b4bcsJhaVGRFibFZ5AB2?=
 =?us-ascii?Q?FRyqh45IUEtCQ+TMKSpcODi26SD2MIVCSER9OdKBZeNU87oRVHQjXKRSQub8?=
 =?us-ascii?Q?qBNAqB7h+oE5BCA9bDvm2QqLEjfEoNDHQjGvDMsFCX18WcIpGCDTbvp7L2kv?=
 =?us-ascii?Q?qfQqRQiloWSEiBzUcDETGHTsmm6hxupZ5tU5V4/yOd55UPrpkxlITmYFMo2I?=
 =?us-ascii?Q?429oxHzCQpqS6MtTNRIYOq0q/9aJ0mpbuwpWQf0hq61L4+2/Y0jH/CCQvx91?=
 =?us-ascii?Q?aU25VUY+SAIm2HI4E4y5ezxb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978f47c1-8c2e-4517-7fb6-08d963ee27d6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:17.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yp8JXpW89gxpwi/NNey4QGih64BHBYpHwYeEUQId3PENXIvSmPdPqcUMwnzRq7bB5rjaRlN9c6YZGwQ+GBLAkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

As of commit 103a4908ad4d ("x86/head/64: Disable stack protection for
head$(BITS).o") kernel/head64.c is compiled with -fno-stack-protector
to allow a call to set_bringup_idt_handler(), which would otherwise
have stack protection enabled with CONFIG_STACKPROTECTOR_STRONG. While
sufficient for that case, this will still cause issues if we attempt to
call out to any external functions that were compiled with stack
protection enabled that in-turn make stack-protected calls, or if the
exception handlers set up by set_bringup_idt_handler() make calls to
stack-protected functions.

Subsequent patches for SEV-SNP CPUID validation support will introduce
both such cases. Attempting to disable stack protection for everything
in scope to address that is prohibitive since much of the code, like
SEV-ES #VC handler, is shared code that remains in use after boot and
could benefit from having stack protection enabled. Attempting to inline
calls is brittle and can quickly balloon out to library/helper code
where that's not really an option.

Instead, set up %gs to point a buffer that stack protector can use for
canary values when needed.

In doing so, it's likely we can stop using -no-stack-protector for
head64.c, but that hasn't been tested yet, and head32.c would need a
similar solution to be safe, so that is left as a potential follow-up.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/Makefile |  2 +-
 arch/x86/kernel/head64.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 3e625c61f008..5abdfd0dbbc3 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -46,7 +46,7 @@ endif
 # non-deterministic coverage.
 KCOV_INSTRUMENT		:= n
 
-CFLAGS_head$(BITS).o	+= -fno-stack-protector
+CFLAGS_head32.o		+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a1711c4594fa..f1b76a54c84e 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -74,6 +74,11 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] = {
 	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
 };
 
+/* For use by stack protector code before switching to virtual addresses */
+#if CONFIG_STACKPROTECTOR
+static char startup_gs_area[64];
+#endif
+
 /*
  * Address needs to be set at runtime because it references the startup_gdt
  * while the kernel still uses a direct mapping.
@@ -605,6 +610,8 @@ void early_setup_idt(void)
  */
 void __head startup_64_setup_env(unsigned long physbase)
 {
+	u64 gs_area = (u64)fixup_pointer(startup_gs_area, physbase);
+
 	/* Load GDT */
 	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
 	native_load_gdt(&startup_gdt_descr);
@@ -614,5 +621,18 @@ void __head startup_64_setup_env(unsigned long physbase)
 		     "movl %%eax, %%ss\n"
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
 
+	/*
+	 * GCC stack protection needs a place to store canary values. The
+	 * default is %gs:0x28, which is what the kernel currently uses.
+	 * Point GS base to a buffer that can be used for this purpose.
+	 * Note that newer GCCs now allow this location to be configured,
+	 * so if we change from the default in the future we need to ensure
+	 * that this buffer overlaps whatever address ends up being used.
+	 */
+#if CONFIG_STACKPROTECTOR
+	asm volatile("movl %%eax, %%gs\n" : : "a"(__KERNEL_DS) : "memory");
+	native_wrmsr(MSR_GS_BASE, gs_area, gs_area >> 32);
+#endif
+
 	startup_64_load_idt(physbase);
 }
-- 
2.17.1

