Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD7A47339F
	for <lists+linux-efi@lfdr.de>; Mon, 13 Dec 2021 19:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbhLMSJB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Dec 2021 13:09:01 -0500
Received: from mail-dm6nam10on2076.outbound.protection.outlook.com ([40.107.93.76]:51488
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241595AbhLMSJA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Dec 2021 13:09:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da1iMCev7zGz9sEPd5JIb0ltmWeqDeU3zo7T+y5duozkS9vZv/sewC9c2V2ESKBXBRmKmVk0VbOOUh2a5mtgsMuU1mJcMc1SN8ViKZgp4/Abf5yzAHlXS1UmYcuyjAdWF4pQQczHYkt22v1crWXmhBFV1PT8kivwU6iaR7ToSd+I/aG6fEgxUB+shb8uvjuSl51L1EdhsbFAbzfxSBtxD2i0Rbnge7elT4muzuJ7ZhQTgLooHZuHpXHzgOu5D7yf4yzyhi7y+u90rXrUyxkOk1zR5xfcuSZxNZrc1+QoQWA+lE03KtloqDoGpvrKzwrsVjQ1Z+pHVesZNYh1nJhvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuosx/YnGiB22MRbQjZ0gCTJkOEWq6j7Mnp0nAZWaAM=;
 b=bPL6GlK76AeKOwUdf6dJ8hYmuuG23bgCpS4e3tS5BhskN+wvYxp4wC6nvWfpKdRvSGPt8K3483ite608SYPoc3BpVdETNjJytpjtmpapRgBWvQF/poURC8R1x/1jk1KZmtiSXq13zVIsaSdGuwFIFzR5IWUpdQjCfmC88oADN/3cfw7YtE9cSc0iLqv785hNB+NEMGqCoLOBQvablo/5S/5IZ09Y2y+UERK7MAQ7WclBgy0PaLvsPoQEjDW/aQXKzQnyRCOEoKqzJ5iMlx551B7Jsy2LSe6XJGxNnCOtLqUyuX9SIMBulD8r2RyqYlegbk+kE6tkZlPS/11kngww7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuosx/YnGiB22MRbQjZ0gCTJkOEWq6j7Mnp0nAZWaAM=;
 b=IYGzXYurA6xgUonu8xMmWy+c5CCunbAj75RqjWq2X1Ff4XYoDW8Blr7PgdyXsRtZHXYTgKG3yJNTE0SUiFwvnF2HGU8UFCWiT9yy0ppF62iq4uCRYobsOXWmdnnKcrSkjbpO7QCpMNM94UUi4GnkqZ5fPlrtitOyI0WwvIOoqWI=
Received: from BN8PR16CA0025.namprd16.prod.outlook.com (2603:10b6:408:4c::38)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 18:08:58 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::f3) by BN8PR16CA0025.outlook.office365.com
 (2603:10b6:408:4c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Mon, 13 Dec 2021 18:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 18:08:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 12:08:57 -0600
Date:   Mon, 13 Dec 2021 12:00:36 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     <fanc.fnst@cn.fujitsu.com>, <j-nomura@ce.jp.nec.com>, <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>, <x86@kernel.org>,
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
Subject: Re: [PATCH v8 24/40] x86/compressed/acpi: move EFI system table
 lookup to helper
Message-ID: <20211213180036.2v2oxet5e3jsicqi@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-25-brijesh.singh@amd.com>
 <cd8f3190-75b3-1fd5-000a-370e6c53f766@intel.com>
 <20211213154753.nkkxk6w25tdnagwt@amd.com>
 <28ab05eb-65b5-0919-74da-a16cd25db2b7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <28ab05eb-65b5-0919-74da-a16cd25db2b7@intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f00782a-6b6f-446e-636e-08d9be63a21c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4203:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB420380AF7BB48C2BD01722BD95749@DM6PR12MB4203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQbivWQSEovHLAY5mDUWY1E+h4RU74uoeeYC0imyXM2nS47RWW4cCm8+uOu+uWSwOQwRBxtRHs9phxKFr6cEUvqLq5hlUfF/eabuqkzvdIGpoXnWNf/31cH5dLrlT9YWi5BTq3iz38Ur8INcO9R+sBXt3kITi1JFw0NfyVGe+eTUxASHhWPM7x2MnfOTahEHFq1cIcYovhKU4flrmPvbcJnuXPlJF8I+63k++bJasBJMd8BubsUqQmi+v2UFlqqmYPE+RkSK7MTfyGPul9THHbbroj1DkIYeh7i3z9bG9Dr8oBLkt9Fl/Ko2UHKMpSoMDQ03hycuV6SC23dmeI2ekSUkFkELMCK2kEfL4V17BYzo7tY3a1lWZPA8xxk4qQim/kZ5fuOsnPZU1I35dD+r2eAWwxvd9IyBNlOHqVBWviPDqPIFoDmw9VweauBSiiDBXdbq/o2yYgYQTUIYLMV8pPgD0CtjUWAzcGjFC/VLqwDhntX/WdDfh7fCAG5pPWKMc8fVffQo7dSPjOD+2uiSRBdW7nRfVlh2HdRKRQEuOfViqjEMt7EFsYfnUGgwnbnSM/3r4Hes6OnX5TkfdfCbDDnl7RgG+K5E9G0s0njRpz14vbMiV60/gk3LEz/BXWtP62APN4cc/YfWoqNr0mwc1Nfg8+wh7m3WAqYEKszq4UDrgYVjOBM4q7duCQGQIk2A8sUynZO/C2UnMYoGRFovfMEjGh8Sfo41wiBLWzn2yeJa8w0oi413aBIgQxWRmmPpzXTlaAaS7Smb7m1eUSIOteMXFKxuHILePA+kjaO4jk8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(336012)(47076005)(36860700001)(6916009)(186003)(16526019)(53546011)(26005)(44832011)(7406005)(6666004)(7416002)(4326008)(508600001)(2616005)(5660300002)(426003)(4744005)(70206006)(70586007)(40460700001)(1076003)(36756003)(2906002)(356005)(81166007)(82310400004)(8936002)(54906003)(316002)(86362001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 18:08:58.0132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f00782a-6b6f-446e-636e-08d9be63a21c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 13, 2021 at 08:21:44AM -0800, Dave Hansen wrote:
> On 12/13/21 7:47 AM, Michael Roth wrote:
> > Otherwise, I'll plan on adopting the acpi.c precedent for this as well, which
> > is to not list individual authors, since it doesn't seem right to add Author
> > fields retroactively without their permission.
> 
> That's fine with me, especially if it follows precedent in the subsystem.
> 
> Could you also please take a quick scan over the rest of the series to
> make sure there are no more of these?

Outside of the guest driver there's only one other new file addition in
the series:

  arch/x86/include/asm/cpuid.h

where I moved some code out of arch/x86/kvm/cpuid.c in similar fashion, so
cpuid.h should probably inherit cpuid.c's copyright banner. I'll make that
change for the next spin as well. Thanks for the catches.
