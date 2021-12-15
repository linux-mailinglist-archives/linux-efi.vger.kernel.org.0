Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8312E47647F
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 22:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhLOVXX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 16:23:23 -0500
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com ([40.107.243.54]:44320
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229555AbhLOVXW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 15 Dec 2021 16:23:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXBRSd0g1WoxtjIDFejv41jgG7hM2p4eA5tb4cA0DlSiQvZsej3Zy/QIvqnH8fbTAJLQqr1E3jAUsy/Iap3JIzV7WcADwNx0oumXU5nQ3vVsVJcS7Gos1pv5CwvLf5oBUeePnTmqb6vBoUjsHZA2e/wckPNFkjx22Ls4w65obCXb0HEA6Z1AXxGNkUPbITrnBUAqS2CPGMNWoKbCWCQ+WpTZdD6apsyVtQKUpcSvKw4+Qwyp8dQyiK7ZfAUtpdT96vwWDKSp2bcSXNQuEZldVCvl++UCx0Zi6wjqKKbOub+2u0sl/B+q+DHIhEITlr+qfKGUwpW/KJX8ESonsvkGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fph5THDqtk98ym810JEJEXyo/NwyePPMv/lxgiWbhAQ=;
 b=APpGBP+IlpTysKN88FcJl1/IQb994FAeipaNXG1zgW8O1QnY79zcBanOR3iiv13yp0NDrgabw5qqwDJ2Ukel/4LM9jGuZxy9ECF4BrLgHOlEj5xwPHDpRXqJ+2baPVsdgYQ9zwjMNzrSk7d7R83XWze2CyO0rwZhxxU8ftZzhFaSgXOWiLmAVpjxzJl5+D/IvBYqKaefmqE4XjpewmwFI7nCX31+5NGi5Dw5/02+OwcUqlxjyyUwOwIYKtTijUeqoOSlKuEKh39+RxuYDru1iD/wWKWKnL0EYh8QTFAPo6KGplj7x+9n3DM6C4s9RjVQ+CYPYOIcxlX95D8Wo3O4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fph5THDqtk98ym810JEJEXyo/NwyePPMv/lxgiWbhAQ=;
 b=H7dUAv7BywPy81qTwTC5b54cjA0BuOYiW7qiS8MYu/bAr5WI0fmGkImKVmgVBERae+n21NstizooK95EijWGb64NpMKNw8U4G8YbaUo6qzfrSYY5jtMegVupMgtD/5xiZrqcvzzbBkTOaRduCM3sbfnJthEvQNLTYbuQoJmKqxk=
Received: from DM5PR19CA0062.namprd19.prod.outlook.com (2603:10b6:3:116::24)
 by BN6PR12MB1313.namprd12.prod.outlook.com (2603:10b6:404:18::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Wed, 15 Dec
 2021 21:23:18 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::5c) by DM5PR19CA0062.outlook.office365.com
 (2603:10b6:3:116::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Wed, 15 Dec 2021 21:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Wed, 15 Dec 2021 21:23:17 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 15:23:16 -0600
Date:   Wed, 15 Dec 2021 15:22:57 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Venu Busireddy <venu.busireddy@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
Message-ID: <20211215212257.r4xisg2tyiwdeleh@amd.com>
References: <YbecS4Py2hAPBrTD@zn.tnic>
 <YbjYZtXlbRdUznUO@dt>
 <YbjsGHSUUwomjbpc@zn.tnic>
 <YbkzaiC31/DzO5Da@dt>
 <b18655e3-3922-2b5d-0c35-1dcfef568e4d@amd.com>
 <20211215174934.tgn3c7c4s3toelbq@amd.com>
 <YboxSPFGF0Cqo5Fh@dt>
 <Ybo1C6kpcPJBzMGq@zn.tnic>
 <20211215201734.glq5gsle6crj25sf@amd.com>
 <YbpSX4/WGsXpX6n0@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YbpSX4/WGsXpX6n0@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03e0197a-b84c-44df-3b3d-08d9c0111c8c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1313:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB13130BB07C755B878AC06CC095769@BN6PR12MB1313.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYP2LTdOkRe38Lixu6kbYbEDJpPCmHcd8EZjk0MD0+lIfY1Vwk/QyaQC4QoM8HpO/zpmF+Xi5Yl/Ena2u0+R3uuNi6lARQEc654bMoR7HywGV12A6wHWcz5uwDSFx/DqCtIkxJALE3FhcChBb9uJT7sqYu/kJVZBMWlUmPwkLDoHSafQGEvrt4Pen647hUcX/RO7bBCASRRvgghhaG0sLVsuJUy1BpuKMBx5v3sdAfaGEbTm6UJ+sjpYeiLnzvaMmzAhI5s3bzsiMiOK3WIYSpERFaikTPjvbJAjvCerI1caL5ns1voHso0Iy1Udhqk8uoO8st4/os6v/uh6APJnlHUiQ2IEBGjG9QoqWDNd2Gda+2r4QoMP4L6pj4njxoM2iXRJWOs0bZQU7VQJeqhIKGVax/425n2Wn0bmwnrVsXdrjt3BwQcdVjfE0vTs3fzyQ7hHTck5yZnaOtWMDkKif7WUVnnDWmh0IWWhOlRj5GadQZOk+UUEkXV9+tzwKP3y1wTivtS46a2fNx/Sgz8tq91WvnfGBasePwbdNZgEycr1w4c2NQfuQXVx7Slz/FABVP14ro1BUFGvtIuojb/YlZbV9mVoBF1VhSk/X3dCHIhYnnRlqULW/Dtz8XHFPHMA7fzQmWZBnAFz5ISDdYZaSSPxWBDlZSpXVLLP84IrtDmQKnZuy+TIXmVICnL764YlnmUCYpz1oyYVW4ShKJlPlx2ncCDW7CVLGlI3Uyxu8rF4iEV0mZdmNwAI88qvn9xNBppDTMhmke3clv0yEYAn3Q/ulUmcmXtEGTSdW4j9qqBDAyp0dn2iQXUKd6LrESC3fHaodvI3NHgGIATq5M9DcD+jVlt3nj1EwWk6LJpbfT+cv1k9K8aILfpeEEa/hJTH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(36860700001)(16526019)(186003)(508600001)(26005)(336012)(1076003)(316002)(45080400002)(426003)(83380400001)(6916009)(966005)(2906002)(47076005)(70206006)(7416002)(8936002)(40460700001)(5660300002)(7406005)(86362001)(36756003)(70586007)(44832011)(8676002)(82310400004)(81166007)(4326008)(54906003)(356005)(2616005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 21:23:17.4783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e0197a-b84c-44df-3b3d-08d9c0111c8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1313
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 15, 2021 at 09:38:55PM +0100, Borislav Petkov wrote:
> On Wed, Dec 15, 2021 at 02:17:34PM -0600, Michael Roth wrote:
> > and if fields are added in the future:
> > 
> >   sev_parse_cpuid(AMD_SEV_BIT, &me_bit_pos, &vte_enabled, &new_feature_enabled, etc..)
> 
> And that will end up being a vararg function because of who knows what
> other feature bits will have to get passed in? You have even added the
> ellipsis in there.

Well, not varargs, just sort of anticipating how the function prototype
might change over time as it's modified to parse for new features.

> 
> Nope. Definitely not.
> 
> > or if that eventually becomes unwieldly 
> 
> The above example is already unwieldy.
> 
> > it could later be changed to return a feature mask.
> 
> Yes, that. Clean and simple.
> 
> But it is hard to discuss anything without patches so we can continue
> the topic with concrete patches. But this unification is not
> super-pressing so it can go ontop of the SNP pile.

Yah, it's all theoretical at this point. Didn't mean to derail things
though. I mainly brought it up to suggest that Venu's original approach of
returning the encryption bit via a pointer argument might make it easier to
expand it for other purposes in the future, and that naming it for that
future purpose might encourage future developers to focus their efforts
there instead of potentially re-introducing duplicate code.

But either way it's simple enough to rework things when we actually
cross that bridge. So totally fine with saving all of this as a future
follow-up, or picking up either of Venu's patches for now if you'd still
prefer.

Thanks,

Mike

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C10261dab334649b4b81408d9c00aec95%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637751975466658716%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=E3prWlptt32G%2FsgFg9wU8cMKec2cHywgNm1pPL3jzcI%3D&amp;reserved=0
