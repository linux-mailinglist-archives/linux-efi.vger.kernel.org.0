Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF743C939A
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 00:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhGNWOP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Jul 2021 18:14:15 -0400
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:60384
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231407AbhGNWOP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 14 Jul 2021 18:14:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8h7pFzQSHHP8MHQRUet2n0AGrfBZNxZWZiQuNHGt0liD8exexh187lwxfzT44kB/hA95EZ5ymoTPIpCFgjDMJaaiylwUwAMyrTcaxXz2HdC3dTx5nsyfktUBcF1fHPiPpTha4mOOmgg1gTqittJD2oJcINtUX7AbYmq2HhcHg7KYpfICyvlKngoH7ip6L3I91uMCnaEnIz4A8YwmyzYzNkBmgUGxN0Bi33ajujyJ6o05pwIVyJnHqFPInVWPSIgSiZVsex8YU2sDgwy5oZVqk+N955ZaTOGzLS9l4PT15A1GxqbCfn9ySLRx4q/3h+HxfBW1fykkD8SCVNQv/usrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oip3Nz5L3d7JaMbJNRnJAAZJQfYrDVXKHw0yuD9K5VE=;
 b=kF7XouW5StcjtMiNstY/jVLzIDd4d6BWeEHur+SMW8Hm9srtU+mMYLI0Gnfg7OmzkKnCBgC1G6KBPC2p0dz+7ThSRpwXCpqSxZaERB5l98cTNj9b878Yf6QP6pZUfxyc60G+xMB9XgRM1vioqu+Q74ZhReBMVtQzc/eGSp3w4fWEOOhyqQ4Wl9STsAU1L0bO0cf5jzgBKXdvncoidwu8FrO0XpbBMBVBPnAWZ6jhgBoHMFc7oNsyyUPMj80/2SxS+M1Rn85Sel7JTUTMtSRGDdXipeGovoxJEVuLaMjEy+Gcbuul1o0mBAdqXu+dICZqZswS2PQp5ILtrx1S5agYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oip3Nz5L3d7JaMbJNRnJAAZJQfYrDVXKHw0yuD9K5VE=;
 b=x0ku0FmD+3OySCKi8Oo4OuobRQiEjXb1WYQiYvUM3LhZ0JiEoTR8GSH4IcJYXrjzPntYMSRfQaaAq41JJL6qt5deP/hJfEx79aRbLtOVcoTlMhRrQhrTkyDFhefw4UFPIvpOC6pvXHu7ijcRWpQMgUy7CdoPCLoZ9nxOa8ZzBzM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 22:11:20 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 22:11:20 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 04/40] x86/sev: Add the host SEV-SNP
 initialization support
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-5-brijesh.singh@amd.com> <YO9SGT6byW8w37oO@google.com>
 <31e57173-449a-6112-30ac-5b115dda1dbb@amd.com> <YO9f63RwTckAEZ1n@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <eed77131-66f3-b029-e46c-0923d57dcab5@amd.com>
Date:   Wed, 14 Jul 2021 17:11:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YO9f63RwTckAEZ1n@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0145.namprd05.prod.outlook.com
 (2603:10b6:803:2c::23) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0501CA0145.namprd05.prod.outlook.com (2603:10b6:803:2c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.14 via Frontend Transport; Wed, 14 Jul 2021 22:11:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f7c1da4-a2d7-4ae6-911e-08d947144f44
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB455782F8877CCD092BC1C8D7E5139@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: swCJMsmxCY/qui7zJXngwaT9c/MxWq7if+bkQdWqX7r+/3EA9vRS4sfb67/UWp8N/68j0hLgY+DpyNwXqDjwrFGM6nnrq3ZXT5zwhaJXegkECrEWkpMTMkBCJI9zXm7zSsqUxrnqGM0wattobm64diEoYyaPqOhlSWtb1YME/Lws2eMqEOv+YF436iWIPr4/oagMjsFXKx/nCwuJAkLUnD1WLJHtOIMmSVn5E9rcv4dHIcZOEY1vMbWwQpx+kI/lxzQNENzczRyr6Cqaa16SGqXZEZ2l867U/QeDZ/WxVchwJDNYtoT4SsvDlLXj7TFT7TOaGsmRWBYnYg37QeMuZmIOrEUEdZbCnDlVcxOQPXFqMlpntF6OQwS1hx1gzzRpYO2y5UzqgNYCxH6FgaZ2OFHA2SOzwZMxSgThJ3UhXBdwdyaHMl/6K1qcEqja8qwGbBZa0U5YMpabUj7DKyttoUvfFnJVtzZUx5ScgT0zTLvaqXrnoQM2YRT84xoax7Jgmmsl9Wo0yVLUfeZyUkTYG7vyZz/+sIdD/aW/Q4SWuqsXilo8ZlXKdsT//TbXu4VZyCSZarGf2T6EchoyFxNn1vSPPqgEOWe3/bzuXmsNeK/ZkWaLCrWK4U/OaE6PkaoNk1TYTgL26ektj9qBdlVAlLwiMf5qgVp3ibdlmQBxx2AdoZVdkwcpt7li2iPjLBlkPPubMAPI9Dp0OtfKOJ6/Ohet3Mj+mZBFcRfsmlCA3pqf1eWZzaGCF4CvtRE3NotvAY0qzn4ZL3W6f7VLnX9F+d17r1iwhLY/rkjdcW3cvszRjwTB91UsSsY3EwNbp5Yx3F56IZyLRYtQGIJ+kApgI7xtyuRuRt1gxL2kc2ua3POc0THHe5ZbI9LG1tKQ58yQXXlApTt+sH1SqsX1FFx3Qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(2616005)(54906003)(6916009)(8676002)(16576012)(86362001)(8936002)(7406005)(956004)(31696002)(66476007)(2906002)(478600001)(36756003)(316002)(66556008)(966005)(66946007)(4744005)(7416002)(52116002)(31686004)(5660300002)(6486002)(44832011)(38100700002)(4326008)(26005)(186003)(38350700002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUZiVVBlSUNIc1pxNEdGeVlIaGZUa0VlT1psYmxQV3o2ZkFyM243QlRSNVFO?=
 =?utf-8?B?SDdKNXFDT2xzWFhoRDVtU3E3bWRwcG5kb2RiejlWMW9KT3d1ZUl2YVBaVGdE?=
 =?utf-8?B?TTBwdFRObXMwV2dPaG9rbmpBV292bGt3TDhRSWFwQlFyRjE1SGlrWlhTZjAw?=
 =?utf-8?B?ME5hSFE4YTgvWDBKaHFPakR5NGVrMy9ENkZOWTVjalI0RUFMZmJ6L2FDSE5D?=
 =?utf-8?B?UWwrRW1ZZDQ5WGgwRHhPWVluVnRvbGN4RnNLM1ErblJ3K012MlR6N0RCR21a?=
 =?utf-8?B?NmQ2dTZ0YnRaMjlzcFJ1YVRETXVlQWoyZGtJZko0Y2I3R3h1VkFsSmRFZ1JG?=
 =?utf-8?B?dzFpa0Nuc2FBUDBpcndIR0F4VWZOVVRXbTdEb1ZzaFVNMjU5UVI1OU5YM3h2?=
 =?utf-8?B?d1JwejRJQnJQdlJVRlBIQ1Z4K2c3TG8zdFB4ZkE2T0RTTTE5WTdaUlZ5c29h?=
 =?utf-8?B?OGFaR0kzUlo5SmJPWDgxRlVyNThXVzlrYXNQOGNUOTJPVnJQLy9tL3Vucllw?=
 =?utf-8?B?a2swTHZKbVZIejN0K1pUVmpmLytyZG5tb3Jqbnduc1NrdndjbHF6YnhzWjA3?=
 =?utf-8?B?ZlN3WTljNmN5Qy9lOHA2QW9rM0ZzVEhiWDVLSXQ5dU9hM3J4eGM5bnVLQW9v?=
 =?utf-8?B?SWVGcmhscHFiT1N6YmRpb3ltWDVWZmxvcTBTUnFoMThXeC9JN1diblBkWWg2?=
 =?utf-8?B?ODhZM0o4ZENyUVE2aFBQcVpFVnRhUm1iQ1l1K0VHcm9ka1Q0aUNScjlMVmpP?=
 =?utf-8?B?d1lzUS9LRTU4ZU5iNUZWZHMyMURhOG5YYjltVHdWQlNEbFV3UFNWc1ZReU52?=
 =?utf-8?B?dzUxNUhScjZWYzQ2VUtTS2pSZFozd0tYUG50V0pXcERmUkhNbnpvd0xWQzJ6?=
 =?utf-8?B?ZEFLNW5aVTEzb05rZUc4QmFTY2paT0lUakpVaGxHRHdlamM0T295MEhweEx6?=
 =?utf-8?B?Z3JoQVVyWEFwQzZxTElrR0V4MW1OSGlMMlRnOGVURDVrOFZlRmZvQWw4cW02?=
 =?utf-8?B?NEhyemZPTVpZU3diaEp5b3lqYlZtbndWRVFlSVE2cmZZWVpNdE5DckNITTNq?=
 =?utf-8?B?VE5YM3JlOWx3Wlg4WGZqME9CNjhqVW5UM0xqWTBnbFczU2dPaGFZUHFkUGJm?=
 =?utf-8?B?aGNBbG5DOGt2UHpjWlE0cHFJSm4relI4MDA0WXFTb0pRRjl6NzZUejIyVmJD?=
 =?utf-8?B?UFlKTHBhRGdRVW9qM2IrNzc3aXJjaFIzNDh1MEFtNDZ0a1g5aVBVZ3ZmQldJ?=
 =?utf-8?B?dXZRV29PRjVVN3d6ZVpzckJmekhVb0FtMUREa29kS1pwdERRV0dDbVdRNnln?=
 =?utf-8?B?SjJIODJsam5NdWdsQjNpRWNQK2VSbzl5YUc0ZDl4MUZVR09GeTRZeWttVTlx?=
 =?utf-8?B?SFIyRFQrd3ZCdkt4TW1QWXluWGdJUHNzaCtiWEUrNDdKSWF3MkhNaEpqTEpv?=
 =?utf-8?B?RmFSTzBEN3ZBRlBjWHR6UG5pRFdWZ08zSll3WnFydlN5dktPK0JSQmx2Lzlk?=
 =?utf-8?B?UWJYVmRKUkhOa3g3NWYrQXlnMlpEdzVJQXVrTkxtV0Q2elNQeUQ3YkdKTnF1?=
 =?utf-8?B?UktPU0RWMm1JMUoyUUlHSm8xekRZM1J0UldSeURhcHNQZHRMSXhJdENRMzdw?=
 =?utf-8?B?ZUJoRWNlNTNFS2hYYXN3T0JNb2JwTWs0QkFGd1pJMlJmYnRPNE5FbXZLUXF2?=
 =?utf-8?B?UzV5eS9HeWwrTE10OGphU2NHYUdjVys4RDJjVmZtOHk5Wm1mbEM3Wm5qOTVC?=
 =?utf-8?Q?Jzg4QnpRA5vS3ysdBJktR8XBBA47H4Do39tc0GE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7c1da4-a2d7-4ae6-911e-08d947144f44
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 22:11:20.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lc3yTXikXZ6NUmpRXnyxxektRFtkQDIf9xTQ/j5MlJ+IBkBT+WnpauR0NaEZUaKSkQV0RttkBSoAXxJl+tN6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/14/21 5:06 PM, Sean Christopherson wrote:
> What's the PPR?  I get the feeling I'm missing a spec:-)

My bad, I should have provided the link in my previous response

Processor Programming Reference (PPR) for AMD Family 19h Model 01h, 
Revision B1 Processors

https://www.amd.com/system/files/TechDocs/55898_B1_pub_0.50.zip

look for the PPR_B1_PUB_1.pdf for RMP entry details.

SEV-SNP firmware spec is at developer.amd.com/sev
https://www.amd.com/system/files/TechDocs/56860.pdf

thanks
