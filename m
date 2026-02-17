Return-Path: <linux-efi+bounces-6171-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGerMnZ1lGlmEAIAu9opvQ
	(envelope-from <linux-efi+bounces-6171-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 15:04:38 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0ED14CF4F
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 15:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF08C30EF2EF
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E9D36B055;
	Tue, 17 Feb 2026 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LpXYWGpj"
X-Original-To: linux-efi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A043D33375D;
	Tue, 17 Feb 2026 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336589; cv=fail; b=SnheVXnlv8qqthz78UrU4NXi7nerM+rDc+mx2vzbZB//XMKP2rplN/KjaUO/KtwZQpmzHCsDqQevOFC4USRJjTvnAUltoQCOn64ngVq5aBqI+IkYJ6Whzfh3dxhK90EZxKXw3370zTAAhUtIMUjdbAb5uiI0n28waNr/LYyua0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336589; c=relaxed/simple;
	bh=aAlX94mi+w/XiORzRTUehkjGl6CKhAheIHp7QRo5d9c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kruPgkeSJIfn4f2bI6FFzjiI1p6+NTNnFFwF5G4NSVSWk62EpuQ79awJgBY9X7MeC0dl8JG0kMI1MQrmCNIEGHEkK1s78YO4d4T87GRVketggcV229VF669VMXdKbphd2hlBoLl/AVyN87KvlHbY0/U37MKMufOdYtp5nPQ1wzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LpXYWGpj; arc=fail smtp.client-ip=52.101.43.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJHqfMShU2324wTRwvEwj8x4sSzSNaKx7R/mZ1PCFNTOwokeUAxwTt2DsYo+rsrarGyAmzGhoFnV8jFjY/NdJZLDq+UJFZC4XWXD2OlBR4XLx4O+WYz7TkEIUxEzSTxEZ4v71Lnkwuij1SLERsM77+HEB7n9X4sD/VB69trbj2AIIQmN/xpDrrZKbnwIx9sJEeu1JxVZgt1PNFYSsTIS4pYXQr0QP/PTC8Cbwo0hTnlXrm7WoIaqM6YXKGoATHgI8HcLiIDXAJBrAjO5HGFP+1FBtpvbpvsyG3sp3LDHdgkC60leG6GOzceWwjAWS0G6+M2lAWPWJ+3aieishOPcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imn0SAM5Yc9kYf64kbvrZB8UuSQadRH0OmoS3KyPatw=;
 b=JSiJYHs6xEtyMqIG5n/8S8vqKCdkGSwAzcg1BDCckHH/h9ifvHZiIiEW3tpZI08Pz3WysEMiDFz68IdDOo/dAW4qQa0/DxyJMQ9fRihRu57ZLclqEptl7tQy3tUa2tSnSYu+YLGX135s3mqhaum+hGgjndEJc5tpvP6f6X7MS169834PSOdR5F7rsGYpXZtgC/6lreGbEdoZP6xcU55iAuhb5hjn6kThqxLmq3SW/OU/YDG4KjpdZ2zgDXDHIzoLKsbR63juOTGZySsHtbJ5kqJbT1qGNHdsB6koiVuljlMDxQATbW1Q9Uy908MylChiWtV2XJOZIhyW0ySiM3cq4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imn0SAM5Yc9kYf64kbvrZB8UuSQadRH0OmoS3KyPatw=;
 b=LpXYWGpjn5fAxKbZTYQlP40G9DAs/+ABHuprynAe2Cs5WjmzhCk1gwi2xUPRf+Vmeru11LoAqndYcGw5uIjE2wP6CU4WqaveEXswsD3MM00yCN9eEc+akIIKnv3ci1IZSQbobTXc7Pqi7YX1PMt9iWCafJKVCOcjKk/ThGB0CZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 13:56:23 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%4]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 13:56:23 +0000
Message-ID: <a45b19ed-149d-434a-ac80-4ea74a2e0f10@amd.com>
Date: Tue, 17 Feb 2026 07:56:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/2] efi: Fix alignenment issues in unaccepted memory
 code
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, linux-efi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Moritz Sanft <ms@edgeless.systems>,
 Mike Rapoport <rppt@kernel.org>
References: <20260217104957.249340-1-kas@kernel.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Content-Language: en-US
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <20260217104957.249340-1-kas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::16) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 4307619a-fb8a-44fa-9722-08de6e2c55ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmpJN1pwMk0xUTh3TDZ4TjBDcjFHN2tUTXNwN0xZaTI4eUpqSUxTaG1aQUxj?=
 =?utf-8?B?Snp1Ny9PNndTYmUzdFlxUXUzUlk4RzRGWWd5Y0RzWk5udnNRbG05KzYrR09z?=
 =?utf-8?B?eVZyZGhZQ2dCNDhmRDJrKzZ1QTkwQ1kxTGpCUGZtajNCMjBvMmhSai9YeGtC?=
 =?utf-8?B?a3pWTzg0WXBpeG9LZnduaHBGcGIrdkZ4aGdzTUpmL2ZhQVQrUllscHVZVlcw?=
 =?utf-8?B?L1NYSjdsTGNad01zUks4MG1id0lEV21NUHYwTSthcFJRSE9FVTVFRzJMZGlx?=
 =?utf-8?B?M2loalBYQVlVODhkdmdZZGRZd1hDZG8vOWgwbWRwWkhyVTNqL3ZJOFJoaXUx?=
 =?utf-8?B?Uk5rNHR4clJBMEkrZVc0czJZZXZvT3U4cnFmbDlZYnJHOXN4dzB5S2FRRHNa?=
 =?utf-8?B?WCtORFl1UXZOV3NzVWlCOFhsUE1WdFQ3em42YzRVQVNxOS9BQU1NKzZhRWd6?=
 =?utf-8?B?ZTRMbVdBSzJVNi8wTlNCdmswR2d6ckVnZUFZRnFuQ1FIeTM5YzNKNUVlcnZJ?=
 =?utf-8?B?cnMycTdoUlI4T0l1Si81aGRTNk1vWnNxeXBFb3pvMnVORE1zcWM4Mk4rZ1Zm?=
 =?utf-8?B?azNRcWlvbEJtcjhHbHY2Uzg4eHRXWTZ0WEFkRmpFcVIzNUJNL2w2UEduR2Vj?=
 =?utf-8?B?NGZSUG00b0hFSmZQeHlTZVRtNkI5WXJJZ0ZqaC9UVFdVUFNrQno3SE9GRzFq?=
 =?utf-8?B?RXYyKzNWK0VTMGRiKzREbDZEZzFWUXhVdytPQTRsM25vS2p6U3REQmw3OWFY?=
 =?utf-8?B?WWpqaHYxaGdzMTlaNW5reUd5WGhVTDB1U2xHSW41c0VtTzAzZi8zZk1wVGxq?=
 =?utf-8?B?WUlaSlZaWStHODFmZlNkeGRPRXh4ZllldTJZWk5WTkFXbHhSOVJNdkJoOUdQ?=
 =?utf-8?B?MDRkYmNURzEyWTlhTlRRb1pGeFRsTXJpY25qLzFTeXRoSExyNWxaKzRMQ0Vl?=
 =?utf-8?B?SkFkbHI5c1c3UG5ZK1RGeStHWE5xSW43VXBEdzV6Z05ZTFlvMVJVNi9mT0Yv?=
 =?utf-8?B?VTFFcjNUeXVDNHV0elZMTXo0dG45N0V0R01Rb0F3WVFKWVF1b0FlU0VPUEVF?=
 =?utf-8?B?NjZFYVlBRVF2NG9YZEpYVEtUMkZBNzQwZU1kUERKbTRJQVIvSWU2SUZET2Q2?=
 =?utf-8?B?WXFub1FCSDg4blkvcTRVL2laVnFNOEVJMWd4N0EvaFZzZktobGdRMWt6UDZ3?=
 =?utf-8?B?N3hCU2R5VmJBMnZsZGo0VWhTSGNTeG5JL29tQnYwOUNTaXZTQ3ZVMmtCa0JE?=
 =?utf-8?B?VjZ1bHlGVGFiUFJhN20wQkg0WGhrN3JURDhjazFERldOSjRJcFRXVlhYb2JH?=
 =?utf-8?B?Uncrd0o1VWhmUWp6MU9JVjY2VElyTk0xWXcxQmVDZnVMVUVUbDZCbHRvVkVU?=
 =?utf-8?B?a2luZDQ1blRwSGQzTGl1VEVzaGhTTWY4cnJiZEIvZXBucjV4YkkxM3EyY0cr?=
 =?utf-8?B?aVI0UkplV0pFQ1ljVGV1eXRqWC95bW9aV05BbFlsMVJ0SXBwcUdnYjZkbzRK?=
 =?utf-8?B?SGRqRzdCNm14VFlCdUs0bVp5dU5jcFN1UExxOXg0Z3ArWHZ3Z0diaEJubG9Y?=
 =?utf-8?B?dW54eTBkbHNrNm50b0wxRDQ4VDM1REErQkdTZEF2NzRKS1J3c3p4c2ptajF5?=
 =?utf-8?B?NnoxZnFvRFB3UllVMnpzNVloQlZ1dThkVGtDWkJwVUJnazBhc3RaYWg2dEgz?=
 =?utf-8?B?Szc5RlgvUGpPS0tnTFhyaHBEU21DV0VsTlBSQzNWU3AvNXFhNlhyOEVWWTlQ?=
 =?utf-8?B?UjVWQkZ5Qmp4V1Jsdy9HcG9rTExlNkU0L242RDViQ05wcDBJTnV0d3hxK3lk?=
 =?utf-8?B?dCs3c0g2NUErbHVrejFqQzJtS0JibEQ5SGNNeHlvVEhYVWhoM25YZ1VGQ3M3?=
 =?utf-8?B?ZVYvRzRCOVlHUTZkcUxCWnFFeGJLM3BNblVmSDVHVndHZEQwRDR5TWcwWlkr?=
 =?utf-8?B?bnZlRmF0QWVJbHUzbFlLUVFsa25xMWRBbG9VSVlHUHh6b0NQeXkyK3hyQTEz?=
 =?utf-8?B?UTNOaW5OZjRCTVJTU1ovSkZyaEJvaE9XbFZCQTg5TGlrNmdKVVJGUC8wZ3Ja?=
 =?utf-8?B?cFhEOUk2WUNGU0VVK3lCVEF6SGl2aWVVRE5sd3Z0U0QwSlRXOUw4SVZvbUFT?=
 =?utf-8?Q?rKRs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUVTZlFaaSt5dHBDMEVBRHdoRHF4VTRnbW5TZEpjdWJTVkNhRUhleWJHSE9T?=
 =?utf-8?B?OWxoQVY3bTZRTW1VcnVCTW5zL2ttVDA0K0UxUks0aWlGcGJJNlQ3WStXVjdh?=
 =?utf-8?B?cXlQSVlhYVZySHZzWlZHVzB3UnJTTXE1QlRKcHdUSHVFbUhha2xKUFVJUlFN?=
 =?utf-8?B?TGdNbmwyakdia1daOXRDc2ppdGYwWkltaU4vVm83c3VYeUNmUXNGMlh4elVY?=
 =?utf-8?B?OEM3NnNpaG1kRWFxdXlZQUsrdmRzYmFMOU9qeWxxMEl5ZEdRZFVtNGFralBD?=
 =?utf-8?B?UjB3ajB2VURRQW9UK2RaaXRRbEhaa0F4bWlJYkoyUXpyWWsrMlpnTkNHOThY?=
 =?utf-8?B?bnc4d3Y4aGRJV3prc3ZrUWk5MTR1VUwyeFZPbzlzY09EZUozbGFhUVZpV2VO?=
 =?utf-8?B?dStxRDYrNHJuWXZsQVhlYjFxb3A2bzhPSTZOUEpwZTdpNk9CemV6Q3cxWmo1?=
 =?utf-8?B?aml6b2w3RU5OblNnV1RUeFVnRllrUUhEKzIxbDdPVCs5OVBmKzU0Mnd5dG0x?=
 =?utf-8?B?TjFhQ05jeEpFUVY1THJOZGUxWXlGb2xqMEJEczNZbXBIRnE3TGhrVGxNcGpk?=
 =?utf-8?B?NXBkSkxxR0UzeU5JMWZLNTlmOFBEbmpaa2FFWjJtNURnbFdJRUlBODVUK1gr?=
 =?utf-8?B?WDJxTXo0UWFJT2EvSDE5N1FqdjNuNitCOVFiR3oxSVZJTTdJUkRQa1Z4TWIv?=
 =?utf-8?B?WU5UTUZVdGFudmk1aW9WN0J2eGMxYStWekE2Y3dEa1FxY1RDWEYxbk9kQ2ZJ?=
 =?utf-8?B?RFlsR2RrU0hmeDNUQXVBNUl0OTBETlhxWno2T1FhZ3dQdSsxdXFKS284bnV3?=
 =?utf-8?B?SWE1UDAzWjBJSE9pRXVBOHFRNTk1aDdrb2gyN20wUjY3cXNqY3ozR0w1MFps?=
 =?utf-8?B?Wk5xQ0JFbVAvQTNLTXp6ckppbXdLTWRFcHlIeU81aFM0S2lxV0poTW1CQUhM?=
 =?utf-8?B?Zll6VmhMVkNkdUNMT09oUXkxR1lkclJqZE5yOXVXRVVJNUYvVlR6eDZBRWlO?=
 =?utf-8?B?UkdsMWRGMmJZYlVycTZ6MFhEN1RHOVlMbURnVEpZL3ArOXdyRjl0QkVkbVNa?=
 =?utf-8?B?cEFGbWR1OUFiTTdPYmovb0NWWjhZN2JxUUV1Z0pia2tkZlJzL0RpSjVBWDVE?=
 =?utf-8?B?L0JVc2RJaytkdld5dFo2SnVZaVkrMGNoMWZhU1M1SzNZa2xOQmo2dDRmY2lY?=
 =?utf-8?B?SGlJQWZiSVBTUndlUTlpWGxMS0ZrK0N1c3g1WTBNMTJDMXdvWFhYZTJDejB5?=
 =?utf-8?B?YU5CdjNBa2xlM0pHMG1qZEFWQzF1Zm1lOXJLKytFQXMrSnV4dXZKZm5pU2Fy?=
 =?utf-8?B?YXR6VVZQSzlCb2ZSR0lFMHRjUmtSNHRyanFtVUFKOUxON1BnNG5CbEVQeC95?=
 =?utf-8?B?TFJlZ1BRNHF5VFk3REZ4OForZW9kSVQwZTZmRHRlZEo3RnJDVm93RkNyWHdq?=
 =?utf-8?B?M2FEZmR3QmNNZFFic2trdXZaU3VGZFJZMTMvZnczcGJJdXEwaitLREZqcEsy?=
 =?utf-8?B?bkJ3d0lrWGFtU1BoNWk5MDFZaTNUVktSNWdacS9sUVE3d2g5Z2N0OUhkdVU2?=
 =?utf-8?B?YVhBdXpyTi9KYlRiRzQxL1pIQmtheUE4UjAvaVFlMnZwSm9tT3lrSUNXdWRy?=
 =?utf-8?B?UmEzTlI1ZXB1bEZ4SEJPYk9FekJHR3NPV1hxc1gvQkppZDN4d3BkR1d3OWxt?=
 =?utf-8?B?dTdKZUpVTlFkOUFRdTFwanR2amRMYkVLcVpuR0xaMDRhSEhXK0tFVzZqU2ww?=
 =?utf-8?B?QVd0bFZqRlZ0RXFLMzh2WmwyWWtBajRSVmpaTUQ0dWVrcGN5ajlmMC9OOFhH?=
 =?utf-8?B?QVA2ZFVKSVl5VEF0OWszMFVuL1ZEa2R3WVgyN2Y0WElPWW1FUjhucHZobExh?=
 =?utf-8?B?OGNGTVRhRjNrdVZtNzdXVi9HNFJxalBnVjhHRGdRczVJTUxQcnljLzgyYU9E?=
 =?utf-8?B?R1BRbjhvcXdlcXYxRlJrc2xROU1HeEduaFNFT0tHdCtQVmNmM0JUcUl5SXJh?=
 =?utf-8?B?SkJYSHk5cUd0dGNweEkxRzgwSSsvTzB4TGl3TGRCRzcybmljbXRMeUd0TzhF?=
 =?utf-8?B?STJacFgrTVdnalp6MzBLMFZCSzZBM0tTdE5BUE8vNktIQmo5anJobW0rem9N?=
 =?utf-8?B?VFk2djVMUEYxcWpKSkpwS25GcFR5UTVBNGViczJINUxOUXIyM2w5THM3NEV6?=
 =?utf-8?B?cE51NG9ZN0xlTWJjUkI1T2c4SEFxMzRaMTYyVjhTNFlMVWtpQitOS2VYb1Iw?=
 =?utf-8?B?SThsR2NSL0VTUFRNdzlCUmpyS0tieDVpcWx5b2FpRnpjMklSSE1pc1RvTTds?=
 =?utf-8?Q?Ll2O3JoOYcfxVhrljz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4307619a-fb8a-44fa-9722-08de6e2c55ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 13:56:23.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/2cwdRnNJmZQjyXBuihGVF0TxEb5oNxiCTCaNoXlnz8h61xS/i1kVwXP1+ghXAJRNffKHAbPQyJwLDnjetqwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_FROM(0.00)[bounces-6171-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.lendacky@amd.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: 4E0ED14CF4F
X-Rspamd-Action: no action

On 2/17/26 04:49, Kiryl Shutsemau (Meta) wrote:
> This series addresses two issues related to unaligned physical addresses
> and sizes when handling EFI unaccepted memory. These issues were
> identified as potential sources of kernel panics in Intel TDX
> environments due to incomplete memory reservation or missing "guard page"
> extensions.
> 
> The first patch fixes the reservation of the unaccepted memory table
> itself in efi_config_parse_tables(). It ensures the entire page range
> covering the table is reserved even if the table doesn't start on a
> page boundary.
> 
> The second patch ensures that memory acceptance requests in
> accept_memory() and range_contains_unaccepted_memory() are page-aligned
> before performing the unit_size alignment check. This prevents skipping
> the necessary "guard page" extension for unaligned ranges, which is
> required to avoid crashes with load_unaligned_zeropad().
> 
> v2:
>  - Fix 'end' calculation in the second patch (Tom)
> 
> Kiryl Shutsemau (Meta) (2):
>   efi: Fix reservation of unaccepted memory table
>   efi: Align unaccepted memory range to page boundary
> 
>  drivers/firmware/efi/efi.c               |  8 ++++----
>  drivers/firmware/efi/unaccepted_memory.c | 10 ++++++++--
>  2 files changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> 


