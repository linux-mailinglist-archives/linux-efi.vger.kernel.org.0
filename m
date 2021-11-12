Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDA544EDE9
	for <lists+linux-efi@lfdr.de>; Fri, 12 Nov 2021 21:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhKLUdU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 Nov 2021 15:33:20 -0500
Received: from mail-co1nam11on2058.outbound.protection.outlook.com ([40.107.220.58]:13472
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230235AbhKLUdU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 12 Nov 2021 15:33:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXgVfQdor5CyD5+ZEtxYyPFLhzP1XK2m0EOTQooW/EBwVDkLO4e+Vw3DXnDCRV6w8jGc34K67f5SBD1rkNitTI1OB+sRX7KShbpqoeTIr2K+NGi/xqIY5tuXjPIjthfPYEe0W8L8HSB+KhBHlW012UaAAl1RFOhmy/B8c8fCjhwwOY0hYSu+KOE8bGEoKFI2Q3fDrBSxsJ/7hvmMJeM8JFYsb5I5G+clJA/sZuPV6t0U9MTugwHXKB1Mk5t4rWQseuCRg4wJqeaSygy194ayPZJ8ZcVJOqhOh4BHErGQlIgDUN7uZFJzFTYP2prK7bbOWKqbujRORBQMCYXH1bcAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/rfx4+lP7CRAXPHJoz+UOHVIQp38Gp2HChcztc2fqw=;
 b=HYn2a9nyEip+QofTzpB/shC3XSzFwzrdazNaBFaz8NPzTNMKfCTe8bqnhMRqVJO+VhV7ya8LgnR0la5lqPfPkSgqORQgVXJjOkGUIgPlXU2CA2SdKVTp42tnoasdmItmLP5ZaweesDoYRjru84XBfN2I9MpUnjIYcJ9XM4/Xenw3EPjEaAibCYrSTnIkC+fOJ+PcNwdBIz54tFJvgK8k3MBd7DRW2ItttDCU1QE08r5IRcYGA/GL5tr7KaW9jmWt/iRv6KKeQfqILlZs/AcaNhqUmlsudqqsOwBvk75j/PkSoxbE2TK4OXGWOgT0Z54drhPX7gvKZGPZjbj3N4SzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/rfx4+lP7CRAXPHJoz+UOHVIQp38Gp2HChcztc2fqw=;
 b=o8P4uBhBlOqeAwAR71CaxagB4FpaoCknNTj+ztEMYQizNCWt3fvA7yOcHA2srwHPrhNJnQ+kDIrA3bnVW2AGvgpKhlb3fcKrNlh+HR4iGiUhqRC+QoqTJz1vVtbG0H4YOJQDgUOJn3PIqOJBmg9nr6diooXgwUgFJmBLTzLIZ08=
Received: from BN9PR03CA0879.namprd03.prod.outlook.com (2603:10b6:408:13c::14)
 by DM6PR12MB3162.namprd12.prod.outlook.com (2603:10b6:5:15c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Fri, 12 Nov
 2021 20:30:25 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::1b) by BN9PR03CA0879.outlook.office365.com
 (2603:10b6:408:13c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend
 Transport; Fri, 12 Nov 2021 20:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 20:30:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 12 Nov
 2021 14:30:21 -0600
Date:   Fri, 12 Nov 2021 14:30:01 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Brijesh Singh <brijesh.singh@amd.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v7 01/45] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <20211112203001.kdzhpgp3uqcr2dy5@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-2-brijesh.singh@amd.com>
 <YY6b4y8Shi5dBlCK@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YY6b4y8Shi5dBlCK@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e0d02b3-6906-4750-1800-08d9a61b41b6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3162:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3162AB9A07FE0E51C567F22795959@DM6PR12MB3162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6Vs41jjXNa8fdImwJcDfz+L77M6wmTAHmeaN8fFttbYE9jvfQPC96bYAaf0uSrz6OE2zmfrqiPLl/R4xdCLST0aVaCplj0jokyIoMS6w7oQH7NmnJUV7yUAcNWAd4I4LWseB2X6U95r+jma0lFMXYHHvOu3YN4p449F2Vy2fP3VF2w70EMzp9M0IRI1Vg7jYWcRwqxK3TVsMnm0zBIcLRlyc+NIgL7CHLJsgNZsLT2g0CVg4Ge3bpEC2Z2NcZGR+Kgw3U6huvx/wbFAzVx5DtMQ4PTvMqtnSKJsvAqh/bOny8GngwUkiiXyQBMFO7BqTK234i72qgQPi2lHO+pPp3chdYDvmTP5RS8as000YpbfCVEq5EFKpDx6aG56u8ftlJsinkDRyeCNEmN1GPprtd9f82y/sKmb/PyMGKsrSgTKBJH9pH04S41ULHWxtp5Jvvd/zqWrGXyOFufXJ7zNcaYmYwgMQXot9GuamcvN5jwX7Bja/axAKn0/W6XoSNFsC95xoJu/kbp6PgKx6UhsN2Rn0dqbfJG93yq6cWosT0KlQ7ZDi5KLKKMPCB0VYCow/TDvXbdT+bvi/yBkX3iJXr9DHWeLuGMw4X6Yt1L7roipP3Hn30GeovRKy8uUYdYLKcdjiCGEbZ+2gMwzQsMoa98l+8eW02xxVwp0fZxAc1sbeMU7pG6xUynmmG0TG4gEmXL4/2XOU0bpPuy3EF2fepzWPal70oDJ9tsTbC04QRJe/VlA9fo3UiLGARwv0gqsAawyRiACRJZClRQS5+Ble6pru1I45V6Q53OiyY3d8s0E5/KT6XMrLpB1d7cmEUO+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(336012)(8936002)(86362001)(54906003)(8676002)(2906002)(44832011)(316002)(426003)(1076003)(81166007)(6916009)(6666004)(70206006)(83380400001)(82310400003)(5660300002)(7416002)(356005)(2616005)(4326008)(508600001)(7406005)(26005)(36756003)(186003)(47076005)(16526019)(45080400002)(36860700001)(70586007)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 20:30:24.5966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0d02b3-6906-4750-1800-08d9a61b41b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3162
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 12, 2021 at 05:52:51PM +0100, Borislav Petkov wrote:
> On Wed, Nov 10, 2021 at 04:06:47PM -0600, Brijesh Singh wrote:
> > +void sev_enable(struct boot_params *bp)
> > +{
> > +	unsigned int eax, ebx, ecx, edx;
> > +
> > +	/* Check for the SME/SEV support leaf */
> > +	eax = 0x80000000;
> > +	ecx = 0;
> > +	native_cpuid(&eax, &ebx, &ecx, &edx);
> > +	if (eax < 0x8000001f)
> > +		return;
> > +
> > +	/*
> > +	 * Check for the SME/SEV feature:
> > +	 *   CPUID Fn8000_001F[EAX]
> > +	 *   - Bit 0 - Secure Memory Encryption support
> > +	 *   - Bit 1 - Secure Encrypted Virtualization support
> > +	 *   CPUID Fn8000_001F[EBX]
> > +	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
> > +	 */
> > +	eax = 0x8000001f;
> > +	ecx = 0;
> > +	native_cpuid(&eax, &ebx, &ecx, &edx);
> > +	/* Check whether SEV is supported */
> > +	if (!(eax & BIT(1)))
> > +		return;
> > +
> > +	/* Check the SEV MSR whether SEV or SME is enabled */
> > +	sev_status   = rd_sev_status_msr();
> > +
> > +	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
> > +		error("SEV support indicated by CPUID, but not SEV status MSR.");
> 
> What is the practical purpose of this test?

In the current QEMU/KVM implementation the SEV* CPUID bits are only
exposed for SEV guests, so this was more of a sanity check on that. But
looking at things more closely: that's more of a VMM-specific behavior
and isn't necessarily an invalid guest configuration as far as the spec
is concerned, so I think this check should be dropped.

> 
> > +	sme_me_mask = 1UL << (ebx & 0x3f);
> 
> 	sme_me_mask = BIT_ULL(ebx & 0x3f);

Will do.

Thanks,

Mike

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7Ca6bf3479fffa4b5eee8b08d9a5fce2e2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637723327924654730%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=SRy8YSe8a2njNc6IT8CGKv0hUefSOW55DJV%2Fi2Lhkic%3D&amp;reserved=0
