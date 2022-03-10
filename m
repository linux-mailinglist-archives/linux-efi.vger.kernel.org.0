Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BFE4D5391
	for <lists+linux-efi@lfdr.de>; Thu, 10 Mar 2022 22:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245662AbiCJV0b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Mar 2022 16:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241349AbiCJV0a (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Mar 2022 16:26:30 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3365BDCE1E;
        Thu, 10 Mar 2022 13:25:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVllZwB5ECHvJH2IyQ89Nye24LYaU5et5XJBG6gm7pa2ODMhLx4QnJGqlciO3gLPxMqL1gCq5R0j/bdER0ihAmEEOccuTDDd4qK8a0c0vOqXt9Nt+XZPx3rD6/bNnflDbCLNaHnBXKjfzZvFaSQIhEE0myg5QLBMcSIdRxyvMVqhz+kwnL4bnybNSbTgPoD4yl3IJp7tv09mly3ecTiFoGBqQtBfNlt6KGQ/gmkQsRrFwnjZexctCiVYKtkVWcq3bccjWICY5vvoCKj9zcVaJYJMGGnJCqKA2jkHQ1Rim3SuG81z7lDLFK7DVB2XUtNI6RUPZYnOHcVdriDhSS7srg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxDlasSjwoxIsuuU61ufTGmMNKV2DESd2lqFJBudYCo=;
 b=XeqxjBA2J8AWNXP12JWF62Dr0bu8aew0Srs3BGoNfSb5s+xvDKLddVm8yY4Z5xqspHOIy0vFRkfdAhFmveaZQg9hTEMSvGUD5aM3ZvP/jYhU4GD0TM/T4Lf4g604UacSXDVAlO5LTSSBtU7hGOEug3l4gm8Qb0q8EOUfAil4EjVkINJrrs6HyqUyU3m/rE88I31mONRQyhpcCBw5wsvOvCFjXyHSkHU7XS8YIWF+zDpuZEpR3l3KSzwhEvmGtEg+mz7uA3rRk5iG+dS/ubxkcIHVcvYdCK0F7YrXhn92mQZjiONRAabrUC7dqw3jyBlcJub5OWWXEPd/wmskTE1cBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxDlasSjwoxIsuuU61ufTGmMNKV2DESd2lqFJBudYCo=;
 b=ot29g+cn4x8lT375236et9lL82+PmJEz9rygzZQQjmNYLKYMhe7vfZ1xKUqS0buMfPd0yv1I1olH+dHiKdgZ6Oz3JgwFrS+BfqH8kausnneUwV+2lVBut1OJ0OHqMUxka/mQooG5s/4PfadGDDm2HATZethI8H/Fs56j6HlLDVE=
Received: from MWHPR22CA0051.namprd22.prod.outlook.com (2603:10b6:300:12a::13)
 by BL0PR12MB4964.namprd12.prod.outlook.com (2603:10b6:208:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Thu, 10 Mar
 2022 21:25:25 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::58) by MWHPR22CA0051.outlook.office365.com
 (2603:10b6:300:12a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29 via Frontend
 Transport; Thu, 10 Mar 2022 21:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 21:25:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 15:25:23 -0600
Date:   Thu, 10 Mar 2022 15:25:04 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Peter Gonda <pgonda@google.com>
CC:     Brijesh Singh <brijesh.singh@amd.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
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
        Sergio Lopez <slp@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, Tony Luck <tony.luck@intel.com>,
        Marc Orr <marcorr@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v12 32/46] x86/compressed/64: Add support for SEV-SNP
 CPUID table in #VC handlers
Message-ID: <20220310212504.2kt6sidexljh2s6p@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-33-brijesh.singh@amd.com>
 <CAMkAt6pO0xZb2pye-VEKdFQ_dYFgLA21fkYmnYPTWo8mzPrKDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMkAt6pO0xZb2pye-VEKdFQ_dYFgLA21fkYmnYPTWo8mzPrKDQ@mail.gmail.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed03dfac-293f-4f5f-20f6-08da02dc7d81
X-MS-TrafficTypeDiagnostic: BL0PR12MB4964:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB49645B03BB34C959A7F3A359950B9@BL0PR12MB4964.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dc5De7F/SPbdODKSJyDNg+XnMEqYEzmy/VzVpUDnEvVJnfV2bpWZR7YvAX5BxZNVlzsktyhvkYl72vlSmAkiILWHOnq6RBPyMIzp/KiDOQUf+6TIt5V4gk8ErxEWNEeXTNJoH6E6q8fcnOGHEQLzxxJBJT4W8dxDAbg5dCMQmW3dzlBO3PkZp6u2LzO8b4JCdWeAc/zFjQXuiNTZ4+8CU/0EbxgqqwZUzyA2UyXqWMdgaOLuMd9ct18oJJIV8FdHvXllu3myUd0MwxdU+bcR5wE88T/PghoA267TJrqKAbFJ/UimRKu2cku3Th3V2rDf2kCe+qjlZl96xYA/4nKTHJ1mfzuKJpgg2sL/hEtzy23F9uqYEbx6RFAKS1JmlNRaZHpvmFM6Y23oLAJUeL2WIwjZlfiuHM5gL9VndN7Uw6gmQmt006fGwD/5SVRiaRYTgytMz6KplT3FXc2Jum5u0OhDwq3WfYA9UpXH0ihxEqKEld72/8CsrqvuYqy0aFPrwHjMo23bWAFB9mKcxHp+UYBgqEQdpvkni2pqN9g5B+pjVl5NowXpsPIw3XFFtdO+G4BFbVqljbcIHnO5d8b9TQM+z3N3e/rnuLnUwBg3h2oyz+7qcD/DQhOSIKm8aQ2PY/e52Yn1x8r/WQrVD7ZpheQakj3HKdkHxo/BsMG0wxa0hfMWtS4XKlQoUG4g456X5bgl+Dwp3BRnDl47tqJPiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70206006)(1076003)(5660300002)(44832011)(86362001)(82310400004)(508600001)(40460700003)(8676002)(4326008)(7406005)(2616005)(356005)(36860700001)(7416002)(47076005)(81166007)(70586007)(336012)(6916009)(36756003)(26005)(426003)(316002)(54906003)(16526019)(8936002)(6666004)(53546011)(83380400001)(186003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 21:25:24.6146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed03dfac-293f-4f5f-20f6-08da02dc7d81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4964
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 10, 2022 at 07:51:17AM -0700, Peter Gonda wrote:
> ()
> 
> On Mon, Mar 7, 2022 at 2:35 PM Brijesh Singh <brijesh.singh@amd.com> wrote:
> > +static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
> > +{
> > +       struct cpuid_leaf leaf_hv = *leaf;
> > +
> > +       switch (leaf->fn) {
> > +       case 0x1:
> > +               snp_cpuid_hv(&leaf_hv);
> > +
> > +               /* initial APIC ID */
> > +               leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
> > +               /* APIC enabled bit */
> > +               leaf->edx = (leaf_hv.edx & BIT(9)) | (leaf->edx & ~BIT(9));
> > +
> > +               /* OSXSAVE enabled bit */
> > +               if (native_read_cr4() & X86_CR4_OSXSAVE)
> > +                       leaf->ecx |= BIT(27);
> > +               break;
> > +       case 0x7:
> > +               /* OSPKE enabled bit */
> > +               leaf->ecx &= ~BIT(4);
> > +               if (native_read_cr4() & X86_CR4_PKE)
> > +                       leaf->ecx |= BIT(4);
> > +               break;
> > +       case 0xB:
> > +               leaf_hv.subfn = 0;
> > +               snp_cpuid_hv(&leaf_hv);
> > +
> > +               /* extended APIC ID */
> > +               leaf->edx = leaf_hv.edx;
> > +               break;
> > +       case 0xD: {
> > +               bool compacted = false;
> > +               u64 xcr0 = 1, xss = 0;
> > +               u32 xsave_size;
> > +
> > +               if (leaf->subfn != 0 && leaf->subfn != 1)
> > +                       return 0;
> > +
> > +               if (native_read_cr4() & X86_CR4_OSXSAVE)
> > +                       xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
> > +               if (leaf->subfn == 1) {
> > +                       /* Get XSS value if XSAVES is enabled. */
> > +                       if (leaf->eax & BIT(3)) {
> > +                               unsigned long lo, hi;
> > +
> > +                               asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
> > +                                                    : "c" (MSR_IA32_XSS));
> > +                               xss = (hi << 32) | lo;
> > +                       }
> > +
> > +                       /*
> > +                        * The PPR and APM aren't clear on what size should be
> > +                        * encoded in 0xD:0x1:EBX when compaction is not enabled
> > +                        * by either XSAVEC (feature bit 1) or XSAVES (feature
> > +                        * bit 3) since SNP-capable hardware has these feature
> > +                        * bits fixed as 1. KVM sets it to 0 in this case, but
> > +                        * to avoid this becoming an issue it's safer to simply
> > +                        * treat this as unsupported for SNP guests.
> > +                        */
> > +                       if (!(leaf->eax & (BIT(1) | BIT(3))))
> > +                               return -EINVAL;
> 
> I couldn't get this patch set to boot and I found that I was setting
> these XSAVE cpuid bits wrong. This took me a while to debug because
> inside of handle_vc_boot_ghcb() this -EINVAL means we jump into the
> halt loop, in addition the early_printk()s inside of that function
> don't seem to  be working for me but should the halt in
> handle_vc_boot_ghcb() be replaced with an sev_es_terminate() or
> something?

For consistency, the error is propagated up the stack the same way as with
all other individual handlers, and it's up to the current #VC handler
function how it wants to handle errors. The other #VC handlers terminate,
but this one has used a halt loop since its initial implementation in 2020
(1aa9aa8ee517e).

Joerg, do you have more background on that? Would it make sense, outside
of this series, to change it to a terminate? Maybe with a specific set
of error codes for ES_{OK,UNSUPPORTED,VMM_ERROR,DECODE_FAILED}?

> 
> I am still working on why the early_printk()s in that function are not
> working, it seems that they lead to a different halt.

I don't see a different halt. They just don't seem to print anything.
(keep in mind you still need to advance the IP or else the guest is
still gonna end up spinning here, even if you're removing the halt loop
for testing purposes)

> working, it seems that they lead to a different halt. Have you tested
> any of those error paths manually? For example if you set your CPUID
> bits to explicitly fail here do you see the expected printks?

I think at that point in the code, when the XSAVE stuff is setup, the
console hasn't been enabled yet, so messages would get buffered until they
get flushed later (which won't happen since there's halt loop after). I
know in some cases devs will dump the log buffer from memory instead to get
at the error messages for early failures. (Maybe that's also why Joerg
decided to use a halt loop there instead of terminating?)

That said, I did some testing to confirm with earlyprintk=serial|vga and
I don't see the error messages even if I modify the #VC handler to allow
booting to continue. pr_err() messages however do show up if I drop the
halt loop. So maybe pr_err() is more appropriate here? But it doesn't
really matter unless you plan on digging into guest memory for the logs.

So maybe reworking the error handling in handle_vc_boot_ghcb() to use
sev_es_terminate() might be warranted, but probably worth checking with
Joerg first, and should be done as a separate series since it is not
SNP-related.
