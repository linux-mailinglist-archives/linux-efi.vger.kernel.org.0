Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E5F436CCD
	for <lists+linux-efi@lfdr.de>; Thu, 21 Oct 2021 23:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhJUVhe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Oct 2021 17:37:34 -0400
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com ([40.107.93.43]:6496
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231625AbhJUVhd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 21 Oct 2021 17:37:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyBH9nIa94f9a2+Pd4uEIq1sYo4cQaX5vjFQrNwQtvvOt6nJaOT9987PVIVpJQPGgQQ+kpF9TUWGdXT8i4P2BOLDgJxTOIuJHvsE9tit85Sk/8DUWw6GFuXRn9csJ6Mf58xYwU2yr+2mxzODYIZI/O9wpCkWv2W7NYmhqNcqpQdSqDbKWFHo/uovFqLN7iTt0Gk9J2+ZvYXKbp2OjLa2eFYAWk4bi2pZA8X0txpSd2Efz6zOStfbeguEqcRrT/jBsGYzmPb2ZXgv1bLo2ZeaCj7mmIMFnemR2rQPjMm4grIvXv0pAz3jszF/7c87W2IooRWDPQnyxANt/6zHaFYIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6aMx7oynnYv5s+GYx7k+1rQa3KHe2r0UL2mrI7XuM4=;
 b=b/3NBVIuBb1Hu9wPHYKy0Ig530/P3sbeyT4Bhte8MGinzuw2DjZzaD0p3OxtRniH9+OPOtA7ZDP9QjMhwL8OjF0X0FZcUa/sif05INXxtepyjEPr1xN0DtjDzmteYDce9foT1zsv6owMusuVXll2/qOgzzmLDtzhppIbBo6Lwc4Yneya03Bu286OHKnFWcIUnxHSQKSy/QXAn/fsLvfKDLu0cUYgsJHEnb7T3nu+om7yjjqLrcoux4pwN4zEC20+JxRR7f7ADcXKDeyiMvDEKhcXl7yRRsQCU3GfLWOuDFI/al4FoJQT3HoJ8q1ZHpSiGGxiGL5wzC184uyvGAHu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6aMx7oynnYv5s+GYx7k+1rQa3KHe2r0UL2mrI7XuM4=;
 b=2a4npdpm+eP6yuhPJQyh4XVKsZdkFzgfmCb4WQd/EwnCW77Atczia4hnkAD3PkB8qfVJx7rXTpcEqn4ObJ0DFe3vMV2Isn8KWTL3HObiRicc/cnvIsYzWOiXtk0N40/8DipJrqnioH4kTa/ZHgLueMGrU0TAyncsgzj8qB0tqn8=
Received: from CO1PR15CA0066.namprd15.prod.outlook.com (2603:10b6:101:1f::34)
 by DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 21:35:13 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:1f:cafe::ba) by CO1PR15CA0066.outlook.office365.com
 (2603:10b6:101:1f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Thu, 21 Oct 2021 21:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 21:35:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 16:35:08 -0500
Date:   Thu, 21 Oct 2021 16:34:27 -0500
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
Message-ID: <20211021213427.at2mqwv3ruj2eihb@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
 <YXF9sCbPDsLwlm42@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YXF9sCbPDsLwlm42@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 903e9f25-cd05-4aa2-eff7-08d994daa9e7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1323:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1323D95010A4D3DE062E84BD95BF9@DM5PR12MB1323.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhdW+QVJshqjV8L/XEaH9XlgNrTi4HcTwd1rMtMIVAZHqj/dZENuiqnqNSafWg6Fjz5stAPD84+GOk10AA2/9kkm5K7sXqOOXYMjXbMWjaPZP07YWxabCDfFl11VfBhEhK3VpVoufGJpX2lH779j6P1QBkuM1HkCOIKqX1mpdJhDcROI3AmGw49naSEdXDNI7brd4ID9dyWIRDes9nlvyvUrIc9vjUsDWz7HCn7RqsKuoiTwLrpIMzzza8H339j396F0Tcc0WsmfrEGJrH+vMblg++KJ+lLWQnAW5uFu5X03gAIek8BOfQuWoDc1IPlLb6yLpv675j95IFrSuBo1T2rnlNGZf04KSfYGNE2TMou2Cko0kN3Th5p4mj15baY1MOoG+ZYmease4sKe9d689H6Uu75mnhjk+nEIUSp3zQuO650ziTifm6giJvVplsQFH2dht2VFUJO751LQtGsWxrOQd8B8NUPAOQHVifYg+IaRGzO7kbAG++QN5QqIG3yb1O4lzrkij4KDSiuhVjj+ZT1c3UeOSEPBnQ4sdLMoAY/EQxT2jHQLBzVlpOU/5bFCHTpvJagzyWA5elW6ThaDFgWnk4FscVUXfX8GkTbn34MUHPRsVAN0ZNpWgdWwc+w15Ej0Cq4JfhTUCAWxF2YrUhadyKGSnpCiDb1v2cJfnn7iDIc59oIoTjCANFb+L0PWR9i0sKHDRDdAUeLPrAsU8ejfsyhidCgnnqyGJimH9sCitbGweUU7GSXF0sXk+ElQMbaVfkeeksNzBsHfJRC8n/BW47vuVeMv0VTfLdDc0pMmpGbQRq0ocCrq/RA8cN7/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70586007)(70206006)(83380400001)(966005)(426003)(7416002)(26005)(508600001)(186003)(16526019)(82310400003)(5660300002)(6916009)(4326008)(316002)(54906003)(47076005)(45080400002)(8936002)(356005)(86362001)(36860700001)(81166007)(6666004)(2906002)(44832011)(7406005)(2616005)(8676002)(1076003)(36756003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 21:35:12.2347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 903e9f25-cd05-4aa2-eff7-08d994daa9e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1323
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 21, 2021 at 04:48:16PM +0200, Borislav Petkov wrote:
> On Wed, Oct 20, 2021 at 11:10:23AM -0500, Michael Roth wrote:
> > At which point we then switch to using the CPUID table? But at that
> > point all the previous CPUID checks, both SEV-related/non-SEV-related,
> > are now possibly not consistent with what's in the CPUID table. Do we
> > then revalidate?
> 
> Well, that's a tough question. That's basically the same question as,
> does Linux support heterogeneous cores and can it handle hardware
> features which get enabled after boot. The perfect example is, late
> microcode loading which changes CPUID bits and adds new functionality.
> 
> And the answer to that is, well, hard. You need to decide this on a
> case-by-case basis.
> 
> But isn't it that the SNP CPUID page will be parsed early enough anyway
> so that kernel proper will see only SNP CPUID info and init properly
> using that?

At the time I wrote that I thought you were suggesting moving the SNP CPUID
table initialization to where sme_enable() is in current upstream, so it
seemed worth mentioning, but since the idea was actually to move all the
sev_status initialization in sme_enable() earlier in the code to where
SNP CPUID table init needs to happen (before first cpuid calls are made), I
this scenario is avoided.

> 
> > Even a non-malicious hypervisor might provide inconsistent values
> > between the two sources due to bugs, or SNP validation suppressing
> > certain feature bits that hypervisor otherwise exposes, etc.
> 
> There's also migration, lemme point to a very recent example:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20211021104744.24126-1-jane.malalane%40citrix.com&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C4aaa998fcd134c8d054608d994a1d1aa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637704245057316093%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=OKO9o3YzKwRkyWPpam2%2Fxn4aRSMKtPEnZjn05g81SP8%3D&amp;reserved=0
> 
> which is exactly what you say - a non-malicious HV taking care of its
> migration pool. So how do you handle that?

I concur with David's assessment on that solution being compatible with
CPUID enforcement policy. But it's certainly something to consider more
generally.

Fortunately I think I misspoke earlier, I thought there was a case or 2
where bits were suppressed, rather than causing a validation failure,
but looking back through the PPR I doesn't seem like that's actually the
case. Which is good, since that would indeed be painful to deal with in
the context of migration.
