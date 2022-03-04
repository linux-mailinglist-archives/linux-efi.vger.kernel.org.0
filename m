Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BCA4CCAD7
	for <lists+linux-efi@lfdr.de>; Fri,  4 Mar 2022 01:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbiCDAdu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 19:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiCDAdt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 19:33:49 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43B368FA8;
        Thu,  3 Mar 2022 16:33:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDPfKEl9joMqJ+44OIauHVFoMp1Z2DNIaBO5T18+4xvIQ3NZr7TtjjUzUKHyLd9q8ZhMtEpV143R5Gad8IRWwjPhXxE/qVYmk7DOdaUYpqUeNxPOal3fcAoFSZercpldPOxLopBddd0T0KYTADbDkDekYPlRHpAU3qjXwrMjavS2mg5cRGMDzyT1W6n/EnV5HA+f8Ha09DCRMIRJ7pKlQTr0eXWPtQwwUzsBNKnEUXFv9ezg/G1SON6eBnQObDDmMhtRJ0/HUiQAf/CVoCXPoDI5DZqOKUiR81QNlceTcBqZJ1aJzVkXUce+Q3RJyC5807b0+V6F290eOFzW3X2d2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9e3CjSPsjljHwMhVeL6p4Wd/jfExdRNZ3MiolS93so=;
 b=i83ynOW/ZyPihRDeTCTScVe+YjAK2XENjLbq8+bbe1djWg9OuLStgYIOxkERNMKr2WjfzMQYjtFWqx+xxE+5eDK7lyHqxi/Z5cnrzpzfsLZVGQV2oVFtx73wmv5Jg7QUr03hLoCdFdp1X7xbQTQu7cMExDflQDauIaP4gWfaXVl3bjGvKeoWzWsB1I1Pt7nw2XWr/N0L2Yu0H3CtrVkYoGdj9TFhgHhiw5SHssO3iFomXN2yu9XqBrKsj1Yr5dLKOSz2QP/LZMWAlBJTpA2gUzRMMM+zRgP2jk2WQOvNnnJf5hNW3wcVl/kN3XYEwfaMRvvWnXrfJBVm2fDUXtOgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9e3CjSPsjljHwMhVeL6p4Wd/jfExdRNZ3MiolS93so=;
 b=MKY6fVI2ZZiqFC6Q5dqOkpL8LaqUbg64+gKfLCDxLHu6gd3gmmjvRCWK8u+3OJ2zK4HF8bvwQltfh2BnWcYljkbpL/WdJpNJkjXkFA+ZrmJ3+2Oh6riVYOIv0tvG1jJ/52wUBiBISrs8YDqdqoXRPnWaQ3NV6S5v3BLJ3vhuAYs=
Received: from MWHPR08CA0048.namprd08.prod.outlook.com (2603:10b6:300:c0::22)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 00:33:00 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::98) by MWHPR08CA0048.outlook.office365.com
 (2603:10b6:300:c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Fri, 4 Mar 2022 00:32:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Fri, 4 Mar 2022 00:32:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 18:32:57 -0600
Date:   Thu, 3 Mar 2022 18:31:57 -0600
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v11 39/45] x86/sev: Use firmware-validated CPUID for
 SEV-SNP guests
Message-ID: <20220304003157.diqytybw6gpwn5sa@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-40-brijesh.singh@amd.com>
 <YiCrp61CoqJUXm5q@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YiCrp61CoqJUXm5q@nazgul.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64e58e9c-e7f9-47ec-c3be-08d9fd76885a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5802:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5802045A9FA06C1647EC122595059@BL1PR12MB5802.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQWam58Y/S5/MezO09K+NssHmkvPi13+71K8gja4xwdYCYHWHL8w17x1uJZbwqs/OcrQofZYTCCqA/P9H6Lkbgo8i43kADgpcKR2OHtUAo0f5qQzbKsh6zwE3uvJHYWbYregXvVJWTe6V45HJB204UHeVlGB8FkQwEC7HyQjWrjYsP6XCMuVTVy19oGc7gfnjQXkqRZ5iCOj0llzJ0BqsyCUCAX2j/STY5uQRhcTV5T9IV0b9iucawivyQmbXdpvObRRynG/30eckzFO93yoXLc/adVoeiC91a8Ier7RDuFDS/e0J8gORf423629SQvrPNn51wW6BbWejuVoYCuXOaYJsk2bkWV8j3jVdxCLbNtoQJxh2Sj9OGFNl2yoONWUieISHvi23YJeoM1w7l1V+AMmRw5BaB5TdIpeKj4a5cjVRH24U41YDOop5VL+STlb6vOtDsC1pFr/njAfXvfP4+X4wE64VvLcDNjME3I+gru/ELWeUmcngzxd57RUa6JWWY512/E02jqNvNKjl0mqc+fNq3eZZwPhQe1lHyvPHKJ3ylZ0JaFt3fM9QHXIkJA8fnwK3F3QrQ37bZjj3224aHKxicgnHtBCILupj4m/vOh0yxArLqk4MHHcWpkKTOMufnWoYNSTcasKxp5DL5SiXXa187M74wQbkClA4JckLbm1H7ClW4eHXTD/Q5hi9qG2zKAgCXKQP8cTWlr8PfkzO+sD5UdCKcn/DaCLyKrgvGmHy8L3TNZXhvhy2DzhriOR/16RrPG8JVxrpV53PUONV+aJ8Ep107NjhXcPLY8J96k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(356005)(4326008)(8676002)(508600001)(316002)(36860700001)(54906003)(6916009)(70586007)(70206006)(36756003)(2616005)(47076005)(8936002)(1076003)(82310400004)(7416002)(5660300002)(86362001)(7406005)(186003)(16526019)(26005)(45080400002)(2906002)(40460700003)(44832011)(426003)(336012)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 00:32:58.3066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e58e9c-e7f9-47ec-c3be-08d9fd76885a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 03, 2022 at 12:51:20PM +0100, Borislav Petkov wrote:
> On Thu, Feb 24, 2022 at 10:56:19AM -0600, Brijesh Singh wrote:
> > Also add an "sev_debug" kernel command-line parameter that will be used
> > (initially) to dump the CPUID table for debugging/analysis.
> 
> No, not "sev_debug" - "sev=debug".
> 
> I'm pretty sure there will be need for other SEV-specific cmdline
> options so this thing should be a set, i.e.,
> 	"sev=(option1,option2?,option3?,...)"
> 
> etc.
> 
> See mcheck_enable() and the comment above it for an example.

If I do it the mce_check() way it ends up looking something like the
below, is that what you add in mind?

In that case it seems to expect "mce=option1 mce=option2" etc. I could
open-code a parser to handle multiple options like sev=option1,option2
etc., but wanted to check with you first.

Also, should I go ahead and introduce struct sev_options now, or
just use a regular bool until more options are added later?

Thanks!

struct sev_options {
       bool debug;
};

static struct sev_options sev_cmdline_opts;

...

static int __init process_sev_options(char *str)
{
       if ((*str) == '=')
               str++;

       if (!strcmp(str, "debug")) {
               sev_cmdline_opts.debug = true;
       } else {
               pr_info("SEV command-line option '%s' was not ecognized\n", str);
               return 1;
       }

       return 0;
}
__setup("sev", process_sev_options);

static int __init report_cpuid_table(void)
{
    ...
    if (sev_cmdline_opts.debug)
        dump_cpuid_table();
}
arch_initcall(report_cpuid_table)

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CMichael.Roth%40amd.com%7C98ed7057691e4faf205e08d9fd0c2768%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637819050942268665%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=SxTMowEey9CFaqlUHfWKVuEqThTEGktHAO3JgQIttRE%3D&amp;reserved=0
