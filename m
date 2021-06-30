Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12703B8708
	for <lists+linux-efi@lfdr.de>; Wed, 30 Jun 2021 18:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhF3Q3Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Jun 2021 12:29:24 -0400
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com ([40.107.93.73]:56769
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229510AbhF3Q3X (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 30 Jun 2021 12:29:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv96Vt2xIPvVSfBU1JIFO54L4QBjwt/B7j3+QRsw6oznpheVknFwKiEdlqNzd8VHCMAJw9Bq7iy+YUILB+lNzzUHiPDlTLYUix813Qjl925wKvs/orV2UFbNxPyv6K9J9ddqDqSKLhKnl+kJGwt5K0sSz1zovn7ZjIAgvxWMyMa3ps3V4oXz3kQVBAu218sTP+M+j7HYL+FsbOuloInP7tFRRYZ+rMHeceSbnsC+RO5LysLaHXAnqW2r4rSiKPVVA70BKfwHk2K0/+1gkFItiEOaisAdh/CPVRge25XDLs5uYbIs133siTeqh13Zgv+3vDRrfyxYESwq1v9ap/e9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwRqcbOuc3khg1zzQuNE8nxMUmi6Co3+X7eZZbk6HPI=;
 b=iRnHIr2p/O8Rm/rz4Vk62EM4v4lW1/geC1dKjPGYUfCgugxJTdgcQaSb2PZ9KQe6uZWXGp7D0wgzJzS4XGdjMDiapLoXiv6jRvLPGiYolG9PUyd1t6OqiEpvteIlOcZ1tm0zo+s+b7wzcqSMhXWwH3Z6wpqTvbaUMxugHR7OciCnYB8ufIwO9Xh1NO3wpMvRZkS6JEgmjCaVroPsoyHNngOuESliwuVYK6BrFhcdyrp6RLyLlUARhZ0ircGP5M9ye6XqYggxvgefZWw9YWYdYzrQsCyot/ijHR+zJzHnY6rlTMQjcx9W64MLi+IVqolLhev+l0E8yfA09kN2nBBo2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwRqcbOuc3khg1zzQuNE8nxMUmi6Co3+X7eZZbk6HPI=;
 b=xWlY2xlaqr2z6jHe7pm0nmt6mzYUDob5wnAbOdsKMIf9D86aOzcx0gBnLhlo9k1uKBRTG1Z83xgbRWQtn9bHxfxayZlRiUaJzds4FwqRenZtTVHSO/AStaqOT76l3kqMyEgz4yP4oUx/14tqlOlVqxfwrGAIeuBrAPCdfqOYRVY=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM5PR12MB1225.namprd12.prod.outlook.com (2603:10b6:3:7a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22; Wed, 30 Jun 2021 16:26:51 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 16:26:51 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com, Dov Murik <dovmurik@linux.ibm.com>
Subject: Re: [PATCH Part1 RFC v3 22/22] virt: Add SEV-SNP guest driver
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-23-brijesh.singh@amd.com> <YNxzJ2I3ZumTELLb@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <46499161-0106-3ae9-9688-0afd9076b28b@amd.com>
Date:   Wed, 30 Jun 2021 11:26:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YNxzJ2I3ZumTELLb@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA9PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:806:6e::30) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.11.236] (165.204.77.11) by SA9PR11CA0025.namprd11.prod.outlook.com (2603:10b6:806:6e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 16:26:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18e62531-15a1-42ac-3116-08d93be3dd7f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1225916604F394C829226D5BE5019@DM5PR12MB1225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VjT8ht+nAoxTJsNdNYkOGdAsNbUp9LBW0T4kXpME7QVuMSbokMPS+O0t2j+29DEYGIEELR4cavz1v30JQ6A5ySXHwoMEryTAtqjGd+SLYph1s3q53MXTKbeR7FJomvOEHp8/tFwdh5Pwz223qwyoxYGYrCWKiYXEVJteqwUY1iCERfqN66cbp8et5yXtHahNEIYs0UIkhYkuOj8Lh/2tcKPJIVBvdbXCnW6qRs1hb+F8b9RgiOtL5OsOFZPW0d/ayZIQdzUOKx/fO1fvDEOkGAbF/x2A0ALASDJ143ynHb5pKhd2Znny1bSrKysBQiJCRDHssLXIoZ2XIqDbsL+MSaTcPcc02ZCXArXDcyCVzjP1/e42Tbsi/UjpAJhda01wSBqH3sC0TUHaKAYC5o8tje0bJulEjLjDjD8QLWa0Kl9dBZascEvB8eJDerxL7gYumegyfCDH3e/phxhYm8+G+RWt2gh5OOcPr/NX34rV+QcnHXTG15VI5LjMW7UFBFNAaGv9JJ580FC+EV54TEGlRqcbZX2yxgrHk4EUvMDZgU4/e0DqMru2WIJJrTxxS36odKwUzUUjcZLJP9MLhTXYc/4f4GOJy0LdZYhJGGFUug7h1ytTDD+OeqKIgDweZvrkKgeNPKH/iJRXOPf/Q5oOM12W/TocVrLkMKhx/8LQcLPKXrUlNp856t/FJO6GKs86Kr22IVwESfZ98f24OB16M/rcum0wg6VdM2dB1ZT9W1s4FpUOSZwwIettP4V+xefNRi1rZX5vm8+st38Eqiszp0fOC/+khnHG7HoWa8F4mF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(31686004)(66556008)(52116002)(86362001)(6916009)(6486002)(478600001)(16576012)(316002)(83380400001)(2906002)(38100700002)(2616005)(31696002)(956004)(44832011)(54906003)(38350700002)(4326008)(53546011)(66476007)(36756003)(8936002)(5660300002)(16526019)(7416002)(8676002)(66946007)(26005)(186003)(87944003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW1icURxWW5zQllkRG9ZOHc5dG9acXgrTUZhMWJyMmZURGRWK0t5QU1kblZF?=
 =?utf-8?B?bktUR1dXWE5IajlhSjlYQ3N2cHBqS3hwWHpubzFwR3VqZitmVUc0a3QyMUZa?=
 =?utf-8?B?eVBsWkNLdEpPVTZkU1JZY3BlelFLOERqOFZNUDlRcmw5MU0vOWxGaWZVbk12?=
 =?utf-8?B?aFpjQjBrY0w0cFh4NU5OWE1yeWdvWTJhQ2ZRVXUxYXBJTFRtdWxiWEgzNUV1?=
 =?utf-8?B?eXYzQWNKSnBIZXgzUmZ0eFo4Tnl3K3FNOWRaYzNlQ2NHd1BmMEd6MWVOaVZp?=
 =?utf-8?B?YzUyanhFR1VZYmNPdGJYeitDcGZoRVkrUUR3TXRUWVVVYXp3Y0MyVlloZERx?=
 =?utf-8?B?L3dMVGltT0NEdTFxK3BBbzFnN2J1TFFhMGtlUkkrVkp1SThzZWg3U2M4RVZL?=
 =?utf-8?B?WXhvazZuclZxM1Z4TUZjMUFTbXdycTBmZTYxTVpKdnJ6Q0ZtL2d3WHJXZ0Vo?=
 =?utf-8?B?ODJuUENQek9hTHc2UGpqQlpYNFJacmpMTWhEYkFTcjdrTkMrSDU1TzJwZERW?=
 =?utf-8?B?NVlZQ3htUjVsUW8zWE41YjlqVXJmcW4zcGNhUWRZVXlLeGx6TTUxZVFhSG0z?=
 =?utf-8?B?aXF5RnU2Mmp4c1VDNGJHSlh3SUg1czhKazZFOW1VQ0RmaklyVUozMmJ0OVk3?=
 =?utf-8?B?WW5kb1lCMUQzenB1QW5wTUgrdjhIbFkvV2duUWZKcDF6cVBiM2cxdHB1aXpC?=
 =?utf-8?B?eUFCYXpzR2FnWUlROUNyWm4wL0FuNGxQT1I2NGxoc21hUFlYU3lEVFRycWlq?=
 =?utf-8?B?QU56VmpHSURGWDUvTWJVdlJYRElDZ0NsVElma3cwRTdmRnAzOWlLRnBnMDNu?=
 =?utf-8?B?QWdtNGdvMDNCTWFaa1pVck11cnl2dDNWUWhNbFk1TFdDRStMalNjaFc1TUVp?=
 =?utf-8?B?dUg1S28ya0wxZFFGT0gyUSszVVg3aWt3Z1ZycTlHK0lia1hzNmkxTjlnZVJ6?=
 =?utf-8?B?UHc1WlBNT3F0QVlQazdocUxrUHdoQVBsN3QrRW96c1pLdmtHV2VnT1k2dXo0?=
 =?utf-8?B?SHhaVnRPWFRHSjRFTVVkSlJOZHcvQ09DNG9vTytWUGNUbWg3WXFEMkpNMHBs?=
 =?utf-8?B?ZXlSQ21NRFRoMnFRb3YxRDhvaUprNExveVRCamR1L2hxLzNnSktoR3NXZGw1?=
 =?utf-8?B?UmdBWGhDY3V0S29FcmNTSmxpbXJnMStvaTdNei9UR0hrdTBFZS9IVGFpLzlL?=
 =?utf-8?B?VlFob21EUmU4SDMxbGpONlJIZGNXcXZTRUV1Q09ZTzlnMU9mc21xRTB6amxk?=
 =?utf-8?B?TGdneEsyM1FyVGVWSXJoVmhDK1p5VmNZOUMrZGx3Qm1HNVJ4MjNFT2tuSXNV?=
 =?utf-8?B?d3F3TFJhTFhzblhJWEtvUUdhUHQ3a0ljMXlZK1BzaWtmK3pwNytFMUZXV2RB?=
 =?utf-8?B?VHZOcFhIZStOaUE0UjIwaXI5bDQ3c0hXU1p3T1BKeWVRS2dyNG9JVGxDTFdW?=
 =?utf-8?B?SWJ2c3JlcVBvNFJhQ1BCZnZQb1B6UVVKL2hzNjA2aWkxN2RnZkF1TmsxM1pw?=
 =?utf-8?B?YzNudHBocFFHYTRjR1JnaXpvbXMrdXlsOFZsblFReXRMVktQcmxBZlFhV25x?=
 =?utf-8?B?eHFPQ3FlRmlIc0VaZ054dnluTFhIaGs2Q1hIUngvaW5PZERlajdnNG5jTm9W?=
 =?utf-8?B?ekVBLzM3OHVJSHpRa0VZMExyMlFocGw5SUsrcmoreTZwQU1NcDNlbDQ1Vkhj?=
 =?utf-8?B?Z3lNcUNSS0dzWXdmeFJWTlRVeXEwcjI2eFk0QTBLUVREVS9RVlpXN3g3NFEy?=
 =?utf-8?Q?ce2UthB6hH5B+cFFEHbKhnBBwh38XegLGHenY8+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e62531-15a1-42ac-3116-08d93be3dd7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 16:26:51.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7FRGyU5rree1GTBtlZOrTOoqAdXv3ctl9R5ho/0acKC6e2J5OD6DZ4idaq0xi99k+D3yuIYapXX4CaPSx0iHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1225
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 6/30/2021 8:35 AM, Borislav Petkov wrote:
> 
> Seeing how there are a bunch of such driver things for SEV stuff, I'd
> say to put it under:
> 
> 	drivers/virt/coco/
> 
> where we can collect all those confidential computing supporting
> drivers.
> 
Sounds good to me.

>>
>> +	depends on AMD_MEM_ENCRYPT
>> +	help
>> +	  Provides AMD SNP guest request driver. The driver can be used by the
> 
> s/Provides AMD SNP guest request driver. //
> 
>> +	  guest to communicate with the hypervisor to request the attestation report
> 
> to communicate with the PSP, I thought, not the hypervisor?

Yes, the guest communicates directly with the PSP through the hypervisor. I will fix
the wording.

> 
>> +	  and more.
>> +
>> +	  If you choose 'M' here, this module will be called sevguest.
>> diff --git a/drivers/virt/sevguest/Makefile b/drivers/virt/sevguest/Makefile
>> new file mode 100644
>> index 000000000000..1505df437682
>> --- /dev/null
>> +++ b/drivers/virt/sevguest/Makefile
>> @@ -0,0 +1,4 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +sevguest-y := snp.o
> 
> What's that for?
> 
> Why isn't the filename simply called:
> 
> drivers/virt/coco/sevguest.c
> 
> ?
> 
> Or is more coming?
> 
> And below there's
> 
> 	.name = "snp-guest",
> 
> so you need to get the naming in order here.
> 

As you have noticed that Dov is submitting the SEV specific driver. I was thinking that 
it will be nice if we have one driver that covers both the SEV and SEV-SNP. That driver
can be called "sevguest". The kernel will install the appropriate platform device. The
sevguest driver can probe for both the "sev-guest" and "snp-guest" and delegate the
ioctl handling accordingly.

In the kernel the directory structure may look like this:

virt/coco/sevguest
  sevguest.c       // common code
  snp.c            // SNP specific ioctl implementation
  sev.c            // SEV specific ioctl or sysfs implementation

Thoughts ?

>> +	struct snp_guest_crypto *crypto;
>> +
>> +	crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
>> +	if (!crypto)
>> +		return NULL;
>> +
>> +	crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
> 
> I know that it is hard to unselect CONFIG_CRYPTO_AEAD2 which provides
> this but you better depend on it in the Makefile so that some random
> config still builds.
> 

Noted.

>> +	if (IS_ERR(crypto->tfm))
>> +		goto e_free;
>> +
>> +	if (crypto_aead_setkey(crypto->tfm, key, keylen))
>> +
>> +	ret = __handle_guest_request(snp_dev, msg_type, input, req_buf, req_len,
>> +			page_address(page), resp_len, &msg_len);
> 
> Align arguments on the opening brace.
> 
> Check the whole patch too for other similar cases.

Noted.

> 
>> +	struct snp_user_report __user *report = (struct snp_user_report *)input->data;
>> +	struct snp_user_report_req req;
>> +
>> +	if (copy_from_user(&req, &report->req, sizeof(req)))
> 
> What guarantees that that __user report thing is valid and is not going
> to trick the kernel into doing a NULL pointer access in the ->req access
> here?
> 
> IOW, you need to verify all your user data being passed through before
> using it.

Let me work to go through it and make sure that we don't get into NULL
deference situtation.

> 
>> +	case SNP_GET_REPORT: {
>> +		ret = get_report(snp_dev, &input);
>> +		break;
>> +	}
>> +	case SNP_DERIVE_KEY: {
>> +		ret = derive_key(snp_dev, &input);
>> +		break;
>> +	}
>> +	default:
>> +		break;
>> +	}
> 
> If only two ioctls, you don't need the switch-case thing.
> 

I am working to add support for "extended guest request" that will make it 3 ioctl.

>> +
>> +struct snp_user_guest_request {
>> +	/* Message version number (must be non-zero) */
>> +	__u8 msg_version;
>> +	__u64 data;
>> +
>> +	/* firmware error code on failure (see psp-sev.h) */
>> +	__u32 fw_err;
>> +};
> 
> All those struct names have a "snp_user" prefix. It seems to me that
> that "user" is superfluous.
> 

I followed the naming convension you recommended during the initial SEV driver
developement. IIRC, the main reason for us having to add "user" in it because
we wanted to distinguious that this structure is not exactly same as the what
is defined in the SEV-SNP firmware spec.


>> +
>> +#define SNP_GUEST_REQ_IOC_TYPE	'S'
>> +#define SNP_GET_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x0, struct snp_user_guest_request)
>> +#define SNP_DERIVE_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_user_guest_request)
> 
> Where are those ioctls documented so that userspace can know how to use
> them?

Good question, I am not able to find a generic place to document it. Should we
create a documentation "Documentation/virt/coco/sevguest-api.rst" for it ? I am
open to other suggestions. 

-Brijesh
