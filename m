Return-Path: <linux-efi+bounces-649-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A842F85FA8B
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 14:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6062821D7
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8385139582;
	Thu, 22 Feb 2024 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tiycohjv"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FADE146904;
	Thu, 22 Feb 2024 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610313; cv=fail; b=sJAI+R+XOyo2xm1idHSN1SiJXIqZVk2EJ3+yrQ1vAk1h3EIriMSPcnrEmapGrkUCbwsJNxGG1KISteDc8AVsRm3xLFYRTqaB2bhsKFo4YJmMMF3m3uOjy2Znhbzvw/etxDgej29lKE43bTD+PlAax90Bgho/2d7ylD6VxYdK0Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610313; c=relaxed/simple;
	bh=Q/CDsDbz/sBkvLDhefTuzy43k2uKuSgfFXbvK8C9D5A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OybXJiv5nUIpWyn8HdUcSJc3y1WlO5sXLC7wwfPMTcxxoRWSTkxVQZV62Q67VbTSHshrOGR20WVWLfC/Bdr3/6a9DLZjRSlC/USBL0MK3Uv+1/yxz+kQbE02BgiVqqq/my6+YQYN0/5oI9se6T7YWn/8kJIZuZMZW3nz8ZE0TlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tiycohjv; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX8+GLTiaVu3ih6oFwwrnJTfvwlKU7JLiS1ajF4l5Q0eZa6X4oOznpaQgKJtGiVsOIYpzfDighY+CgrSwVCIBxTuitMcuSHb3G/mS4h4UwVLXG5MPCN4UTTrQ7vGNvSul+hMLtWZq8wkMxNEmaVeOXR8LpXUALw4N+YjsMlw1N/QJjMcvprcsBDNLG1yYk9K03Z24kmdDSgmsMZrOEmckpv4Zmzp4Z1OSWp2k+7yyR18Jvl82pcX1rC5aTSAMgYfKvmkqjxdcbLzxICKZPqS9x6fn4e7YZhu10jiMGMOef/cCWQO4ZNcuiosnGfe1QIi45r4QjnMguulEg1yKtt/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76UNAyFAu8qjfnGLlE4QYhRAxCfrTSJzPyxjhNMzfwQ=;
 b=CoXoopxH1q7+ZM9fId4cE8KKNMJNhG/J5Osi/XnpcSoJdFtDG3W6YyHQeqYUS0Df4gmw2tChv0Yu3ILOCHvrwjPaB6ouB6vpCcV1JMPExumNFWCQPe4ahWe8TqEGiT4xctGMydWsSr233oeG7Jq4q/o6Vki6NQ2G7JzEFPKXiF+K3FJJmCU/eiV33dNjhmU89QjkbeCX8Oadpx4D6r0Z1py/CwlhCGX+ivd1/jQNTaVYIiAInp21bEOePxOsYwbqtv02KymJ7smAqBWp2WLa+T9OOYQxlF3QB6x+1T6/+20HH8umEyy+TbXbb70YH+Mt/zV7Umi/C9NVSeSmp+fz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76UNAyFAu8qjfnGLlE4QYhRAxCfrTSJzPyxjhNMzfwQ=;
 b=tiycohjvFPbZvXdAgvRt2NPDYjg8LmuU5tdw7FYcdZkmCynbK3k8/G//g6c6MPfUxLIu+DWhYNU6EQsu1x2T+o86Jj6sJdrJE1aaDxMZraWx2qck+WoS9YpisC8QE3jXT6OOs3f9WTX6NeR03Hw3ziGdQNETxkbqxWSZwx1c99w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 13:58:27 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 13:58:26 +0000
Message-ID: <3b7a719b-d7ff-495e-af3f-a419e4b46d96@amd.com>
Date: Thu, 22 Feb 2024 07:58:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/snp: Convert shared memory back to private on
 kexec
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 luto@kernel.org, x86@kernel.org, ardb@kernel.org, hpa@zytor.com,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org,
 peterz@infradead.org, adrian.hunter@intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, elena.reshetova@intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, seanjc@google.com,
 kai.huang@intel.com, bhe@redhat.com, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, anisinha@redhat.com, michael.roth@amd.com,
 bdas@redhat.com, vkuznets@redhat.com, dionnaglaze@google.com,
 jroedel@suse.de, ashwin.kamat@broadcom.com
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <cover.1708390906.git.ashish.kalra@amd.com>
 <aa633d7439885da7e54c41db07d65f8e177bcf51.1708390906.git.ashish.kalra@amd.com>
 <97a7d69f-03e1-4ecc-a0ce-10bfe148509c@amd.com>
 <amk4ozai3l65d6ef3k2rsnapaislbvlwpfx7p35tqqhesmc4w7@5vmi52a3qv3o>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <amk4ozai3l65d6ef3k2rsnapaislbvlwpfx7p35tqqhesmc4w7@5vmi52a3qv3o>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0079.namprd07.prod.outlook.com
 (2603:10b6:5:337::12) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b5ae32-f6c0-44b9-7ecb-08dc33ae571c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3QFJL/YN8OvVTf30UBKS90D8gAZ2UINYHs8ZZ2hB1K5OPgZEmDdyc8hFpMK6z29HbpLZamlY9gmkHmvPDDWueQMJTYGTh0N69jEF7fjkhIjraHc+Pbs9pKb02AQU1Kbw2VTLbigz1nTEBrsU++qVtkYfABvKJSOTfJIfs9XHek9JnnzMm8OfPDw8nNpghKyIODY+Wbc1k4AjPMV5DcDVKaS+IVGzbe7x/FupHtMgCT1zTIs0FYYT1slQgnfrYHJdJM0rYKlkZY+jyajIMHrJ4U8n/h5F3bbOyMcdstILfjzmdDkNStw6b/sUB67zuRiJ5e8PsFvM95/8vrwMxyS4tWF2hQ/Y49WZWpWRE9lnoF64PDrr9isyMX+yjY78yhI344H6GEsIlKlgoUjyh6El+freK67djhMLQJTTSrKJJTWlC/HuvO5mw3xb+MooVfEyrvoC0TqU5mmA/ej7eUfonDnO9n/AcTyesoFwoI4WAGKYPapR5UjGnwnmoZZIA4WgrLMxhH3k+1ZdzfjWg5QGXKNkBBMdN3MAd5s6WCDHp08=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1drRG5XVXN1YWsxdGJNcm5qTU1qKy9ET2pHVTFjcTJjZkV0YUF2cUxtc3Zw?=
 =?utf-8?B?YTlRdzEraWpTTWZCTFQxTHZKRDlYaWgzeFJJYisvMFBaYWg1WG8zNnJKWUt6?=
 =?utf-8?B?NndaMm1sTHNqSnBwOUswYlYrMlJZRnBlSUJucUdQdUE4d1k0ZFExN1czNHhN?=
 =?utf-8?B?WGU3NlVhZEFEZk1PUy9Hd1VEQXlidlNpTW91dm5oNSt0VXdqU0Y1SE4vOHp5?=
 =?utf-8?B?cDFBRmlzRGt1cytoblNNdHZDNDAvRWxCMG1VbGtsYXEvaUlydEZjL21jY1h5?=
 =?utf-8?B?N0tNSjRhVCtNN2VYdHB3d1hwNkwrSklIa0lZWXlDenZmT1UvbTk3UnVBN3Rj?=
 =?utf-8?B?QTZtQUtUYVhrbzFFbFlXZ0ZLZlpZNjE5eGw2ZzdGTXYzQ0lPNWJCVVdTZ2xX?=
 =?utf-8?B?RktTZEVCbjRWcGlKYmx1RUdDeWxFQ0o5eHBENTZCSytOaWRwd1czWldVWE94?=
 =?utf-8?B?VmtBMHBFdGg0QWhiZysxS1R1ZTlvT1k3U043ZmJtUm9NZUxwR2VjNWU1ZWFT?=
 =?utf-8?B?aXY0VlRET0dFV0VkWjhGMlN6dEVvN2h1b0YrY05lZzhMSXlaa0l0Nm9SakxY?=
 =?utf-8?B?NGk2OFoyVWtENDhoY0NJNmxuRExLeVhGVGU0RGorQnlZTW1EUEdBRjYweUdE?=
 =?utf-8?B?WjRSRnpGcDkwVTFUdXhGQmNhRVpuSGQyd3JCQXZHZ2FCNVBOWjlmL1czOU1i?=
 =?utf-8?B?QS9KUSswY2xSbmYvVUxCRDkrdFE5V0V4akZlM2lBU2RjbVNhTmlCcGRRTUpy?=
 =?utf-8?B?VDRpTks5MnFoYzBvanU5UVB0RW4xQ25LNTRXT0NFSGY3eG5xTk40VWVLNlpG?=
 =?utf-8?B?UUlZR0hCZDh2c05rUHpvOGMzTkdRRmM0aE4zbUQxVUlaZ0VSUThoSVpJWVJD?=
 =?utf-8?B?bmtRYVBrZzM1bXd5aXd4NnJEdmFwRGtrT09MNmwxc1RWbnFPK3ZTQWU5VXdG?=
 =?utf-8?B?YkJRcnZtTWw4eUlaSUpvTzNKSVgzWTRjdjdqRFBzblBWU3ZMMVFQRTJPaC9S?=
 =?utf-8?B?bk5NU29kTndHN0tMVzdpeDcvYXduR3lhOE5ERkY0MCtienU5WGdXL2xncHJJ?=
 =?utf-8?B?UmoyWTR6RUpyVEJaNjhTTktwUkFQWGpNaTRYdktLVlBEY2lhMDMxRURxZTQ4?=
 =?utf-8?B?ZWVxcURWK0JSeVptUG9tS2JQL01LdUFGZkJzZGp6ZkNJWk1PQ0FKOVZyY2tD?=
 =?utf-8?B?UGNEL05jQ2pxdTVhSUhGZDdNbnROTUhmUnY0d0ZJTU1MR1paNmNjWWd5MDkr?=
 =?utf-8?B?QklJN0dZSzBEVmtVVXVHeDVlSGkxK3lxWmhyeVQ0Q0dYT0xuM0tQT0h2Tnpo?=
 =?utf-8?B?MFU3ZTlpT2dKb3Zaczhiak81dkZJc2pBd0lXVGxXNG5JekJPQ1puS0kwV3Y1?=
 =?utf-8?B?YlBIeHVKWVNVN1psUGJ3dDlxN1lTQlpsSDlVb0dKZWV5aXpodzRDMkFZMWhq?=
 =?utf-8?B?Rzc5bGFFVTA3bG1GVWdoWEVQbHVTTGxvMHkzVURSSnFoUjdSMHVISFhveGZY?=
 =?utf-8?B?UWxiaThrZFBFVEFTTVRQTjFFYUVZdGU3OUVDUWdObU1TRTlaK1lYQXNleDV4?=
 =?utf-8?B?Sktma0tXSmFKbEZLN09xYk83QjVyWlRiWHdEQjI3WEVmZDl0Q3Evem0rdGZu?=
 =?utf-8?B?S0RKRnJmMzR2T2UwYVNQNmVnMmdBWUc5YkhHcDRDYXJPdUpkaDhMQ3RzdUxW?=
 =?utf-8?B?dDloUWppelBadEc5TDBYZjAzSDdVcEd5VFUxdkpaQ2E2RFBFVzFiVXVzTjF5?=
 =?utf-8?B?NUt1QTZYL0VTNkQ1cFZzaE9qVEVmREd0L0R1bVhzVzFFNVk0L0pSd2dJbXhL?=
 =?utf-8?B?V0dVYU5wYnFYU1I2bm82bUxlYjduaGFEbzNneUFmaTFGblRmSzVJVEl6Y0cr?=
 =?utf-8?B?cnBMbjhwVytzc2J2c21jZkkwMTZLTXRtWXFwM1MrUVk3NGhndE1DYmhiamIz?=
 =?utf-8?B?bTV3Nng0aUhoNEtRUThIN0hlMmlLOTZkbEF4NmJoUzlxS1VrSFlyb21TdFY4?=
 =?utf-8?B?MG92TDFHeEV3bzl1bllycTBnS3YvczgyMHZEanV2VWo5eXo5T1NkZVFzb1M1?=
 =?utf-8?B?L09rRldhbWpPY2Y5NWRyRzMvTXRsYWNiajFIV0xOUERnclFER3Z5RHhHOEkw?=
 =?utf-8?Q?8xcz/qW+PJs0gf2MDZ8O4kWEQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b5ae32-f6c0-44b9-7ecb-08dc33ae571c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 13:58:25.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEgqhHn9kL9ofZHlLHA5ttkhRAjVUEw049Kbjd62BtXuf2kl0GdnE3ThlHL3CJJudUo/gTsuk+fu3eVlKCH8Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714

On 2/22/24 04:50, Kirill A. Shutemov wrote:
> On Wed, Feb 21, 2024 at 02:35:13PM -0600, Tom Lendacky wrote:
>>> @@ -906,6 +917,206 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>>>    	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
>>>    }
>>> +static inline bool pte_decrypted(pte_t pte)
>>> +{
>>> +	return cc_mkdec(pte_val(pte)) == pte_val(pte);
>>> +}
>>> +
>>
>> This is duplicated in TDX code, arch/x86/coco/tdx/tdx.c, looks like
>> something that can go in a header file, maybe mem_encrypt.h.
>>
> 
> I think <asm/pgtable.h> is a better fit.
> 
>>> +void snp_kexec_stop_conversion(bool crash)
>>> +{
>>> +	/* Stop new private<->shared conversions */
>>> +	conversion_allowed = false;
>>> +	crash_requested = crash;
>>> +
>>> +	/*
>>> +	 * Make sure conversion_allowed is cleared before checking
>>> +	 * conversions_in_progress.
>>> +	 */
>>> +	barrier();
>>
>> This should be smp_wmb().
>>
> 
> Why?

IIUC, this is because conversions_in_progress can be set on another thread 
and so this needs an smp barrier. In this case, smp_wmb() just ends up 
being barrier(), but to me it is clearer this way. Just my opinion, though.

Thanks,
Tom


> 

