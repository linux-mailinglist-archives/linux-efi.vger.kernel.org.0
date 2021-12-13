Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356DD4730DB
	for <lists+linux-efi@lfdr.de>; Mon, 13 Dec 2021 16:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbhLMPsR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Dec 2021 10:48:17 -0500
Received: from mail-bn1nam07on2068.outbound.protection.outlook.com ([40.107.212.68]:27299
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232841AbhLMPsR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Dec 2021 10:48:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTObWRuBr/ORk+oPx0oykFczKFragho17x4KMUbX6F13bqvOMxRbPekW8AHuFks6fe5zPK8AXiLu4vCN1GghKFfduMCIGI0R2x9iTQ4ie65DnD8HMc0ZjQrFWnM65gD9q14fJCtQuAtflVnqoGSFEy4V9Mcqdkw4TcTkcqXviezcGxwzQ+BcSPiDf+zz4ZGVGN9A6Qd4hlADhyppHxc6g7jVDKCHjLA3ad6Gg3aCRk+A2SyxiDh6OTdve06VeOai3+Mv8BhR5HuhtB/PQNvA7mNjPaFVpGjrtCoWX03YwFvSXxvjaZQV9B0jllhe/hMt/ABsBAUPVZW3R7WB9cYGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87U+8v7gHyuWJ4hSa689RZ+ZVsCXjLnhoeYuroxDy4c=;
 b=KFmIKx0f6DVA5Fnga304muuwQyNmP83JzhFAszFNbyPkjVtWbqr5tiSB7scXQZPEFf4g1Wm+ifk/x86Bu8LG0ZJaNNh6hh/hwhgbt7swFqtYWGBWnqW2bRkCe7HtXfrrXimpQJvSg3wKbVMZrxoLVtoeKU++Jzuz8lemAhKhRRGcE5/Jg3Hd3y1mj0OiIhgPEO2y86VM5c5Nnn7vemcer8KwaY1WQBJ8W3YC9HnsaKWrWmdnbxnnfIsq4MZtdoCiGISMjexwVJbOP6qFoMnd4frc107SDtcKZgoELfLFB21dGfj9H/VTdBXA0UOcGueahEJ6XhgtKtfR5Jr2V043YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87U+8v7gHyuWJ4hSa689RZ+ZVsCXjLnhoeYuroxDy4c=;
 b=349pgGPmsG0o52j+3R/PXF3ENw+62oBDM/NsvkeiOChHcRDWb8zma2mqHe6SGGIBG1qv3YoXMuhh/UOGiWhACuNOGzn7K8NjFkDyi1ZuUll777IrIDmK+i2mlw0FTQDI9DbhgbSYPUHxF3MoJz4eMwjcoRvktl77QKR55Sbjr4Y=
Received: from DM6PR01CA0003.prod.exchangelabs.com (2603:10b6:5:296::8) by
 CH0PR12MB5058.namprd12.prod.outlook.com (2603:10b6:610:e1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Mon, 13 Dec 2021 15:48:13 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::6f) by DM6PR01CA0003.outlook.office365.com
 (2603:10b6:5:296::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Mon, 13 Dec 2021 15:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 15:48:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 09:48:12 -0600
Date:   Mon, 13 Dec 2021 09:47:53 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Dave Hansen <dave.hansen@intel.com>, <fanc.fnst@cn.fujitsu.com>,
        <j-nomura@ce.jp.nec.com>, <bp@suse.de>
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
        Borislav Petkov <bp@alien8.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 24/40] x86/compressed/acpi: move EFI system table
 lookup to helper
Message-ID: <20211213154753.nkkxk6w25tdnagwt@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-25-brijesh.singh@amd.com>
 <cd8f3190-75b3-1fd5-000a-370e6c53f766@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cd8f3190-75b3-1fd5-000a-370e6c53f766@intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28614e60-2170-4edf-8435-08d9be4ff8d8
X-MS-TrafficTypeDiagnostic: CH0PR12MB5058:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5058B125EBE644067E283EF795749@CH0PR12MB5058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEtF+JRI2/tkQQK5Am9hIhBx6wd9xsY9FnHn44ZhoiVh5jMqt/45ijBN3HZoweYlIjaWzpmYMNS+pxauUAtec9nilPYS5oRsHswdWE6kjmRTi3kUdG7hrRfgw//GgJOaHfWlBjQXDtSi4JyeVQr0M9Litg3fUDkJHucawXF/uDSlB9BNF609FXfhXyEKcLYaIhT6woPcVzPRJB625k4Hs844oDzB5vbKX7xtFQqUud+uk9EenlIf0QGqcj2ChC6VsB4oQ+Rqq4blQQtUXvcbhVznInr2iHPPMsCOtnP+oFqizTV3Qd172YjX7S0WxpJaI+CgMByLdpQQ6SvpXF9xaKSFUwN6Yb1iQzVuBpHlugrGPolTstfGKk+sGKzTqUXZ1CjjnfW3EXu5eMEun+GCi8RxXaRA2g5QQg7MyJdAH3vVwphyPNV1kx/AFUZZIuuBac9LlsdqmeYYEO8zPhlKtwhafjvJg0IR+0vF8Qe/4WdAFdigpLm4cmz8+CCm+rZmZKIANCnt8F64SWPpNEQGSXDKkwK/kcRhomXpbO4Fe2kxAaaYZqlzVJ5EFePSsZ3KeV9Ut1zdYjkTct9ttiHp5sh+CUJg2/z7wC7S1o67EwrieLX++6SBwImtbqHJrsJ2qQIA3p/8FYk5y3pV5hcfABCSXD/Vb1wscqDtYS2LhhpccTgSV20PzfPQwp5ls44EAReXb5brVP3YAf04aVOy47LLluXTgDwCntjJE2Do2hBFfMEpWtntaAu9uTMFOAwlBPpLf/XbY2CMm2/uXYb1d8VpfZDnKPhJZ3VstNgPE5Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(1076003)(7406005)(7416002)(2616005)(82310400004)(4326008)(8936002)(26005)(110136005)(16526019)(186003)(336012)(6666004)(86362001)(47076005)(8676002)(40460700001)(81166007)(54906003)(36756003)(2906002)(356005)(316002)(44832011)(5660300002)(426003)(53546011)(70206006)(70586007)(508600001)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 15:48:13.5331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28614e60-2170-4edf-8435-08d9be4ff8d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5058
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 10:54:35AM -0800, Dave Hansen wrote:
> On 12/10/21 7:43 AM, Brijesh Singh wrote:
> > +/*
> > + * Helpers for early access to EFI configuration table
> > + *
> > + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> > + *
> > + * Author: Michael Roth <michael.roth@amd.com>
> > + */
> 
> It doesn't seem quite right to slap this copyright on a file that's full
> of content that came from other files.  It would be one thing if
> arch/x86/boot/compressed/acpi.c had this banner in it already.  Also, a

Yah, acpi.c didn't have any copyright banner so I used my 'default'
template for new files here to cover any additions, but that does give
a misleading impression.

I'm not sure how this is normally addressed, but I'm planning on just
continuing the acpi.c tradition of *not* adding copyright notices for new
code, and simply document that the contents of the file are mostly movement
from acpi.c

> arch/x86/boot/compressed/acpi.c had this banner in it already.  Also, a
> bunch of the lines in this file seem to come from:
> 
> 	commit 33f0df8d843deb9ec24116dcd79a40ca0ea8e8a9
> 	Author: Chao Fan <fanc.fnst@cn.fujitsu.com>
> 	Date:   Wed Jan 23 19:08:46 2019 +0800

AFAICT the full author list for the changes in question are, in
alphabetical order:

  Chao Fan <fanc.fnst@cn.fujitsu.com>
  Junichi Nomura <j-nomura@ce.jp.nec.com>
  Borislav Petkov <bp@suse.de>

Chao, Junichi, Borislav,

If you would like to be listed as an author in efi.c (which is mainly just a
movement of EFI config table parsing code from acpi.c into re-usable helper
functions in efi.c), please let me know and I'll add you.

Otherwise, I'll plan on adopting the acpi.c precedent for this as well, which
is to not list individual authors, since it doesn't seem right to add Author
fields retroactively without their permission.
