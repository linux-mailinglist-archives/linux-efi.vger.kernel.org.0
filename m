Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFF93A679D
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 15:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhFNNWZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Jun 2021 09:22:25 -0400
Received: from mail-mw2nam12on2060.outbound.protection.outlook.com ([40.107.244.60]:48769
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233717AbhFNNWY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Jun 2021 09:22:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ym4errBmsh1q8QoHhuI8a34qsFoGW3P3GMNQqK+aWsg7A2IxzOBGO5qVdxc5ffRwUjLHb5iUSTVl0jFj3NJoaVMZYirWfF88Tt13+4JEspe0y0qZBAW47meODO0YURndzDJ49Che4EOd6Z41/td8BveIFdRC9dTiPK+tDAUPW9tO/tHBeP+3EL+f3+2sZ5FiwiqQoiga1zJ3tO/hZLaJpUe9cny9g+CFwuZbtFdG178/DsTnlLFVnkxcToTywR7AVvD5AaNpL28KYnIRroj+YOh/EhsBcXRgmWPLw80amhpYkme0f8qq6ESHpNkjKsnQbq6TWWxP2JbAmr08U7/oMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcUcqV9aPG5kS58MXcoYSVsLN/AKgmwv5nRDztm+r5Q=;
 b=MjV7ye4X2j5ssZUKK3samWtplhv9IYB4mCrBvwf66p3yugL0k+IPOM5B7OfVLkdPSAKIsHt0Bcx2KUzLQxPnJtSB0zz4zZMjJ7iYhgvPBdNyY6AJfE59PLPekvNwQYkS3kBvevBTJgnnar4OoFG/nxRDWUWHKeseETlIxLVEiwDmRfNdVFURXvW8s/4WJdYfCM8PnRk0RhbqP3pEVq2kDXYUw3z1A6a3BShryESxIsfcgXMi8juMlygsprG3/URq0XV6U4ngWGHx/ot2IeKB3rmLTZlc62oXHT7lUpmPjY3x7gpxz/0mWa92BuOe1E3eDDemgRxXJeswXnSoTeQQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcUcqV9aPG5kS58MXcoYSVsLN/AKgmwv5nRDztm+r5Q=;
 b=29I/LKAADjrNEyB6WMRNZ+KYPFxjNVAkjda2r7rN8D/G54YLTFwN48IKymsaV1oSpHq4LtimphetHAvLqgEX8yGVTf1lk5U+ezQpuQYIzTZzDMPrlfLKci286cQ9b94deA5M9vGMDXAUulvwLm3MPdmjUzEJOUBly+C+/aIGeB4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.24; Mon, 14 Jun 2021 13:20:20 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Mon, 14 Jun 2021
 13:20:20 +0000
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
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 21/22] x86/sev: Register SNP guest request
 platform device
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-22-brijesh.singh@amd.com> <YMEVedGOrYgI1Klc@work-vm>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <aef906ea-764d-0bbc-49c6-b3ecfc192214@amd.com>
Date:   Mon, 14 Jun 2021 08:20:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YMEVedGOrYgI1Klc@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN4PR0501CA0040.namprd05.prod.outlook.com
 (2603:10b6:803:41::17) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN4PR0501CA0040.namprd05.prod.outlook.com (2603:10b6:803:41::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Mon, 14 Jun 2021 13:20:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1be80567-86cc-4346-0d66-08d92f37287e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4481:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44816E1756B10FB213DF2629E5319@DM6PR12MB4481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MycA8rCUQQe549oiulh6p9Odmx154VtRgPO1kpdnoaLMd5MaZiB5a3RuDXylSfnn9DqkBlAajqxAXKNd0BPy+ljURd49QUuCljZraycB3EK+dJMoYSghTeVmJgSy8amhhesemekhxa59gAwUkXf1NEKxAlSMCFnEovQkIiqFvX6A8avARYdsN02vVgRbn3qlhC1/+4WxDzBFtf3OheQuK0fljEoIHQ3jouyXTYAqVi167rJ7GeaA/mUCaHJJDehzOHN4fjOm5gTa5EaXc2HdNNKmrrn6pABFmqVDGwDXHSD67r1JxGRcBFmhFldbu433b+rvnJlFn6SD9oJhmp6S47OTloub9zFLgWqD+w8uf5eivNUmFvlhcw+giPeYfM2LuGZV6s2o6fUIpQK0ZaZNJBIs0mYKruuzE86aINoz1WT31x/PlElFME3d2gSCF6AweMvNhmCZPF8Giiv7ryLgyp7mRdUJROE9Ckn4AbkuWReUTawCZBTb1Ybb8GWKjnd3krEu0sou5p0iJB5gst/n971XNt7hojEq6h2tHW2SXElGnCrEXpmI8o0VfSTxqhMZigsiArNse8C6i4YJPAcihMsrb5omLWAnRws5QYe9uqMZALGzU2WbPeagg0OeRA0M0wot0H0zqKztltSfyE/O5chtzIdznL/Fg7m64dEZ3CvUD08RZC9MCp5R/I0H2pYi21YSjU9jF/MFJPK5SzNcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(956004)(2616005)(478600001)(44832011)(8936002)(7416002)(2906002)(16526019)(186003)(54906003)(26005)(316002)(52116002)(6916009)(86362001)(4326008)(31686004)(53546011)(6506007)(8676002)(5660300002)(66476007)(83380400001)(38350700002)(36756003)(6486002)(66946007)(6512007)(66556008)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWM3VGF3YmhGODJNMkliQkZxRmRld3hyRnA3MDk2N2dUWThQRnBYTHpjQlFQ?=
 =?utf-8?B?dCtZS3Bqc2JPS1IrQkQwdEwxQ2lqZkVmYmVIVVlqd0ErUVZjRjNlUnVja0cv?=
 =?utf-8?B?eVpyWmdZRXg4eXNGZHdNSDVrdVNWbFFVOVFTQnJxelB0VXhscjZwdlZ1VjM2?=
 =?utf-8?B?VmlFODFQMm85N0F5bmxiSDErOWRETnA0V21Uc3JtWks2d2p1VWpSaE4rTlRC?=
 =?utf-8?B?SmVLNnNIMEdseW9Ca0lkQm4yUjAzRDF2QkN1RjlaM0h2U0V1RHh2SG1TeGtK?=
 =?utf-8?B?U3RqMVBZeTdRUE5FTWovNzJnckF2Sk5QQTl1dDJmQ3VaeVJVd2Z0amFmT2RL?=
 =?utf-8?B?WVcwaG9SeGg2c1hjMW1sdy9MaDdja2ltL0hnUjFRbE9LN1hzZTlhZmJudC9v?=
 =?utf-8?B?UGs0ZUUzNkVuZmoxOHdPNkdaQzZmNjBKTVYzZTJUL0VrSUNPdmk2MzF5UEtO?=
 =?utf-8?B?WXlLZUhWK3c2bTJFOVB2bjhwTEhSY2NLQ0U4Y0srd1o5UUFCWWwzSS9TNHY5?=
 =?utf-8?B?M2dJOGtndHpjcFBLWXVTUEkzZEpvVkxXb0FWKzFxa294cVFoNXliQUFhMlN2?=
 =?utf-8?B?MkhFRE9sNm1lMWw3T3BMNk9PV0V0OWlaWlZJODNOTHc3byswRlRMMlU0QStS?=
 =?utf-8?B?ODVxWDhFSysyZmZ2N0JSdE1WTHJNTXFiZkkweVpoUkRsV0FnbHdDbDFQOW56?=
 =?utf-8?B?Z1EzeW4xMzVxQmpvQmZoMVNMR2JGNjdUT3FhY2VCRXBTbFpEUldEYUNibmI4?=
 =?utf-8?B?VFZsWThBQTlURzJJK1ptYVI3Ry9WT0tsWGlpRnk0dWQ5eHdUM2JyMzJZTEMr?=
 =?utf-8?B?Mm1xbktzUUhuakpJTUdEYW1uOXNEVDdEb3VBUjUraElxN08xbm1nbnh1TDVJ?=
 =?utf-8?B?ZWlwN09GQVo3dlhneWo4blhleUljOGtYSVE1ZEFKamdmMlRiV2x4bm91ZTVO?=
 =?utf-8?B?RFZyT1FnRFNKTkJaNDlsWFUrc2sra2RGQlRHaDFxYnVpTjdkMWErYXJ3V1pi?=
 =?utf-8?B?eTM0U00rSWxRbUFtaXBuQXhoaEZocHBMT2ZmQXJDUGdYOThpSWxhTHp2QVRt?=
 =?utf-8?B?YUh0VEo1ZDlBRVdKVlZZKy9KMnlsTUZCYllabm1VUG56TGlmUmYvQVB1UzBj?=
 =?utf-8?B?VHF1U2I1RlJjSmRnaUkvRVBldVBFeWtaWXM5UnJtS1Rrb0dHeDVoWkFWbmZB?=
 =?utf-8?B?VVB0bkRXaThEMVZnRUFGL3dKUWt4WDUwelJhQ1V4dnlOSVJLZi9iRnZ4VWdh?=
 =?utf-8?B?aTlDYnN0UEV6SnpmaUl2Nk11L2RPVTdqWjlXYVZFNENva2RFNnhscG1HN2li?=
 =?utf-8?B?N2xxNFhEZVRhcHBVZStYZ2JvcUU1VUhLYXpRdVZDbnZzcGk0WWpSUlNKS0hU?=
 =?utf-8?B?eXd3bHcxaDRrWDBGV0ZMMnpvZksvZWx5Rmdremc5a3dJQnh6cG03RzRsY3Zx?=
 =?utf-8?B?WldFd3V6VENnZkY4dTJRRktrUGtaZ2xsT2N1cmVpQ0xxVkV2M1ZEYVBQdmF1?=
 =?utf-8?B?eXc5a20zaDhFQVgwdmtDN2pwNE1qc3RYWThGWmwrNXhqM0FWZ3gyVjczUjNj?=
 =?utf-8?B?d0hzN0RpMFdRT2dLSlpLWE8rbmJSLzB4RXdnc0pQUWdNMW9Ga3VWSzdiLzFW?=
 =?utf-8?B?enFnUVM3VXB0ZFpuVGJ4aVBXaVdUVjlQT0lPcmJOcDNNZnB3eW9TdUtIanRL?=
 =?utf-8?B?ZGRMT2pYQ2kwOW5tdWlEWk05NURIUTJwc3kxdnp1SklXT2tOc3F2dnhhd0ZG?=
 =?utf-8?Q?G/EMgKmoIh2/Zdse9BnYQwH70rNvhqDfbqm4CAs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be80567-86cc-4346-0d66-08d92f37287e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 13:20:20.1340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxcSqUlDwHIsPUUQ8AJhTg1zW6dEz12nMv1Y4352t/5Edz9BI1zKTxGhghU6sWU6ekQeFeXYumR4gnUQ5ttkog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

I see that Tom answered few comments. I will cover others.


On 6/9/21 2:24 PM, Dr. David Alan Gilbert wrote:
+ /*
>> +	 * The message sequence counter for the SNP guest request is a 64-bit value
>> +	 * but the version 2 of GHCB specification defines the 32-bit storage for the
>> +	 * it.
>> +	 */
>> +	if ((count + 1) >= INT_MAX)
>> +		return 0;
> Is that UINT_MAX?

Good catch. It should be UINT_MAX.


> +	/*
> +	 * The secret page contains the VM encryption key used for encrypting the
> +	 * messages between the guest and the PSP. The secrets page location is
> +	 * available either through the setup_data or EFI configuration table.
> +	 */
> +	if (hdr->cc_blob_address) {
> +		paddr = hdr->cc_blob_address;
> Can you trust the paddr the host has given you or do you need to do some
> form of validation?
The paddr is mapped encrypted. That means that data  in the paddr must
be encrypted either through the guest or PSP. After locating the paddr,
we perform a simply sanity check (32-bit magic string "AMDE"). See the
verify header check below. Unfortunately the secrets page itself does
not contain any magic key which we can use to ensure that
hdr->secret_paddr is actually pointing to the secrets pages but all of
these memory is accessed encrypted so its safe to access it. If VMM
lying to us that basically means guest will not be able to communicate
with the PSP and can't do the attestation etc.

>
> Dave
> +	} else if (efi_enabled(EFI_CONFIG_TABLES)) {
> +#ifdef CONFIG_EFI
> +		paddr = cc_blob_phys;
> +#else
> +		return -ENODEV;
> +#endif
> +	} else {
> +		return -ENODEV;
> +	}
> +
> +	info = memremap(paddr, sizeof(*info), MEMREMAP_WB);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	/* Verify the header that its a valid SEV_SNP CC header */
> +	if ((info->magic == CC_BLOB_SEV_HDR_MAGIC) &&
> +	    info->secrets_phys &&
> +	    (info->secrets_len == PAGE_SIZE)) {
> +		res->start = info->secrets_phys;
> +		res->end = info->secrets_phys + info->secrets_len;
> +		res->flags = IORESOURCE_MEM;
> +		snp_secrets_phys = info->secrets_phys;
> +		ret = 0;
> +	}
> +
> +	memunmap(info);
> +	return ret;
> +}
> +
