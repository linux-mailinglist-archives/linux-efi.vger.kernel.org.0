Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6D4451635
	for <lists+linux-efi@lfdr.de>; Mon, 15 Nov 2021 22:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbhKOVRO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 16:17:14 -0500
Received: from mail-bn8nam12on2088.outbound.protection.outlook.com ([40.107.237.88]:65505
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349916AbhKOUUd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Nov 2021 15:20:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ei6eHucmFLDbpOOG/qk7Y3y0Ij3iG+e90arzGxiMuZ/kOhYfAMZrMh0aNa4tsrkLK64snD/fmIFzKbhjBRi3RCj2xPzTr4CjpDbNzn9F9tFr7Dds2Md8jpT8mmKpCsvhFAlfn2AS9cdxjInvBb5Jz9CPq5a/bVkxFiTed0mk4pC6KL8dX5TQy/hXDqdiTDtcRPqf9PJetcqFtQSJ2y2XPa3xONOuyVnQWwujaNEpyCTCjxVY/eYrwgiCUfhMaH8eJilw+lYARuxgmdRtJwPwoDQAejKrrWmX89dJuKiw7nWHDVmgXCF8FfRNg31D5YwlDEflkXJzvjrYNxS9Uc7LiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VVL8bqbWRpeB+XKJzbFZJrnmufTsmh+lfrCAKt9p2k=;
 b=nPTxCoLsEM8TSKA+M7/Ry6eiQNL4dNG05wj7DUGy13rn4nppMbhkC5a7MBvpdqbpkPXUWSU9dbqMSDFHQ5AlUB8vgVJ94s2rbRa9aM66deg608WF463XVdkxGsTg1wNYpkPtK70o9WEYoTHnGmwSE5RbkaxicgfTaY9wcswtdCwJPqj9y1jGiieW04FlMhNhjcrxmtm2wiitizUtfi49nuOcOcus8/zNE2XkbkauOgpHdW+yNNEdamWDqzySDqhx36bT77tJNz61PTEnQUGqID4pvbZu6k1y3we5yxav0jeB4BAAfK+hzZVqTml7NGzOblYDcRy26lHg2265cGZm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VVL8bqbWRpeB+XKJzbFZJrnmufTsmh+lfrCAKt9p2k=;
 b=F0VNP8fyOnKD8SinZzpr1PJUbssiAxUKxAiqk62Wm6AXrDaXsSpv52TGz+wFkrtLdlgQ9sC/XhiH8GLia34xxPvi5Xo5QQux3RbCH1RSrlr1xUE67nSkKD6ZnERDP8OJSuRbgG0OUMDLuBOD1QwXZirFXlBDPdzW+Mvu5qq9ylU=
Received: from BN6PR13CA0039.namprd13.prod.outlook.com (2603:10b6:404:13e::25)
 by DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Mon, 15 Nov
 2021 20:17:34 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::9d) by BN6PR13CA0039.outlook.office365.com
 (2603:10b6:404:13e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.16 via Frontend
 Transport; Mon, 15 Nov 2021 20:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 20:17:32 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 14:17:31 -0600
Date:   Mon, 15 Nov 2021 14:17:15 -0600
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
Subject: Re: [PATCH v7 02/45] x86/sev: detect/setup SEV/SME features earlier
 in boot
Message-ID: <20211115201715.gv24iugujwhxmrdp@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-3-brijesh.singh@amd.com>
 <YZKxCdhaFTTlSHAJ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YZKxCdhaFTTlSHAJ@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 029bca0d-ebec-4086-0cc7-08d9a874f4ca
X-MS-TrafficTypeDiagnostic: DM6PR12MB3435:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3435C345241F18C05A5413C295989@DM6PR12MB3435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ox7iGByGcFrN/9Q6stqLHzHcZ3iJBEiSuMgD6JnJBXyXPN/QsS7NrZMz55NZ5eLw9kIN8E0AzpkM6iHrk8WxW+Jvp2+89ugnJ0vzfz5CKyrHldgz2ZoW+QqJ1uV/SOivG/Mj5HtSlAPXZUIL8emkuqvTvP0CEiiu/oD1BlWP+/e/QhnXuS72HtSCNUp07hIpyB270MF1HbuKjWZ31ZcyLWiI8uIeQPdPzz2WZgQ3aLbUk6SHqeBIRo7MR6ON7wm2lCRAfilr6WxADxwY+Ebm8aATHYBwLeLsBr4nb06651f3FBzW1gNIxUeyYfsHLVH8AjEm7VMpyToXbGKC2ny2vWFdhXon48FNpDJc/VpGNQTOGI+j/MkwyUWT6MVV6dwcBRmi0VldKhgIwR9IyaQ9G07Ok0OUviJYKn3Zx0B/95VIs+9j1Ud8erip/xFY+H3JdpxbJS4CLbIAeVEMppb52qd/VJv1LUv5ELi0H9h1PhTlpsLHgNLF5dcPAe+HagVQ3TJ84fE/McanTaZzxrkucwH3lRCgMQplhkIqraIKoXO0jfuKDXGmlKg13kmB0l6T2c4M4or+9pum67dziecY8Ntunab+gmxslZJNRDpccL17lRvr6c7DOymlr03D8O0Z7TydRUNafVLWHYtKElpQHzU/HsCHmX2oXq5+L4nMG9FJ8lGt79boa/ukyv7jfTgKKK2qjV3rPaCyFzVJ6FlbHwDQDwWVhDWjBHLCFXzSXGzFf+BdaW4rBuLhw9W6rE3rhLjM7mmJ8GwwGI4FjWSFaVWxxJH6nas6DRtN0DBgSF8MTRfFkPuiqETDczD7YKkDtfy72IGDM+l6OJ1xtHLfE2dPjwOHLp2SdTbJB1gy/Xo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70206006)(36756003)(81166007)(2616005)(356005)(336012)(82310400003)(86362001)(5660300002)(16526019)(7416002)(7406005)(186003)(1076003)(26005)(47076005)(966005)(426003)(44832011)(36860700001)(45080400002)(508600001)(6666004)(4326008)(54906003)(8676002)(316002)(83380400001)(70586007)(2906002)(8936002)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 20:17:32.5731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 029bca0d-ebec-4086-0cc7-08d9a874f4ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3435
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Nov 15, 2021 at 08:12:09PM +0100, Borislav Petkov wrote:
> On Wed, Nov 10, 2021 at 04:06:48PM -0600, Brijesh Singh wrote:
> > From: Michael Roth <michael.roth@amd.com>
> > 
> > sme_enable() handles feature detection for both SEV and SME. Future
> > patches will also use it for SEV-SNP feature detection/setup, which
> > will need to be done immediately after the first #VC handler is set up.
> > Move it now in preparation.
> 
> I don't mind the move - what I miss is the reason why you're moving it
> up.

The early #VC handlers are needed mainly so that early cpuid instructions
can be handled for SEV-ES. In the case of SNP, the cpuid table needs to be
set up at the same time so those #VC handlers can handle cpuid lookups for
SEV-SNP guests. Previously in v6, that CPUID table setup was done with a
separate routine, snp_cpuid_init(), which was awkward because between
the point snp_cpuid_init() was called, and sme_enable() was called, we
were in an in-between state where some SEV-ES/SEV-SNP features were in
use, but they weren't actually sanity-checked against SEV status MSR and
CPUID bits until later in sme_enable(). I tried adding some of those checks
from sme_enable() into snp_cpuid_init(), but you'd suggested instead moving
the CPUID table setup into sme_enable() to avoid the duplication:

https://lore.kernel.org/linux-mm/20211027151325.v3w3nghq5z2o5dto@amd.com/

but in order for that to happen soon enough to make use of the CPUID
table for all CPUID intructions, it needs to be moved to just after the first
#VC handler is setup (where snp_cpuid_init() used to be in v6).

As for why CPUID table needs to be used for all CPUID, it's mainly so
that the CPUID values used throughout boot can be attested to later
if the guest owner validates the CPUID values in the CPUID page. I
added some documentation for why this is the case in:

 [PATCH 33/45] KVM: SEV: Add documentation for SEV-SNP CPUID Enforcement

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C29ab37203c1a4c796bdc08d9a86bd7a4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637726003477466910%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=xxIMC4PM7kJ2O79gQKK7I%2BhnOsuEbckVPA9Gicz0S9w%3D&amp;reserved=0
