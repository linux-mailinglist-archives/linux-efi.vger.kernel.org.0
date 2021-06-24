Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC273B2F1A
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jun 2021 14:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhFXMh5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Jun 2021 08:37:57 -0400
Received: from mail-bn1nam07on2085.outbound.protection.outlook.com ([40.107.212.85]:7394
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231334AbhFXMhz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 24 Jun 2021 08:37:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqoYz6SaISH1KNAM2soBRZrLn2zX4MXRhVgZDiRK1H9hoG+QiMWlbeEFzMMLzJ3sm8cN2bkvq1eWeh79Waoh8AYDncUgF8Z2hOFgJ8P6LZFZFBjGzJO/aCPUibApqodwR5wA2017F8QzXuw69PDQ4aCuhF/yotEfPxtOs4M6lFLko8xnxbzyUEq2oxS95K+FtmYyFRnsknOvTJzFlX1J9j5NwQI40H169cA8KKDSER+dvjiA+imXwMfUYVEuDBnpoHlZuQ4s+bzXGuX+kwg7wQtT82hDtRKeqXgEPyKUgCHqVjT5ECE7YPOWQEUWiVJw8XM7MGkx0ok2BzzOkpz55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyeUpBbBOmXODCLqTI7FU9TSVNZw5XSHpNLN/pfnBTs=;
 b=mIhItRTfQdDKeoKNb3s5+aJKpt53a9UBWUNgTFSsVTG2XEk8IZlQxHfKBfCoxl5jXXqV1oHcKR2gubrAC7HWOpvWH4erJmLxZswjvQEfJBD8WxVYGpwZqa63hbzSkRM4UjWKlKKCdQs/ctrCQgPzcpTAyyXKOj2t6IiULZ1769Dcv20Fu9C/n/gxSXbY8lwM3m9DRbg1oogmXaDJkdyd/emNR/ygOvTqb2epR+EJm99d3B/crOJIbb3mZGJWZO8j5b+a5kGdeoa73l7DfjNKFlQf1KXLL1S+JuhGf6qH0nATMpqpfzfp1MhfjspycApZlTgBvploNmxpcuCfRw7UVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyeUpBbBOmXODCLqTI7FU9TSVNZw5XSHpNLN/pfnBTs=;
 b=b4Qhdh9A7h+ROooddlIm0pvBV5P7r1upFsfQPF0XyFrXaJpDRZAK4G5aMiTwOf4Fo9cRNl7ZPsTRC/S3X9DFJYq45MV0ioYyo3BBeEqYNUGr/cn/h34FCV4qsrH7BxAEHDQJf64DP9mkSS5fM181r1Bk0lvYjvIJVxcJ8Nn881o=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3845.namprd12.prod.outlook.com (2603:10b6:610:29::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 12:35:30 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::181:e51d:a4f7:af62]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::181:e51d:a4f7:af62%5]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 12:35:30 +0000
Date:   Thu, 24 Jun 2021 07:34:47 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 20/22] x86/boot: Add Confidential Computing
 address to setup_header
Message-ID: <20210624123447.zbfkohbtdusey66w@amd.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-21-brijesh.singh@amd.com>
 <YMw4UZn6AujpPSZO@zn.tnic>
 <15568c80-c9a9-5602-d940-264af87bed98@amd.com>
 <YMy2OGwsRzrR5bwD@zn.tnic>
 <162442264313.98837.16983159316116149849@amd.com>
 <YNMLX6fbB3PQwSpv@zn.tnic>
 <20210624031911.eznpkbgjt4e445xj@amd.com>
 <YNQz7ZxEaSWjcjO2@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNQz7ZxEaSWjcjO2@zn.tnic>
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA9PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:806:21::8) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SA9PR13CA0003.namprd13.prod.outlook.com (2603:10b6:806:21::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Thu, 24 Jun 2021 12:35:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9d408f3-ad7b-4aba-3d13-08d9370c8da5
X-MS-TrafficTypeDiagnostic: CH2PR12MB3845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3845CC88B6B2BFDE8DEBA13795079@CH2PR12MB3845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+Oi7wo6a+j/dN6KAhj0Jml+Z9gLi7duRZlcd9Rn4qZ+eT6T9ftdVSbuVtxaR7UVQTCWe3AjnhQPNw8apuusTs5VNXQsIYQdmwfYwuC/F4eU/wUIjTOZ48rYcRkGP0Tbgp71ExeMI1zsspSf2DyStFLwewXQqZB4KhhRyxeEBVm6zrhmeW7PmCZHIJdJfZDojphmakGJzR++Dv4vKEyy25lEoxPKvett1BbBrFzdqsbuu5HNVPvQk4G6fl3Z7O4NYcJVjPhzaMc+MuepgdRH+fvvSXGrtOXgVbL39U7jQRShMOgd5Yq+5D8XJbcv0cw+cPZh3iQubtzE4bcNwD8brRolXoxBhyC4FCmZOQKk2iofH04aHdsnjiSFnRDCjJ13DZQJodEP3QeCMuJIID7Px461yChMN/no30yCYFsxeoD8zildHKuHA7ITBFiWFOE4tW7yBywwwbkTyJ7Ff4N70IcoCkawnjU1VRBh7BFnWPqdgTxq4y4nzPcfB8jBvLxGs5sk2BLas8KPJ/zKckJ4qEmOoFBJ5lUdVwt20PomYEoLA0gVGydUiLtye3isrRiBVz1dPC6bJ9BmseIq4yfP4Q+q0aZmAz3BXZl8P4kZVSG+NL/A+SxBPk0/DrOq+oT08FqI8wvm16aif/r0AIWHyGYYubFzp7srutWxYTAA0qZKxpwySTpbzXRM/N9ADhFrembpMUFUw63wp0dSvu3CYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39850400004)(346002)(136003)(396003)(2616005)(956004)(5660300002)(52116002)(44832011)(316002)(6916009)(6666004)(36756003)(4326008)(6496006)(38100700002)(8676002)(66556008)(66946007)(2906002)(38350700002)(8936002)(66476007)(1076003)(7416002)(16526019)(186003)(26005)(6486002)(86362001)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e1ZSzhLTq3w9qLRua0/Ata7nuq0qYHndPOm71A1pM1sMVQmqUJs00sGVmQmV?=
 =?us-ascii?Q?tM9BaHvIAe4c0uBoHc5sVYYWWr2E8bkmUlAh/x+3Hk9g9l6R5AjLz75FXbT2?=
 =?us-ascii?Q?8zo5zh+qm/iFbRPfGm1WPo4D+2YnZuAmlb2LSyRCVBsttTZK+VNAk+n9z2k1?=
 =?us-ascii?Q?nbpF1Yn2Njmoq7uzWDO4avpNYdV+L2eK5dcXAsXoiySvdsqRvA6cGGOxlcU5?=
 =?us-ascii?Q?l9hruMkRSgmSPsCKfATlfoUenKjQN9AKvdPcmMDWT2Pc04S3zJY3MaQCutWB?=
 =?us-ascii?Q?81taThwS67+r1kilRuHkSjj2CXtl+7M8aURRV/qJQkj9JpX29qGbrlj6r4nN?=
 =?us-ascii?Q?FeRvyz8f/jCXxYB48f8jM7l7N5CjocF0n5dWYFTEazJR2JuvHywAW86RtPhq?=
 =?us-ascii?Q?feTAPXJ5fj2ABZOrSnBncsr1jNkW1WOyUHF5u4A6iJGhCqbHI9OEYZaRUO6O?=
 =?us-ascii?Q?BSe3T1NVG5L2kroXQpm4km6B2m4O8NglhxABy4gff995ELqOJNexV1v+gTzB?=
 =?us-ascii?Q?PbTXpbVNuLmp6GH6BT/rNx3KnRlyeAV+CcVjrhI3/YxT2JhDBurtxYS6mRjv?=
 =?us-ascii?Q?wioJAJRtjoogPftFoDGKwwYoGy/B0icLkhIMvD0iYOQJ2NUo9HKH7hSeNVH6?=
 =?us-ascii?Q?hknuOTyuP7OxJtu7/lOIJCqd071VGpKKgK625ZaMZpo4+F0RXNXzfX1myxOm?=
 =?us-ascii?Q?3b6s0bokhz1TVLkj1f71cK/XKJD84CowyuJpN/j7Q5LPjMBxd7x304dxyTKv?=
 =?us-ascii?Q?B14b/MsqEzLjiHQ/o/8D5uGrJ7UUXh9/nYp/HEIVu+L4CgXn9MZZQZ4+bc5n?=
 =?us-ascii?Q?HLIw0j55nf4/B2+8pe096AEyAZ/AzX2GCCBbLXJQQcrv3gFiAkfsPtbUWlyk?=
 =?us-ascii?Q?E2KzsFmakj9Rkr/A1irrjQNXoaMM0nO53yqOCRsi/IPvRrpROItU4VPzofHq?=
 =?us-ascii?Q?wD+Pz4/Ei6jnb5XvQfYduDTiivxh1IGw/enxEUEwVd+cTVQtrXBoTRzpgaKi?=
 =?us-ascii?Q?zURexI9jvd5nqrxAcLpj9IHSynKfhp/2pljCPUlBnXx2moyfwzakZcXAx58Z?=
 =?us-ascii?Q?LB2FfRGBhFpDf+CQWju7JrE3dmGm3PglGCaxNEXcg27BhCo3V4fTX9Hk6Awe?=
 =?us-ascii?Q?BQWV+fKW6FcrjnquS1f2twNYzdA46G7/oBtyJc8+f9mXFAK2ofxhGeykq/Qs?=
 =?us-ascii?Q?9I1/Dud731gUEqM4lO00ADq39j8jHiTWYQZktLgFhPqf3hLv4wLQeaFAqwdg?=
 =?us-ascii?Q?bMBh4hLrRyHlJrtUBbXTFzGuH4O2MYYhGpYMpFOfiYvWAc6dpt48B7I/pvF8?=
 =?us-ascii?Q?SS3Gq9mYtktEBpwx2/AsPC1w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d408f3-ad7b-4aba-3d13-08d9370c8da5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 12:35:30.7487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qc2tis56kokXcnsW46xO1jNRNtlVs49juvVcDrkL14guYN8QE8q0KlotixQ247UL52KY9tUCsUgeglTng3jv/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3845
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 24, 2021 at 09:27:41AM +0200, Borislav Petkov wrote:
> On Wed, Jun 23, 2021 at 10:19:11PM -0500, Michael Roth wrote:
> > One downside to this is we still need something in the boot protocol,
> > either via setup_data, or setup_header directly.
> 
> Huh, now I'm confused. You gave the acpi_rsdp_addr example and I thought
> that should be enough, that's why I suggested boot_params.

Well, that's sufficient for the boot/compressed->uncompressed parameter
passing, but wouldn't actual bootloaders still need something in
setup_data/setup_header to pass in the CC blob (for things like non-EFI
environments/containers)? I was under the impression that using
boot_params directly was more of a legacy/ad-hoc thing, is that
accurate?

> 
> Maybe you should point me to the code which does what you need so that I
> can get a better idea...
> 
> > Having it in setup_header avoids the need to also have to add a field
> > to boot_params for the boot/compressed->uncompressed passing, but
> > maybe that's not a good enough justification. Perhaps if the TDX folks
> > have similar needs though.
> 
> Yes, reportedly they do so I guess the solution should be
> vendor-agnostic. Let's see what they need first.

Ok, good to know.

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
