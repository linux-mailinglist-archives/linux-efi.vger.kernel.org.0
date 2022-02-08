Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564E34AD0F8
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 06:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiBHFdM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 00:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiBHF0U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 00:26:20 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5385C0401DC;
        Mon,  7 Feb 2022 21:26:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+i8HTM6jxOsgGKNTsashcZbpjcVroqBPLrTrVfwYDPp5uH87cANIWwzRLEXgsQlQNxUp20WPLEnS87GumpV4X4pgUzr8W+unpn9lPBrt1ve9PUTI2mU2tLKtGRUEFBzTLAmsiWBG1gsny9/V7pXX923GtOPHJbU1cpNizzAGNOX2Mamp5t7g5Is4v1PQJgN/SpOqk58QpA2I2czqhvbnzAqmoBh5LqlB50wk1Vq3fMIpMpJhliAYiBbzq8OaNFzeeyLczRyUArW1IDcjxydfunAoklqu/5hqHAx+Dmlxy99W5pKF0X8+xT8ykVeUbO26kJ0uegeQLOV8wtHZMGVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF0Y/XpSIShSyUWtXZ65BpYee9yKqoawahQAmu7cGEE=;
 b=Ko7IkfSPLE8Pgl9WvKsXIhcMKAo7IC59CgVIxBD6XYm2odFfNpkGUrFCBCb0lY+gJ4yYXi49tSkIFYRSyJK53O0ynpfMC8mrqAXLG7ynH8j353zna7c5riks5+yh3+EEQaWpH/jPte5kbglXcCahNdj/uMJNCjSp6ghkb0hNaUEntBgYElIDbSaegyGge/aw/HdndQOPFvpdfBXVU6IZfC8EcCfXPlik0Q+LAkg2eL60n//zlK8bWbaQJmzCvVdXIqcfZlfSVulJ2ycmvMQCblasmWDWddytbXAYa8wSQGNDCsnh1mY1rKy/y+VTqNGD1Ge6on1U+UCIegljRtwHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF0Y/XpSIShSyUWtXZ65BpYee9yKqoawahQAmu7cGEE=;
 b=IeL3iiZj2ugOPnfgN3BuJhdfpLKuAoMlAmfN691RWxrafUPU5GUI0IUDQ8yRSkLfPy+P1evjK2NMZal1SQXPyeO0D7BLiFBqyGukwhe10ogCLCxtsvWZXwFw1YpYl/Hz3ZCGqcoLHd50D0NKGrO4ayclReduFvIwGWYsGYARdEI=
Received: from DM5PR2201CA0022.namprd22.prod.outlook.com (2603:10b6:4:14::32)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 05:26:15 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::98) by DM5PR2201CA0022.outlook.office365.com
 (2603:10b6:4:14::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 8 Feb 2022 05:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 05:26:14 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 23:26:12 -0600
Date:   Mon, 7 Feb 2022 23:25:42 -0600
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
Subject: Re: [PATCH v9 37/43] x86/sev: Add SEV-SNP feature detection/setup
Message-ID: <20220208052542.3g6nskck7uhjnfji@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-38-brijesh.singh@amd.com>
 <YgAjq3mSudt+G+6Y@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YgAjq3mSudt+G+6Y@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99bcfef4-6d2d-4b6c-c322-08d9eac3863a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4125:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4125F57D91BF52568B297FF7952D9@MN2PR12MB4125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOFBSAcxDw8NpwEhASqBWoAHCYeoykjKce47Z2TrdBlbI9Qvw8BJh9g/bYTZJ9SxP7FlFbcsC5faXjsCj1CMIqbIlYOnvJfZQ/Gk9PM/c1HGgbn8k97485QtS6PododVNvMvIrp8P8iuBwgydKbTPO+cRZXSvs8ekHH4NeNPtcWFwAVLQx9DXO/WTF1cV2eUwZa4H4Ka4K4J3ZUcSnItEfq/FA5Gpn9eeM3fyqeEvk7OXaE8try9KaXCqaanHOR8YVfSODkJ2CQV4MobgNYLnxxK2WiYXVppwWQzszHkI2GSTd3QY5+kQN7aPSLPOXFCCV3WTE58Rlp/v+07e3zzfZzqye2xpNxb1VJuNdYKe6YtOOktCwojBkZUICwyHVI5U1WPBeodDL6Ot7T/UzfGw7ClucL3eLRU8gstILZQbFa42fNDvj51fezBwdXr6PhNXrZ+QMVyl/X6TN/3yZqHAooz++WGp7fkywtg/kqKcpV1lb6XjhNI7N04jUWmlYYVP5IH7qoo/OOdTB+1HCQtJDM/VXyb92uusTFt3TAGK/mAxMlSyXFNcdwRlwCvSSm9NxCEhVvqSFjV85B1gq1nnD1jHnt2vvCERlTId8Rr2mbgr0x6jgblOV2XmEpl6I9VyZ9IuR4olQvfEQzo2cH9YCcHGeDSoeM29b49Tqa9WcZPRm4CkrSNMoKEdRM5OoEtvkHbh+6Cl4FxksLnAfNsIdEBb0qyxitZRI7WkV96gm6lhiO4oft+yO8ppoOmGsohzU4Lj7DJyyJtUDShtgjaVVAby0L4hTsipZcppY2+akQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(44832011)(356005)(81166007)(36756003)(7406005)(7416002)(5660300002)(508600001)(1076003)(2616005)(2906002)(16526019)(47076005)(83380400001)(26005)(36860700001)(82310400004)(186003)(316002)(8936002)(8676002)(4326008)(70586007)(966005)(70206006)(336012)(54906003)(6666004)(45080400002)(426003)(40460700003)(86362001)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 05:26:14.0218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bcfef4-6d2d-4b6c-c322-08d9eac3863a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Feb 06, 2022 at 08:38:19PM +0100, Borislav Petkov wrote:
> On Fri, Jan 28, 2022 at 11:17:58AM -0600, Brijesh Singh wrote:
> > +static __init struct cc_blob_sev_info *snp_find_cc_blob(struct boot_params *bp)
> > +{
> > +	struct cc_blob_sev_info *cc_info;
> > +
> > +	/* Boot kernel would have passed the CC blob via boot_params. */
> > +	if (bp->cc_blob_address) {
> > +		cc_info = (struct cc_blob_sev_info *)(unsigned long)bp->cc_blob_address;
> > +		goto found_cc_info;
> > +	}
> 
> What is the difference here, why aren't you looking for the blob in an
> EFI table?
> 
> Even if you're booted directly by firmware, there should still be EFI
> there or?
> 
> And if so, then I think you should share some of the code through
> sev-shared.c so that there's not so much duplication...

In order to scan EFI this early in the boot of kernel proper, we'd need
to pull in the helpers from arch/x86/boot/compressed/efi.c, since the
normal EFI facilities don't get set up until later. It's doable, but
since any entry via boot/compressed kernel will have already done that
work and stashed it in boot_params->cc_blob_address, it seems like it
would only introduce more complexity and potential for breakage.

For direct entry to kernel proper, our thinking is that it would be for
things like the PVH entry path:

  https://stefano-garzarella.github.io/posts/2019-08-23-qemu-linux-kernel-pvh/

which doesn't use EFI, or other container-focused applications which use
lightweight non-EFI firmwares like qboot. So to support direct entry into
kernel proper, relying on the CC blob setup_data structure instead seems
more suited for these cases, so that's why kernel proper only uses the
setup_data structure and relies on boot/compressed to handle EFI entry.

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7Ccb8e665b2ed14dbd400c08d9e9a841ff%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637797731199858639%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=5Pd7PA4BdfnfWzcXpah8HkrtVfu4h6nUIR8b3mB%2BIxM%3D&amp;reserved=0
