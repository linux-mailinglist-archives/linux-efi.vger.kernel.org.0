Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3C7435881
	for <lists+linux-efi@lfdr.de>; Thu, 21 Oct 2021 04:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhJUCLK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 22:11:10 -0400
Received: from mail-dm6nam12on2075.outbound.protection.outlook.com ([40.107.243.75]:1889
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230434AbhJUCKz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 Oct 2021 22:10:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaJDy9Vc6fEkGNROhrKbn/a/kNx541uWVHrvUUQBH7nPMAscoF2dvNqoKt3PPK2/XODdJpeiY1WI8DziiwwlzcvtAaXQYP8UWbNh8WxRqCip6tXyKp1+GbelbmmMcyAS77F86omzvgx6vEX3wsEwPBWCpQ5lk8V/l4rXgdLx9p61yk8Xfl0DgblxJP0w3mmpX5DnMQLfWgm8kjQTDwLPe6Gt8UaFHKpfAw8vzHNEgNhiHNhLzlmZ+i3Lf58fQmMihL7/G4SRj2WJfIGJeCtYZxsNbYBleHmQWC/9hFD2Zkv3jVEwHGJCLkHXPSFL52OvkHBxs5OavjC9ZT4/p1H5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1RzmMIIB3nqJk/6Tx0FqgDSwx6GyRKM9zJqHSoLeBA=;
 b=P0TeHX3pCtZo4YcUw6dFYWyTBZM3wq61b1FbvO6Ou2t/xUcSUd+RUisnkHZawe40fDsUIcLVX+taFi4onwc+YrsjWS0cT3SvayUdP30IBSgBDnHmWSFsOS0OGAXTawa1AqSj6rtnXRd8i2QQlzfkLQQ0vSs+J4J9i0Cu8gQ8upjd+h0e23piQ+T32f82UEKQyM+McnOM/Rs+6KIJ65F534rMQ64fX+Xbm5LrcRsfZO56e5B119Dz2u/YpRN2SpKtRA4jqZMvTX97sHveOUxGxDytySh4FSNY9MNWZBzuTf7aTLc9EGommIpEtvx+VSMVeOqBjjov0btDDWxgVEBtog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1RzmMIIB3nqJk/6Tx0FqgDSwx6GyRKM9zJqHSoLeBA=;
 b=V+TWMTbDRVClHx2XlXekWlyHYyz++zOuA+DRV+vRaxNcDUnkuQqxwy8ke7Gcuyu8EaNQizggKVpR/muzc6Uvs0RnFjZV6iobNwLdP5a+0F/SUtJA7W8qG9nVsgt4erwxd9JT9wue2EyLcGHZLe9F/yt73gMMzFVToz2ZIIigI8I=
Received: from BN8PR12CA0022.namprd12.prod.outlook.com (2603:10b6:408:60::35)
 by BYAPR12MB3400.namprd12.prod.outlook.com (2603:10b6:a03:da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 02:08:33 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::9f) by BN8PR12CA0022.outlook.office365.com
 (2603:10b6:408:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Thu, 21 Oct 2021 02:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 02:08:33 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 20 Oct
 2021 21:08:31 -0500
Date:   Wed, 20 Oct 2021 21:05:42 -0500
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
Message-ID: <20211021020542.v5s7xr4s2j3gsale@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
 <YXBbJwd2M03Ssq6I@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YXBbJwd2M03Ssq6I@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e6e95bc-5f79-4d12-9267-08d99437af23
X-MS-TrafficTypeDiagnostic: BYAPR12MB3400:
X-Microsoft-Antispam-PRVS: <BYAPR12MB340082209E1F49E9E700BEC095BF9@BYAPR12MB3400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aAoPkf3XCznOOszTrb5mjCdcpHMO7YA7rz9nRGa3qBAP/RNUf3N1HiQeRbMg4mi5+58dNHQaV2S3CihT/n4cuMljg0ugkuWLwI+gLGCyME89rhpL9T0vou7P0BcEz5oRTFfgEnBgmhottUnllIlC10JJvdyzlO+gKehXMzOiI13qEk6w+vdCIQnH6aTceW49W9Sdts2jHzVvV0wKuIVWtoNK+U+nh59URokiNGCmy5rsdUM3Wi9g34dtoQDD5kdvmgjYUOwO1wFdZG6//bk8ah3s+u9Cvud8oVlkfHDTGZc1NlfGL48VIyT7av4L7QtKBeULXmmld4/F2im0Zhprpj/tjT7SYQxc+/2m1w+Bwc4nb4CYOTqiSSFAHFd0dz7+V+g9mOakIpkReTnCB5OTwhTBosj2BFqXLf5YW9MRYVsHPAFjnP0HwaxC0u7jlRI9gNZln4OACS8CMAIXe2QbWCFPJZwF9LL7MpPlbdJBmME0VBJIshCwqtViffRAav3oAA71AUQ7x9/ZblITZwBWpnTp1Q4P1Q1r6wjq3F/6QGfackduamxny9da2Fq7CWqfjeCUF+cpJCr9uqFpHOc5AfMjTNDF6WrYabuMCynORp0Qz7xwRCaR4u6WkiCtpMFb9bAj7cChonpB9KmABbIs6BIwaZYTamUXAhUNsH2TKb0n05nm51wdtoxXyVLoSajpUyg+H77FGW0b6g+q3HTzM0U95cMhbqFAX0ZkysoMu5u40sHiDfRXceM6wvCDjxKtqoy/C1ClSzeoUII/SwW/0uOhD22D6/SscG1stLGIBKM4m7ylhi0wBIsTOGnKrTkj
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(26005)(70586007)(70206006)(186003)(4326008)(8676002)(8936002)(6916009)(336012)(16526019)(47076005)(82310400003)(36756003)(966005)(508600001)(316002)(6666004)(54906003)(2906002)(81166007)(356005)(44832011)(36860700001)(426003)(2616005)(45080400002)(1076003)(5660300002)(83380400001)(7406005)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 02:08:33.0043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6e95bc-5f79-4d12-9267-08d99437af23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3400
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 20, 2021 at 08:08:39PM +0200, Borislav Petkov wrote:
> On Wed, Oct 20, 2021 at 11:10:23AM -0500, Michael Roth wrote:
> > > 1. Code checks SME/SEV support leaf. HV lies and says there's none. So
> > > guest doesn't boot encrypted. Oh well, not a big deal, the cloud vendor
> > > won't be able to give confidentiality to its users => users go away or
> > > do unencrypted like now.
> > > 
> > > Problem is solved by political and economical pressure.
> > > 
> > > 2. Check SEV and SME bit. HV lies here. Oh well, same as the above.
> > 
> > I'd be worried about the possibility that, through some additional exploits
> > or failures in the attestation flow,
> 
> Well, that puts forward an important question: how do you verify
> *reliably* that this is an SNP guest?
> 
> - attestation?
> 
> - CPUID?
> 
> - anything else?
> 
> I don't see this written down anywhere. Because this assumption will
> guide the design in the kernel.

According to the APM at least, (Rev 3.37, 15.34.10, "SEV_STATUS MSR"), the
SEV MSR is the appropriate source for guests to use. This is what is used
in the EFI code as well. So that seems to be the right way to make the
initial determination.

There's a dependency there on the SEV CPUID bit however, since setting the
bit to 0 would generally result in a guest skipping the SEV MSR read and
assuming 0. So for SNP it would be more reliable to make use of the CPUID
table at that point, since it's less-susceptible to manipulation, or do the
#VC-based SEV MSR read (or both).

> 
> > a guest owner was tricked into booting unencrypted on a compromised
> > host and exposing their secrets. Their attestation process might even
> > do some additional CPUID sanity checks, which would at the point
> > be via the SNP CPUID table and look legitimate, unaware that the
> > kernel didn't actually use the SNP CPUID table until after 0x8000001F
> > was parsed (if we were to only initialize it after/as-part-of
> > sme_enable()).
> 
> So what happens with that guest owner later?
> 
> How is she to notice that she booted unencrypted?

Fully-unencrypted should result in a crash due to the reasons below.

But there may exist some carefully crafted outside influences that could
goad the guest into, perhaps, not marking certain pages as private. The
best that can be done to prevent that is to audit/harden all the code in the
boot stack so that it is less susceptible to that kind of outside
manipulation (via mechanisms like SEV-ES, SNP page validation, SNP CPUID
table, SNP restricted injection, etc.)

Then of course that boot stack needs to be part of the attestation process
to provide any meaningful assurances about the resulting guest state.

Outside of the boot stack the guest owner might take some extra precautions.
Perhaps custom some kernel driver to verify encryption/validated status of
guest pages, some checks against the CPUID table to verify it contains sane
values, but not really worth speculating on that aspect as it will be
ultimately dependent on how the cloud vendor decides to handle things after
boot.

> 
> > Fortunately in this scenario I think the guest kernel actually would fail to
> > boot due to the SNP hardware unconditionally treating code/page tables as
> > encrypted pages. I tested some of these scenarios just to check, but not
> > all, and I still don't feel confident enough about it to say that there's
> > not some way to exploit this by someone who is more clever/persistant than
> > me.
> 
> All this design needs to be preceded with: "We protect against cases A,
> B and C and not against D, E, etc."
> 
> So that it is clear to all parties involved what we're working with and
> what we're protecting against and what we're *not* protecting against.

That would indeed be useful. Perhaps as a nice big comment in sme_enable()
and/or the proposed sev_init() so that those invariants can be maintained,
or updated in sync with future changes. I'll look into that for the next
spin and check with Brijesh on the details.

> 
> End of mail 2, more later.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C70ce657823a441516fc808d993f4a402%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637703501243595370%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=nIqCXolZUNWTV6eBfLscXRfQDWJZk5fwBMghKVbIeaw%3D&amp;reserved=0
