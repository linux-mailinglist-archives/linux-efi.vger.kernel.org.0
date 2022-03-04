Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D046C4CD815
	for <lists+linux-efi@lfdr.de>; Fri,  4 Mar 2022 16:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiCDPkS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Mar 2022 10:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiCDPkR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Mar 2022 10:40:17 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDCD1C65FB;
        Fri,  4 Mar 2022 07:39:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHEpMG8bqdLsAOt1GoP7RFRjUVU8KNgoIg9jql9JG+QiPdrogxsD1Rig5sf+gMB+jaRvLGH/U+YVtLRKQ+iitU9qGBXr/rSnUWE3xR6AYdYf064MU/9EedtUjcQuH6raF0wsh5wTFRaLVS77cv7qoMjgADQQyy9oV2CyreBdQ1aTd1f3VLKox3Cfai75LY4ba0TdV8WK4O7MwXU2TlyREQOEQdCPc02uffivPZiCTO/+EaB6+sGyDr3CNNYIl03MOiuFruPKCl+AFtKFkyCV5vCm8R0YyXx8rX6OhVzhR/zf/8uPBt/ldQH4D1AUdldruOtejugP1b+Tf7RncqaPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cg+T1CUBu+Q/E9GUOeZjMV4lDSiKpdHcoLsRkvh2KFw=;
 b=l5X+s0rTj9jxlJqzBekaEAZ5gHCc9OdG6S128rsoJV9Y42Ctn9T01oBqDnGUSoqSNcjk5WzQCCjie1nNFfUNAlTki0LuTz/29v3CGIOGSR7k3HCIC3QJ3yuWerXrJ7mA+ibnoGryzsY92BMbvC9oC+D3mmtFVO//TBGwdQ7h5EVtk1KU7jv727H1N5gUM9Ar4Fxzp/Sx7KWcLQxlTbBMA1on75f7RBVzdKT///08EwNYMeymmbsQNZCDR5I8qOPGpqc43Lih1wqg2aVBbEIXw2BE9gHvqFIkYfWQFAb2TcgHdGlIkbwTF2S2wqDh22aAWbXdua/Yd0s913OUzJCkNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cg+T1CUBu+Q/E9GUOeZjMV4lDSiKpdHcoLsRkvh2KFw=;
 b=LMVhwKya4WlgeKP5xldY1+tK4LC0lWhqE4iEE1joHv0d8Q0bSlRM1zRI/keSlYGmFrdHYWU/WVIjuwhRCxfKPhTStZhOGE4zguBkt3PX++LXnYekA7bOCMksuY5ePnzVdfvDzHpOjf+IGkP+ea2/9d85LMc1Eiegjm2JDyUBajs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by MN2PR12MB3198.namprd12.prod.outlook.com (2603:10b6:208:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 15:39:23 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::88ec:de2:30df:d4de]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::88ec:de2:30df:d4de%7]) with mapi id 15.20.5038.015; Fri, 4 Mar 2022
 15:39:23 +0000
Message-ID: <c3918fcc-3132-23d0-b256-29afdda2d6d9@amd.com>
Date:   Fri, 4 Mar 2022 09:39:16 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v11 44/45] virt: sevguest: Add support to get extended
 report
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-45-brijesh.singh@amd.com>
 <YiDegxDviQ81VH0H@nazgul.tnic> <7c562d34-27cd-6e63-a0fb-35b13104d41f@amd.com>
 <YiIc7aliqChnWThP@nazgul.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <YiIc7aliqChnWThP@nazgul.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:610:b3::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9df500c4-65cf-403a-0c3d-08d9fdf527fd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3198:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31980A0C690256A35FFE541EE5059@MN2PR12MB3198.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TaQcVtzovUQhR0KCyqadbTmiWGzD61SFhGVchKdRocGjKIOaoVUGZ0eYDR7OiSQuogFFuqR3qP+meVpGjQs19ubl2c+w2ZHDx+C5iZOub6W+b/qj9MTF+oaLDWVMOv3G8H+/01iVopZQxeEtLU5ssF0bjSfcrh4jLmX6q9k6o9kCHJVIuFRvTUYYqYTXCcTPHA0w34MLOLyhcjzl1uFzQemfx86Sj+Oi5AZuL2rry22lepsZr3o4RYbhjNAJg6GVDHUXiso8n1AxipwwI7J38B0SIhOyPnY6SehssHScbTobJ0GsV364LiijuGp9/I65meEphb2Akncj/Y7TS1LnICoQtm2S9AX62pz5ndd/2ATPZ7mO/F17DO/LsjS7ZuM2XBIESluwi5yl7Eq0qpwoVX20IvKu1DNbC2s3oO1mfLmNJEv7bdbGvlNeONWM3DkbEal4gGZgthEJgnhvZ27IXnox4KwoImBbVieff+lNoxqAr2Neqsp/rzrK4tSp7RqjcDC4NMr9KszN76Ys8WsvxWIYIjMrGPYgs75MwXoA1WjgJ+1aDkFzQHfzBeNUlhXFbn07zGHLtSyOmw7LkC3TzRbLqUumgDpp+OEhMmcCRa0f8ngXDyc/tPuI5Wk3wxwSi1TkGZUMKgtsWCM7kC5Kw+xiyFo+moBesg/Ih1nx5iE6n023xOYoMvkNJmlnBN931klL0mCGNVBU2PZLZI8paoFqoTGrFAEHTuep5hBEY2XfVJ4Q6GyeujC0pMex5oN1rsq0/UrPCh9HjlfID5TFlM5eP7pZocRsd/OHdMQ7L2MUDadX5O6KJXv++Uudfa2B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(31696002)(66946007)(316002)(66476007)(966005)(6486002)(8676002)(66556008)(186003)(86362001)(8936002)(44832011)(508600001)(5660300002)(7416002)(7406005)(45080400002)(6666004)(26005)(83380400001)(38100700002)(6506007)(2616005)(6916009)(54906003)(6512007)(2906002)(53546011)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2NwMmUzOVQyY3hPcnNXdmFXQW9rK2p4UUZjSVFEU3ppL0NYL3ZjRXQrMDJa?=
 =?utf-8?B?NHYwRW41a0V3b1dQK2NzS1pLVDJWQ28xcWdyVlB6c1JOUFF0NFo3Rm9VWjRZ?=
 =?utf-8?B?bmRtbWIzWFhPaDFsaDdOclR6WTVnWTZsd290V2Z6N0hsbkpFZi9qMmFsei80?=
 =?utf-8?B?dzFFSnE3alkyYVJwM3JYN2c0OVBKTEE3RmFtMGkzR2xSc3h1bVJEMHNlWmc4?=
 =?utf-8?B?VWNlbjZGTFkySWxuRjUzeGJFcUJmTS85K2hMd09FMFFOdnlUWG5hbTFaNE9X?=
 =?utf-8?B?WXNUd2Y0WURZZVA0MmxMK3hFMFQ0eWhxN2x3eUw2UWtsSmxibWQyYlgyWEUw?=
 =?utf-8?B?TTBOZFNIUWN3U0RWNS8wbWZqeHJxTTZDUk1nWkxYakN1c1FQbE9yTHJEbCtl?=
 =?utf-8?B?a2x4b2JFR1VBQ2w2MTJQQUVFbHZWb1BPQTlNZzl2bEUxcTdScUh6VDZLeW9i?=
 =?utf-8?B?c3gvdEMxck9UcFRkWlZUcFBHOFE1Z1VwQUNKK2gxSjdEYWdVbWFHOGJjcjIy?=
 =?utf-8?B?V1lkS3A5TEdEUEJEMHdGNmwyeFVPSzA0RWFsZW54enhvcGVOMVNkUVR1WWJ5?=
 =?utf-8?B?b3BaSVVYWjhTSVJyN0VjRWFwcGtuVURncVBpd1ZySzgxZktGOTEvSTRjS0pW?=
 =?utf-8?B?VzQ4RUM3cEMwd1VsS3JkbDUwV3lXTndJK1Y3ZHpXbDZWYkVBL3NvQW1nN1Rx?=
 =?utf-8?B?NXJ2ZVVpN2htcmxweGl2RWt5T0tlZW1sK1BlWTJiRytzendXOUdZUDBPNCtw?=
 =?utf-8?B?VTZ6OUxiOFZnQkZMVC9wZVBhVkVLV3RqbCsxdjU5VGJOWmJqejlPaHltMER6?=
 =?utf-8?B?ZkRJc2pPSCtJd01tRnc3NWNWKytPTHFhWmI4MllSVzdVQmxRSHYvVTRGRFV2?=
 =?utf-8?B?ZVB6L3VSUEZkQnhmNE9pZ2Vyc21RYVdLcTlKYmprY3EzQm5NbXFmWnVLaGRE?=
 =?utf-8?B?QzlUUmxPVTRZeVUwRUhLQ3JDQ2dGVElhWWJudENBSHc5d2hpQVRQeVFqUThy?=
 =?utf-8?B?bE5hUExmaTJYTGxuY3cyNnJjZmc0RFFESGlDckVGMTd3L2FYcGQzRnVnbWtx?=
 =?utf-8?B?RzJ6OS9ObXpyc3oxeml1MkxhUDQvZUIxalVSWnBZbVNWQzUxeHF6bTBWUmo3?=
 =?utf-8?B?VS9YNHNZc2RTb3dKNSsrUGU1SkJKZDdnUHB6bGx1b2podEY0NjZodUo0KzBu?=
 =?utf-8?B?clZhUFQrUFJib2Q5N0oyZFNvU1YvbXhrVUZ6aVhhYjgxdjNDbUlhVjJqZ1Av?=
 =?utf-8?B?STZ6c3NQQzlMTXFONTBZNTA1b0ZBNk9WWnNjaFhGeGJVVmxSeUVqVmRKVGdE?=
 =?utf-8?B?NWJsejYwTWgxdDhEVktGaHlZUlE5bEwyQVlZMGQ5c0N2QXVTYURHZzZBdXFK?=
 =?utf-8?B?RHVYeExjSEZXYWtwVnFVN1dQbkJDWDQwbi9lN1ZMeE1zaXRFZUJtMExvRmpl?=
 =?utf-8?B?MGtSTXQyM1Uxc2k4NHliU2xGaWF0N0V4ZmxnTWZTQ2RUWkZQUnl4aUJGU0k0?=
 =?utf-8?B?UWZETW4wRWVrMHNBK0tMWTcvRzB1UGN5bXhRR21TcGNVZHl3TTVOdWtkem41?=
 =?utf-8?B?RnhCRGV2dWF0WFFvNERoOGdkSVNKTUJML0F1VTlob0ZkWGN5VzVhdnR0Z0pt?=
 =?utf-8?B?QXAzem11NlBOeXYxa0JlTWoxaXRGWHhUNlhDb1pGZEdWZ3JjbDFwTng0dFE0?=
 =?utf-8?B?R1dtSTlRNklUYnNKS2hQaldxL3lHbUloWkZnckVIU2JOWkFNWW45MmIzR2Nk?=
 =?utf-8?B?ck8reStPNTFPcTczekcvUldEMUx4MlR2Q2F3eVpaeDRZZ1V4cE5IQ2xyZFNy?=
 =?utf-8?B?TlBxbHA5SEFwZGVKM0dPbWE3SlhNZDlwUUNHRXFiZ3dwREczaS9SOW9UNFow?=
 =?utf-8?B?ZVhMN0lHTEVFL2dsdVAxQ1NvcjI2dWRRWDhadnBOaXljRGpNcXN6VVE5TSs0?=
 =?utf-8?B?TFdqVFRYL2dSTUh5RW1vYTlPYzRFT0RRa2hTdzJ6RXRRQXhrYS92WlYrQ29m?=
 =?utf-8?B?bW95RlRreVFhTnVrcG9NVnllcGxibGlDbXRJWUk3ZWVWMVN2MFRsdGp3eFhT?=
 =?utf-8?B?eGpoQlNETWYyVUpmMjQveng5MmNwUVE0cEt2cjZFTmh4UGpvUS9zNi85c1hV?=
 =?utf-8?B?RnFTODBUNm1yMzhielhGNUVZYnFLcjFHV0NsZ0JFTHVFeWRKUXFvWjNBMVg3?=
 =?utf-8?Q?S6P0rmRRaZc+31lMhQ8GsyQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df500c4-65cf-403a-0c3d-08d9fdf527fd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 15:39:23.1064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pj6m1VVMmD0iHzyO7Z0wUR/lrKaTvB0NAJnDDHZMFAZLgg/66WHJk0aaYeYLaOl07IgBcmc6BUGFOWIcc72A3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 3/4/22 8:06 AM, Borislav Petkov wrote:
> On Thu, Mar 03, 2022 at 10:47:20AM -0600, Brijesh Singh wrote:
>> I did not fail on !req.cert_len, because my read of the GHCB spec says that
>> additional data (certificate blob) is optional. A user could call
>> SNP_GET_EXT_REPORT without asking for the extended certificate. In this
>> case, SNP_GET_EXT_REPORT == SNP_GET_REPORT.
>>
>> Text from the GHCB spec section 4.1.8
>> ---------------
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdeveloper.amd.com%2Fwp-content%2Fresources%2F56421.pdf&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C10f73f9bd6524f9f9c4e08d9fde843d5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637819996563585169%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=GS3iyUCAOmaPuxN4sRi%2B%2FFTsRGF7QC1jISc%2B25c4XtY%3D&amp;reserved=0
>>
>> The SNP Extended Guest Request NAE event is very similar to the SNP Guest
>> Request NAE event. The difference is related to the additional data that can
>> be returned based on the guest request. Any SNP Guest Request that does not
>> support returning additional data must execute as if invoked as an SNP Guest
>> Request.
>> --------------
> Sorry, it is still not clear to me how
>
> "without asking for the extended certificate" == !req.certs_len
>
> That's not explained in the help text either. And ->certs_len is part of
> the input structure but nowhere does it say that when that thing is 0,
> the request will be downgraded to a SNP_GET_REPORT.

The decision to downgrade will be done by the hypervisor. See the GHCB
spec (page 36), if RBX (aka number of certificate data pages) is zero
then section SNP_GET_EXT_REQUEST section (4.1.8) say that hypervisor
must treat it as SNP_GET_REQUEST.


>
> How is the user of this supposed to know?

Depending on which ioctl user want to use for querying the attestation
report, she need to look at the SNP/GHCB specification for more details.
The blob contains header that application need to parse to get to the
actual certificate. The header is defined in the spec. From kernel
driver point-of-view, all these are opaque data.


>
> And regardless, you can still streamline the code as in the example I
> gave so that it is clear which values are checked and for which does the
> request get failed...

Will do.

thanks

