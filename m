Return-Path: <linux-efi+bounces-3356-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64960A92C00
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 22:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6E38E4F24
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F90A20408A;
	Thu, 17 Apr 2025 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i/47Dq6L"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727782AD0C;
	Thu, 17 Apr 2025 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744920111; cv=fail; b=Stle2VUVJCJztBBDbhMfxYPCKolM8ffJCxuUB19FQi2lWab+LAdfxqgSofeG8Fl49Faha+1qr6t8x0KjVZcE0/3Y0BlYR/C6GyMqOENdkI2bn5gisHD8M9m160kXFvrLiXFiiThf7smGpSmQ4qQ7Uu2Dx2fSfsZJ00e0igsWSyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744920111; c=relaxed/simple;
	bh=FJzD5iyhmSSbMTO6kDrcUM4lYNLx/q0Z8bQIVwW7jWM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tneICtY0X5u5SpRLERZXICsjksc3rm+Udb/2ilVRga0v8sAVxauyVxnDvGVWFlzvFuEu/an97nK+vu7XvtCoDbt/b/DtdY6Y/ztUYbkDObKaEOaCurSU67PgQllp61jbquZ63gxPFU04zvsdwcqqYWCGa2k/EiFLlFUreHEu3gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i/47Dq6L; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7FjNrVRCCsxYlVvTO1dWKVAvDbu1JR8c1z6E5m88HBBisD0E25UHRGLJSEEl9GFFLWHQI3XhRP1F0g0YWyfKcOa7WMSecNppdDec9ePvGWsCldX46DwrybQelztyMM/5N9amMsdNz/ugIY0sVITcMK+fcmmrx4rFZHRldENho6ETkTfW0bpaiKWHFqpobayzAG2iS6F3KQ84bJKi+YxVEJMw3NffhoCh0BEfiQdRgtDmFbFFjCbn5AeqUPiv93PGTNL8M4T6upRVCw4HQHQSU/x0kZw+Q5b7v1C7JttB0AriIYDCHV9uUYcdBhKXZp2DnjN0kZUEYQz0hqew5PD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pCZbypKgJbvbqqY71l0jto4AOCK3BO1rep4R+Ajx0A=;
 b=m0fk0Hi20z6gT1oUehu+kehP1W145Tqrw9NLFjEW7lhwNBCm8LtUJm1zdxEdetWGgGY9uYBlzH8bvaU7grjsjY4ffQD3vYDf9eChdT5+H/fbs4+KmpOwpw1sb1JYkLvtJysPaHyJktrbCGllOX+d57B8YKRZwxQXjY3SGocIN3Cjl0favE/oOkdZ+QIeTNP5cXCiyuj54v4d8RcDUzXphjcu/reJKzHpafDil8Z5VxHexIPbX3dD3VhF4E5N8vGl/HyB7xqKbdmbaou+55pd8ZC3TMJExFm4pc9Hmedn2im3f1mrG2t+83KzUwaxuE38NMgbC+iFY3MLjguhFi/QOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pCZbypKgJbvbqqY71l0jto4AOCK3BO1rep4R+Ajx0A=;
 b=i/47Dq6L7E6hmBmESz20jtXcwiDb/+RXqYJiZll6jM/2JwdyVGI8rnhR4TWw/Bw0AaqYYa5Kfhdsk7rxe+S8T2+QTbJvjHNLPv/83xE5ZFxpxgHynqWuoks/0pLcj7/ccT59uvJKNaM13P1uS5sZIlXxLQHd9P+hbY9YaBPrN5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Thu, 17 Apr
 2025 20:01:43 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 20:01:42 +0000
Message-ID: <c606da9b-f8f3-60ee-9e19-30e75a435c92@amd.com>
Date: Thu, 17 Apr 2025 15:01:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] x86/boot/sev: Avoid shared GHCB page for early memory
 acceptance
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>,
 linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
 linux-kernel@vger.kernel.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>
References: <20250410132850.3708703-2-ardb+git@google.com>
 <20250411184113.GBZ_liSYllx10eT-l1@renoirsky.local>
 <CAMj1kXEqWxokyJf_WUE5Owwz3fO6b-Wq8sSNxFmMVAA+Q47uPQ@mail.gmail.com>
 <3f2b0089-a641-1e0c-3558-0a8dc174d1ec@amd.com>
 <CAMj1kXGvLQwea2J0E72tMhY-9iDCTmQm3drrHCTLyZ=hCP_iAg@mail.gmail.com>
 <96762dec-616b-b906-02b3-e006d43a8535@amd.com>
 <CAMj1kXFVeygkdnhtkGHsKfRgGXoMRpdjQ-wTO1RBLU_wERs_=Q@mail.gmail.com>
 <3196bc53-cb39-5501-b585-de175eed83af@amd.com>
In-Reply-To: <3196bc53-cb39-5501-b585-de175eed83af@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0048.namprd05.prod.outlook.com
 (2603:10b6:803:41::25) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e35cf41-e4a5-4abe-43f1-08dd7deaac52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVk1Um9xVk1tU09NakwvMTlwWXg5aDhhSW5lT0l1VGFLdTZ4ZmJCS1RVNldW?=
 =?utf-8?B?Z0hLSEZ0ZmRzNVgxZ0U4a0xXbjFIc2JIMGViOU5zZG9hVmFZTHhES0g0RFNM?=
 =?utf-8?B?NlEvc2d6dWVpSXRiSlBHUS9JM3VBejhLa1pNc3l3cXFxNituczJHeDhVdVIz?=
 =?utf-8?B?cm9KbVJMTUVTbTFqS0owL0VkSEZpU2VqbnFjYWpWR29ReEkwUFEwdDlNUkNs?=
 =?utf-8?B?NXdsV3ZvTVltb1pnY0dhb2J3SGhXaUVkVXVnZ3plZElUZGtRVWY3dnpNK0FW?=
 =?utf-8?B?SFFBa1dBZTdaVy9VbXR6QU5sQzV3a1JZalF4V2Q3UGNxck53OEo0ZWJxQUEx?=
 =?utf-8?B?YjRkRU1XREVMeW1lcGRHMUtTMHlZSXhnN2c3Q2YxcWd6Qkk4VVNiOHlKWURW?=
 =?utf-8?B?NG1XMGYrdHdPb2NrMDdjNTY5SHBJSTZwR3BLZ2FBbXNGMEQzeVZtdmdWRHJE?=
 =?utf-8?B?OExOQ3FFdmEyWHNId094MHEveVBqdk96ajd5cDR5dE0yRUFCVXo5WjR0bStS?=
 =?utf-8?B?bHVSbnNVSWJoa2pxbTlGVDIxVms5M2dha3hubXdrNkRiRjJqL20zYkY0SDR0?=
 =?utf-8?B?MVlqSFFOblpVYWx5TGh0bHpSVHN4Vk1memIxaUpoRUNaSm5pUks2bEFvU0NF?=
 =?utf-8?B?dllZV3BtMjVOZDdYZmJhOHZDazUvZFdUdGRlL2NXOW5PMTB6c3g1dm52SnBT?=
 =?utf-8?B?Sis5aUo0WHV3ZmhvUUxFc1dOcXlUa2k1WENmbEIwTHIwRDd0UXZUU3MxVXNP?=
 =?utf-8?B?ZXhqc1NzTGFTeXZRTkt6ZlJMd3F5ZVJSK2N4U21mMEJhTlFqbGdMdUVmMFp4?=
 =?utf-8?B?aXgxS1VSUVZhODlKc3RKbkk5UTFQdWpHVzZLL0NyakhiOUpYR2ZEQjU0WTJo?=
 =?utf-8?B?TTZRcTY2by84Z29JR0xleTQyZ1pPNFdxNmdiT1NpRm9rODd4UEtTS0Z1U0Yz?=
 =?utf-8?B?ZWVEQ28yZVZOZmtnWGVYeDZZQU1kSEdpbi8yN2U4YzlJTkQyWi9YbHU2V2RP?=
 =?utf-8?B?djJyT2Q2bVhoNEtQVzJsWkF0NVJaa3hjbkY1SHQ4Mk5LMGxRK0hFQXN0TVJQ?=
 =?utf-8?B?c1FFZmV1TER2ZVNVMFJkb0JHakxwYzFSY1UrazgyMnlnb01XUTJ2MVd2dlJ2?=
 =?utf-8?B?ZXV3VVMvcHQyaGNJbStLWXJEVTRta1ZDMUhjc0pRTVRoRWl5QnE3YVRpdVpK?=
 =?utf-8?B?THJsblBsUkdBNXFGTHZzaUlIaElwT1NXY2t1My92STZoczN4Q3lNV2Z6VUVK?=
 =?utf-8?B?dnY5OThGUVJxYmFDOUg0SGwyTlJzak5kaDFsOFJsa3AvdkFHNW1oY2ZiYTcw?=
 =?utf-8?B?WmFFVTBGZzFuUFJsZmltdldOSUlDc0pqajBHeHJ5dk1oc2labFNteGRnMEkw?=
 =?utf-8?B?QzBYS2Q0MHF2VTg2RndZRmsvN0plS0ZZbGJqSWUvTndXVWlGNThaLzJRQmky?=
 =?utf-8?B?aVZzUDhuakgvUENJMGNPckpSaytuMDRvcU1zc2liS1Y0TWtkL1dXS293OFBm?=
 =?utf-8?B?TktrNVFrOUR3VVFOWDNOcnZZdUNmT21nQTBOTUt2a1FBQnZYTUFIMFhDekR5?=
 =?utf-8?B?emxFcERYT2w1U3B1WXNoa2NMVXZMOCtteWVzRUI4S0lDY0c4WnBUNUlrKzlE?=
 =?utf-8?B?bHRNU21kd21mYWwwUjBFWDhQdVR3MkZXU3grdW51NHM2OVJ5M29zMlVtWkdr?=
 =?utf-8?B?YkNzUHV0SHJCTzhFTTNZb25DNmFGMG5QL3ZiZ2VMQm80OFdiQmVtNkhZOUZx?=
 =?utf-8?B?RUIrZUwxMzFoaVowR0VJRVpoVXFLUWhabytUanRzYm5vbDdQSUVvdytIcVpy?=
 =?utf-8?B?QnBqeGNINVhYNXkyRXhvK2dLZE80bmtMMXpOeERnNlNKTzVDOWlWRkVmOWVr?=
 =?utf-8?B?UWUyeWRYZ2RjVUV3ZElDREc5L0oxWmw3RWpjbTR4a29jRmVOWmdydStKNXRW?=
 =?utf-8?Q?E2GRo7HgR5A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkZwc3RDaVdVTGV5S3BaUURGWjFHZ0hYckNKMENhUkIyQlVaUGNmWHcwZjNu?=
 =?utf-8?B?YVRrR2Raek02WitwSytFTStsbkRFeDNML3RTWlNETXlaQ0FHaG9WZExLY2dB?=
 =?utf-8?B?QUN4eU4rdnV2Z0ZNYk55UnBGek1TempJZlBCaWNDa2xITU9UZktsWjZRWXc3?=
 =?utf-8?B?bVdjK05aVm1NbzhkRGlNanFOTFdBbFM1QUNsYXVxYlFabitYcmdLSU1oeFh2?=
 =?utf-8?B?YU9SeTJ2TkwwWVFHaEJQYkxCZ043b0NLV0pNRmczTFdCelpjbjN2SU00Mm5i?=
 =?utf-8?B?QllPZ3g3alRjckV4QzRNS2dwRy9INUh6UUZueGwyaUliMmN2UGtlQVpDSWY3?=
 =?utf-8?B?L3RPWXovWGhRQ1hyWnh6dnljcjhUR0RHUE0vam5ubm8yc2VzUjRkdUZIQndE?=
 =?utf-8?B?OHpKWVpUd09zZVVGMXZpVDVYTGVWbXFkeExGN3VTVEVCUkJ3Tk5kdDJQSmdz?=
 =?utf-8?B?aGF5S2ZGSXFEVS9Cb3ZZM1Y3c0lzYVhHV0NRWFk0Z0x3RVJwUDhkeTAzb25o?=
 =?utf-8?B?ZCtXNGxCT2JLOVRncjlNcWVTTkowZFAwNFZ6K2dpaEt1SktTY2RDU3ErT2x5?=
 =?utf-8?B?WkdxMnYvL1Q5b0Q2cGUwMFB5bER3VWdDdU1zWUhKRnZqZlNmemVocUhxYWk3?=
 =?utf-8?B?SitVa0o2WmMzeExCaGF0Yjc5eG43dXlBNkd6NlBjYVNScHdlcGhhM2Uwc1FT?=
 =?utf-8?B?UVVUV3FCWEpMcEExMmJoZHVtY1VLM2VqSU0vaXRjZldsbnA5SjJmZ0dsajdn?=
 =?utf-8?B?SThaa3hPTk56dGIyODgzZHFrR3dSaTRMNUNRSmQwTW0rSmd2R1hZVlZKaUlY?=
 =?utf-8?B?NVpLbHNxTmxEM2xxQkJzTmVkZjM1OVhSUHk3cEV1UkF4SzZpRm0xV2FBNndy?=
 =?utf-8?B?dmV4a0RyVnBSVmF4dmVhWjRZQVRzbFYzblV3T3ZseVBYeU1KYWQ1eTQ0REhI?=
 =?utf-8?B?THFtODd0enNIWG1OeUFlMnpPS0lEOGpJMzhtMUdaQTVId1lEYkJmdU4yM0hG?=
 =?utf-8?B?Qks1Y09jRExiclJXc2F5N2Z1bURTMkh5WmkxdzgzU2l6NHZoRUpxUlMyVzNO?=
 =?utf-8?B?WThrMkI5eXV0eEVJcERLNm03SWZTSzJZa25ja0p3TEdsRG9hUTN1cnVERG94?=
 =?utf-8?B?RXhPRzJVbUJaTHdhRGVFTnA1clFNMWp0ZkxGOEwrK0lZVlNyTmEyWnNxK0ln?=
 =?utf-8?B?ZDNzTkJHZ0FYT2dIdStGc0hNMWFVVHJTQVQ0SlVzdnJBeWdIcUlHeEJoajky?=
 =?utf-8?B?c2pNK0didUI2blBBVThWakYvQWpZT1FkL3BLV3Jkc1JBRFZwa0FHeXh0OUhi?=
 =?utf-8?B?MmRqaW1sVVpEeHhQYlo5Mmt3RVV5YXRIYmhnQmZNc1lxakNzQjdzanZSdFBn?=
 =?utf-8?B?d1k4K2gzOGdJcXFvdVl5WE5wV2dseFdic0tVc1NsVUlKVTA5TkJHZVN2d3Vj?=
 =?utf-8?B?MlU2TE92cDIrT1kxOTJQckF2MExwaE90ZnNORFgvYmRYcFBTOHZnMGxSU1lZ?=
 =?utf-8?B?NkQxUWdrYjhyQTlZdFM0NmpNMmxDSEs2OGtHUDVNZXFYWm5hdkZKWG1qSHVN?=
 =?utf-8?B?MWdhN1FxT05PNlpkNjZya2NmSnlmdEVGWTF1Ulh0b1RGWUFRUFFGOWxYdERZ?=
 =?utf-8?B?d2ZNbXJlVnRobldiZWNYMktGUUVRelFXdUwzb0oxajUxYldzM0R2OVk0Slda?=
 =?utf-8?B?Njh2Vzc5eWs1VFNCa2lNZUdJVnBVaHQ3MlVYdHFiN3pEYmp4WVVzalI0QnhY?=
 =?utf-8?B?UmRyZEExV1pkUDdUWmlFZkI3QThQTHM4TmQ3ZXY2WWMwUyt4ZWlHbXBMZEcr?=
 =?utf-8?B?T3ZLclZDWmlUODhsK0xhZ1Q2OCtqTHFsaUNzNmo1MjJKb0RHN2RBQTBxcG12?=
 =?utf-8?B?cHRDZ0RVbFJyOEE5Y1dxRlB1RVJqRUttNng4cEluOFdFRWxXVVp1MWNURENK?=
 =?utf-8?B?VDhJYnBITnZXN2JRVlNqcWZPQ25MMnMvazNVRy9Vd205d3FVV3R2dldkb3lk?=
 =?utf-8?B?V0J4UDl0TDN4YXMrWXlucWpsRk5VTlNRVWlnMTA4bEIxUGF1VXBUYlFRMUhM?=
 =?utf-8?B?ajkxaWp2cGZlSEIvNDZqM1A5NS8vbktjQk4zcko4Qmx6VUZTUC9rd0E1RjRz?=
 =?utf-8?Q?lc98l8Pz0Ef/nTfbUAPoFVZHQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e35cf41-e4a5-4abe-43f1-08dd7deaac52
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 20:01:42.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kp84vxLCO/VH9RykAjME+n4uR8rIxojWJvI0MSy0pDcEaogQSTHv/B7eYyIEtoyJ2vSstLd9IKzsGlUElQC4hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708

On 4/17/25 12:26, Tom Lendacky wrote:
> On 4/17/25 11:38, Ard Biesheuvel wrote:
>> On Thu, 17 Apr 2025 at 18:21, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>
>>> On 4/17/25 11:14, Ard Biesheuvel wrote:
>>>> On Thu, 17 Apr 2025 at 18:08, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>>
>>>>> On 4/11/25 14:00, Ard Biesheuvel wrote:
>>>>>> On Fri, 11 Apr 2025 at 20:40, Borislav Petkov <bp@alien8.de> wrote:
>>>>>>>
>>>>>>> On Thu, Apr 10, 2025 at 03:28:51PM +0200, Ard Biesheuvel wrote:
>>>>>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>>>>>
>>>>>>>> Communicating with the hypervisor using the shared GHCB page requires
>>>>>>>> clearing the C bit in the mapping of that page. When executing in the
>>>>>>>> context of the EFI boot services, the page tables are owned by the
>>>>>>>> firmware, and this manipulation is not possible.
>>>>>>>>
>>>>>>>> So switch to a different API for accepting memory in SEV-SNP guests, one
>>>>>>>
>>>>>>> That being the GHCB MSR protocol, it seems.
>>>>>>>
>>>>>>
>>>>>> Yes.
>>>>>>
>>>>>>> And since Tom co-developed, I guess we wanna do that.
>>>>>>>
>>>>>>> But then how much slower do we become?
>>>>>>>
>>>>>>
>>>>>> Non-EFI stub boot will become slower if the memory that is used to
>>>>>> decompress the kernel has not been accepted yet. But given how heavily
>>>>>> SEV-SNP depends on EFI boot, this typically only happens on kexec, as
>>>>>> that is the only boot path that goes through the traditional
>>>>>> decompressor.
>>>>>
>>>>> Some quick testing showed no significant differences in kexec booting
>>>>> and testing shows everything seems to be good.
>>>>>
>>>>
>>>> Thanks.
>>>>
>>>>> But, in testing with non-2M sized memory (e.g. a guest with 4097M of
>>>>> memory) and without the change to how SNP is detected before
>>>>> sev_enable() is called, we hit the error path in arch_accept_memory() in
>>>>> arch/x86/boot/compressed/mem.c and the boot crashes.
>>>>>
>>>>
>>>> Right. So this is because sev_snp_enabled() is based on sev_status,
>>>> which has not been set yet at this point, right?
>>>
>>> Correct.
>>>
>>
>> OK. Would this do the trick? (with asm/sev.h added to the #includes)
> 
> Yes, that works for booting. Let me do some kexec testing and get back
> to you. Sorry, that might not be until tomorrow, though.

Ok, found some time... looks good with kexec, too.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
>> --- a/arch/x86/boot/compressed/mem.c
>> +++ b/arch/x86/boot/compressed/mem.c
>> @@ -34,11 +34,14 @@ static bool early_is_tdx_guest(void)
>>
>>  void arch_accept_memory(phys_addr_t start, phys_addr_t end)
>>  {
>> +       static bool sevsnp;
>> +
>>         /* Platform-specific memory-acceptance call goes here */
>>         if (early_is_tdx_guest()) {
>>                 if (!tdx_accept_memory(start, end))
>>                         panic("TDX: Failed to accept memory\n");
>> -       } else if (sev_snp_enabled()) {
>> +       } else if (sevsnp || (sev_get_status() & MSR_AMD64_SEV_SNP_ENABLED)) {
>> +               sevsnp = true;
>>                 snp_accept_memory(start, end);
>>         } else {
>>                 error("Cannot accept memory: unknown platform\n");
>>
>>>>
>>>> And for the record, could you please indicate whether you are ok with
>>>> the co-developed-by/signed-off-by credits on this patch (and
>>>> subsequent revisions)?
>>>
>>> Yep, I'm fine with that.
>>>
>>
>> Thanks.

