Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8214763A0
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 21:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbhLOUoT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 15:44:19 -0500
Received: from mail-mw2nam10on2051.outbound.protection.outlook.com ([40.107.94.51]:32356
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235170AbhLOUoT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 15 Dec 2021 15:44:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYPY6rNmroqhvCmKgJvLjSRNtCktUziQ+ZtYRYFK/p1Ml86MUf6rswnQ1OkKSaTB+SmLiOhTCUB/uAdKVEoj+GCEHRHd95YGbUVrRCJr2BPTCtRpTfaEp8B61/jqhQlRP+MCWEQ5grCcgP9PRG8eIYiOGyHmbcaVlsevWNmhiAYMhBmFk5R57d/3sK/Vm528Fccowrf/4EYXJLO8YDs1fls8XcihXbyLl7vyY6j7TJoRCiQ8gyb7VmI87VOOEpXei0+lXqAVBSvQSCr3F0+h7PneObSp6tr50bvXJWostqIV00YI1nnJwmKP73ZDfeFKxhit1i2oxrbdlGDyOPbtGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZLona5DZ9C33MDnxdiWILaJcCR4MTePVXg0IaQsWsA=;
 b=kSASYt2P4huAVvejFEqq2eQftuRjfuvH9jKeI8dIHOMQU7+mHol+WcI8NdJBtbh9CfiAxUvkQQIuA/BEi1rMFCdYzNuJlum1kNf3Y7VmtZLQPUlu13KNVD4jxCU6blzy198MxzByIP5Rj669J1MXYJHKwDkVlmirsTSvhDIjaa0fHT5MjgckQEex0EI5Pb/fxZV/g22QxKHZy/nCLxaH1q9emlvwNR2U9Dd85ajAV5RThL+UgSsI4Yhgti0EZuGPObGK5ombMuFEYc79muPCcr47eLzS/zoO6PG7R/5O9xD0Wp4lhghmN3hKr7lU+tiVRYqexNd5x8mHXjEPloNiuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZLona5DZ9C33MDnxdiWILaJcCR4MTePVXg0IaQsWsA=;
 b=FlHa6KzeKkFtML7BbmtoAohjVMH8xBRbgk+u1K8ZH7gOBNMlyAYzj9miAnXBbx42IOk813RpkCeeZE9He7y5S4gfDMHZm0EPjUolf+wd2NDqeGLVY6Iyha3tUt5kY1NZeiuZZAyzFl9KjOhVQeBIckBN4pwiE+MB5J7ME6QXrTs=
Received: from DM5PR06CA0071.namprd06.prod.outlook.com (2603:10b6:3:37::33) by
 MN2PR12MB4990.namprd12.prod.outlook.com (2603:10b6:208:fe::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.13; Wed, 15 Dec 2021 20:44:16 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::1d) by DM5PR06CA0071.outlook.office365.com
 (2603:10b6:3:37::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Wed, 15 Dec 2021 20:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Wed, 15 Dec 2021 20:44:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 14:44:15 -0600
Date:   Wed, 15 Dec 2021 14:43:55 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Venu Busireddy <venu.busireddy@oracle.com>
CC:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        "Tobin Feldman-Fitzthum" <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <20211215204355.mbzfaxco6ltx3oty@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-2-brijesh.singh@amd.com>
 <YbeaX+FViak2mgHO@dt>
 <YbecS4Py2hAPBrTD@zn.tnic>
 <YbjYZtXlbRdUznUO@dt>
 <YbjsGHSUUwomjbpc@zn.tnic>
 <YbkzaiC31/DzO5Da@dt>
 <b18655e3-3922-2b5d-0c35-1dcfef568e4d@amd.com>
 <20211215174934.tgn3c7c4s3toelbq@amd.com>
 <YboxSPFGF0Cqo5Fh@dt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YboxSPFGF0Cqo5Fh@dt>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 562fe0ad-d9fb-4bc2-04be-08d9c00ba8ce
X-MS-TrafficTypeDiagnostic: MN2PR12MB4990:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4990C102E89CC93C6B79049795769@MN2PR12MB4990.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B++HUZaYswxIAHFNGJ2wfFcoyvcHB8ND1468XM03iqTmDxLlpQ+dK443iEaoA3ylpxGUUfQ5DaDDsYYCAWPUKXtW0cU4vZ+3QvldB4hqqxfQeEMjWnye+gSBbJGlUFkf29tcGWJgWZMXgUZjyon0k1ODCYiJVr+OY6Gsq90b9Gm1vjsPnphKJVX49szg75u+vPYAV2130MW8RIq+EVpuHinxyOQl1PuTDf6U2OwxP2VqcHqcKwdvUd0/aJNL34NQR/a1x3y9RaybuDYAsDRHwO80SmjzMx4pmR7ePv82Q7QF0vsYRPZI4UYmwTWrZElzFxR/30vxl0zf8Xd2WZM8jggsSi4+73B4m6pnumv/MTttLR23Q5azYaR1kalvJunDPeeN6vzcsviLzIMurT2kP46X1Ois4ujuXZwMVCI2keUaEM0LtcBNtJeaK7DuHDdTE5+1FTZtpDxGMcE3DtGRXae541eAEwfBg8SQvouDnsQSFLXQiCDRsOLxHiGsv7MYUTvSfd3l6N4UGQuzs9Up5Z2k26Rxs4yibQqOcsYqFTbiKYxPYv04q8lGP/bE3fW7hlSGhQIWjrzv037kzwSJS62QEE/bxusUHTGA/q77g24NnW+U305q6OcrguOyz1oeRzuU4TL037QfadT3g3hv/tpiLvl9WySbHi1i8E1xlUFadEo3YMr1ByrQu3W1xig7hYmRn2kb1KHKOcUW00z1uPRJgGQvWF9MXivF3OV537f+EBkn6U0SHHyFFbamTi71P2oYD82sY9OZFAIkJDEoGdDn6kL91XO6+CetrY+JxKk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(44832011)(70206006)(426003)(508600001)(4326008)(316002)(86362001)(40460700001)(82310400004)(54906003)(6916009)(356005)(81166007)(2616005)(8936002)(70586007)(6666004)(336012)(47076005)(5660300002)(1076003)(8676002)(4001150100001)(83380400001)(7406005)(7416002)(186003)(53546011)(36756003)(26005)(16526019)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 20:44:15.7789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 562fe0ad-d9fb-4bc2-04be-08d9c00ba8ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4990
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 15, 2021 at 12:17:44PM -0600, Venu Busireddy wrote:
> On 2021-12-15 11:49:34 -0600, Michael Roth wrote:
> > 
> > I think in the greater context of consolidating all the SME/SEV setup
> > and re-using code, this helper stands a high chance of eventually becoming
> > something more along the lines of sme_sev_parse_cpuid(), since otherwise
> > we'd end up re-introducing multiple helpers to parse the same 0x8000001F
> > fields if we ever need to process any of the other fields advertised in
> > there. Given that, it makes sense to reserve the return value as an
> > indication that either SEV or SME are enabled, and then have a
> > pass-by-pointer parameters list to collect the individual feature
> > bits/encryption mask for cases where SEV/SME are enabled, which are only
> > treated as valid if sme_sev_parse_cpuid() returns 0.
> > 
> > So Venu's original approach of passing the encryption mask by pointer
> > seems a little closer toward that end, but I also agree Tom's approach
> > is cleaner for the current code base, so I'm fine either way, just
> > figured I'd mention this.
> > 
> > I think needing to pass in the SME/SEV CPUID bits to tell the helper when
> > to parse encryption bit and when not to is a little bit awkward though.
> > If there's some agreement that this will ultimately serve the purpose of
> > handling all (or most) of SME/SEV-related CPUID parsing, then the caller
> > shouldn't really need to be aware of any individual bit positions.
> > Maybe a bool could handle that instead, e.g.:
> > 
> >   int get_me_bit(bool sev_only, ...)
> > 
> >   or
> > 
> >   int sme_sev_parse_cpuid(bool sev_only, ...)
> > 
> > where for boot/compressed sev_only=true, for kernel proper sev_only=false.
> 
> I can implement it this way too. But I am wondering if having a
> boolean argument limits us from handling any future additions to the
> bit positions.

That's the thing, we'll pretty much always want to parse cpuid in
boot/compressed if SEV is enabled, and in kernel proper if either SEV or
SME are enabled, because they both require, at a minimum, the c-bit
position. Extensions to either SEV/SME likely won't change this, but by
using CPUID feature masks to handle this it gives the impression that
this helper relies on individual features being present in the mask in
order for the corresponding fields to be parsed, when in reality it
boils down more to SEV features needing to be enabled earlier because
they don't trust the host during early boot.

I agree the boolean flag makes things a bit less readable without
checking the function prototype though. I was going to suggest 2
separate functions that use a common helper and hide away the
boolean, e.g:

  sev_parse_cpuid() //sev-only

and

  sme_parse_cpuid() //sev or sme

but the latter maybe is a bit misleading and I couldn't think of a
better name. It's really more like sev_sme_parse_cpuid(), but I'm
not sure that will fly. Maybe sme_parse_cpuid() is fine.

You could also just have it take an enum as the first arg though:

enum sev_parse_cpuid {
    SEV_PARSE_CPUID_SEV_ONLY = 0
    SEV_PARSE_CPUID_SME_ONLY //unused
    SEV_PARSE_CPUID_BOTH
}

Personally I still prefer the boolean but just some alternatives
you could consider otherwise.

> 
> Boris & Tom, which implementation would you prefer?
> 
> Venu
> 
> 
