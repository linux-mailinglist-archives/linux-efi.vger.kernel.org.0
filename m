Return-Path: <linux-efi+bounces-2312-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C449E75E7
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 17:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FC816BDD5
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 16:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DFE201001;
	Fri,  6 Dec 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ckPlQOFZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8414D708;
	Fri,  6 Dec 2024 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502553; cv=fail; b=KvEmSogZbvem1WD0xWJgdaDdZLA9YUHI4tbOCbgTjJn7DCBOE+XTwdOvP6seqU2l1pmLf7LUcHbpAwMUAiQleIxz2qvdsVNbrINyIFXD2XkZhuVC+vBeptTD/GohMIIda4H3aIsdAyfaDJn/L+rJFmq9DqEevqFkxxaoX3f0iDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502553; c=relaxed/simple;
	bh=3UW8KpND7SZFuvIAk5G8HcdcdygLmulLdHBYiuBEPMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hF1AQUKwwdkzGfux63liRVm67ATXG0jUEEpuES3qphInBIm4p071W9M8RhcZmCGi796Myocyspy00Vdh17qZI56PW+u7oRzlZlcMFbIf4y41gGwdG3HfmsIFbp8VEhbh/XU0Dp+HEXIL8G6z5Z28Sy25DvzpE6F5yIhMsDzPa3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ckPlQOFZ; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWH6O/meEuXb7ObMzhz0RPt4+/vA4jBPsp3UO4uLB4HLeK3OG7Ec3Xo/XEH8fx2g8aP6SZtxWn2niZYGoFw6K9TbucghrKPOEHKp53QyaJqCiwBjVtDFdI4lJr73PRjiuVcRiD3b8MPC5SR4y8o/C3I4gT9dHe9aGZKfYaVWjT3Js0YlT2FYZrRUHAfF2VJEN30ZyQQFFIF1rsD8DlmbzYzn1a20fS7UPUR4DR7K2PAj16w3AHfBy8jRZ2yJoT5q4h9/s7/i+cNMqmLpUTdKKsUeyOHMudj0s0ily3yMV1FTFvLg3UHlKWmh40QPVO7yDgv2SDmUAGqhdq3c20u46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oTJ2cjgcn2mX7LC5xkx9QhCjAQnYC/7yUK9LnUFvQg=;
 b=D4P7kV/sH5HQZ4ZSIsbgEg9OS90u1N460+Utk7Wv07ObSuSJaxmRI+tBrftYBWhhDbdiXc0odFn19IcoLarmji4gA2KJdoWi5sqUDbNs51Ij5RQUKRL46XZypfigWRw5AtQpt8Fu+DopqZDhKO4FQgs76hBbOOc1XXiAP5yjzE2RNsXkf/NYzvPJ+4CiEYjV0wBHo8igTtvsBr1OK1X2LfBbHjlei7U1e8O+AyhoRDCaf4pOXc3KVIB7yd50Ee06dfK4iIgU2l0S6uLSwtnlyUWrG0VOG0bdNPrchZ6i7l/F8yev1LFtZhQeE9DMQfZ81ro4tv5n9LGxXAXO6jng9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oTJ2cjgcn2mX7LC5xkx9QhCjAQnYC/7yUK9LnUFvQg=;
 b=ckPlQOFZ8nRYueKbF0VyDWZ4ttUSkdJNaQQXQMZerfdWOSwZJlC3uIkIeFE6E19jbERKa2cz7r4L32m8OekLc2/xg5G1L+EIeprynOV5kInICrm3XMV9nV2IZAwVT4w8enGujl6MMEErGNyzBfMR+Dppx/hL9KkiSRJDsOvK794=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 16:29:08 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 16:29:08 +0000
Message-ID: <e27d3940-c6da-42c5-b6b3-60ee9680331b@amd.com>
Date: Fri, 6 Dec 2024 08:29:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
To: Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241119003915.174386-8-Smita.KoralahalliChannabasappa@amd.com>
 <20241126160527.00005c2d@huawei.com>
 <ac098bd3-f7dd-ca57-8010-13e843d9f1d0@amd.com>
 <674e01034ca7a_3cb8e0294b0@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <674e01034ca7a_3cb8e0294b0@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: e38d73de-c21d-4110-6965-08dd16131b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2cxaWF1QnBtdm50dC9uY3VFamR2Z1dKdUhDMU8vdzVoSmp4dGRDeDdaQStU?=
 =?utf-8?B?TDBaNGZjSmRPMXlJR0tLTXRjYlFIYldiVk1WKzAvcVFld21YZy8rcW1aM0VN?=
 =?utf-8?B?M29kZUprWlZSV1U5TUN1andnRFVJWnFoMmVHVVBna2RlZGlHdzlObXhOYlg1?=
 =?utf-8?B?RzIraVdzTGdzMUhDNVNNd0xXQ2hady9Sb3lPRlljcURLR2g5TnBJLzdoVWNF?=
 =?utf-8?B?cks1c3RURkNXMGFtZjN6K0JSZWZ4Vyt3dWlnUGpQSDhpYjNYempHK3JpY2w0?=
 =?utf-8?B?UkJvaWtld0hYT2lBYnNEelhNaDN4Q0FLK2plVDBjeS9BTDV2YTNlSC9QQzBu?=
 =?utf-8?B?ZVA5cVIyTVJBM3BVOFJnc1EzUE0zYlA1bENiNnlnTlY5T1lDb09pVUFiM3hY?=
 =?utf-8?B?dnQvZ21lbUpINCtZL3pFclh6L2loRVRhSDJKSk1HMzBqWVZURDI0SURoUFhy?=
 =?utf-8?B?YUxRc0c4VFRKa1IrZ3hqOFdBYjFVTVVwaVI1M2RmOUJFeFI0cEFSblZ6NGly?=
 =?utf-8?B?SU5IOXhmend3Z1JPdVB1Y1B4c0VmeUY4c2lIVktlVU4rTkZDWThIQUJRSm9T?=
 =?utf-8?B?d2hjVWplUm8zZjdIdjVkOFNzUUFaWE1zNlQwV2NYUER1dm9WVkY0am5EN3Bv?=
 =?utf-8?B?UkFLZGpUblpZRmdwM3lTc2ZjTXc0RlhKV0Q0dm9YMlU1YU1qdUhySncvQVQr?=
 =?utf-8?B?S3BudjhNM1dRWFh3ZXBOSkRMRzFjUyt5ZlZPY0dBNEU2UWx6RktCNXVqR3dH?=
 =?utf-8?B?SUtidW9EdEZydzM4QUY1WUk1elV0ODIrVU9nbjNaL3NkM3JYQWpENElJZ3RC?=
 =?utf-8?B?UFgzczBmdnliNmpnaEZ2cmNDTEZJbzh5ekFCak1KNFVDVnc0ODI1enFXaE9p?=
 =?utf-8?B?ZW9jemJLZEtrUWRvREtaRXdoY0xBQVNITW4xWU9kZjlSR2FnLzdZZXluRVlU?=
 =?utf-8?B?SmVWemtDb1ltUVFMR2RtSmJUSXByYmZhbThJK3N2dzI3S09CU2k1cGd3d0w0?=
 =?utf-8?B?bENCQmJoaWx2bGwyOVBYemRLcW9kbFhLNXJTYzFnSlkxYjFtbW9PQWc4WVpG?=
 =?utf-8?B?NkhzMkhBMVZlMWFSVHIrUFFET0FYZGlaa2N2WnlMbks3Uk5aYStEY2pBTFhM?=
 =?utf-8?B?eEsvcVVXQmZBSlJuY2JXa1ZrOGhtSFBTRzFMTDlmOTZrNFE0K0hiZmNscmI4?=
 =?utf-8?B?OGI4azdNdHg4bGJDMmpyYi80VGdFWVE3VlJUNEh0dytLZERrQ2MxOEVtOEZm?=
 =?utf-8?B?REpicTROSnlIT2hSVUdnZFByVTJFMm8vQWNBRHZJZWhnUzBIMGFCdjltOVlv?=
 =?utf-8?B?dUFvVkp1c3BEc00yWWQwQTdDQis3QkZGaFRNaXFUcHRZNzhCTVVJTEdEN1R1?=
 =?utf-8?B?dSswYTgva0VjSFlRaHRWaXE2aTJONG8rLzFqQkR2VXF2Z2kwRVpidnlaQXcz?=
 =?utf-8?B?ZU5mWTBlVHJVblZhRGdTeFRGYWUrS0FUR0FUSmlhWU12WmtDY0FTSmF1RGxq?=
 =?utf-8?B?Ykt5ckQvUEVibmlkV1lzWmhsU3d1NHQzcnlEM1JEQXlFNUZpbStRTks0RE1E?=
 =?utf-8?B?NGtVN3JadnBQSlFwdVhtdm0rQS84bXpxVmxuWVBtRnlmNkNVL1R1a1RhL3k0?=
 =?utf-8?B?QTcwZjgvT213ZWhyRHdoYkFKRW5yaGlLa0M2UXdwVVhnRHRwNUE3MTNObDNs?=
 =?utf-8?B?aEpvd1ZabXhPMjVCOGVsTWcvZ09qeEVjVnF5dGk4SjEyVVNBc2hCaGpLeTNt?=
 =?utf-8?B?L0RtSnVtNmNsWk5pMmNja0t0eTlRcEY1SDJoY0xEMTZwRVBNMHg5aEdyT3VE?=
 =?utf-8?B?bHp0QmRMQzBpdEZWTTF3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzFJTjVZOW8yb3RXbTlRdXQ5bWdWMjJad2FNWTJ5Y21YV01CdEpVU2F5NFpL?=
 =?utf-8?B?clNqbVc4dWJzYThJV3JCM2hoWGxlUjBRUndSeXo4K0hNckgvUXdPMXFjdDdk?=
 =?utf-8?B?OTFTRHFqWjhnUnVUb3oxMnVGcVV1dURPY1M5a3dLT2hKbWxrMFpiR3ZtNHl2?=
 =?utf-8?B?TWtLbnlNcHhrT0FselZLR2NVMkdma2RvdmV6QkExc0NlNDNlS1dmMCtyRG1v?=
 =?utf-8?B?aFhESERRbVAwM0REa3MxWU04cUtKQk1QUElQR2RxQXNXd2d6bG5FZWpCQWlF?=
 =?utf-8?B?ZnhMOExkL0JIUXJtL2RhOWU2NmROaUQ5SklRc09DaURaZTZ2eE1PTlNjYXJw?=
 =?utf-8?B?OHdGbnlVOGNyZnFYeEdKcE5aRUJoR05VTmtRWkE3YnFRTzZsV3hNR1owNkZk?=
 =?utf-8?B?YWtUNnNldTJQU1d4cG9pS0syeW85TmxudkdMTDR6cjdxSTFzb1pjLzNUaGlY?=
 =?utf-8?B?dXRZSnFMTExjOGZNb05HOXB4Y0gzUjkxSGkwRnY5SHZCOEpTRlM3RVEyL3Rz?=
 =?utf-8?B?MmNPS1dreStlaXBnRU8yTU9vQ3RIU2JoM3pPSHBEYjFKUjIwMUh4SHNXVjdY?=
 =?utf-8?B?UGpIVDQ5MTJVeDVxS2YrRmlMbFMxOVYvSFRXT2MzRnVuSUQwOXNETGV3NDQ3?=
 =?utf-8?B?bFVURmNDeFJwT3I1T1c3aHJ0aWJPZGdIYWN2eFoyM09leCtyY2Mwd09qRnpU?=
 =?utf-8?B?WHRvQml4bGZCQUlnWFZBYXAwb0FubTFTTnYvcW9JRGc0MzQ1NUdJMXJySDI1?=
 =?utf-8?B?RWpLWmk1Q0pXWkltZllIcmdReXRBYWorajNlZ2hoeHdNc24vK2VzcXdId3JL?=
 =?utf-8?B?TWQ5QTNHZkZPa0MxWitjS1dHeGgzMGZsTlZoaWsvNW93Vnh2bFNCeitQL1g2?=
 =?utf-8?B?OVE3TDlUMEF4TmxteVZ4OWt6cC9LMTcwa2pIWGhleldVNGJ2bmdJMFhHamNk?=
 =?utf-8?B?ZklRbE1qMU1RYlNBcGpXRksxOXV6V0V5ZThwS1dwNDN0c0dNZXh6UVZwU1RF?=
 =?utf-8?B?WkRENGlRSXh1RFYyNXdJMjlkVjNlOFpJU2VnSEM2SVZwMzYxWWxrSW10MENH?=
 =?utf-8?B?WGFKanVSbFZMdFVsbVhvU2wzT2JHTXFva04zUnVjTEduUWVQTThMdm1sWWJQ?=
 =?utf-8?B?SlBjUDJNS3k0dHA2TEJYUXphNmg1WlBOUlBvOWVvcForUWtBOHFiQ1RWNm9G?=
 =?utf-8?B?Rzd2ZlowOEttNkdsM2ZjaW1Cb3ZXMHpUNlRrdG1uMUltNzUxbisxbk1DejIx?=
 =?utf-8?B?N2ZReFg0c3V0bjRqcTZCLzhWdnJ5SUxTUGlNbmVudFpxOS9GekJhOGh2Mkpl?=
 =?utf-8?B?dTIxNVNHcXQ5RVVPcHdJaXN4OHlOUlVRWTRxc2VlekFtSmZLNEd0alBrQ0hq?=
 =?utf-8?B?QjZ5TFJITWQ1d2xNenhOV1I2TllBNVFpZ1ZFZmhRUVNJemNSQjVRaENxUjV1?=
 =?utf-8?B?L010MlJMQzV2VXRMOUZWOElwWG1XNlZtSEZoc21uZnR0a2F2MXRkRERIZ0hi?=
 =?utf-8?B?WWZsbDMwYzc3SEdpTndMZVMvV2JtK1VVTk1Nd3NYeUlQYi9YamFZbWV2MTUx?=
 =?utf-8?B?ZHBLNjJNWFNRUExsWEV5NTh3K0VaTGhPMDNObW02bnRmQk1IYXBjMU8wNVJ3?=
 =?utf-8?B?V1pwYlFqNWZYSkFsQThJQ090M2VXQXhZbTNadFJ0UmlkL2lOVytMRG1xZFNi?=
 =?utf-8?B?eGFTaXZacEU2ZC9pVDFQTHlkaXRUQ2xtbGh0QTlSaUxmWFZuT0tDeThLNjVo?=
 =?utf-8?B?Ky9mMzVNaklhS3VrVGNOTlpJaVlrM1lxR1hMcHlVYTYyNThQRDY4aXg0UHJD?=
 =?utf-8?B?QTdCUitjaklRWU1KSWRFOWsvN25IMTRKYTJwNmJwVThyb3JoMDZTaFA3MnRB?=
 =?utf-8?B?Z0tZMllCWDVhZ09SV2J0eUpZbFRDdkZTaHpuZ3NzcUVmMVNaOEV4cnl4UzFZ?=
 =?utf-8?B?cVRkTVRiVFJMQ1pNdWtieHZJbUh3ZUltaXRVM3g3TW9nVVh3b21Zd1VCVENr?=
 =?utf-8?B?eXFSQW1JR0Q3VjVTZXgycGV1Tm1KdWgyV3lTTXVybFN3SGNiQXVPUjJsOXR3?=
 =?utf-8?B?RWZNbDZ0a0RMTktuZVZiL3JDWU1tc1VUR3JKWXNlVk9XenJ6ZmxZYkFTVW5U?=
 =?utf-8?Q?VE4mzjUDfaG7UBmY8aM1duOHE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38d73de-c21d-4110-6965-08dd16131b7b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:29:07.9968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzW6zdX4CNiTuQHCoIU/2Fc3qtHKd4+WhbEZOpionhUmHl3XJ1YJFxkoA4UZR/+vPoiD8JF4hRanTPN9Jdc1Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475


On 12/2/2024 10:48 AM, Ira Weiny wrote:
> Smita Koralahalli wrote:
>> On 11/26/2024 8:05 AM, Jonathan Cameron wrote:
>>> On Tue, 19 Nov 2024 00:39:15 +0000
>>> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
>>>
>>>> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
>>>> CPER records. Introduce support for handling and logging CXL Protocol
>>>> errors.
>>>>
>>>> The defined trace events cxl_aer_uncorrectable_error and
>>>> cxl_aer_correctable_error trace native CXL AER endpoint errors, while
>>>> cxl_cper_trace_corr_prot_err and cxl_cper_trace_uncorr_prot_err
>>>> trace native CXL AER port errors. Reuse both sets to trace FW-First
>>>> protocol errors.
>>>>
>>>> Since the CXL code is required to be called from process context and
>>>> GHES is in interrupt context, use workqueues for processing.
>>>>
>>>> Similar to CXL CPER event handling, use kfifo to handle errors as it
>>>> simplifies queue processing by providing lock free fifo operations.
>>>>
>>>> Add the ability for the CXL sub-system to register a workqueue to
>>>> process CXL CPER protocol errors.
>>>>
>>>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>>>
>>> A few minor comments inline.
>>>
>>> Thanks
>>>
>>> Jonathan
>>>
>>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>>> index 4ede038a7148..c992b34c290b 100644
>>>> --- a/drivers/cxl/core/pci.c
>>>> +++ b/drivers/cxl/core/pci.c
>>>> @@ -650,6 +650,56 @@ void read_cdat_data(struct cxl_port *port)
>>>>    }
>>>>    EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>>>>    
>>>> +void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev, bool flag,
>>>> +				  struct cxl_ras_capability_regs ras_cap)
>>>> +{
>>>> +	struct cxl_dev_state *cxlds;
>>>> +	u32 status;
>>>> +
>>>> +	status = ras_cap.cor_status & ~ras_cap.cor_mask;
>>>> +
>>>> +	if (!flag) {
>>>
>>> As below. Name of flag is not very helpful when reading the code.
>>> Perhaps we can rename?
>>
>> Okay. May be flag -> is_device_error ?
> 
> I had the same question about 'flag'.
> 
>>>
>>>> +		trace_cxl_port_aer_correctable_error(&pdev->dev, status);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	cxlds = pci_get_drvdata(pdev);
>>>> +	if (!cxlds)
>>>> +		return;
>>>> +
>>>> +	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_corr_prot_err, CXL);
>>>> +
>>>> +void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev, bool flag,
>>>> +				    struct cxl_ras_capability_regs ras_cap)
>>>> +{
>>>> +	struct cxl_dev_state *cxlds;
>>>> +	u32 status, fe;
>>>> +
>>>> +	status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
>>>> +
>>>> +	if (hweight32(status) > 1)
>>>> +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>>>> +				   ras_cap.cap_control));
>>>> +	else
>>>> +		fe = status;
>>>> +
>>>> +	if (!flag) {
>>>
>>> Why does  a bool named flag indicate it's a port error?
>>
>> I will rename it.
>>
>> Or may be use an enum to explicitly define the error type
>> (CXL_ERROR_TYPE_DEVICE and CXL_ERROR_TYPE_PORT).
>>
>> Or may be split the function into two distinct ones, one for port errors
>> and one for device errors.
> 
> I would vote for 2 functions.
> Ira

Noted. Thanks!

Thanks
Smita

