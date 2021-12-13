Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB0F473396
	for <lists+linux-efi@lfdr.de>; Mon, 13 Dec 2021 19:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbhLMSIn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Dec 2021 13:08:43 -0500
Received: from mail-mw2nam12on2088.outbound.protection.outlook.com ([40.107.244.88]:63361
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241633AbhLMSIl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Dec 2021 13:08:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRTshZMB4bKbxwtzf3dGFSEXx/5OIAePj8WqNLnVOnxTDX6t/KZ+sDtx2ANzkQZF1jBsQll5bATuy6wMKji8AbtOKz+gP8SFuYq/59C1B4QzNgbQMCB1Xq8i18fLS913jUcS/2xI+xqrIHJYyBAmGiJUWMiRWDD30Ufj8zbonaD9sfvYFJuS1zF6fUuX9ubFbEAfaAOj2Zp2kR9SgqGTba+j+An1Vw6S+PlZvfmiVdgcH3DdiJudFMSX3q9/m8bxkSluQG17ddAxi8RTCzoXYNCI5Ph4noRRMKcrSqacbqcNrEU4mdbK9FPLmfr+ZiIcOtLofDdomQzeyHOL2RIr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFtI9vVfxWP5bD3sdXH2zjEzRnL+JzJC7n56z+10gr8=;
 b=msqubN+2fD2FErWBycHIjGxoJMSCxoRaJCoelYaeoXYhgQHk+yCVoZdOA8iWzp7FSNff8766hdDdIzrE+6CafWe2Be3s0oZAgot8XT1kpLzlIqZAOXQ41JGKykNvs5f/ZKbRwEmWjIS0Dy2/GxghYWKNYbfod1JxHUcpDutQ5UKEfBIMOnjohKnQxCtABkCHU5BRsSfzvze9pEtNP4rOHBEff+x7WrCr+eHqaBHOjynVAMrbBMXNtx7JW9o5McccDczpHY5bOYzaCFz3NegNJydHZeIOllvm4SUFEzA17T6NEjyE2+9fgXgc/XO70DkKignhhEKeryuFT6qH1F5Akw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFtI9vVfxWP5bD3sdXH2zjEzRnL+JzJC7n56z+10gr8=;
 b=aUx9fP5r//K52PSZWxiiRU9fTu2CxXRUVsnPJYfGHTp56j0D7QhF68WFcQrIOM72ncfBi2wefsfpETmyhGnS+kD+UGmmkqo44BjwA/8Oh0t0+nvPd7BWRLFyly477hmiNjoQ+Poudd0DsB9Gnwm1xV3kao7Hbb9Fj5zV9bLtrw8=
Received: from BN9PR03CA0064.namprd03.prod.outlook.com (2603:10b6:408:fc::9)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 18:08:38 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::b4) by BN9PR03CA0064.outlook.office365.com
 (2603:10b6:408:fc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Mon, 13 Dec 2021 18:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 18:08:36 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 12:08:35 -0600
Date:   Mon, 13 Dec 2021 11:54:47 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Dave Hansen <dave.hansen@intel.com>
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
        Borislav Petkov <bp@alien8.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 33/40] x86/compressed/64: add identity mapping for
 Confidential Computing blob
Message-ID: <20211213175447.2wskpjxmrvqzzpjx@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-34-brijesh.singh@amd.com>
 <14a7c745-b6c3-8d9c-144f-2d06b80159e6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <14a7c745-b6c3-8d9c-144f-2d06b80159e6@intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c202b6f-46af-4dc3-c492-08d9be639554
X-MS-TrafficTypeDiagnostic: MN2PR12MB4358:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4358D2C0F63AAD603CF6FCE695749@MN2PR12MB4358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jA9h6RZZNeb0BEM9WPv3GbXAxqEfVECYReP0EtGEwOiU5coZrx90919tlYrU/5waJx5PmASm/S2/DSxmfvu6OnDqekHMQNDmKETv6Ko/zfvXvRrJmbsZtStt7hwb61Vpqgavsj+KSJZ8C6Ad/uVm/f5iIbmOVmVFyCiV9fuQ4PL6esGp/blYa6wkIMdGjwQPegVdQvslcYrOMbM7Ysk6OSebcL7Q9Hm0vluSyyd8och79IE5NLLxae6h08t9djBQFd2WgLVwOXQKDSRYT5IEevv8KKJ4BEQXO5HtvvSALBA1PMZyxYRFPMsM2B0dHb5wfwelDiL5/uOuLkdH2vlSN1NDZ8vTFcjoelvidbLmwo+s8O6YqAP7sjODWEgJuhr3nW719KRSkCi/fN2BpB4lKttCDuEmjha7+rxmf5xDWWwMTcoeH5AmghuHshAtuUw3svXy5aYoFOn6qPcR86OlRi+vpy9NiW7+Zw0CSNf3j82nM9G2qnGIaxjOKJRTaIiBj/UY8EXiZALPAMkgglA7qgy5HJ9sHRU+JMCuRscx7bPpeOxcU2eblJ/i0bhuHY/p7BoHbGguj3MgKb+8ggUqB26nyC+xw7d7zDwXwsbPx0hcpf0iDlO4HuGNb11UUGMVVjCNMeBQHMjL9ikBddIs5yI9vdYTHZNUkB1LH+SCyp2B/9PbE7bDmNi/pCQDbvCyxovZUSkehtzbvID2SgRkipOCYNHyZUT2kCsVcZgJz7TmxWxvj6Jl//pJmgkoCX8gvJ9huRJ6sOI3/YlXjxissOuqtXFLK8uvKeYJX0b1wsM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(2616005)(2906002)(4326008)(44832011)(7406005)(40460700001)(82310400004)(7416002)(186003)(81166007)(6666004)(86362001)(53546011)(16526019)(6916009)(356005)(83380400001)(426003)(8676002)(26005)(336012)(36756003)(70586007)(508600001)(8936002)(54906003)(1076003)(36860700001)(70206006)(316002)(47076005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 18:08:36.5601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c202b6f-46af-4dc3-c492-08d9be639554
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 11:52:28AM -0800, Dave Hansen wrote:
> On 12/10/21 7:43 AM, Brijesh Singh wrote:
> > +static void sev_prep_identity_maps(void)
> > +{
> > +	/*
> > +	 * The ConfidentialComputing blob is used very early in uncompressed
> > +	 * kernel to find the in-memory cpuid table to handle cpuid
> > +	 * instructions. Make sure an identity-mapping exists so it can be
> > +	 * accessed after switchover.
> > +	 */
> > +	if (sev_snp_enabled()) {
> > +		struct cc_blob_sev_info *cc_info =
> > +			(void *)(unsigned long)boot_params->cc_blob_address;
> > +
> > +		add_identity_map((unsigned long)cc_info,
> > +				 (unsigned long)cc_info + sizeof(*cc_info));
> > +		add_identity_map((unsigned long)cc_info->cpuid_phys,
> > +				 (unsigned long)cc_info->cpuid_phys + cc_info->cpuid_len);
> > +	}
> 
> The casting here is pretty ugly.  Also, isn't ->cpuid_phys already a
> u64?  Whats the idea behind casting it?
> 
> I also have a sneaking suspicion that a single "unsigned long cc_blob"
> could remove virtually all the casting.  Does this work?
> 
> 	unsigned long cc_blob = boot_params->cc_blob_addres;
> 	struct cc_blob_sev_info *cc_info;
> 
> 	add_identity_map(cc_blob, cc_blob + sizeof(*cc_info));
> 
> 	cc_info = (struct cc_blob_sev_info *)cc_blob;
> 	add_identity_map(cc_info->cpuid_phys,
> 			 cc_info->cpuid_phys + cc_info->cpuid_len);

Yes, the cc->cpuid_phys cast is not needed, and your suggested implementation
is clearer and compiles/runs without any issues. I'll implement it this way for
the next spin. Thanks!
