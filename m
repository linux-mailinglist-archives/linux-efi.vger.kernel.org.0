Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFC34A92D3
	for <lists+linux-efi@lfdr.de>; Fri,  4 Feb 2022 04:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiBDDrL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 22:47:11 -0500
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com ([40.107.236.74]:11712
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232345AbiBDDrK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 3 Feb 2022 22:47:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nS6uY7f0OPTkIhqyf3vc/O3f0WUve59j/esDWvzVjXeF7MmAdp168PXs038o6jFrSu61RtX/qrGpp16Q07uLvmgSNQ+mGKli7XLi2vI3YZkHVomxXZpSVK+vFloWleLSuiA+rjf2wO5p3SOgNOEPxU7tAuprDgkvy+sDmKeNQP7fy4VN0v8G9opf134hVVmD3xlRwd4Un9sx8ZzIRliUgHJWWT/sl8RJAixVUXpd4ZXS26ubK+bjQGG4PXp8DXCaNiOBgmqxbyMAplpeZrivK+S38ZJ60QG5LjjrT8PT57scqQ5p6g/RpQXWECsx8NL/HdKpOLLWfLHw/YdvFfmBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2uG1D3QVrHsVl4D88DeXg3OThfJ2MtOcC7T1EM1NN4=;
 b=eY+2pd54FugjtDI8rDDnlJg+IJ6Xg8Yyk4wAYmUZREI2HXPTuVNbOI3PwEXulMBhMmQxnWlsY66AgPTKg3uxysKTZr4GWzxKp+C2Gxha86kT48ppTAHIe4RybWAnqJZkX4xMWWUGNwntj/YY1E6oZSipSDlCI570sn+5P56IvkcMLQYEnzFaIHp3uY/TTCUiCRWCVfaI8dNKjjjDorVrQ14uzJIIeKxCXsCLnieWp7a9ayX3wf18BXqjEhfQbcBgNDlnmjh2V9Ga0d/3oqJQibwTynq/QYWZqMwHPZNLyuvEjtGWat1mcovQf0lwpE8BAMbjTnuoJx3NkFWU6BGP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2uG1D3QVrHsVl4D88DeXg3OThfJ2MtOcC7T1EM1NN4=;
 b=zJXDisXwHC6VX0qlJPYRj0JUVuM55u2d14o6iPx7kaTDq3GcktLQAIGy3mILwdTc4OrWO08t06w2TOLLvOkZU6TbFTZdLJpaIIjE2UmKq2iXFSbckSdDcqMA8ugm0DdgI9wC13htJODPtgL7r2GZE2kckB2io5DWLdHRcxKyyfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB3481.namprd12.prod.outlook.com (2603:10b6:5:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 4 Feb
 2022 03:47:07 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 03:47:07 +0000
Message-ID: <67d2711b-200c-0894-4ff7-beb3eb304399@amd.com>
Date:   Thu, 3 Feb 2022 21:47:02 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v6 6/6] drivers/node: Show in sysfs node's crypto
 capabilities
Content-Language: en-US
To:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-7-martin.fernandez@eclypsium.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220203164328.203629-7-martin.fernandez@eclypsium.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:23a::23) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8a41fd5-332b-4eb3-b52d-08d9e79103a8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3481:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3481C65DE2F8D0B40684CD5CE2299@DM6PR12MB3481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07yO1vs9Q0Je7qU9JV/kzlacML+LZ4Th8Qm2FRsBHonGdKfOWvlwdkhgTDrkzLWHdnlQaanlP9Lm4r+mARNHQBW3k9qdw3LYLzldbZOV8wUQLzlwjVG4WSeSJyN//vRbJhAcK4ff2/vqJ5DrTfegU4MUaBqPqfpvaUBJNm+DGXS70tzMV7GIjJdeTeHETpCgIQDNehZYPXxapdTO/tTQxw1pDm8KCcVqn8eL4dP4IuUdDKyt/kYNaLfas8CyZ+iGdkEtYeltqXlD+Yot6PyA5V0eU7+/PtxlvZdZIB6aScxALmukDjZrln8KYUr1JmPuI/BaBVyYtkU7AM+rLFkpKjjgqgW5U5Frz9UcaXTYq6gnIZuDpmialWdhjQIzLTb8XTc2uknLuQ7k8rX8nqRU0OOo5Y1EJubz+2MkFh84Z08JxyYfRFUcLryzGu4qQG5asxAQVZmCCwRWDi3HCWvLyhtgth1FYcvyasOfJv6ZcMBPDi7K7qCDF6871JtT9mFDP8aa8lsLIBjlX3Nr998tdyO1mR1f8GJCRZT8pGYLwgrK1+YG3nTVz/vfdJ6vrni6dXJ4nXJvoQd/T3msjIc9mWvZ3e79kCkCqhwWk1XWom6lJTbGZy4PuNmsydUsHJtsVZ+XlC5lWIlc0PXqeTbuIXrfsjSlFweeV63CHCZVh8rFwwxnjZxTNbQF3OmdTaxIFDkw1AHR6Jx/Xbyz98sXV4Da9W/YW31QmiTmusokR3OCjl0PtAzS4JLT3x0y1il0rFVgbJGTICN4fhGQzuc0Sfx3hib5M6XitZSrYLOKhbXDtwxNxplLsP9WyEN1TaOW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(38100700002)(4326008)(2906002)(8676002)(36756003)(66476007)(31686004)(6506007)(66946007)(6512007)(83380400001)(316002)(86362001)(8936002)(2616005)(31696002)(186003)(6486002)(508600001)(26005)(53546011)(5660300002)(6666004)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2tZK2lDZWJqbzkzQnlhOHNVNFlvTU50M0JTVlY5aEhINGxObkZjaGI2Z1dJ?=
 =?utf-8?B?S3JRZXVObjJmTENwbXg0dG1QU2RSOTFKMGE4TzQ4QUNOay9TRWFQTkxvMDRN?=
 =?utf-8?B?UVRWVjhFVTZGcUoxVURjTVNiM2c2V0R6RWZ5alVzQWZrOXpMQk1aMytpdkw2?=
 =?utf-8?B?OTdpNFhRaU1YTFNKakc2Ym9NSEtwYktJMTVpa3dQcHl2WEZVMVlyekt2dnc4?=
 =?utf-8?B?OXhRVXIxZFI4U21mTTFqNVQ2c2tLK05RTlJSeU16aGhMWm14SkVGVjYrek9i?=
 =?utf-8?B?amtKd0l4NXBlMFphdmVzV1F6UFVIYXMyN1BZL1VYeFF5emNBaEpHSlh4SlVH?=
 =?utf-8?B?ek81aDlwUWkwa0JWKzM5a1NQNkJwZHI3eFZkNW5McXpNVFRoVHFoVGRacEda?=
 =?utf-8?B?cFAway8reWJXcWY2SGNCYWdJQjdLb1c1QnQ1OHFTVFRCcW9TMGpaZmh2WU16?=
 =?utf-8?B?VU83M01qZHE3Wm9KQmo4RHJBeUFreHJlMGZOR2lsS3JMK2tNM0xjaU4zR2ov?=
 =?utf-8?B?TE9WVGNqblkxMmN0WmZlOFZDM0tXNVg0RVRpdHZ3NXVPeExXZUkxVlEwOU5I?=
 =?utf-8?B?NU50cStXSWFJUTA4dGFBM0hHU05kOVhPRkFNK050U0lRL2tLZ3dxYjUyMVBn?=
 =?utf-8?B?YThtRlFrSnUvaUcwbGcwaWd1Nzg3Ulk5N0E2aVRmZ1hlYTBIMkRmb0xHNXdo?=
 =?utf-8?B?TktrMGQrVFZtSjBvNGZVeUNiQ0FZZkZ2N2V4N2ZseHNiSHZDMUZtR0J1RXNK?=
 =?utf-8?B?RlQyQWE1dExtM25qeVBqb2lBdGlacE1BT0traFUveG1NQXZ0SDZhVUE0cVIr?=
 =?utf-8?B?WVdHQjlqUWtId1NRK1ZncEVoUER1USsxbldaeGFidzFYbDlzL0lnWTlzM3Z6?=
 =?utf-8?B?amtJVVNmTFc5YnFRR2JMM2JkNU5aRHNOSFhBWlk2VVFUMmthZ2ZueXdFTTZ5?=
 =?utf-8?B?NUtXUmJ3cUlKdkZrcER2RUpCZWpoV0lIUUZqVUxwZzRubml2eHE2RE1oOUZl?=
 =?utf-8?B?UnB0dFdadkkzZDJyVnZWbWZ6N3d5NXM1aTdnaWMxZk9mTHVqVXptWjAraUNi?=
 =?utf-8?B?S2pMV3B6QnZieEUvSTJKRkNOUXhWd2xXeFBZbVdMUkhJSDNkQlJub3Y2N01q?=
 =?utf-8?B?aVQrcDJyNFJtRHpSOXhUTWlleGxrOFgxRlBuYXBRUytFU20yL2toc3MwRHFW?=
 =?utf-8?B?ZXNUNTc1dXNid1ZCM1VLelpiK0E5Q090WHUzOUxiZ1ZhQnMwbGNpbDVEUk1B?=
 =?utf-8?B?MWZ4Q2t4WVJMYUltclV4VC9pRk9jUnNGUUtDcm0yUWVJNXk1bGFCNnJ0SUh4?=
 =?utf-8?B?L09wdjhOOXZWRXpzaHhyZ1IwNDZZZDdaTE1SWGNlVlFoMUFxT20wemhQSGVW?=
 =?utf-8?B?OW1EQWR2bU5KN2xWMlhnaVd2dXdEcTZIMFJJd1ZCNjZIVVBQNHNJQkFWZG9Q?=
 =?utf-8?B?WnN0aWVVOXJmbmgwQXJoc0pKOEt4Z2FoTy9hcmVFKy8xOSttc1YyczFrTTNs?=
 =?utf-8?B?Sm9OZXQvR1dNVms5dm1zUEVtbjJUMHphNnNWb0d1Y0VDY01tM0Z3NVVxclhW?=
 =?utf-8?B?R0dXeUpOYWNyUm5rQ2FBNkNLVnVwYjU1NEh6cmpRUnVYUXlYVGdaekV6K3pl?=
 =?utf-8?B?TFZsOUV6OGtCYWtaV2pDaDF5dGtWZ3FiNnZCdkkvRTNSOFhvZzBJWHd5MzJz?=
 =?utf-8?B?ZTBCNHNBN3R2bzhycXNrSWNyTVFOOEZrelhER0hwYXd1UkFuclZaK3VSWnBU?=
 =?utf-8?B?SDNRVk9icFoyWkFYK3d6MUxuQVRDL2ViWll1cWdaam9VMFdQcFBrb0xWYVRh?=
 =?utf-8?B?OGI2d2w0Sy9LZHh4cnIvWDNiZFdZRkxhRVpoNVQ1VkJvcmlwb2xwR0JTOEpk?=
 =?utf-8?B?ci8rc1BJUFExVzFmYmhkcldVRVhKNU1LVHk4L2VrOXIwTUROdXZ2d01Yd3V4?=
 =?utf-8?B?TUdGSW9FbjF6Y2FrK05MajJqYTYyckF0azVlcldrYmIxeFY3MlQ4TzRxb1p3?=
 =?utf-8?B?SWtrRnJtNm5vbWl2dXJId2NIOHEwNDBWMUdmU3UwK1pBQXBuSmtlaFNKaWR5?=
 =?utf-8?B?QTV0ZnpGOTNlRlNzMmNGaGE1SmR0bXFubUdyM2k2TDUvTXdmb3RNWkNUQUxw?=
 =?utf-8?B?SHU1bS9KVU02Z3lpVFp1R1RHN09MS3ZHU3RCNTMzanh4VFczcTZhZTRFejF4?=
 =?utf-8?Q?dwMFmNTMkQEOcnvjEkhQuhE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a41fd5-332b-4eb3-b52d-08d9e79103a8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 03:47:07.1672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAE+tjRTMZGPXTFt6+HOdZQ9hH+Txopxk1v3I63t6YVhHYvfMHvxbZ2oI9vuJ2lGUacnbNF+Y2e746NWdhkCew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3481
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/3/2022 10:43, Martin Fernandez wrote:
> Show in each node in sysfs if its memory is able to do be encrypted by
> the CPU, ie. if all its memory is marked with EFI_MEMORY_CPU_CRYPTO in
> the EFI memory map.
> 
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---
>   Documentation/ABI/testing/sysfs-devices-node | 10 ++++++++++
>   drivers/base/node.c                          | 10 ++++++++++
>   2 files changed, 20 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-devices-node
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-node b/Documentation/ABI/testing/sysfs-devices-node
> new file mode 100644
> index 000000000000..0d1fd86c9faf
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-node
> @@ -0,0 +1,10 @@
> +What:		/sys/devices/system/node/nodeX/crypto_capable
> +Date:		February 2022
> +Contact:	Martin Fernandez <martin.fernandez@eclypsium.com>
> +Users:		fwupd (https://fwupd.org)
> +Description:
> +		This value is 1 if all system memory in this node is
> +		marked with EFI_MEMORY_CPU_CRYPTO, indicating that the
> +		system memory is capable of being protected with the
> +		CPU’s memory cryptographic capabilities. It is 0
> +		otherwise.
> \ No newline at end of file
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 87acc47e8951..dabaed997ecd 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -560,11 +560,21 @@ static ssize_t node_read_distance(struct device *dev,
>   }
>   static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
>   
> +static ssize_t crypto_capable_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct pglist_data *pgdat = NODE_DATA(dev->id);
> +
> +	return sysfs_emit(buf, "%d\n", pgdat->crypto_capable);

As there is interest in seeing these capabilities from userspace, it 
seems like a logical time to also expose a `crypto_active` attribute.

Then userspace can make a judgement call if the system supports crypto 
memory (`crypto_capable`) and then also whether or not it's been turned 
on (`crypto_active`).

`crypto_active` could be detected with some existing support in the 
kernel of `mem_encrypt_active()`.  This will then work for a variety of 
architectures too that offer `mem_encrypt_active()`.

As it stands today the only reliable way to tell from userspace (at 
least for AMD's x86 implementation) is by grepping the system log for 
the line "AMD Memory Encryption Features active".

> +}
> +static DEVICE_ATTR_RO(crypto_capable);
> +
>   static struct attribute *node_dev_attrs[] = {
>   	&dev_attr_meminfo.attr,
>   	&dev_attr_numastat.attr,
>   	&dev_attr_distance.attr,
>   	&dev_attr_vmstat.attr,
> +	&dev_attr_crypto_capable.attr,
>   	NULL
>   };
>   

