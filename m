Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52814CC329
	for <lists+linux-efi@lfdr.de>; Thu,  3 Mar 2022 17:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiCCQsN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 11:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiCCQsN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 11:48:13 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775EBE48;
        Thu,  3 Mar 2022 08:47:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRX5+F1XCT/nI7Y/sTJ2SHAYSG+qU4M8Q1TUga1KuRs6XlQ0k4caeMCg3WLVMn35IJCxdiEiB3uX64tT4CzA6igdAzEwz+76qc13U9FyYQxuyRQYl7CoD4yg6OJjVhRksWK0gbOUGkGLeOikF8dXmf076Bp15rZbuGKX+2Uto+go+1/zrh/NgflOepLxHYPPoz+IiHy/i0psHisCV6zT4gfKhIuhBKKsf8FIgn73l3xl+iJIe5ooVy3bVPnbO97SgNBjNh1XAcZdlYkw5ptFYf6zcNkkyO1Cb3OITYyfmbua67A0O9+e5LJVtkH1mzCTbkRYr6qpJYcWzbXIiyjEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BG7715QI1Glj0SyhZsl0JiDQWN21fJQ2iNWcI4ICbEc=;
 b=mP3IXI4nDVXCbVnM0blnjyOT7rcQ3UfyU2nJrMXr95x5nGwQX1HBlCkJdSo86CbS7cbyyES9ilxQfO/tq1nSqI0M0DxZp62gdy0dv45CB/TDrYiIf/NHhXXAq1hyWSPNzu1SDfG8tADt8k1IO/3ziB1XoiT+0QWP/tge4VV++2NN8rZ19mtJdM2MBDXGvZ/FgYSkocP5Fa6mU/VrRUXc5FZ139DBUwkJGLzQMS5XFyIvt2x7OT+bz52kgzy0D4qNFmMFHkiHBMAZIP2z59rU+qY3WP9nRisd6Zup2GC6+9k0LXzV8LhMcOAsTqP3zDKfkIqEcZxB1OFODt4YP8kkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG7715QI1Glj0SyhZsl0JiDQWN21fJQ2iNWcI4ICbEc=;
 b=Vl+fBUcvkVgQl7kvD5GmjPm/sdZt2lab96mjX9yEVsAg7p9qUlLNizQ3ag9Ig9OGiHCbs9isltOgDxhiybawuHpbVgp3h0DdHko7rVN1mgzC9L5HtmZjTVBZ/32/mfKzqppQ4udM6HYIWmTo8V7Jp1zw4Ttn9nDnY1u61a2mFwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Thu, 3 Mar 2022 16:47:24 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::15e2:e664:c56d:4d91]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::15e2:e664:c56d:4d91%5]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 16:47:24 +0000
Message-ID: <7c562d34-27cd-6e63-a0fb-35b13104d41f@amd.com>
Date:   Thu, 3 Mar 2022 10:47:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
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
 <YiDegxDviQ81VH0H@nazgul.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <YiDegxDviQ81VH0H@nazgul.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:610:cd::29) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3c1f970-31c1-49af-cd0d-08d9fd357dee
X-MS-TrafficTypeDiagnostic: DM5PR12MB1578:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB15784C6EB1EA524D31AD5671E5049@DM5PR12MB1578.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +L7TU+6hzfy21gAJNYVuRNDwIb/WZ/9v/8ou+2iiUCgWTryq+w4sAPBtBTCXlCa9ejoQxd8lHVebxdr27vpWlryNi1EChsA2chxxQCTy9yy+y6Amg41liNhnhx47F8Y70c2ozzuZFntvNNg2nj4i35IpTyOy9VziJs5rDqQvlPwqB755f/uCW+Q5kJw5oUEbLb9IlRAuCGMLxQUJUuMFPlpqtVIZ1zGLxrwrVaDxjYGgrmok/cqhtr0+DkFEMgcCKDANgIvWx5kFddgLnKOJouIN1bTe1Tk1Xz2J/xA4vMvVTp7RuawDUSTB3kIdAYrUwjXPIJ+BVSKvZM4bej5VBVIM2cFqUMLuHggwuBo/Nh3BMSVo0kkFsSDtVYoKl4nlZJm/eZa2NUuYeiK2dPyYd97phDIOE24aNApGdOLMcqgBex0e3vXkWHrHyam4Ieo7/QvNaBlo4zUP+CdrQLfZU1sLSSuxtXgNUd7AGujyuSzRBsxxEcnRGySNIuESAZcJE5uWfsUyg6idstd1ugSj0CkbgsgtuC3OddvooMu2/+kOwLz5Q4jalhaawzSjUt/z51eh4nCzVl89IuHfY2vXJtx418ISQuWJUwR1WvqYckyoxuzdnfnNWPqD8cJTpYaadjnQaRbXffey2quEp7jbC3QjIkixeKnS+El0Kpaa/e7S/YNyusZSdd0DgLMZot7VHfpjbEMFruSElye3Bo3tvgppHFsMHQDRLzluRvsJFb/jSR+V3g51Br6HN/3Soy/sHbsbnwuyVy+hK2QCrqGCWM/W9DmJS1Trkpm4Ld4pRyirsLH0PvhYORDzV0ATN1YB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66556008)(66476007)(4326008)(26005)(66946007)(186003)(83380400001)(316002)(6916009)(54906003)(6512007)(38100700002)(2616005)(966005)(6486002)(36756003)(31686004)(6666004)(508600001)(44832011)(8936002)(86362001)(5660300002)(31696002)(2906002)(53546011)(7416002)(7406005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWsyZE9QZ21MSWdMZHR6Rk5FcFZCbXdURFNsVlJFNG93Tlo1RVpMNGhXSHNN?=
 =?utf-8?B?Mm1SQWdmbk5OS3VKRlBjS25FSHhPaWEydzZsWlZLRFR1MXhKd2JoN0RZS0pR?=
 =?utf-8?B?Uy9JdjljRlg3WnpIWEp2djdrcDNQRzVoRmlmQ0Vnd2NLVFB1bzhXdUdhVXpl?=
 =?utf-8?B?MCs5Q3JDNzhWZUd0QlBTRWpKQUYrbkx1RTErTURhYmdTL1pIN1ZUT3I2SEJL?=
 =?utf-8?B?bUJScEdmQkEzYjBab0ZJc0pKeFB2ZDFIVGc1Y1dJRHpjaTRNYitpNXByaXY3?=
 =?utf-8?B?cTNBSGMvM044eWNrUnQwbVkvSW1WTFcxR1M5RHp0SFFjanE3VEJ2eURRUW9E?=
 =?utf-8?B?L2JNVWZUanVvYTR6M0ZISHFnb2tTajdyeEllUjNjRTZjbndsSkZTeFIrRFNL?=
 =?utf-8?B?WFdYWDlyWjQyaUFvcGtrN1NhUmJ3Z2F4ZXFvQzNCUjhqVS9LNXVQTGtGWUxj?=
 =?utf-8?B?cFZqNjhtMHFDcDkyS2FkOTZ5OUtiQ1g2RFVHTEpQYlhvUUxDWVlDdlZXbW5t?=
 =?utf-8?B?cm9RV1U1TVoxWCtNQ1c4NzNObUdlcjB4bEx0eG1tU3hkVEUxdnorRzZkd1Fl?=
 =?utf-8?B?U3lTeGRwa2Rka2hjbVI4Qy9uODRXL2o3UkNHelhnWWRUMXlvSlR5WGtHUDBu?=
 =?utf-8?B?ejlEemRpSWtUMkpJTkFoWGtWSFZyTTh3emZjQ2FWUFkyUC80S01ITldKVWF4?=
 =?utf-8?B?NWdUd0tpTlB6UTdBTmp5dm1yRnpML0RUR0xoNlEzNmtNL01waUVhRSt2bWpY?=
 =?utf-8?B?TTZZTlJIRnhMczNYOWhXb1pJd0tQMEYwcFlCUTBDem9MMTloMURETys4Nlk2?=
 =?utf-8?B?azh0L0wxYVNtdVVpOEptOW1sbGN5alFSVEI5MEVMdFRKNEVLd1FvcGNrL1dy?=
 =?utf-8?B?amlTOGgvb2xYSlMxWkJubUVNR3ZKRzdKRUJQSk9tcTMxSG56dGdhd2d1TGU5?=
 =?utf-8?B?bVNodzBrYnVqQmN0c01OTWYva0pVWHpCSTMwcyswM0k1cWJTZU9HZVdRem9a?=
 =?utf-8?B?d1grK0xGWGhiOGlSNjRmbXl3RXp3alJNc094VFRTQTlITUFFalhhenAvSlVB?=
 =?utf-8?B?RGdoUS92eDZ1R3JiektObm5NUE16MllvS0ZKNlRXdlVPTDFtcjFzNGE2bnlS?=
 =?utf-8?B?S0s2NGJtRmdyNVRtMU5JYmlHeFpmWm5mSmlxOWYzditDTEh1cGlFRjRyY3kv?=
 =?utf-8?B?a1h2K1Y2b3h4T09jVmo0YmF2dGpNRWhxQ2R2Rk1ZMU1peXpSZUFzZ1k3dThU?=
 =?utf-8?B?cFJBKzdmaGZPSi9DczR4OWZ0TnBMaHkvN0V0d2JpTHE2U05rS0w2Vjc4V2pz?=
 =?utf-8?B?K09zbHovODkwQysrVlhaZDZxcGdkQUZhTjczaFVVT3BJS2o5K3kyMk9OaXM3?=
 =?utf-8?B?N2pFZStYeDNrbXo1SjYxYmtuckU1Z0dzV0FtSE9XekFIRDhxWWJGbHk0UytX?=
 =?utf-8?B?ZXZrZS9UMXg5My9QZzhaZTFOM3pucVVxYzZLYnQxRFFvSHBuUkpSTE9nVmYr?=
 =?utf-8?B?czlUK0ZhdGlOQ2RlVFFxdnpzdXJ3NFdpOWFYU1hJM2w2MDZpQUpuMGlUNjRw?=
 =?utf-8?B?TTlZenM3UXhyQUlmdUlreVI4a3VaaEs3Wlh0NjVtRElxNUs3NmlVa0xMZk1o?=
 =?utf-8?B?dGxRNlA3dnFpL3NYTjh2bVBwalhDejRyZGlKK1F0R2Q1QjFtUE5vVEIyNXdw?=
 =?utf-8?B?dVpIRjB1Y2ZuM1pHd0hFR0poL3hDdm5vU2V4c1UvVEdMYmZ5Z2p6Z1R4N1pF?=
 =?utf-8?B?MUdXRWpQdTZBSm93Vk5jMnRtZjBSMEJ1QWZ3QnB6MGZkRWtvck94aTgyYTV2?=
 =?utf-8?B?eEs3dlJkc2VUMlhHWjlFMGNsa2R5T0tnZXhhRzRKOGlKRmVnQU16UFIrT09X?=
 =?utf-8?B?NHBIcjFRTmhEbTdwbHFZNWFPdzVWZFp0bWlmdk9aejgyODhsV0ZyckxCT29L?=
 =?utf-8?B?Si9sZWVyVkZYTUlMUmIwSWUvenhQVWZMY0xLYUtCeUc0d2lUQlZaQ2ZzdThn?=
 =?utf-8?B?UUZuR0dhVVFJQlBiMWFWR3pDU1BBOUk5L3hJVEN1a3VjSlk3RitkdlRydkdx?=
 =?utf-8?B?TkhtdFY4T0FzQm9CQ0g1K2lubDhxaW5HQ2lSR3ZuZnhoQ2RjcmJrdFJVdTBB?=
 =?utf-8?B?UW5KaEhCcE1BSHRzWHkzcDZVY3NMMXhOVDllUUlxMDN3dUZVdDBTWDBXWE8x?=
 =?utf-8?Q?GqtAvN6NOJ8X5hIzsfqFZRo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c1f970-31c1-49af-cd0d-08d9fd357dee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 16:47:24.0344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zwctsuSfAQS9BN8NzyjqIDOx0VX4dqUmbjb5lYrwJVfDS1lJh005BaEW4KI3yX0BceoP61U/wQoIiYNS5g0SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1578
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Boris,

On 3/3/22 09:28, Borislav Petkov wrote:
> On Thu, Feb 24, 2022 at 10:56:24AM -0600, Brijesh Singh wrote:
>> +static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
>> +{
>> +	struct snp_guest_crypto *crypto = snp_dev->crypto;
>> +	struct snp_ext_report_req req = {0};
>> +	struct snp_report_resp *resp;
>> +	int ret, npages = 0, resp_len;
>> +
>> +	lockdep_assert_held(&snp_cmd_mutex);
>> +
>> +	if (!arg->req_data || !arg->resp_data)
>> +		return -EINVAL;
>> +
>> +	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
>> +		return -EFAULT;
>> +
>> +	if (req.certs_len) {
>> +		if (req.certs_len > SEV_FW_BLOB_MAX_SIZE ||
>> +		    !IS_ALIGNED(req.certs_len, PAGE_SIZE))
>> +			return -EINVAL;
>> +	}
>> +
>> +	if (req.certs_address && req.certs_len) {
>> +		if (!access_ok(req.certs_address, req.certs_len))
>> +			return -EFAULT;
>> +
>> +		/*
>> +		 * Initialize the intermediate buffer with all zeros. This buffer
>> +		 * is used in the guest request message to get the certs blob from
>> +		 * the host. If host does not supply any certs in it, then copy
>> +		 * zeros to indicate that certificate data was not provided.
>> +		 */
>> +		memset(snp_dev->certs_data, 0, req.certs_len);
>> +
>> +		npages = req.certs_len >> PAGE_SHIFT;
>> +	}
> 
> I think all those checks should be made more explicit. This makes the
> code a lot more readable and straight-forward (pasting the full excerpt
> because the incremental diff ontop is less readable):
> 
> 	...
> 
>          if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
>                  return -EFAULT;
> 
>          if (!req.certs_len || !req.certs_address)
>                  return -EINVAL;
> 
>          if (req.certs_len > SEV_FW_BLOB_MAX_SIZE ||
>              !IS_ALIGNED(req.certs_len, PAGE_SIZE))
>                  return -EINVAL;
> 


I did not fail on !req.cert_len, because my read of the GHCB spec says 
that additional data (certificate blob) is optional. A user could call 
SNP_GET_EXT_REPORT without asking for the extended certificate. In this 
case, SNP_GET_EXT_REPORT == SNP_GET_REPORT.

Text from the GHCB spec section 4.1.8
---------------
https://developer.amd.com/wp-content/resources/56421.pdf

The SNP Extended Guest Request NAE event is very similar to the SNP 
Guest Request NAE event. The difference is related to the additional 
data that can be returned based on the guest request. Any SNP Guest 
Request that does not support returning additional data must execute as 
if invoked as an SNP Guest Request.
--------------

>          if (!access_ok(req.certs_address, req.certs_len))
>                  return -EFAULT;
> 
>          /*
>           * Initialize the intermediate buffer with all zeros. This buffer
>           * is used in the guest request message to get the certs blob from
>           * the host. If host does not supply any certs in it, then copy
>           * zeros to indicate that certificate data was not provided.
>           */
>          memset(snp_dev->certs_data, 0, req.certs_len);
> 
>          npages = req.certs_len >> PAGE_SHIFT;
> 

