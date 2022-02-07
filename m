Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC4E4AC26B
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 16:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiBGPFd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 10:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377491AbiBGOl7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 09:41:59 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE978C0401C1;
        Mon,  7 Feb 2022 06:41:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9EdlwJYQ3TmaDMwRVmGXO+no5qp62tq2fwhN1k6lv0ZcwR0hUPZDwrlZOS77ds5mb8cab+VSaz1+EhgBqmKDsJg48oDq+KTieKwTMw8///2KKh7Y1ZHJvYL3FWbvCjJa9hmvt7fodxHGTuWCwBZ4eLWqEVjkIagTx3P3SZ2r7NOjjpCBodSprF3R+4gSrEzhwwgjGjdTQ45tmFJ0BQh3zqwqSSGM1GfgkHCahNBsiUHauEIjZHijRILPwiGs3l1JZRKNvqqugSNhNZR4H7yOgLH8bU3BnX/91yBZ3E8m9OogFe1mo+nalRnxYy5ED80IyzOqiGMm1+4gsIPbQR9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HnbdG3ozvi8jDOAd5srVqOwmEnciYis1tlw1MSkpa0=;
 b=aL3xVqi8btXiHtS6tkQYINLX98rAiLgTAmvKyFJp7wMxyjWoXt3rzjm2tdbXsYkHuH9zkaMSJ3DV561yBxHmW7gvZ4w5ZLDQg3p4T+NcwH0fgu8t9G3CJAHOacilq+jff9wrPDffO+nyeYVHr07Xrig79brqch1OGTAeKLOyWZY0WnvgL48t+jtM4TS0R+1sKCibzHwBkNalM2aGicGv5E9PDFSH1CwhWPzqRBRsSFSYGug4ugg6QGxDsORBlGugzsyfokrEgxdeFHQ4O51Eb0mjpGvFuNh8xJXxIn+RlrZOZh0XxEn5I0IQ1hNlWk8SLw7cTnlbRpQpoks6pgQE8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HnbdG3ozvi8jDOAd5srVqOwmEnciYis1tlw1MSkpa0=;
 b=lhcvASTO+B3paUaBNlSZiVzaG6rZmKQjnSfAw+3r3Vs6V2d1NxfN2WxODHxhbxKEaMqz2jHIW2ehCqpBFDWmnbFU11nwMuVpuPTxO11s+X6gfuuSQpC8OHNB+TgRI3k/v4s1Ad6tZlU7uFdYlCLhoi5vaM1ahMXcNTeva8rXPoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by BN6PR12MB1524.namprd12.prod.outlook.com (2603:10b6:405:4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Mon, 7 Feb
 2022 14:41:52 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 14:41:52 +0000
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
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 41/43] virt: Add SEV-SNP guest driver
To:     Borislav Petkov <bp@alien8.de>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-42-brijesh.singh@amd.com> <YgBOKQKXEH5VqTO7@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <cb4aa4c4-11e9-163c-5101-8b0dea336fc1@amd.com>
Date:   Mon, 7 Feb 2022 08:41:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YgBOKQKXEH5VqTO7@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:208:91::29) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5c33f8f-7dea-4873-d7ef-08d9ea47fae6
X-MS-TrafficTypeDiagnostic: BN6PR12MB1524:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1524A2CB79B5DB75C32F5787E52C9@BN6PR12MB1524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJGnK91zAcQlnUIq3m0vrkOh21NocCtP/AIMpe4MN3tfZWgx/tzxaYDdC5KpyqKyjs3loYuwtFwjPWT7PpZOb7GrayAtkfAXtE2Oko76T0BlO+dmoYZOnoYd8sYlCJeoaGuIHo40HALFc/GODcLbnxzHHFV6s0FX5AIdQS9pa3+4RF0G+Ttmd6X4W4h0exMXV1zKp40yHx0XwNa3UhwNI2FioFKRF0NJFivdGiAIBnE1btl+5QzdXiog/1IpnIzPwz2kKJQrSdrBgy89yv782wrjwJ6IS1Yp7pQPo7jtIQu1427qqAKQ7d9ypwY0Lez4fse4AY8EtG1IodUiU5n2jFBV63TV+wD9VUZmyLGIAsu8NXB73KI4TOlSSj5EXNYD1pRgSIprQKsFQhuj6oNAXVuQ8fbs3wT81avh1deHXhv/CfXStqsae65MrzpFTKqQi2oJwzz7CB29/TtMOJny+faEcTXBCgtqXaue8+2Z4QoaGc5R4lRdkU2Wxsw7PsxWXvWq62ArCNIN7hYG/jAn7iSqom/eV/wEY6ORBHsqsS24jnjozM8q9avAOBVFxYRvgB+GI26XRThta9wWAUCeaO4FbSBLTpZYEz3iWh6kY9+fK0urbAa4TZkMuX7CryyQ9DbpCtgRVSfgltOUvZjXHoGDcu1NN7nvkO1uyV51UYK/9eXdogJFjb7lJoMnuyIg0E9bRMM+/uj6oBoS60s0ctnwF6tysU64zP+5AP8bOwsaMOLlPh0gJsxHFgSVxu44jaibEM/k1F9QO8ZE+v3YWRklgarEARyDnrNJedmqhkP5oY0LDTF37yaDNwL07MOV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(6506007)(508600001)(53546011)(38100700002)(83380400001)(6486002)(86362001)(966005)(6512007)(7416002)(7406005)(5660300002)(6666004)(66946007)(6916009)(316002)(31686004)(66556008)(66476007)(8676002)(4326008)(8936002)(54906003)(36756003)(44832011)(2906002)(26005)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnBQb2RRMk9nMnZ4cjFkMVlTNUFIRXdvckhLbWpsYmZpN0dXcWhiRkE5Q25M?=
 =?utf-8?B?TDRoVjdIWmM3dlkwdStXWXVyWFVKSXN2LzdIV0c0K2VwUzZkMURFTHcySmRm?=
 =?utf-8?B?NjJ5QUFxWktjQ3pwUkVKa08rVnF1SUpYUWE1SFp6RGtCQjUwQzhHNGRUblFn?=
 =?utf-8?B?RXlhNlhhL1FlUDl0VWt4eVR0eFgwSUFVdzFkWndDSmtaS1h2SFF2V1lleENv?=
 =?utf-8?B?WnFjN2R0TC9TYy8wM0NqdEZPRkhmN0J6MVFqY2N5NmUwYUlEVGxseEJuWTli?=
 =?utf-8?B?R3A0bmdZOWRPUi9MbUZBeDFrTE1aaXp2VEtVOFZVYW53SlJabXo5MEpyQUVE?=
 =?utf-8?B?MVdHa1NjTlhWVzh0MmVPclM0UHBFN3g5SGd1SUxPbDRzY0lxR1NuUENqcFk1?=
 =?utf-8?B?WVFZdit4NjdaREFXbUxTWDF4QnZja0pwZmdKa2IrTEZnNVhxSU1ORkl2bG9l?=
 =?utf-8?B?M09rOGs4OU5wWFZBK0FFY0tROWF5R21WZjVUNmVCQkExdDVjOWJMWVFyamNK?=
 =?utf-8?B?R0x4cUQwKzJiMExYNHN0bDR0NW5MMnFOSkN0WU5qY0dPbnpPY2hXSnlZYUE2?=
 =?utf-8?B?cTRUbXdsQU1LQXRFdW5qUW81VGdxak4yM2RXbFFXbllBbUxHUURDVnJaK0NV?=
 =?utf-8?B?ejNQUkVMSDI4RTFSOXZiekU4dUF6VVB1dlhGVmJDS2FQa05hSm5RSlR6RFpH?=
 =?utf-8?B?MzUrSU1DakJGNWtaRWt5ajcxN291ejVjWlcyU2J3Y2t1eEFCY2hWZnZYMktq?=
 =?utf-8?B?UlA0YTFkQitBSkFlVG5BaVphdldRZzNoSUtyUU9SVVozK1F3K0h1ZHVjVVFW?=
 =?utf-8?B?SWk0K1liVFQ3dWpMU25KUEVVUWJDVnFQV1IvcTcwb2xyQlp2UWhNdXRCc2lX?=
 =?utf-8?B?MmJIbVhENlJzRGhBTkVpbTM4Wm1CU2wvVEJ3S21ScE84QjF2S2ZSYmxEaWda?=
 =?utf-8?B?QWkzbFhWMFFlYkhnYnRkNlFZSy9jRWc4enJqWWJnY2xCcElQR0xGM2t1TEFq?=
 =?utf-8?B?VXRkRks1NUdOZGdxWjdpR1VMWEtEODcydC9UTTlvRms0ampMTWVBemtmb1BQ?=
 =?utf-8?B?OExia3ZYK21OZGorUTV4SWZ3NUhsUDNhc2I1M0hVM2RiSDBmL3JTeUtXQUY1?=
 =?utf-8?B?ZTZBU09nN0JpcWl4MVpXVWh2QTl3bkNVdGEzNTF6V1lZZ2xUOUJIOEZUd1ly?=
 =?utf-8?B?WVdJQ2ZrTTZmRFN4SjlUdHU4TjVrbUxUNHJjS1E2elo1ZCtxNktjdk1kNk1R?=
 =?utf-8?B?NFpUMk44MjA0QzExcWNUMXJoVDg3RzE2QWJnQzlIQjNiYmJTR2w3ZDhnenVq?=
 =?utf-8?B?RlB1R2dqcEd2Y0QwOFI1WHBrK2JZWVI2TUlvMlNoSDExbjhETjlBeXdrZkhJ?=
 =?utf-8?B?aFdFaS83aGRlOFlrNW5TcE1UcU5BTWdlM0FvQ0RrS2I5NlBrVE1nVEdIRzdL?=
 =?utf-8?B?dXdqZHBRdW9CbTF3RWk5ZzRaMk1BNVlQSjdGcmdzbkROQ2xmc1U4SU1uR2VN?=
 =?utf-8?B?a0ZHYktpT3NaN2JPUk0wdnNGa0MrS1B6RXowL0dxR0xNclhMakVUNVNjVEtS?=
 =?utf-8?B?VGd2elU1L1FYaWxLK2FPa29paWRLdGJvekRhczVnN3VwMzJOZjU4ZHdNV3lV?=
 =?utf-8?B?K0xWTThFbUFwVUd0RnIyaW5HNE9rc3gwNWRUNlk1eE05d25paTliRzVMR1RT?=
 =?utf-8?B?eFd1RGo4TTJoK0NnbGhqNlVYTFR4VXpTK3FtUjJqSitxUXo1ajFDQWFkc2hJ?=
 =?utf-8?B?SU12QkQ5TXpGdVgrRWNENmsxNEZjaWo1ZDk0cEFqb0JzQVJmcFpFTlZJa2ll?=
 =?utf-8?B?azMyQUtVWjVOSGxORlEzdmtZYU4yZVZXaDR5dUtsL3pQZzJwRGI3RVZvbmZB?=
 =?utf-8?B?eDJFYnIrNG1tYXBCR3gxTXJTT2NjQlV4bExPNkdhQkJWS3NSbm5xWkoyOXA3?=
 =?utf-8?B?NVFnMGc5L3Uxc1JYSmFrWFVGc2crTTRyQlIzRTkwU3gvRG5RMG9Yc1lXd2Vs?=
 =?utf-8?B?c0kzUHFKanJTSTJCK0xrWEdJZEd3U0NvTU55VTI1WTROME9qdW5KcHhFNVBO?=
 =?utf-8?B?bDhtS292U1d3NGdoT0pKSFErLzEyR3IweUZvYWFWNGVTMzFIb3Z4QVByWlJO?=
 =?utf-8?B?S2JIMXNZdlBiUkprUWM2d0dkL3hHakxVSHp3eEJ0cFBhQ0NZOG1EOWtxRitL?=
 =?utf-8?Q?jR5B/uACxTF+B08i/m2v0sk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c33f8f-7dea-4873-d7ef-08d9ea47fae6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 14:41:52.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXo59zmIflJMpjhRihJQcykh7wYYbjJIrwKfmAdzDKJG3bkZmFFpo5ne8pInGvGnMoJykQB4k9pz1B70Wm5Cug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2/6/22 4:39 PM, Borislav Petkov wrote:

> And once you do, do "make htmldocs" to see whether it complains about
> some formatting issues or other errors etc.
> 
> /me goes and does it...
> 
> Ah, here we go:
> 
> Documentation/virt/coco/sevguest.rst:48: WARNING: Inline emphasis start-string without end-string.
> Documentation/virt/coco/sevguest.rst:51: WARNING: Inline emphasis start-string without end-string.
> Documentation/virt/coco/sevguest.rst:55: WARNING: Inline emphasis start-string without end-string.
> Documentation/virt/coco/sevguest.rst:57: WARNING: Definition list ends without a blank line; unexpected unindent.
> 
> There's something it doesn't like about the struct. Yeah, when I look at
> the html output, it is all weird and not monospaced...

I will fix those in next rev.


>> +
>> +The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
>> +The ioctl accepts struct snp_user_guest_request. The input and output structure is
>> +specified through the req_data and resp_data field respectively. If the ioctl fails
>> +to execute due to a firmware error, then fw_err code will be set otherwise the
>> +fw_err will be set to 0xff.
> 
> fw_err is u64. What does 0xff mean? Everything above the least
> significant byte is reserved 0?
> 

Yep, I will explicitly say that it should be set to 0x00000000000000FF.


>> diff --git a/drivers/virt/coco/sevguest/Kconfig b/drivers/virt/coco/sevguest/Kconfig
>> new file mode 100644
>> index 000000000000..07ab9ec6471c
>> --- /dev/null
>> +++ b/drivers/virt/coco/sevguest/Kconfig
>> @@ -0,0 +1,12 @@
>> +config SEV_GUEST
>> +	tristate "AMD SEV Guest driver"
>> +	default y
> 
> Definitely not. We don't enable drivers by default unless they're
> ubiquitous.
> 

Randy asked me similar question on v7, and here is my response to it.

https://lore.kernel.org/linux-mm/e6b412e4-f38e-d212-f52a-e7bdc9a26eff@infradead.org/

Let me know if you still think that we should make it 'n'. I am not dead 
against it but I have feeling that once distro's starts building SNP 
aware guest kernel, then we may get asked to enable it by default so 
that attestation report can be obtained by the initial ramdisk.



>> +	 */
>> +	if (count >= UINT_MAX) {
>> +		pr_err_ratelimited("SNP guest request message sequence counter overflow\n");
> 
> How does error message help the user? Is she supposed to reboot the
> machine or so?
> 
> Because it sounds to me like if this goes over 32-bit, this driver stops
> working. So what resets those sequence numbers?

After this condition is met, a guest will no longer get the attestation 
report. It's up to the userspace to reboot the guest or continue without 
attestation.

The only thing that will reset the counter is re-launching the guest to 
go through the entire PSP initialization sequence once again.


>> +
>> +	crypto->iv_len = crypto_aead_ivsize(crypto->tfm);
>> +	if (crypto->iv_len < 12) {
>> +		dev_err(snp_dev->dev, "IV length is less than 12.\n");
> 
> And? < 12 is bad? Make that error message more user-friendly pls.
> 
Okay.


> 
> The order of those free calls needs to be the opposite of the kmallocs
> above.
> 
Okay


>> +
>> +	/* Message version must be non-zero */
>> +	if (!input.msg_version)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&snp_cmd_mutex);
> 
> That mutex probably is to be held while issuing SNP commands but then
> you hold it here already for...
> 
>> +
>> +	/* Check if the VMPCK is not empty */
>> +	if (is_vmpck_empty(snp_dev)) {
> 
> ... this here which is not really a SNP command issuing.
> 
> Should that mutex be grabbed only around handle_guest_request() above or
> is it supposed to protect more stuff?


Yep, it need to protect more stuff.

We allocate a shared buffers (request, response, cert-chain) that gets 
populated before issuing the command, and then we copy the result from 
reponse shared to callers buffer after the command completes. So, we 
also want to ensure that the shared buffer is not touched before the 
previous ioctl is finished.


-Brijesh
