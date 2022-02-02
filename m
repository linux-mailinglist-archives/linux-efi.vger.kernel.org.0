Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BBC4A76D7
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 18:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiBBR2Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 12:28:24 -0500
Received: from mail-dm6nam08on2078.outbound.protection.outlook.com ([40.107.102.78]:56929
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229588AbiBBR2X (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Feb 2022 12:28:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZPtAmdAqoStTJ7NC5rbXd4cfUdHilh99bfscc3DAkkPi5salfAdZhbvzoLl8NT2+LXzw9B2vW2NdlNGENfCHjeADKr0gIf8X3inZvH0LVfOqAErDZUeI/KuecLuQXz/dP3+LQTpwhEHK2eTFRqRM25G34p0v8CvgaJz4GJ1LZKJA1HocE1NcGKFGsozOhII11wTw68csbCEkx+UKobo/xrPwLAC3bRLPdfOyeJgILpeGMc8Iq5XrSyDrMaFS5mGN1pcm3Q4fYwEFYxFG0wavB6dOnz1Ow0C8nbUl/9nLEKDLLOeemmMC+ItumY7+ye3Bw9fPmlskIx6JDIXc//HNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyWDAk54qqiEQMhQDyIoYwm6klf4P4e3MEWGlvNJvSQ=;
 b=cKFxEnzLDX2lfKKXu79rli7wHJ0L0fWEVSHCkv5mJ7o5NfTCH1JkCdDvie9wnr6/fw1MF3qlAwYPz4oiGbZpT0RknMJIKNTZGS2+vw32nES1bBurxcq+AL2OAiERs2zJ7UZHnsztiHSnr9Mi+nufKq4PBcBqCMv9dYwbzedDqUTQ1yco//hhKTNnCPBPjh/oiNuwYLi5TTUeibIjsqcUo700R+ESMZSkWenAAl3TaDDYRo4PBVSd7Vy2EHPoCx18KoRYy+f2NkYnK4voxB3b53JhHosT6+OlMGoiGalcEke/IHAGQQyhjZxIRh+InZQPi8+xzoYP75dvsIOOtiZTpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyWDAk54qqiEQMhQDyIoYwm6klf4P4e3MEWGlvNJvSQ=;
 b=iy7kD0VCwx4euFv+5RR38NqjMSQUloJ1ZYZGr63FRTlJj2fXJLH2rEnINojkovRCkcL4q2VOxtTp963JiMfFJN6Jc2CTb7zwoOXMQXdvksBx0hALdU2IlnmFnB/pBwKZB3qfDvCoS4iEyUGaPJNQTFSRfsU0tMk7Ji8dNGXXNrg=
Received: from BN6PR1401CA0018.namprd14.prod.outlook.com
 (2603:10b6:405:4b::28) by MN2PR12MB4207.namprd12.prod.outlook.com
 (2603:10b6:208:1d9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 17:28:20 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::f0) by BN6PR1401CA0018.outlook.office365.com
 (2603:10b6:405:4b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Wed, 2 Feb 2022 17:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 2 Feb 2022 17:28:19 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Feb
 2022 11:28:18 -0600
Date:   Wed, 2 Feb 2022 11:28:01 -0600
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
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v9 05/43] x86/compressed/64: Detect/setup SEV/SME
 features earlier in boot
Message-ID: <20220202172801.4plsgy5ispu2bi7c@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-6-brijesh.singh@amd.com>
 <Yfl3FaTGPxE7qMCq@zn.tnic>
 <20220201203507.goibbaln6dxyoogv@amd.com>
 <YfmmBykN2s0HsiAJ@zn.tnic>
 <20220202005212.a3fnn6i76ko6u6t5@amd.com>
 <YfogFFOoHvCV+/2Y@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YfogFFOoHvCV+/2Y@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62bee106-c2e2-4269-136a-08d9e67167c7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4207:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB420744992AB681F813DD3BA695279@MN2PR12MB4207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9cP6IXXLhASjZrHYzhjg/hsYwk6NdNoAit6a2tIfzMOknRM5NuYetOes+qSY1prZIeGI3bHpTK1Gzb+nXpKrDU9nQvr3r6CsRIxMa8sucIjUcYd0q9zizPo7HPqrGL7w1wsMemVtRAP4LjVLgavW0E5whTXHMtQ0RjWcc3iwj08Z8QXmRd7VfjHV575akDMrHAm0PSFsbobNgrZwZkvZwRy74FXUH02YkqRGK53/puHPe9JRYXIsmqTzhc2De7rQvpX8myw61ORJDZUNMIf3U3VOzsx3+HyO7Wt3ANfNygcMk3I6+R0YJN7oeu0HmC+NvrND/vpay2wcQl1jR2rsfzTF/RabRTOSUGDcP85pmIDRJcmGBmv08KHP/TX7Clqi6D2eAJdYgwyC7J3gcK2C89NmvBXPHbvTMBHaH+ICEpmqFvBSWn9Xeji21X1bRqMSgozfBJQIlt2iKxS6/ewfontkuw+3ajU6xES6QCbwp1d1zgZts3HomxV48qLcfnP1LvyTQ83E7cAMnqEwVIUvVyNv0P9wCfP/YqmT29rTDbqXN6ZQfdq0afGy4MZxVCYQWxdPeaY3tWR/iv5dw3g/Ucy83S6zLG2piw59ZWEtJf377rM4jid7Xz1w227Dy1fYA/AAy3fJAnhX0sVOae15QLUDPbMKLQK3YIySAoM41qApdDYk4abaTLeSakLAlliEgYG4Xmf/TB8MqWjlxzl4qA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(54906003)(6916009)(7406005)(36860700001)(82310400004)(5660300002)(316002)(508600001)(7416002)(70206006)(6666004)(70586007)(26005)(186003)(356005)(44832011)(1076003)(16526019)(4326008)(8676002)(336012)(426003)(2906002)(8936002)(2616005)(40460700003)(81166007)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 17:28:19.5647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bee106-c2e2-4269-136a-08d9e67167c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 02, 2022 at 07:09:24AM +0100, Borislav Petkov wrote:
> On Tue, Feb 01, 2022 at 06:52:12PM -0600, Michael Roth wrote:
> > Since the kernel proper rdmsr()/wrmsr() definitions are getting pulled in via
> > misc.h, I have to use a different name to avoid compiler errors. For now I've
> > gone with rd_msr()/wr_msr(), but no problem changing those if needed.
> 
> Does that fix it too?
> 
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 16ed360b6692..346c46d072c8 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -21,7 +21,6 @@
>  
>  #include <linux/linkage.h>
>  #include <linux/screen_info.h>
> -#include <linux/elf.h>
>  #include <linux/io.h>
>  #include <asm/page.h>
>  #include <asm/boot.h>
> ---
> 
> This is exactly what I mean with a multi-year effort of untangling what
> has been mindlessly mixed in over the years...

Indeed... it looks like linux/{elf,io,efi,acpi}.h all end up pulling in
kernel proper's rdmsr()/wrmsr() definitions, and pulling them out ends up
breaking a bunch of other stuff, so I think we might be stuck using a
different name like rd_msr()/wr_msr() in the meantime.
