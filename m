Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A7A436CC2
	for <lists+linux-efi@lfdr.de>; Thu, 21 Oct 2021 23:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhJUVhN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Oct 2021 17:37:13 -0400
Received: from mail-dm6nam10on2086.outbound.protection.outlook.com ([40.107.93.86]:51329
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230340AbhJUVhM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 21 Oct 2021 17:37:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfTqnm+TQkFYZubWykU4rNbJgmYMFZEc50F0mYBo245e4QjNt9q+W0AYMoyAzEjy25iGiw82c8XTFFcG2w39gL7DQsX4jx0mJuhKIPkTbGHSJplxEnQp3U33pZY3vx6ufyAF/cGVYxUgto0spuyBBEkX41G6OM+A0tDOeiAc6GjwdXviUaCOKzq7kJHvc++0p+ZXRxczseJSCxBu8Y7PbX6cZM51eTShrTsx2YdKIvYIhU0KlXPl221Rh5vtdUOAg4OYtRbA+0BDAVTEIHtxWzNF5DtZ5N6vYkeduNRsfBfxKjxqYGOmiCJfP+P/a8SZpengzLd1LTULdffeOwMBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQSWunhr+oMpucU0bq+d8M5GXwsurEZDvlo4o1xDboU=;
 b=UmhsjGhh34c4aFurVstO9cQzDjVbt3TgMMDEAF+vu0iu1XQv6nUAeac5Nv+USu92DtWumeZsEzdA7k+tN7Vbjj/MbV2bW6n+AIw9MngFZk8ekMBzc1RJA3/s2DU2fIFz9SLfO/W++8Mb0bmZsah+72gutzorRfSPo8tmvXuRcjIM0JIq0YhNFqia4e+ccbZOXoWgjVz8tXxNDjsbmuQtjvxie7MQmerJ6K66MzegpXkCIraHZKv4mB70z2UtZA4VSv+EvtzAirezT9HrMYx5SQBhXTXFxAFCSoPPEkyXSD+gf7oA/5+HtjnCIHSuECU64jQvl62VohYmKyiXT0iJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQSWunhr+oMpucU0bq+d8M5GXwsurEZDvlo4o1xDboU=;
 b=YiqAtn8KYP8/GGn+xAzo4rKSPO2hQeu6qg33uzD/KYlO4+DkGiAyfbI3KF+SDKnmRPzYvPdfQgSSyVb7SzWRU6/qcv+jl1JSMFS7zgxpDrV+zSsHec/vBEXH5fsL845nMXyGMVSRdrXWK96w5eg8o2Kid1v6ZqxIQgP9NS261xA=
Received: from MW4PR03CA0257.namprd03.prod.outlook.com (2603:10b6:303:b4::22)
 by BN6PR12MB1939.namprd12.prod.outlook.com (2603:10b6:404:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 21:34:51 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::41) by MW4PR03CA0257.outlook.office365.com
 (2603:10b6:303:b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Thu, 21 Oct 2021 21:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 21:34:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 16:34:47 -0500
Date:   Thu, 21 Oct 2021 15:41:49 -0500
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
Subject: Re: [PATCH v6 08/42] x86/sev-es: initialize sev_status/features
 within #VC handler
Message-ID: <20211021204149.pof2exhwkzy2zqrg@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
 <YXF+WjMHW/dd0Wb6@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YXF+WjMHW/dd0Wb6@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8b9ee77-f2f0-41d5-6b13-08d994da9c1c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1939:
X-Microsoft-Antispam-PRVS: <BN6PR12MB193918634C445E8CCBC1DDC095BF9@BN6PR12MB1939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpMVGqPRcDJEHa2Okm7+Wc5EQr5Kf/j/SldppDnQ4UcTgxifNW/RavGo4wMz4JOhP0I+OWJMCp2TQgJgaydtPOc+0Ueb7XtugTawJ752sKlFckIzY0cHDa6FXbQ1RySJrTfQ7mpBkUJOSBIyp2G9QQORIs2r4wLa3qnA3gXtduzj1iNSDzhUNqsHzdTxazJUv1z3onTnot94iYHtyVeGaQW+fip34xuvhyCcPj2CzW1cJ5mo+7sPhVZSgU9QTyIT2TYUlxVOoCP9jvS7Njg4yGfggs1dyS+mrpwflK3Sgs4mooZdg7LDFD3Yybhcm1jzzRfw+1/SwjZDcJjr/PFFvD9lR63hneK+VHmYekuGQL+CjqswB3t2UnHBtbbhoho1gx+1y3dn2gCh5XBqFulZiBwV1kiNPzOwkNTTAwRx/HX40bKu1bAo5kjqrX8Z76Qmfw46qBjY/9QGD9mdVHSEBXclwA5ydoCvowxk7r64BlSH7FPIAtJ0TG13RxovtHj/cVcQGlWCNny6RfT4KS+HrZcRMtLLY4SZLhYmG2TaDfGnH+PLROd8PPXJfMBfmtUWTFATmSfRINuf5SW29VrumDZ3sn93QObfNN1Xh7cvnIjpFSTOyHU5kfhQRWJ3qy6y0Uf5dGR7JS79uMHIYnv9RVjVIocdDhXdPs1Js3HETok/ySNPQlf4WLP3Vl1Xr9V2O0v6PX77Ns25lf+6JQW3luLgztJG3YHpFEvRzpH1vfWO4ok2zccHEZkBXynvNRgk7h0LEaf8X9T/OlntXhJXqX+sEUtvGta6mn3sfRgIItjitNcLXV6LoA5qDsQQC368
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(70586007)(70206006)(16526019)(47076005)(82310400003)(508600001)(4326008)(186003)(8676002)(426003)(36860700001)(6916009)(1076003)(86362001)(356005)(26005)(44832011)(8936002)(336012)(54906003)(966005)(2906002)(83380400001)(36756003)(316002)(2616005)(7416002)(5660300002)(45080400002)(7406005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 21:34:49.0886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b9ee77-f2f0-41d5-6b13-08d994da9c1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1939
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 21, 2021 at 04:51:06PM +0200, Borislav Petkov wrote:
> On Wed, Oct 20, 2021 at 11:10:23AM -0500, Michael Roth wrote:
> > The CPUID calls in snp_cpuid_init() weren't added specifically to induce
> > the #VC-based SEV MSR read, they were added only because I thought the
> > gist of your earlier suggestions were to do more validation against the
> > CPUID table advertised by EFI
> 
> Well, if EFI is providing us with the CPUID table, who verified it? The
> attestation process? Is it signed with the AMD platform key?

For CPUID table pages, the only thing that's assured/attested to by firmware
is that:

 1) it is present at the expected guest physical address (that address
    is generally baked into the EFI firmware, which *is* attested to)
 2) its contents have been validated by the PSP against the current host
    CPUID capabilities as defined by the AMD PPR (Publication #55898),
    Section 2.1.5.3, "CPUID Policy Enforcement"
 3) it is encrypted with the guest key
 4) it is in a validated state at launch

The actual contents of the CPUID table are *not* attested to, so in theory
it can still be manipulated by a malicious hypervisor as part of the initial
SNP_LAUNCH_UPDATE firmware commands that provides the initial plain-text
encoding of the CPUID table that is provided to the PSP via
SNP_LAUNCH_UPDATE. It's also not signed in any way (apparently there were
some security reasons for that decision, though I don't know the full
details).

[A guest owner can still validate their CPUID values against known good
ones as part of their attestation flow, but that is not part of the
attestation report as reported by SNP firmware. (So long as there is some
care taken to ensure the source of the CPUID values visible to
userspace/guest attestion process are the same as what was used by the boot
stack: i.e. EFI/bootloader/kernel all use the CPUID page at that same
initial address, or in cases where a copy is used, that copy is placed in
encrypted/private/validated guest memory so it can't be tampered with during
boot.]

So, while it's more difficult to do, and the scope of influence is reduced,
there are still some games that can be played to mess with boot via
manipulation of the initial CPUID table values, so long as they are within
the constraints set by the CPUID enforcement policy defined in the PPR.

Unfortunately, the presence of the SEV/SEV-ES/SEV-SNP bits in 0x8000001F,
EAX, are not enforced by PSP. The only thing enforced there is that the
hypervisor cannot advertise bits that aren't supported by hardware. So
no matter how much the boot stack is trusted, the CPUID table does not
inherit that trust, and even values that we *know* should be true should be
verified rather than assumed.

But I think there are a couple approaches for verifying this is an SNP
guest that are robust against this sort of scenario. You've touched on
some of them in your other replies, so I'll respond there.

> 
> Because if we can verify the firmware is ok, then we can trust the CPUID
> page, right?
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CMichael.Roth%40amd.com%7C155dd6f54f3e4de017a908d994a236a5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637704246794699901%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=U%2BS%2B%2F8%2BX8zLvPQGWvsOb7o6sKBz1MOZqU%2BVLKHiwugY%3D&amp;reserved=0
