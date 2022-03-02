Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ED34CA839
	for <lists+linux-efi@lfdr.de>; Wed,  2 Mar 2022 15:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbiCBOeR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Mar 2022 09:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbiCBOeP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Mar 2022 09:34:15 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905203701A;
        Wed,  2 Mar 2022 06:33:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwHuZ78euGoD67e1o3LUmvuinEnFQyoNQAKeChEP8J21NSxzX6x1qbeO6EAmIjQFmzSkkfIFolkBjdvvrONBTm3TuUChubrEce+RHFlH8+gf24fMzq+l8VaikVuvj4I3aMRj5z4WlGpgiz9HPENJzMhPAKsALpjUk4IXsBOzw8B8nQZ3EDipENAy65W602cZFwAz0VLMDSdyLxWMVQrsiT3AiXAXS06/Xl/rzhq7QyrUkx86kO98Rl1A2lvKRoNgHzKWVV7YQLaU3CmbbY1YgPpym52YZ2ncSzK14G03u0ISQBTGAHfWV0E1xruhoIKrFSBe/a6gw3y+o+jc14v8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98p80NeXqvujj7Hovlh7xtZah1YYbwsL8W1gv2jMo1A=;
 b=iDqL9iJ6K72tB78nFjNEJhfDiDqUvqYfNr42WkKIAA3A3bICuM9Ecg3oI8iOjREqzvuao/p1fSICovizLplh6vXSTZGE3j2MjmWN6SatPnLQZwmUL8BKVwL3FcbdWZPtszGBoip1G8o8k1QFIhXoin8nhTXdO2XtVStxNs2TNZnflc65FAp2r8DYVkCYMuMrFOToCxNUgtYYWejbUdPsKFVmQwyNoq5CsTbF59pP8WeobJfcMHZkmd0lxSDeGlghlVlA2jLSyG7ROUHYqbkbW9Jw0MVvUMs4teK3TtnDRToPsUVqCh1TimrrG4kK6bQfnrFtvFKQ+MwxohcKQyJl9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98p80NeXqvujj7Hovlh7xtZah1YYbwsL8W1gv2jMo1A=;
 b=Li1gYDziEF1IoMX1oEmUEz18LYlE5YwW56UC34vFY10tNiKLjfyEbB2/H85t7RJx/8CC/BVtQtmzHYu/L3nU2JCiMFVohuE+Rxe58MG9YiwnQiQiXXHWHRste8Bvut3W8lm0lrscTFA0sFteim47dIdrITL55sCgzmUpczgWBHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 2 Mar
 2022 14:33:25 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%5]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 14:33:25 +0000
Message-ID: <9d621439-108b-db42-d5ea-b390748d243b@amd.com>
Date:   Wed, 2 Mar 2022 08:33:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     brijesh.singh@amd.com, Thomas Gleixner <tglx@linutronix.de>,
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
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v11 42/45] virt: Add SEV-SNP guest driver
Content-Language: en-US
To:     Dov Murik <dovmurik@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-43-brijesh.singh@amd.com>
 <c197dc02-b63a-eb45-8e52-275934177d7e@linux.ibm.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <c197dc02-b63a-eb45-8e52-275934177d7e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0014.namprd12.prod.outlook.com
 (2603:10b6:208:a8::27) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e07740fb-7591-4c7a-72a2-08d9fc599c0c
X-MS-TrafficTypeDiagnostic: MN0PR12MB5738:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB573896226F6C6FF60118D4B7E5039@MN0PR12MB5738.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehik+t7UlYqfbXQnwKgc+8yiBrzJsPwJv4rICMSvdF6QNohJStMQ24Gb/dTyz8SXYAk3hOUpQu01ynQU76EAcIlpb8MjnJYLRSRWSpsMAO7M68HZrIpvPNb3nwaCs3/5aRFHhMZfD3c/rtLW+d3TV8FFx7F5W7zjBg+ezT8lrkCfcaFVauMRoRbIL27kHJIwdi7SVsQoJ44+Kbtcu4tETKnKZkXxowXYiCGdSGYTVTl7rxE5PMaiYvViioSLUHqYoSZqjLXGmfp09obBcmdA+IgC0PfxLOX7anzAzJokD8RpRXGQpbhy5ue1iV5qaZJpspocZRJWsZhPXTjmAnF4UlLbaU1RdKPYxcEYQmN9cIn8kYSLYzvjICcVDRYFzs/JS1vhM36eAxVpvco8ZX3hxxfAtLdE1fUj75ELqIhqPi+QY3BrbZ+PL4uXKZBGi5a8DbtBibkcH8LGnWxqXB8VjbKbhxTiOOl1BdGUWwSBvQKxJsggH8MuxHOdHlxz5pjLZGvt9tnO0ziQoCEqJN1dTWPl2Vh7kuAMQzM9etgcyVdZ6Zlw5sEVhu1snbHnOTjU5nUlZn9FZHjLM9dexMiWJ9NUBA+RFndmUZQGB7IGbXknM9D5CebfbptA1cqpS0gO5aUz4MrFfsCb7WE+Yrw78HxKeG6NIBEvEPytMRFawHbjocezYyZBir8TdaNJY41gzQpTSt4tx3xvtImcEf10ErQSqIIvSMlTu6xlosQWFe1uE5K2egtJT8ZkG+QlVtx6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(31696002)(66476007)(186003)(86362001)(66946007)(38100700002)(316002)(54906003)(26005)(7406005)(6512007)(66556008)(2616005)(83380400001)(508600001)(6486002)(6666004)(53546011)(6506007)(2906002)(5660300002)(8936002)(44832011)(36756003)(7416002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVd0Y3Bwc3hiOUZ1a3kvRE5FVHFpMDAvMVBOU0V3RlBLTnRDcS9xVks3VDNp?=
 =?utf-8?B?NmNRcW9hZVNkU1llaW5nQmtDQ0tuTHlWS3k2VndBT3c0aDFUYXl1M3FxTlMr?=
 =?utf-8?B?bHFWY3ljK005cHM4OWlCak1BRVp4dHZicWgza0JMQVNkSjJDMFM4dGZEMUc1?=
 =?utf-8?B?THRmK29sUzZIaFNBSSt3QWphUzZjWllZTHNzb3ZzVVBSc3AwZ014TTVUYlBX?=
 =?utf-8?B?Z2lUR3pNV2Z2WFMyVkc4emxQOGFhZjZjbjkzTWZMczRVS3M4UHg2Sk9sTXdY?=
 =?utf-8?B?OURTSkFoQVVwN1FiMnc3RTVnQVVYNVZyZ1ROUzJ1OFN3eHFXSFFjWjNRT2VL?=
 =?utf-8?B?VWJjMXY4SHNTWUtDNCtZNWhxSFZNc1VSYmtyRXE3NGtBNEFOWmJBRDNqZE4x?=
 =?utf-8?B?amRJbFNPbFhxVHNjUjVQSGtTd0h6NDByZnAzdjFrNXpQbjkxNDJxQWI4WkFz?=
 =?utf-8?B?eGYyQmlFL2RKT1B0Zzc3SU1ERng3bGpRMzVZcGQxNVVwRmVDVDBuUWlxMjNw?=
 =?utf-8?B?c0c5c0VUMmJUN0plWDlMOVkwNGdPUDdGMnNieXlFUEpaTytGOXA3WnFNNGY5?=
 =?utf-8?B?eHc2NTVYV3BMYmhkUUxyUnR4dXB1Ums5ZEVINE5oaEhaMG9xVVd4SkdRZUI3?=
 =?utf-8?B?YTNQeGExZXprc1QrNTkwYVBKVEwvVFkzdWJVMUhPWU1Rb0xQNklQY2Jub1lz?=
 =?utf-8?B?U3R0d3J0Q2kyUTlQMEVzZFFTMnZNQWlHUENqUll4N3BsUXFmOE9pK21xTG5Z?=
 =?utf-8?B?ZVhvUGN4bkxkRHNZbUtXTDEyeExpQ1FZN3FSSXRrY3c1VitQeG9IOVdFSWtL?=
 =?utf-8?B?NUplTTk5a0V4R1ZWb2U1RUNiVm1SUTJzTlhYMitHT0tGMFNpL2xJQ1pMSWcx?=
 =?utf-8?B?eVk4Z3NRREFVMzV0UnR2UHpibnJsWTJVeGp2cmlTTWVpSFlKb3E4VlkvdDlm?=
 =?utf-8?B?b1RPME5VS01tdDFNbTBXc1RBN2c4WFk4bS9sZTc0U0RTUEVJZGdyR0V5VTdt?=
 =?utf-8?B?TTFYZkZtOU5TMU5SUTExenR2QXNFOVpaMVo2NDlCQ0ZUck81WTdxYzBaTnNu?=
 =?utf-8?B?Q2xHa0ZWUXYxYzZUY1hRMVk4Slp1a3ZrK1pBSkowOXdWc2ozQmRyM0lWenRH?=
 =?utf-8?B?OEw1VkhRSk0rV1RCc1hWUHNvek1OQVFDb3FxV0dzN3IrbUVMeWVMSWtjam9B?=
 =?utf-8?B?VkxIbzFiWXlSKzMwQUVwbTZMeGpiU1V0RVZIWStZRFUxc0h0Um1QVDh5SUNU?=
 =?utf-8?B?MWphVWVnODRrS2VPNHVnelBLaVB5MHV4VVBxQ28xV2J2bSt2Nno0RHduZkhK?=
 =?utf-8?B?cGlIVDljQ3lpVDJDMnlGN3BoSTlHNEZWV0k4OXV0ckRvWEovelI2L29ibjFB?=
 =?utf-8?B?MEVYa2ttdUo1MlpnKzJKQVRDR2ZpQk93ZjRQL0hsbXFQYTUwVGJOR1NXdmRy?=
 =?utf-8?B?NnZ4N1pkSVNrM0FraHVhSUlIeFBMbnU4VW80NFNjUkZkZC9SWlpiNW1kQzVG?=
 =?utf-8?B?SlhoRllKbE4rRjNQd1cwNCtZYU0wL1FKMmh3ODF4bHRCTUgxSlBBSkU2M3pJ?=
 =?utf-8?B?QVd2TVU0VUNxaUhqUDRscFFHSUJJNlNUR1VoSi9tRGpjak56a3dTcU1uZi8y?=
 =?utf-8?B?QjdVYmk4U25RR21OYWplR0ZoajVSQ0c4TjFoQUVmVUswNW1kTlBDRlFoOU9v?=
 =?utf-8?B?WTVrRGJvNk5HYlU5TUJCUlppMUwwcGQ0b0VnNE40eWo3VllCdmRqbkZnS1VM?=
 =?utf-8?B?OGFNQlZxd2tTdDM5dHZlN0d4cUFjK1lsYWJtTzB5QmxuUWVEaVh6ZFNzZWd3?=
 =?utf-8?B?QzdPa0tjWm44dHBlZ1F1WXcvNzBET281L1dwb0lsMG0vWEVRMkxnb3BZY3dH?=
 =?utf-8?B?cHh4Nk1zbElWWnkwSko3YVhtQ2RYK3ZPTWpFV0Q5anJjV2hMWHpLTHhsY3ZV?=
 =?utf-8?B?U3V4TElWRFFKVkNKblloSFZCR1M0V1kvZzBycWpTckwyU3hDMEpXZFBlQzBo?=
 =?utf-8?B?dVBZYWk2TWE3cVlHWE9qZDkrQU9XM01PcHg1Z1Nla1VwMVpFdnNTSDY2dTRh?=
 =?utf-8?B?V0lqYlNtc0xubkRtOHYrNTFkYW1Gb0k5TkZjVllCSFA0N0FiTTJRcEhCclE2?=
 =?utf-8?B?ZHdHN2ptWmNQbmgrY3BpMVFNTEhiZXlyNFliK082dUd4d2UxRzN4STRZQ2RJ?=
 =?utf-8?Q?UNn5IJVk5I+IqgrDSyM/IX0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07740fb-7591-4c7a-72a2-08d9fc599c0c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 14:33:25.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoFgBqAyXjDzzq2xBGBwJkKFJn7YTHBvijj9lMadCFOjgqZbnRX7Fz9jx+O+ItbnguhEcmsSHzq8gkbUmuia3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dov,

On 3/2/22 04:03, Dov Murik wrote:
> Hi Brijesh,
> 
> On 24/02/2022 18:56, Brijesh Singh wrote:
>> The SEV-SNP specification provides the guest a mechanism to communicate
>> with the PSP without risk from a malicious hypervisor who wishes to
>> read, alter, drop or replay the messages sent. The driver uses
>> snp_issue_guest_request() to issue GHCB SNP_GUEST_REQUEST or
>> SNP_EXT_GUEST_REQUEST NAE events to submit the request to PSP.
>>
>> The PSP requires that all communication should be encrypted using key
>> specified through the platform_data.
>>
>> Userspace can use SNP_GET_REPORT ioctl() to query the guest attestation
>> report.
>>
>> See SEV-SNP spec section Guest Messages for more details.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
> 
> [...]
> 
>> +
>> +static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *key, size_t keylen)
>> +{
>> +	struct snp_guest_crypto *crypto;
>> +
>> +	crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
>> +	if (!crypto)
>> +		return NULL;
>> +
>> +	crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
>> +	if (IS_ERR(crypto->tfm))
>> +		goto e_free;
> 
> 
> When trying this series, the sevguest module didn't load (and printed no
> error message).  After adding some debug messages, I found that the
> crypto_alloc_read() call returned an error.  I found out that
> CONFIG_CRYPTO_GCM was disabled in my config.
> 
> Consider modifying sevguest/Kconfig to force it in:
> 
> 
> 
> diff --git a/drivers/virt/coco/sevguest/Kconfig b/drivers/virt/coco/sevguest/Kconfig
> index 2be45820e86c..74ca1fe09437 100644
> --- a/drivers/virt/coco/sevguest/Kconfig
> +++ b/drivers/virt/coco/sevguest/Kconfig
> @@ -1,7 +1,9 @@
>   config SEV_GUEST
>          tristate "AMD SEV Guest driver"
>          default m
> -       depends on AMD_MEM_ENCRYPT && CRYPTO_AEAD2
> +       depends on AMD_MEM_ENCRYPT
> +       select CRYPTO_AEAD2
> +       select CRYPTO_GCM
>          help
>            SEV-SNP firmware provides the guest a mechanism to communicate with
>            the PSP without risk from a malicious hypervisor who wishes to read,
> 
> 
> 
> Another thing to consider is to add messages to the various error paths
> in snp_guest_probe().  Not sure what is the common practice in other modules.
> 

I am not sure about sparkling the error message on the various paths, 
but I agree with adding the 'select'.

If I happen to do v12, I will include it in my series; otherwise, the 
maintainer can pull your above fixup on top of it.

thanks for looking into it.

~Brijesh
