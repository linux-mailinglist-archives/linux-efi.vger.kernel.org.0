Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59103B2F14
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jun 2021 14:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhFXMhy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Jun 2021 08:37:54 -0400
Received: from mail-bn1nam07on2085.outbound.protection.outlook.com ([40.107.212.85]:7394
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230136AbhFXMhv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 24 Jun 2021 08:37:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4GdFBhMWpbQXamQBzSrmPKUB9cnHrvYdifioGFhRUMOVyseukFzIb4Pibp/QB/ly0OlKpMH6GZAsVdhOC5ZwTpVIXokNV0Ejm6egVKGkiQUvfLcmCiwFB3qKli9ykoF/AogMlWhS+byPm6gREbBP+n5+gkIvZIH2tX6+nrjp3jfwVLO4kRYLbQ6tmL6+Q5IIri0q6dUPlIMIuTUhC+jyRpgKTLA+Exr7DUDD1gu9KOEGGy/Gy8s4Rj/Z5Qypxc/f/Gs1XJ4ZdGHTmIDv7D/iLA3WsDM7668O1hrzk9cHVr+H7xwwKpF1GTmpWL7hfLgFHRhVEu5PRYDUIqm/r5y8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnZ9X3iL/DjP2dADOISDKhE/sVoXiojEnP7BkOTOZCg=;
 b=IIC32QrcsEQD+OltUlFPZ9oe5zB9JlcrZKKkEVz+tETcdU2daq8h2Z2ZJB5UV1yCLfLz0dnEj7xGw3Xjo9o+g6xnXgicIrrNOWSIiLDTXQy61tlV2LIi6jRxOu05mP+JW8uf5n4QTWszhA5JUwBQ01maN2ILcp8O9LcIhjqO/7IX0KmJrMiQYg/k5vOe0I1RbmpB8ijBfSYOStvVmT2LCtW/976jn+ecugnjX4khX6pNx2nKub9ezjkcjprTGj3ZeLub7P8L9hnmafhKYWHxqUbq4aUnAAbKkqDAx1YRpsB0vd9m61HfcL7Tf6+q8ErhR/c9sAHmSKdJNG0IOf7wcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnZ9X3iL/DjP2dADOISDKhE/sVoXiojEnP7BkOTOZCg=;
 b=2OXO9XzJRJU7xIgiyPIGFawwOlTQu5a9iMhT8Ja7NYoWcqJ/kKc0gHBpabTnX3oCXNRt+S3DUNwHZ5l9/yWJf+WO+r9aexieyDcKp5sxF70tPvqv+1hRKKNjXg5khSLo/p4YtmfS2AAWHmjxKhNpngmUgIfWTjkL27YB1mvimVo=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3845.namprd12.prod.outlook.com (2603:10b6:610:29::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 12:35:29 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::181:e51d:a4f7:af62]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::181:e51d:a4f7:af62%5]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 12:35:29 +0000
Date:   Thu, 24 Jun 2021 07:26:55 -0500
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
Message-ID: <20210624122655.cx3rugg5uvbeib5r@amd.com>
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
X-ClientProxiedBy: SA9PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:806:21::7) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SA9PR13CA0002.namprd13.prod.outlook.com (2603:10b6:806:21::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.9 via Frontend Transport; Thu, 24 Jun 2021 12:35:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cda64e2-6ed0-4689-b063-08d9370c8c70
X-MS-TrafficTypeDiagnostic: CH2PR12MB3845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3845329D2C36529A0A0139BA95079@CH2PR12MB3845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1bEmPTkwt8xwZsn9aB2Q/AaDswaNj024GBjpOSc3g9AHGBCiO/hkFICiPALL/9ozFe/G6SgKfRGkFiBV5MS4r4tp5XBRZQbiEpwDEkFC56tC3S1644dGo6TTvN5te7kyYzupS+eCJfhFrEIZnE4rxgWtUBgwOOkOM7lglXTado6BE43P+JVNv1Vqx6jAzmw7wXlT2OVYVCkAF6Ha2HDhcTPNNnkqMcqXKBlPA+f75PSc0d2+NNnfBoU58hyiNdE/T32jT8OuM56CoeH+2XS8sEpuLeZCfrOr9tgNQeWLKLZqVm2h3ezAjjT+wMAlGJCs0pq9dsvrjxTligl4gJYc+8qplb2ROfRpLVuYd1YnXh6KVIMF6YXNf1NY3XJ4e2LJsRm1vuuXJNMbSClJSJ2S4zBPckL/go1O7Vxs8sW8YZwNdTNdEVR5PSxAkA5kOdoFJS7OlIyH8DbgZ5GmExw4OCVgNjXIi8g/bNg2t9HpyQCfwIHY4MxiGY10X/48ibrvQjYrBAn28vLrwQ/70f/WT0uwFNubRXpbExCeN5t8WiDhpUpRFx1lw3rTxYchl8aq5k4BJn1jA+bDxAjFLr56St5bhT/PRAmnfHnIybRs52230LIxKCWgAc8lz8oHyjiqLP+YfGSrLealUU/LKlgC+J83e0VMa/NOLeCzPFuV4sMfRkvxV9bXTJ8vLCCoI+gnbW2bFhqd/QqJ3vv/kyugkZ9aCHsquhXwD6HHsl7+59lpLp6mzwqVKR3B5vsa303VDWtBi1+j4pC21WZwpfSfO1vVbARGnB9bwUGpYD9kMA0QPGvkddPsMO+DYKZENM5hx4XNeTwdCTfdG4/g36LIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39850400004)(346002)(136003)(396003)(2616005)(956004)(5660300002)(52116002)(44832011)(316002)(6916009)(6666004)(36756003)(4326008)(6496006)(38100700002)(8676002)(66556008)(66946007)(2906002)(38350700002)(8936002)(66476007)(1076003)(45080400002)(966005)(7416002)(16526019)(186003)(26005)(6486002)(86362001)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IeLbMV8qmhnjtsOJgWF0rjW63fc9Fm1r3uPTZ5sPGhEODGhn0roJGy6RSVoR?=
 =?us-ascii?Q?yN9RO02GvlJbYpbjEEafO9cnoyzdnbiru27K9UwOGIHNIJkTDPULo9+36fwL?=
 =?us-ascii?Q?WumLUNG/i5SLYI3XSiw494uvemxvZzfRi61QLNRRmgQRtfODtQFzmZl4gc8W?=
 =?us-ascii?Q?a4r3LvqxaHPHKtkTCaqJhupt+t97/VwoFF0jHl9FODNGu3kpsoSjX/R6l5j7?=
 =?us-ascii?Q?lj/ngrDFo2O8cXw86s55tOYQXWeyLltYkvcErzeHXgoH0ErpxF+LhmaUmsex?=
 =?us-ascii?Q?zM5l0R9/SO29pyFl/1FfukrO8HVkZcNCIzzp+TAzJ/+7msF61G3dpVrV4DyK?=
 =?us-ascii?Q?hwFHmigBOerxPv0lRZf9o0hKYOk7q1R0AJlWQaWnCRXR0GE7b8hERrljWRVT?=
 =?us-ascii?Q?3en+rgFvwtWm/N0zHbHFHZ5AHRmwjxABqOMVKRxdntdbhwXVQmFty/U4urPh?=
 =?us-ascii?Q?gVwhPAZHZQplz4bZyt+cgDhqPMUIl8xV82hcvG3/LjKMXyH4AF7u9LafR3mh?=
 =?us-ascii?Q?INB5UCDJfKRiTtcp/sRWpLE5VmuYE/xQc2ItrZ3t/6kSJOk8KtGUz4J4vft6?=
 =?us-ascii?Q?Wt+qgoW0Dg8koZO1O0jP2ZIFLLDWi5oWjyiE7OKL6y0BeAuxPOZE6/Dt/p2J?=
 =?us-ascii?Q?ackcMbgv0wi4/F2k1jHypXhRT/l91287zJL4uw9pN++gbLoT/V1gu6/W6krR?=
 =?us-ascii?Q?k6sy+JH7K7Xu0n9LMUWCECR8D17dFty3jBBmed8GD5lfkLgC98HWs59yIexV?=
 =?us-ascii?Q?gjotA0ErgaLTMY7o9OkqCkXmXXNjUwBKcNgQgVsXJF7YZ+76a97kcAekmR5d?=
 =?us-ascii?Q?Z5fiv5hy71jX9emr5kK2K0q54bjyRtZq/ZNDeJEQhJkRwOeTultWaeEL7+Vo?=
 =?us-ascii?Q?VBoCwWx59HMYFYKE38ReD+OEGJQuBL3tFK0z0L1HOai68DgYUz6YpLIv4Xta?=
 =?us-ascii?Q?DOC36/sokJR5G4wesx5RBRmSJn74MQOipbYH/gekQMEX6P+R3Nf9Whs0IdRL?=
 =?us-ascii?Q?B/Vc2WuuMLFgrZ9WWSlqPK6i4akqgycpHXuV/qhrQm8/XCSiphVY275uH+Nw?=
 =?us-ascii?Q?m4K8zYU3eX5rtz+aLzER4CV2fG/SB1d8+PI+PxBq2KHJuz0vHVlFnQjXkVHj?=
 =?us-ascii?Q?PWBcl/3x17SscarQragkiQDWfn3SGjiPTQfew31rV3hnFtykSeH+7llU7drl?=
 =?us-ascii?Q?P1K4VyLCw/3rYUvirYLq37XuUvxU2WqgFCSXkRX+psURF7E/QcWv2izIOmPY?=
 =?us-ascii?Q?oC2dLxxFBc1dydgYO4ah1djwRQnX9b5uljM0jR+69ZSe0W42a2OXesgQRaUU?=
 =?us-ascii?Q?z8qMInQ6IcrFdQhM7EQFAoEt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cda64e2-6ed0-4689-b063-08d9370c8c70
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 12:35:28.8421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5NO41dGR6e3vaCXphAwdSAD4yfIXiDh5WopJG+hyHVS+ReSvRpZiCt8qH4kRLosrHPDKp83h7B2wiLEf/CmAw==
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

Well, that's enough for the boot/compressed->uncompressed parameter
passing, but would a bootloader be allowed to use that same approach to
pass in the CC blob (for things like non-EFI/containers)? I was under the
impression that for that case we'd still want something in
setup_header/setup_data for bootloaders to use, and that using boot_params
directly is more of a legacy/ad-hoc thing. Is that accurate?

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
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C876d84222a2d4c2fc14008d936e19194%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637601164763100440%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=XIsAM9LxAOr7LlsJBkT33OuxywezofF%2Bq7%2FEqxpJOVk%3D&amp;reserved=0
