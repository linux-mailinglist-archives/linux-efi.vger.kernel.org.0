Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9862F3B4689
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jun 2021 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFYP0b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Jun 2021 11:26:31 -0400
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com ([40.107.223.69]:40096
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229445AbhFYP0b (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 25 Jun 2021 11:26:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEhiGSn1hbwaWWdE9gCiJOSV38LKRiiVcNs71PXz0NrVQnST7YbreyjahC/2QbrboFL4XeJEDzf5eKdC2lLEYhLoeo3PCQEygw4qkNfwFI8wZ4v3VYq9p13voGPMvOWlSz/1E0xjbSZMSH9NbTa27gePCywZJ5NZUcOkcI5u+gtCNTeLchT4Q+5WWjlaRVeUWk9KtYbKKThDRjdtHYX0l3juOpVFvkGgot806eLMoDkZt9qZmIA1pSNIfx9oOt5cIhi0UezCgctCHzpuR9kjtLTAU2fXHj43v5rW78hO9Hhsp34dFCDfkoi3bfrmcnU7AV1Cv5SnwnMU6s3VMcZyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCT/WEI2tnuui5H5cnSBt74NZ+EI44YlTu4BSMm8JOo=;
 b=MISsC3f/FrU+z0H8O1X6OmXzoLtB3h4dq1M9J7kWDr7rrEPlOAor436jR1juyNidQqRdNd5yDIPkE2Yk9cbVAbtXuMBLI+xwKZ2yGzz91PoxuYOBViPn1vqZUktTBeOiHmAGqqIgD0ZIob5+cPMrLU4Hnybxgj2EZ8YAtcS2D2CLb+bu+pD4IyPauhM4IhQSgJHgZKEyfC7qZ3uqX4cmGSYoLApZqN0Uzs/XALSurLIXsmAp/psOGnZx+CgPJIBHr31rsvsnocw4mgPLO+x7EYM0R0I6DPBHTTROzwiG3MxsBS+dTtDOZvgxdSOk8Ar0XDUBq0XHTBUw3lFBPR0yMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCT/WEI2tnuui5H5cnSBt74NZ+EI44YlTu4BSMm8JOo=;
 b=OJr06ydFSzZm0lzRqNumKoblctRdyrzpP3gdrT1TTD+0QMqi15H7W3hq30fh+ODM0xh02wW1JiBuATrcg10F+RBcmzIxOgXE2x+khFKqJ5jFqalO2P5VKtWVM/10QraVV8XNUdnNg6jxcMt6ysQm8z2Bv/tTSPZ6934u8ri4czA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM6PR12MB2924.namprd12.prod.outlook.com (2603:10b6:5:183::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.23; Fri, 25 Jun 2021 15:24:07 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4242.023; Fri, 25 Jun 2021
 15:24:07 +0000
Cc:     brijesh.singh@amd.com,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
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
To:     Borislav Petkov <bp@alien8.de>, Michael Roth <michael.roth@amd.com>
References: <YMw4UZn6AujpPSZO@zn.tnic>
 <15568c80-c9a9-5602-d940-264af87bed98@amd.com> <YMy2OGwsRzrR5bwD@zn.tnic>
 <162442264313.98837.16983159316116149849@amd.com> <YNMLX6fbB3PQwSpv@zn.tnic>
 <20210624031911.eznpkbgjt4e445xj@amd.com> <YNQz7ZxEaSWjcjO2@zn.tnic>
 <20210624123447.zbfkohbtdusey66w@amd.com> <YNSAlJnXMjigpqu1@zn.tnic>
 <20210624141111.pzvb6gk5lzfelx26@amd.com> <YNXs1XRu31dFiR2Z@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <8faad91a-f229-dee3-0e1f-0b613596db17@amd.com>
Date:   Fri, 25 Jun 2021 10:24:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YNXs1XRu31dFiR2Z@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BLAP220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::17) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.35.102] (165.204.84.11) by BLAP220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 15:24:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c86b0849-49b0-4304-d93e-08d937ed4608
X-MS-TrafficTypeDiagnostic: DM6PR12MB2924:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29246DCC2EE08A62A25343A7E5069@DM6PR12MB2924.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePLoVwLB88PLosNOduGp2J49H/F28Enk8Oz91J4ZV2l6WUMG/TEXuQvSVU5JFMxJ4JK9b+aeVSEjHsfCFiLKYLV/6apQyqKH7N7k2WCGw3DN5sQfqxrWTjQvoZEcCd8ZoJnCYTh/YbYqYxc79Qw2GD5Vx7xo3eEZzLm+yCRvbKYY3vJmSiuyzfunX5wtlcQQhmaSXa2F8+YssOmmkBx5cPmFJAFa9xW9+4ch3XKFBFeQWv2hYYYHVFstZxyMjfvpMO6x2BRufHeZME7Y8jSt9CwPHctc6BEBYbStfLfrfqhxCR2kP1cYUQnoY9wZjTon2rUnSOFR4IOZMIfvS95flSRNj/gBtMLxaSeQkwI1hFJamCnGEi9Rve2NDhH7eYlJrpnmdTc9/Ta1ALwxhatkw+h8CaKQ2FiXIFvcdQLJAa6okAET521CBwADkZo63aBVLD3rE3r8jd8JUqRL47j007DmiCoIphX0FLakFZU0K172nMNiDUZhKDUwV6YC7j9LWR1PHVBQe0XlTOn4yI8WH+6YGGiy5VhMy8EEwzH2/PeVFnt5kepTOdkP9LTqY60CYOspy3615aRxp6bdnm11mDbqbgnuwxhu2mdu35elfuBw/q73VQJ918OGof1RPdkB7OcRlCAW1l/wUDIzRZEBsgO1estE0vNwLj5zzTDKDweCL5zwWo/vHQuPQ49EOb5olF3ZGrm7cD3vD/ynhvX0KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(31686004)(31696002)(38100700002)(38350700002)(956004)(7416002)(478600001)(52116002)(8936002)(8676002)(2616005)(44832011)(5660300002)(4326008)(16526019)(86362001)(66556008)(66476007)(53546011)(6636002)(26005)(66946007)(316002)(36756003)(54906003)(6486002)(186003)(2906002)(16576012)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTFDNi9iUmJLWWhleTJ0UWtreDM5dEovTkU3NGs5RHBlSy9rbUJTc1JxSDVs?=
 =?utf-8?B?OWtyb0Nadm9XODZrQlM2cThodjNwNE90TjZleFF2STVpS05FZlhvZXVGODBl?=
 =?utf-8?B?MHJleTlWbE5ha2xlVHc0SWVTL1g2NHVleUpmUGVvMDBCdWVUaGEzUWl3VnZm?=
 =?utf-8?B?OXJEcW1FdXFvb3h6SkZMQkh0RkRNYk5rM3dkREgySUVrZkljYy91bGxweWhu?=
 =?utf-8?B?YlY5ZmlvVEVzUjdYN3dwS05UV0E3MVJzQkFQMVVOWXRkNi9LQWltSUZZd2lm?=
 =?utf-8?B?dkVJRkdaZmhPOXQ5VHpBOW1wblFFZmFUajlpdGFFRFdsdUJ5UmhHSDNOdDlr?=
 =?utf-8?B?b1hZTnROM2g4ZHNsZVlteFF4ekdQaGF1cFc0cGd3OFhmbk5FWXdFTGFjRHg2?=
 =?utf-8?B?YmYxZ3NXSUdYZUFxdXlqaWRyYng5YWN0c0lWR3BXTWdqdThBYzdYZnhZR2dx?=
 =?utf-8?B?cW1IRzlQaXNmbmk4YkFFTkx5QWlVSzBOODhJaU9CaGtSdUFqUHA2MjJIaE5l?=
 =?utf-8?B?bERqYnR1RjRVcTJpZFlXQ1dsQ0pRTWhCQjVQQWo3NzU3aWlTQ1FQeFBBVk44?=
 =?utf-8?B?SGladm5mQVdGMlhVdjhrbkdsZFVWZ2d6bWVrTHhXM2pxS29rc0hzQkFNbWZK?=
 =?utf-8?B?dGdvckE3dUtOZHJ3KzR3S3l5c1BTcG5scjROYURQSkk1T0tRZGU0TXQ3U29J?=
 =?utf-8?B?eW1BMG5WcjR3SUlDMnV5RHNqcXkvOEVGMTB6NjR1MXY3RmU2WnpoV3RxVGlZ?=
 =?utf-8?B?dFhBTG91eG9KZlY0aWNqa29pVnQzaGlqMFRtdlFONDczcWRML3dUMk9JRVdB?=
 =?utf-8?B?dURUSUVVVVFiUnB1aVk4UjZJN0lmS1ByRW1wWjdOSlEzUjExTWdmR1diMFNo?=
 =?utf-8?B?NFVBMHlrUTMweGtSdm4yUUE1aGxJVnd0eGZIT1Fsa1gyRS9OYUJxTGJPVGhZ?=
 =?utf-8?B?T253UElkRklkRk80aFZHU3JpOTByWVlrRnNITFQvQ2ZqYUdnQSs2K2tKb0E0?=
 =?utf-8?B?T01pL2pvc09vYk5VYzJCM1dQRVdDeG1aQUVVYXZwTE91WFN3Zk5XQzdtZElX?=
 =?utf-8?B?R0tOTUpXajU0T25SQUx2SGlpNTZnT0RDUVU5cGNaZ0t1UFZqcFR0dE1DYWFH?=
 =?utf-8?B?TlZWdVo3NkJYZU5tVDVOcFVGdk5IUnpvZ2duWCtNY0RMTWtGN0ZyQ1lCSWts?=
 =?utf-8?B?ZjBHOWxzd1dqVFIrdnJEYmJvcVlGY0NMem1maXljdHl0Y0xpVzU4ZWlZM3hz?=
 =?utf-8?B?WElFZ1hjZ1doREpMZm5yNlJaYzEwZDIxekpJOHkzN0p5aU9wOWVjMW9HTEVM?=
 =?utf-8?B?ckV1UjN2VXJ3elpLenpHR1JZQWhCajdyMllQUjVvczdCclQ1MkIweUhoSjRY?=
 =?utf-8?B?dUNDQ0RPbm5XbHBWUU96bE9EWFhadzh6YVlrMUhQUi81ZStDZVNUU0E1NUZI?=
 =?utf-8?B?bGJoVlpGZVlSaThMeTRYYlEwVTJOdjJHMitONFB4bWFsOVVuTTMwajdLc2pt?=
 =?utf-8?B?cGh2d2RpRlJBRGt5M2tyOU5lTko4N0h4VyttWjZxSitZbEZqOVpTL3dXMFgz?=
 =?utf-8?B?dHBCYXBsYWgrbTlpUUlVUnBuaGlIV2ovcDAweUZhVGwxUFhReDFJd2VOTU9R?=
 =?utf-8?B?b24rZ0wvRGU4NkJOdG9xMzdXOERkL1lOdWNrMERPYTJoTFEyUjM5RzMyc3Fx?=
 =?utf-8?B?WUUvYndoUXF0VEVyUGxwak16SURQbjRmUVdsbHZqZFIyZUJicHFXNmpFR1FN?=
 =?utf-8?Q?bhCG4gtoIvx5QxR2Ks795XTyekv7WJJ+LrlUydW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86b0849-49b0-4304-d93e-08d937ed4608
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 15:24:07.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjZf/mwXrACXExbwfQd5u/OE+izECV2R7LsevK89dcNbXVqsFQaFdXmOPJY6tL/kWj63XWwRE4a/G82z8WVNPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2924
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 6/25/2021 9:48 AM, Borislav Petkov wrote:
>> For non-EFI case:
>>
>>   We need a "proper" mechanism that bootloaders can use. My
>>   understanding is this would generally be via setup_data or
>>   setup_header, and that a direct boot_params field would be frowned
>>   upon.
> 
> So, you need to pass only an address, right?
> 
> How workable would it be if you had a cmdline option:
> 
> 	cc_blob_address=0xb1a
> 
> with which you tell the kernel where that thing is?
> 
> Because then you can use this in both cases - EFI and !EFI.
> 

In the case of EFI, the CC blob structure is dynamically allocated
and passed through the EFI configuration table. The grub will not
know what value to pass in the cmdline unless we improve it to read
the EFI configuration table and rebuild the cmdline.


> Or is this blob platform-dependent and the EFI table contains it and
> something needs to get it out of there, even if it were a user to
> type in the cmdline cc_blob_address or some script when it comes to
> containers...?
> 
> In any case, setup_data is kinda the generic way to pass arbitrary data
> to the kernel so in this case, you can prioritize the EFI table in the
> EFI case and fall back to setup_data if there's no EFI table...
> 
