Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29F07C6C44
	for <lists+linux-efi@lfdr.de>; Thu, 12 Oct 2023 13:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347154AbjJLL2m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Oct 2023 07:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343649AbjJLL2l (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Oct 2023 07:28:41 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D398691;
        Thu, 12 Oct 2023 04:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXp1BvKic0CCnVngJyWQEat5aCvaave5t4N2oiOT4og21LguGEPGK9mfFHMUkI4TWeid7eiJmCIdm59LFKGEAGNqExJitMbpMHNPuYn9L5LEYxmhmOygpOkOzaEhbIHFzu1tb61+cBihA0oWTJoU4jdXeZwvNbQ72SeXY7QgQdwBT+RR2MDyIFt2kSti4FAnMjqf1YNQ+/sNPi5T2cyadx3DlJ6mWU3WutOrM+CetHtbLnindezMNQ5Nb6ALBw7jnWlkW/NptgpDInVswuLMxlGq3EYF2BmDEmA0qSfwnOI6wGIecLMxQfzMQGvhhSMBfwPrG6c7QjIN6wSTlmWH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzOqzBByf/kQG0tvNeZsa1J2p31LBFhWcuXiHyMqNQs=;
 b=X5Kp6dcsyy/q9p1Z9PUPAHg4gfKcP1Ih7Jict8gSN45wXMaMd4KoJP8tDR8XFTrVDPJdg06e0jS1bdfMW2FelhDFBvj1TYJbo7VdSnQ3dRKJSjhJV65Z7mP2vgbwlg9uZcjT5SJWK2w1AtU+Jy4enwjDJgL8VeltSamxevHkl3dLA+o9qG2nSGN0KlAA29Rc/Jr72++qYnHpV7uCGS2c/xoIMwUojsKYr3aM8e9TQ35SDp0OFWxtOrAlsCEg9vh1F//x0s2q1D961nkaKzW952gFBBIsdI36BCcOuAp6Wy0JqVMX2bL0ab1yA3GmWo78gCrOm2zm1Fljid9u71oKpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzOqzBByf/kQG0tvNeZsa1J2p31LBFhWcuXiHyMqNQs=;
 b=SXcbZC1F8si8gXG97zD41EmMPBQeKqeM4dtdMLs7PMso2I+38oDph7tVKmBFmLTbSKo9TQAlUn8TFKpN6Z5R6xJqVa76ktkrqldKrqDPQmWdp9uWXpVyaxAYRS8Oosp/nOjeBC30oHkZu682xDzOGIMaZEdTP0Ybj/HtN77x42vhY0ipl2UwNO6ZPrVbB8Pu92h4fkLboo9vK1315PVI1QPkb86Je0upV0dFUkuiXHtUbPGfYmnPK+Kg1F10peo0ReziNygNuuIKsTryybjg/ONGTH8VCnE0Nwj0CCI/MsWMtX+IXsJxvGAPXyKM8/aGakIMDpgvmpIRuBZEGaLrtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by PR3PR04MB7435.eurprd04.prod.outlook.com (2603:10a6:102:88::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 11:28:36 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::edd3:f00:3088:6e61]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::edd3:f00:3088:6e61%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 11:28:36 +0000
Message-ID: <9346655c-df15-498b-a6e3-f6dd918c663a@suse.com>
Date:   Thu, 12 Oct 2023 14:28:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/efistub: Don't try to print after ExitBootService()
Content-Language: en-US
To:     ardb@kernel.org
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
References: <20231011192528.262425-1-nik.borisov@suse.com>
 <20231012101456.goamenepqlte65jv@box.shutemov.name>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231012101456.goamenepqlte65jv@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0086.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::27) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|PR3PR04MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 284845a1-c1d0-4491-36e5-08dbcb165f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jgHTVgMKzK+hGYGH263AWlUWvQQhpoaCDRex9rQ523F5npUDUvLAvMHIp8ArQBf4Ar95j62it0MXG2HNa3+IECcqoiJ7KCJKAKWMhvLs123R6YJboyxiC/mtdAB90IxMyb2SSGhsCC7pwJuf+E7HfvCtilw0jDTh8+z4QoxAONUhRXUrEZNI++t0jXuvdPRos2adbqGaGJ6aO5ysZNnmuqT6Z+NUDuy3SMdnyenI7HQFkxKomAGbf/IwQY7AleEEi2QDg8CsT+be4Z8bUwyI3luU5rxOSwDuPdO9+HOJA02E/n8QJojak6k003YtLLc2GLvwBY7Au2xldsZtNaVmYSUXZ3GNGctzBnFB/o94DYU+nUiMQszR6Hqcwbi5t2Glk+3E6vFMYjDhI/nW3qV5N569sU4aJCjsjc30pnMDBBpCKn9Ldcjjf+6iaD/jp5nvjg3j5Kp/S8Fajv3Sk5y/+WIvOS4PXsiwXycHAcSw5YFaum43lx1Q4zSS7lSXX61zHlMrCBidI93sr0Ip29Fesw4U/PexBXBFrw/0jZbmfeObwpNku1F69mxb7rY/2/Z722KQ/XLpJu2NBrILBwQwosjNXm5EDnOAJ4Fc5EJjUYv7AcHyL95zsFzx/+PamPP5WW+9PmOPuAQif1euN5jEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2616005)(6666004)(6512007)(6506007)(86362001)(36756003)(31696002)(38100700002)(83380400001)(66556008)(66476007)(66946007)(316002)(41300700001)(6916009)(2906002)(8936002)(5660300002)(8676002)(4326008)(6486002)(31686004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHRRaVk0TEpxbFM0eGZpY2lSbGRZRUl2UkVqa3Z6d1FMOUpCNlZsckxybURW?=
 =?utf-8?B?VTk4S3k2clhQR09PTk1TVzlhc3V3UXZYZkd0UlFpU0N4SWgyVHVOWnBoNHBB?=
 =?utf-8?B?ZktVWlBETXBmSCtIYUVSZGg4dXpOQ1d2cDRUUjYxdXNOdmRVSkNod0p1ZFkx?=
 =?utf-8?B?UHpyMHJwVUczMGdYYSszQmJlYWVZVlFZbVJranFQd1pNN0g2cWN1VmRWdkFE?=
 =?utf-8?B?M2xrZlRUSElCK2FEaUk4amw5OWZLSlJ0SkMrMWZRT0hqUnR5Y242Q1NlQ2ZU?=
 =?utf-8?B?SkNFOUcyYm1VQTNPelJiN0pVMzJXQUhkL3VwcGhYemJaR2pLUVJLbldxVWN5?=
 =?utf-8?B?eGYrczhxaVloRTB3cWJVMzJ5bCtwT2JmTFMyRldLaHZ6bzMvKzl0bGZyNFo4?=
 =?utf-8?B?L1RjLzhUaW1pTTc3VFVZOTlhTk9Ta29lbkVQMlY0YW5DQnNZazZkSkpuMmRt?=
 =?utf-8?B?UXR6T3hWWEdsVlYyNjhpR2JCM09uSldpcnFsdUg4cDNSSk1mTGVYYkEwOTNN?=
 =?utf-8?B?Ri84NWVWZWlmV3VWVDNpQVZCekIzNnpSbHAwOVJqaFlGbTNDbTFVVjN5Vjdn?=
 =?utf-8?B?cFl2YzY3bHJlMDBQTFhtM0NUdC8rRGw3anpwbmdTNWZ0VmNCMVZKeFN5bEpx?=
 =?utf-8?B?YzAvM2w5UVBjZEw5MTIzT3R3R2syVUJhaXhVcGZuK1lJOGdRa21oQXBNV3dp?=
 =?utf-8?B?MGlZajU0SFZyV3V0eUVUeFB0T0pKZFZVeXJieTFaUi80S1d2QnE0ZXhLOWo2?=
 =?utf-8?B?ZVVpUUFsRHdhRVJrMzMxbFNnUGdMSytybjhHWWt2TUxVZDJ0WGFHZWExclpi?=
 =?utf-8?B?RG50a2J6dUNwcVdwZEFRTHl4Vks3eE14aFI3L0l2WW4vejdlS0xiY3JrMmxm?=
 =?utf-8?B?WHZBNjF4Mlc0ZmFzbzVVbnhEZ0diYnB0clJXbXJEUUlmaFdDOWF4SnRFZ3BF?=
 =?utf-8?B?S1U1TStrazA3SUdJektzaHA4QVBMV0pSaExWSXEvMEt0SVppdFhKRkczY2Nm?=
 =?utf-8?B?ZUpzaFpUZnN4TXJNbkFlTWxBYnZvK3JTTnZEVkhZK3RvNnZjZlUwMnMzc1Zs?=
 =?utf-8?B?a0RsK1JFM3BGTWMvSXl2ZWZMenVzcXREY3dra0cxaEthT0VLTzFtWE9XZE9o?=
 =?utf-8?B?WG9tNWs3a3J6eVl4TDU0TXNIck1PNHJVRHpBOFhpZmdTRDFmMStnWk5LdFly?=
 =?utf-8?B?RkZ6c2laelROdW84d043RXUzOVlmVjZaSWFqK3VBZzhZMDlJV1pMZ2VIOTh4?=
 =?utf-8?B?Zmc5M1ZkaWRVcVBQMDRUU1BPVmtyZ2Y1TXVCbFpWcHZncW9QQk1mMkdydHpo?=
 =?utf-8?B?VEtSWEs2d0R6MlFiWWNtZTFia0MyeUdUQko2aWcycE90WEF0WW1va3Z4SXQ5?=
 =?utf-8?B?MGhKa3Z3UGRPS096MENDQUM3VkFadmN0cnA1ODVoQTNNMFE3cVRIZkcvK1Zy?=
 =?utf-8?B?b3JkeDhqelZYNFQ0YUg4TjFZRTNYR2YwVTQ0dmpPV29KWVo4TmdVSTAyVU93?=
 =?utf-8?B?RkphTkJvdGJBL3FwckF2NUJxTjQwZWowaFM2UVJPbFFHbXY1K2RnODJFR0RN?=
 =?utf-8?B?bC9mMEhPU3JWM2tYaTJEdGw0QzBGdFpWbjJ4eW5lcTBtTU5NSEJDWFRpdHZS?=
 =?utf-8?B?czFxbkY1VldvZkFZNVdJdFU2TVhZNlF5UHNSWFliMm5BU0xJUENOb05teDcr?=
 =?utf-8?B?MjNiNWJRa2pURzVlZlJHeEx4K1pkZUltbFdGV0lsWmZaRTRIeU1DcTNVSWxD?=
 =?utf-8?B?L1o2amV0OGFUYVhyaFkvRlgyS3lnZkhzVmhoTTZja0NuT2hHYUNDeDEyRFUx?=
 =?utf-8?B?bzd1SjBDNG5Xa01TV0VmVXBQNkZkQ1BWZHhrSjcxYWJzRTRoRXM5a2QyY2RO?=
 =?utf-8?B?RlgwSGl4QkpIOXEvei8yUFdPNUl6alBiZGFnTkV0R3g0Vlk1T040S3FSWTFk?=
 =?utf-8?B?QVhWdS90L00vMVFwYWJRenZyZ1NxVVlJL3NQckJYbkZ0aTU4VEpIN0NRdjdL?=
 =?utf-8?B?M3FBUUxNT0xmSk1XdGVYTnd6dThGSWtqenJJdS9FU1NwKytkeXA5cVNtNHdv?=
 =?utf-8?B?TnhrZzZlWDRrNXQxOTBLRVl2azhhelJLazFaR2Fob2hDeGVoQnBXZ2hDMTNz?=
 =?utf-8?B?UGpML3EvSjJOb1F0TGdhekhPdjNRNmxkRHpvL0FwQmlWT2NrYjFma0NuU25D?=
 =?utf-8?Q?ANjhfnpQbR/YrU2YhhuA3AiBqoRJR7wLhvpj6RqTiFqT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284845a1-c1d0-4491-36e5-08dbcb165f7e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 11:28:36.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDU2NC+g8A69WRv8COBniWPS0Y2jQjdpKlltl9aN8nEW1Uoz79v94O8wEniaTsSDxOZeAW1iN+2bFAgfd92+RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7435
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 12.10.23 г. 13:14 ч., kirill.shutemov@linux.intel.com wrote:
> On Wed, Oct 11, 2023 at 10:25:28PM +0300, Nikolay Borisov wrote:
>> setup_e820() is executed after UEFI's ExitBootService has been called.
>> This causes the firmware to throw an exception because Console IO
>> protocol handler is supposed to work only during boot service
>> environment. As per UEFI 2.9, section 12.1:
>>
>>   "This protocol isused to handle input and output of text-based
>>   information intended for the system user during the operation of code
>>   in the boot services environment."
>>
>> Running a TDX guest with TDVF with unaccepted memory disabled results in
>> the following output:
> 
> Oh. My bad.
> 
> But there's other codepath that does the same. If setup_e820() fails with
> EFI_BUFFER_TOO_SMALL, efi_stub_entry() would try to print "exit_boot()
> failed\n".
> 
> I wouldner if it is feasible to hook up earlyprintk console into
> efi_printk() machinery for after ExitBootService() case? Silent boot
> failure is not the best UX.
> 

So looking at the code the only thing which would prevent refactoring to 
exit logic to directly call exit_boot_func etc and setup_e820 before 
calling efi_exit_boot_services is if the memory map changes. The current 
code ensures that we really have the latest memory map version and so 
setup_e820 is called with the latest version.

Ard, how likely it is that the memory map can indeed change between the 
calls to getmemorymap and exitbootservice?
