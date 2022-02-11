Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CE44B2BB5
	for <lists+linux-efi@lfdr.de>; Fri, 11 Feb 2022 18:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbiBKR06 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Feb 2022 12:26:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352088AbiBKR05 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Feb 2022 12:26:57 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F1D1FC;
        Fri, 11 Feb 2022 09:26:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEDXK3H3fEdlO2yIZcmmDHt2MJzVV/gOU378a4vAhIObizvkXbqxBo48AgUi8I3Su50+HbvHSFF5++KPqTPRjKL5dRl9RqFLI4pXYeyCM9TEpxr24AphrAE4ejR61U76iYiqB3mO+Vynn/bWjoOjwaT/X53VWtrjK2PtXlanxW92jxo3RyJ2LY056dl0jok8/w8oka9/qzYfKzvdOSYxQGnlsxqbjpcUdAQHvZ+5cF8BUKmqXrQiVXLuAsAIbRoaJMlnHvYw924WXpH7PmPfbzlGN0+JpEc+Oba8zl1xLwoSMgLAGcG5g4S0vJO/VjGL3qZsewYBtFeBv2AiUyhRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O0hsWYkzpiZOC1kKf6TEWkU2R+n3SoNk7tEttRso3M=;
 b=YsPuH+J6MmA8QM9zGAeiM14tR2S3Arn9g01Dl9uyn/+ObVGiuP7Rqnfw/2LgkqYPMLKNB6t++kcIkLm3j2wKGTT80edV2PfgEJEyAcPAuxLHknhtpLuhzrePolWDW+MdWHqn8PQy02W5NB5Zwm/Gy3tu444Yv2EuVBuIm9igNQoruzEaInmoPj9stRH1mSiaXbMj9VzfBVYIPsqlSgxbKcX43JBZqeTUMU00mj9t5q2dc+XCw09fSeHXJbG7U33Pnk8mQcUQyNQIe4NcDkljEXnkBgqlawlfKEbXSYdV81G/AKH5Tgg/nwS0jvt+TJrQhTnEf094Fpsn0hGa27A1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O0hsWYkzpiZOC1kKf6TEWkU2R+n3SoNk7tEttRso3M=;
 b=WrmN49YbFlZqklTg/6UHAsmrodLaXmY5UkVF8Qi3sxEHY5rMxU9+gEDedvqrb7GNRriIKz05WfjTn0gYFpHp+PJHsyA0aA7/75u7p6MLgVSgmHDdhU4IuiS17+tSBXkX1DqAHbEGzUY0DiZZpnfPbRAQWokydHf5ewRr8/RZOjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by MN2PR12MB3165.namprd12.prod.outlook.com (2603:10b6:208:ac::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 17:26:53 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%5]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 17:26:53 +0000
Message-ID: <0242e383-5406-7504-ff3d-cf2e8dfaf8a3@amd.com>
Date:   Fri, 11 Feb 2022 11:27:54 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v10 21/45] x86/mm: Add support to validate memory when
 changing C-bit
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
 <20220209181039.1262882-22-brijesh.singh@amd.com> <YgZ427v95xcdOKSC@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <YgZ427v95xcdOKSC@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:610:e6::35) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a2c06d3-a028-4fc7-de01-08d9ed83b1a0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3165:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31651D4C1DB3C3E82637A312E5309@MN2PR12MB3165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsG5BdStCu/3NFUeSftfdzgaazIkMG/jjhVFlJKTK8YSTD12H62bOKexNNGw9l+abVBpQB0yRjAH5Wl60qTNes9q+DhweeysNP1tN4iha2jJZrqYCyGtkifZUpL0ITzOvfdioAbIte8Xn4HqjaVgMQ2ROe+UxWJF2ahH72oweQSbGNSYIfzXEEuPc/B1yz2KDuj02N+ZK25M24UEES6bzGjiTbkBpmHSXpHFdH9OYaFAO4ZwVcVXkq05OJjEDVfxGEiYVliZnP8B+dhTdTU0LUkn6D6VDBQ7L/s454+S7IcG4M0A17VDggJIKp+nnPZZpuZvMd9b82sQPV9gd1KnLt5R2Km1SV2t0ubnVgqlbM234uW6n8vvmsd3I5iIzRzHTCk08slZwL7Rdotx1zzOdrucBlspuPv7utOSYcCWn/jQhLmrCcOhAUUGRbaaHAC3YVuKE43LWTTj13U/NqH2ybcbtQPXs3bS+BpMdkmfye6gZxI2CERN3ZNydr6jfEtmIYXYwBdhKrzoIL2UgBJZx5a5axbDeor1noJZi1mJWnz8HpKkv50gRuDctWwby8eVZTStejrjPW8iGLU4ye9aj8q9+tjPpTS3VsTFtEuoFyfTwc20KaQeX4I/VVZYzRJspWju14a/WtuLej2xCWVUXluedIu0M1nMKHylbiQ/+WTLn0mMuxjEeaz3NTmkbevWeIxouGag2hL2fBAjWjnMQbMz0l9Z17/SPsUT5xZGVsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(36756003)(4744005)(186003)(2616005)(26005)(44832011)(15650500001)(8676002)(5660300002)(31696002)(83380400001)(38100700002)(6512007)(31686004)(54906003)(316002)(8936002)(66556008)(66476007)(66946007)(4326008)(86362001)(508600001)(6486002)(7416002)(110136005)(6506007)(7406005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3lJWTlxQkpSOWNDNDBXWm92bVpHNTRCWEtpd3k0TDcvWUNCU0wxQlFHdlUy?=
 =?utf-8?B?NTJmTHNxMXRoakhZT0dCTDNiTmhwZkt6RnZlZlJNNWx4SDBKMXcxdDVmMUVZ?=
 =?utf-8?B?dGJoeFlnWmxCUjN1Qi9FNk5xbHFKSitnQXVrM05nZWVUcnlsUGxKVVlrY28y?=
 =?utf-8?B?a3ZKaURGQ3ExSmoxVk95MDdlMURiaitGaGhjZFQ4Sng1K2RPamZ3MVN0Q3l2?=
 =?utf-8?B?aXlwK3M0YU9SckEyLzNMd0tQRmdPSVZ2cjZKOXVpMjBhM0V2bmNqZFcrMTRx?=
 =?utf-8?B?YUZ0NW1yRnFZRWdRZERwdU42bzFNbW1tdFVreDVuZjEzb3FlcExiTmV5OEV0?=
 =?utf-8?B?aklIQzhSdG9ncUxWT2xYRU5LYVVHcTNrTGlETkFYWEluOUkrU1hWNFd0SHlV?=
 =?utf-8?B?ZzBWMnVBU0VJQXBBUHpmK1FXdlpkaEVGR0J4eUFIeWtoZTVrSkhmOHBiTTdT?=
 =?utf-8?B?eUtWbTd5MWpVS1pUREtVaWxDY3R4MUg3U083ZmRNeW0wOVhXdjAyVGYwZWZF?=
 =?utf-8?B?SCsrV2s4MlVOaDBLaXhiK3FHa1N2L21vUHBOaHoyVGJaRWxwWGxXSDQ3ZUNk?=
 =?utf-8?B?b0xsOUdyRjRXSjA3QzlOWURkMTdqU3RaZWRmTVN5S050bW0xSy9XYXM1bGNI?=
 =?utf-8?B?T1BLaWVZWXdnRDY3Mlh6N3RlbG43cEJUTWJsL3pvM3RUQ1JWMWF1TDl3WVcz?=
 =?utf-8?B?OTdmWkFWeGZYN2R3SFpLNzlBSVg5REFaamFWZVlidUdwK29jazUzT0V2a2lH?=
 =?utf-8?B?aG1uWmVBbzh2bFhWN1FDUkFNYjBWdklaT2FzSURSSjQwMjhMSWZBcTd3dHNN?=
 =?utf-8?B?S00wcUxqRlZWVUpYeU5tcWhHR2lGSW8rQlJlOGM4aTNUcDNERDU1R0tDYmtT?=
 =?utf-8?B?b3RPYzlIZW1nUXZyM3Q0dGJMRExoTnFXOEVqMXhMdnFTcktmZ20xMzNUemVY?=
 =?utf-8?B?WkUyb2Z5Sjk5SmYrVGtsVXQ5SmxyZ1dCdzdzRXlGVnFQYVhpZFhSRlcrSUhr?=
 =?utf-8?B?VVVqZS8xdUFYRDhPaGlzY25EQzNEdWlOSzU0ZWgyVzZicE9jVFFueURNeUVw?=
 =?utf-8?B?OElUZVpWampCTWtQQ0krR0YxNnNsU2h6WTl0aG1mbXMwbmd6UXJFMXVXR0dY?=
 =?utf-8?B?QU1CMmtiU2ZLR2FFOEZuaFdITkJZcGNVNXVid1VWcy8rYVYzcVQvelJYNDln?=
 =?utf-8?B?TGJKZHdRSitsOFNFVXF1UWlFS1pzQ0ZaRXhlUDZyUVhSZ0M2bW5RbGFnb0lk?=
 =?utf-8?B?QTROeDY0YWk1OFpybHgxQ3RGdzRxOUM4YXVocWJkSk01T3QwckFpODNMVGt4?=
 =?utf-8?B?UFhzK0JWejNOZmZVbmI4SjNiTVFRekdVUThnVEFzQmhHLzlsUGFDbjNhZ2Nk?=
 =?utf-8?B?akZuaGtlcVBZU2lNK0NWc1RHaFc5ZkZFYUw0RkxvNFdtM3hnOWpQN1JFS3JC?=
 =?utf-8?B?bk1ERWRXOXg3UDNrWklsVG84SGg4b29OUlIyTGQxbGNTNk9pTTNRaXNKY201?=
 =?utf-8?B?M2w5WWYxVWx1LzZHc0dqbDNVN3kzRXA4QWdiNUJMMytoWlVpTW9HNlh4bGpT?=
 =?utf-8?B?d2Q0Vm5SVEluQXZTY3pLa1o2SlpRdUdOZmpRelVCOFJMUnhhM1FENWdtOEhN?=
 =?utf-8?B?M1Jlamp2anBOL3lBR3o4ekJ4ZWhXTlR0anRCUDlzMFpUWGJMZXhEZTJRYkhn?=
 =?utf-8?B?RzA4ekZ2dUt1SjVraEtkL1VPazZVS21kRnplanhoTjdHS01Bamdqblp3U2F1?=
 =?utf-8?B?UEJrVUpzUUtSdDMwQURYb1V0OUxhR0hkSlpoL3VzWkZkOGYzR0oyZU51dHZk?=
 =?utf-8?B?OWxwT3dTWDl4Y0tYK1VDclBLK3JCeU5hb0FQQm5WWmF3MzRsQ3NZbFlEcDV6?=
 =?utf-8?B?UEtvd3FjRlM4L09HSHdUSWVHTEtZQTJ6OGl6SXhvRFQzVVJLZEtRWlhlK0Ja?=
 =?utf-8?B?b3hSVWQ1TzlLQzRuNlZsazNyVnlNWFdSSnpqNVlQVDZrSjh6K29STDVnMGR0?=
 =?utf-8?B?MWpqVVp2TTFZS283aC9sRDI3K1NudmtoWDZYNlFsaFhsLzBTRnRXRWhNaXpu?=
 =?utf-8?B?dEtyQlhORXlKTHhyL3gyQmlGVncxTWFlbkhHeDJlQjUrcVkwNE9Na2VBNkJx?=
 =?utf-8?B?NDFoSXhaM0RkRGNZOGZJZFhWV2VFNk14c1lZamVCTUNuYUlaY3BxS2dKaWdk?=
 =?utf-8?Q?PrktBfh0E+1e5UenahrLIaY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2c06d3-a028-4fc7-de01-08d9ed83b1a0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 17:26:53.0931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diqyZdoGKfeN7F8AcJP0UhVRscSTxZmLPlqAhvGHUCjcmQd+jBrleFMetewig6m+OgjbRbaFKH/wvrh7WvogzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 2/11/22 8:55 AM, Borislav Petkov wrote:
>
> Simply have them always present. They will have !0 values on the
> respective guest types and 0 otherwise. This should simplify a lot of
> code and another unconditionally present u64 won't be the end of the
> world.
>
> Any other aspect I'm missing?

I think that's mostly about it. IIUC, the recommendation is to define a
new callback in x86_platform_op. The callback will be invoked
unconditionally; The default implementation for this callback is NOP;
The TDX and SEV will override with the platform specific implementation.
I think we may able to handle everything in one callback hook but having
pre and post will be a more desirable. Here is why I am thinking so:

* On SNP, the page must be invalidated before clearing the _PAGE_ENC
from the page table attribute

* On SNP, the page must be validated after setting the _PAGE_ENC in the
page table attribute.

~Brijesh

