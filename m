Return-Path: <linux-efi+bounces-3456-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A46A9B354
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 18:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9A218961F9
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 16:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A5E27F4CB;
	Thu, 24 Apr 2025 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SNxZxFPB"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D8199949;
	Thu, 24 Apr 2025 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510700; cv=fail; b=EOAjqmuwqM736cSTIGiidw+3jWqZUh6TrD7xKZ0hqX/gMQvn+p/Ts+zBaIagiI+9Ug6CNOOXKvouHemDLJU5YVHn/5tCsi2NXz4bErmGAMMc7t37z02E47gd5RZAQIEZzcRGwO8hVVQbdmtCYm3EtJiPKbq1agLAbaiBu19RYfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510700; c=relaxed/simple;
	bh=bOBHF6aEUEz76NOed6c/2MIA2aHpebM8qiecQ9t4Lic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DKZ02jOk3H2mrbM6+NHCO5/ydA5nzkFl6YuuVULNbpPrn3FeZ19+ExPZwI+hrkPckYbc0AvFfoJpabLUFmHoxIINqVAAo6o8DytaMoGMxpFSmJfaCrJXKuh3iiAv+JX0bT0cvOkTqAad2BVgELO8tsr0WagczcslfzA5q/YMSI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SNxZxFPB; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtT81vMlNv8saAzStX0eC9SAh6ZTFqlR1A9Wx9vOmYY4L/SIHaqoeKvjeUVxVaYYMMWcLvlRXPLAUe3ZJPHltzVZwaCywg3BRIy3ji43846ocyNyS0n+WyxU7W4XL8CbMcmY85UYVvrAmG79B/eMNuh8xQzLNpHRL1qSxyw1d1dLic7AVMWdSr1Y+2UUaCwzwieBXCsySE9LUHOfBGRFIZ5twkVWXs37wEQ3phGcfCM3Z/+iwaV4X/ETZLhGMlEgekE5s9q2jcTcsy07yQxt2hCv7TQB5wMk8CytzVbux908wg6kbxyfWdkLY1ICQU5TFOhhy2TKxiYcECXyDSstaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qX/T7eLizQd98ROMMlVm3d/CNnpkO0xe/PkNTMA4i+o=;
 b=yMO85b86e/hF7dJO25PbD2FHveDgMB4KV3FW0bA4Pw3SS8zWSHRPa3XUsAyujmX/jAq0jMc/P29QdT22rWI7v7Hv73DHanHxJH8y5pjTwVwiV6gSrFbK8h38+her+pTYy0XsG+/w+ee700A7vo3dS8SbdcDFwUpspYTc7jxoTqnzkfUnRNV7Z30RrbG8VCiZB/arG/zNP+zgqnr0ulXnhlsUM6WQlM1n2Pe4+DeoZ/md0tb2AsZMuARWANxuIuwudUBTvPMg0N/kaPGTx+v5i0N81WJfSotVLj7pUTf8sAf3/6AglfDFkCmHx0HKrJQOIfOj7btmXq8BLfp4pQCUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qX/T7eLizQd98ROMMlVm3d/CNnpkO0xe/PkNTMA4i+o=;
 b=SNxZxFPB9+8TODNPyJTTrS/W3T74+QOCAfSaLQggTQZuNFGNJI7UblnpNUtVzHHs/PTr8M3msrQroFxRjxuGKCpylV9oEfoqFtKXrvxWMynOA+cR2t9FItypgvzUwBoPvtuYm77149IMA/b4gNU1OypFd1u383oRzoblqk/DTHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 16:04:55 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8678.023; Thu, 24 Apr 2025
 16:04:55 +0000
Message-ID: <10b690f8-9ce1-28d6-ae84-3fa323d32d54@amd.com>
Date: Thu, 24 Apr 2025 11:04:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/sev: Share the sev_secrets_pa value again
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>
References: <20250418141253.2601348-8-ardb+git@google.com>
 <20250418141253.2601348-11-ardb+git@google.com>
 <cf878810-81ed-3017-52c6-ce6aa41b5f01@amd.com> <aApZ6JwPQ8Cde3OK@gmail.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <aApZ6JwPQ8Cde3OK@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:806:6f::29) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c72879-df12-4804-7ed0-08dd8349c0f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDlrYVQ5V2Rxb3NCMXVVcWt5OS9MSW1GTU1TTUI0UkZqOGI3c3Zmb1JJOERQ?=
 =?utf-8?B?cEhqTGVaR1RhRTlBeTJTa0pBMDBXTVloelBOa0twaTNtYnRkdGQvdHdnallF?=
 =?utf-8?B?eWx4cFVWUGhUUFFBLzFhekt5dk9UUjNBQ3FCUEdQRnJTNDdxMVJSeEpIMVMv?=
 =?utf-8?B?K1pRRzN2NTc1djU5ems5cGs0UEtPNDl2aE4rTDBmQ1JpemdVUEdFWmNBZVpG?=
 =?utf-8?B?dDhVU2lQK01yWUdBRE9iaW1wMHhFSDNIZGhhVGE4MTBKTTlPbHF3c2NwVHRX?=
 =?utf-8?B?VkJ1VVJ1T21ES1I2YVQ4bGJ3U0VrbzBpZUpxVTNlNjBaQjM4dENuWnNyK0xW?=
 =?utf-8?B?UXFQN2xuSDVSNE5hU0RyMmxpWVFmMFdvNUJ1aG85OEExMVl0YjAwWWZGS0xl?=
 =?utf-8?B?OVpjSHp1aFdOcHdDM3ZSZ3plSURrV1AyL0lQNVBZU2JkR2tocVF4dkw3Wksx?=
 =?utf-8?B?eitWZ2hWaGsyQnJBQVp0T1RFTGN4THVNbEFNeHF3SjhIY0YvcVNPRmUrdS9P?=
 =?utf-8?B?YTQ0WFp0aEFlbU9LZ2diSEZhanhnZWtHK0N5cjluTHFYWi9jTDg5ZjF1Sm8v?=
 =?utf-8?B?R2RiUUNQdWl5S0trcktpNXlKb3l0eG9IaTVEc1MrUWhhWlFCd2JpOVhyTFVD?=
 =?utf-8?B?NDVuRWszcHQwUHEwSDk1Q0pUVlQrRXhBUXNocThlQjVIeVJOTXlXVE9QaTAw?=
 =?utf-8?B?ZWc3Y0RFaU50Si92MlNkWEVMbXZyYWtjdXQrd0xYVWJyZ3kxMHNaZ0x3SlF3?=
 =?utf-8?B?WHB4RVArVWlkZDU5NmpXRFVTNmNhcmhBTWNBbnRvczhkdmRaTUhCdzJVQm5I?=
 =?utf-8?B?Mit1Zk15bFNHNG1RWmd6SWtlQ2R1SnppVE5GcjFVdlkvMm9Ncmk3eVk2dWhX?=
 =?utf-8?B?TXNobXcvYkFBcmhJM0FMRkFRSSt4a25tcTJQODBhR3FncmpiNEYyNG4rYkRl?=
 =?utf-8?B?blIvdis3L0ZscFR1dVBaWjRKY0MwenRWcG5ENy9MNVhtejBicUwzU1MwSWNq?=
 =?utf-8?B?emNnbVhmU25zblVVcVdMZUt6eUJIOWc3VFFmMllwU0pPN3dEVEY5TVlYMkx2?=
 =?utf-8?B?Njh5TTkwNEI5WnFWRFN6ZnJ5SUVKbDJxQnB0Q0UxR1pUWGVXS3NvdFVBUmdu?=
 =?utf-8?B?NVVyQlBTSFo3TWJJUkZiSEVhYXdwU2ZiKzhZWlp5K0dGczJvenN4UEJrWkRl?=
 =?utf-8?B?S3UzVWRuLzNqSElUdnhxcmVPVHF0WEEyNGNBRXpTNnFxMStJOWMyNW5xNVc5?=
 =?utf-8?B?WStUa1VYQkpXZ2o5d1krZ0pRbjNVWkdPSVBXWUZveWVEbkhRclpsWlJlb3Ro?=
 =?utf-8?B?YVE3ODdCQzRtSGg0VlMzcUVWVkdhTDhCOE9qTDdaWWNGNzZYUmhFbFB1ZENN?=
 =?utf-8?B?S1ZQdmJ3aXd6SUdob0J5eXBGa0RKVFhyMjRnNUhnZ1ZlTTFlazV2cGgvYm9w?=
 =?utf-8?B?SEpVMjFJUUk5dTlJRDV6Zm8wekNtTHNPSDhEL3lRUFdkZjZXWE1KWFltL1k2?=
 =?utf-8?B?WUlwSko2K0J5bHUwcVNTeVM0enRpOVVrbEQzYnRteGpvLzBWNWFFUU1EUU13?=
 =?utf-8?B?WXQxeVAzTlZHRXdLaTFSN0FLOWV5MGFWbEtMUDVBb2l5andQQzNVaUMxM1Jv?=
 =?utf-8?B?VWRqdmVNK29UT2JJVmU0V3cxR1hmamlwdUFValYvbE5Ca1NxRzRqejg3dVNY?=
 =?utf-8?B?RjIvdHd1Ykp6NENTSU55ejhWWUtZRjlVQ0JmRGducWpqUXg0YWxNSmp4UmZV?=
 =?utf-8?B?WmtnNENHM2pRcnRVdXFuTU5lUnROY09BQ1BHSW15MllCb242OVJucFhlaVYw?=
 =?utf-8?B?U2owNEJVZ3ZPaVB0MmtHcTJxenh2UVFkc0x2c3FDZGEzUktVbVBNTlhXSWFR?=
 =?utf-8?B?YkpKSDJVNlk3WnZBMld1cVFuL0dWU3lvN096UDZ3ZzRUQks2NWtiSldPc1ZS?=
 =?utf-8?Q?vOjdtoHHz00=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUNWNDhkWGFsRUtwS0VsUng0b1doSHUvNVV2UFcyL1pKeXZHVGt6aTFyMXRJ?=
 =?utf-8?B?WDZyM1FLek52emVBTlRxR3hNYldDR0N1ZFRPVGpJcEl5REdmeWVxbUZ6QXZM?=
 =?utf-8?B?YWNUbjFIQUw5MmtNUEphYmlpV0YvTDIxd095QklYc083K0hEUUs4WHR0aWQ2?=
 =?utf-8?B?T1RpQ250VzhGNGZrYzh1RGQweUlYRzZHRk5MQkE0VVNFYWZIdEp6cThKM281?=
 =?utf-8?B?OXUrZnhxa2hDYm14Y21tcmkra3BxQjc5RkluSFdHc3A4c3hWQktLRmdieW1H?=
 =?utf-8?B?M2RMQ3NHT0dhU0xUM0U0eVF6TGdnMitrSWMvUXp2K2NtamhucVVweDFXZlVn?=
 =?utf-8?B?T2lUYkdMRDdOU291T2JsYU55QVVhSEFEWG1GZmtmNVVZZkw5SFV4Mjk2K3M3?=
 =?utf-8?B?MktZZFBFOXptL0tKSGlGQUNsbDBIUk5tWW9KZ1lUdjlUeU9nQnMzMm42OHU0?=
 =?utf-8?B?eEgwSHF0QXgrME0wM3o5bVZWdkhnRTBzblVBbUtwZHpHYVV5c3JoWlYrYU9m?=
 =?utf-8?B?Y200WnBGN1MzeC8vU0VJcEdKRDVpZ1lLalF3cFFQaVNMK0xWcXo1WTZPTVBU?=
 =?utf-8?B?cU4vUGY2eWpvS0VOcUlVY1RlS0ZwaHBJYzZsSkZEbUlSdDJGV0krVXJ6cG9s?=
 =?utf-8?B?dDFmeVViOTJjZ04vMXgwaWw4RXl0TVZDYnlCOTZCQWtVZ0ZaTlJhQ0tLRXp1?=
 =?utf-8?B?NGJHRGJhZGw0VDBQQ3BRallCaEMrSWg0VHBoS0JobGdhQ2w1T2ZsWUM1VXVj?=
 =?utf-8?B?UHp4ZzFkb3RFM3N6NUsyVVdhVXljbXk3MzAzdFdyZEZHSTN1cGx1WWhUNlZ6?=
 =?utf-8?B?Um5hL0F4emp3Yjl6ekdhTms3OWMwMEMxTVh2Q294MDNtMHpxUkFGWDlwNUZV?=
 =?utf-8?B?NitFSDBaUkIzNVhXVjBMVWo0SlJma3lidVpoQ3ZJYlRsbUdJUXBLNGE0bGdl?=
 =?utf-8?B?cDA4c1N5RVp2SXRQa25xSlBvejlPYzlnZkxQeEczSjJ6NFhqN2F2bXNNazNl?=
 =?utf-8?B?ZEdYMkpTTGMwdVhWRlZqZ2tkYW1GckJPSGdnTmZiNFVBeTZuRGJsTFZRNXBF?=
 =?utf-8?B?MFJTV3VDYnBuTHIvMmdSanpGQUlSK1hCSkowWVhabnhTUGFxZ2FsK0pWcndM?=
 =?utf-8?B?U3NNWkdjT1hnSkpQSU51NU9HM0hUZFMxL09MSFhYbTFjc3BkN3JtS1d2ckhi?=
 =?utf-8?B?ZW5EaTEwTXRiQjg4LzhKYXV3OUhGV2lYQ3crUFUzemxYWElTdy9sSC85UTE1?=
 =?utf-8?B?SE5tbGhqQVZPUFg2U2xRWnpyT2ovYVlDeHBlRTlNeDhoRWhwTFFWb3YyKzBY?=
 =?utf-8?B?ZUlnSWJzVWxrU3NSaDBFYzRJVitGbVZ1SS9zYnlxdEVBajdFVzFtWUJqWjVu?=
 =?utf-8?B?d1JEV20zYUVucHh6YzV5MnY4SjV0ZkZpUEdyeStvZm1PaFNJK2g5RjFXTDFV?=
 =?utf-8?B?OTNOQThiSm5yaVhXOUtSTWE1V1ZXK0xJMktUNkducDVRT0pwZFIvM05yc2Y5?=
 =?utf-8?B?blQ2SlFUOVBCVjh6UllOOXhhMExQRlRyUmduM0dpa3MxZUVNeHYreTVGZC9R?=
 =?utf-8?B?WVhPMER3OXZoL0hqSFVobVlzUlJyb282RmhWRDZYMFBIQU0vSi9UaEhyMktB?=
 =?utf-8?B?NkRVT1JIQW5zWFJscWg1WXF3S0hvWW9WTnJXcWk1MmlxdmNwWDFuWjMvREtK?=
 =?utf-8?B?MHo3TXVUb0xPeHNPVlJERXVSZWY4N2NZMThNYzVJakdtYi9HMG1BUFRjbnY3?=
 =?utf-8?B?MjI1aUl6eWc0TmZmRmRodmRMc0xMdFVBbGFCMzZkNE1LL2hzd3hwZ0M2L0xz?=
 =?utf-8?B?eGhTbFRTWWNZWURYN2J6UnhGZjJWU2Ftc3lQTjJjUXorREV5UUhQbTcvRjhM?=
 =?utf-8?B?V0YxL1hhQVlBTlFkLzhCQUQ5V3EzWVRWOTJyK2FnM0NlcVUxUnpQbGo3d2J5?=
 =?utf-8?B?RndFaWpQSi9Kc1RuZDhGN2tGNEZjemgrQUd6R2VaR3Q5VjNGZnNyWlYwUjNM?=
 =?utf-8?B?UVNiSVJ1aWlHM1hwWHRNM0pYUGlYWVhza0hKTE9jc3FhVkJNTXVBRTZma055?=
 =?utf-8?B?bFZqemVFZWFUbjZ6QXh3UXcyUjJCT1BXRE03N1J5N2JPVGNPZzNlSnZseUEw?=
 =?utf-8?Q?GLMh883jJxK6e7W+1fV3mCVtC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c72879-df12-4804-7ed0-08dd8349c0f7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 16:04:55.1852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4oREnXmDbfIpcIXJaodpM2H5snbBL/xFy12cLRYDOxtPfRSqq5caCWlSWVx3lq7kaRX7Zasn4MGL+l92F9uUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801

On 4/24/25 10:34, Ingo Molnar wrote:
> 
> * Tom Lendacky <thomas.lendacky@amd.com> wrote:
> 
>> On 4/18/25 09:12, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> Disentangle the SEV core code and the SEV code that is called during
>>> early boot. The latter piece will be moved into startup/ in a subsequent
>>> patch.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>
>> This patch breaks SNP guests. The SNP guest boots, but no longer has
>> access to the VMPCK keys needed to communicate with the ASP, which is
>> used, for example, to obtain an attestation report.
>>
>> It looks like the secrets_pa is defined as static in both startup.c and
>> core.c. It is set by a function in startup.c and so when used in core.c
>> its value will be 0.
>>
>> The following fixed the issue for me. Let me know if it can be squashed
>> in or a full patch is needed. Although, it likely should be named
>> sev_secrets_pa since it is no longer static.
> 
> Thanks for the fix!
> 
> I wrote a changelog for it and also included the suggested rename to 
> sev_secrets_pa as it's now a global symbol. I've added your SOB as 
> well. Does this patch look good to you?

Yes, looks good.

Thanks,
Tom

> 
> Thanks,
> 
> 	Ingo
> 
> ==========================================>
> From: Tom Lendacky <thomas.lendacky@amd.com>
> Date: Wed, 23 Apr 2025 10:22:31 -0500
> Subject: [PATCH] x86/sev: Share the sev_secrets_pa value again
> 
> This commits breaks SNP guests:
> 
>   234cf67fc3bd ("x86/sev: Split off startup code from core code")
> 
> The SNP guest boots, but no longer has access to the VMPCK keys needed
> to communicate with the ASP, which is used, for example, to obtain an
> attestation report.
> 
> The secrets_pa value is defined as static in both startup.c and
> core.c. It is set by a function in startup.c and so when used in
> core.c its value will be 0.
> 
> Share it again and add the sev_ prefix to put it into the global
> SEV symbols namespace.
> 
> [ mingo: Renamed to sev_secrets_pa ]
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> Cc: Kevin Loughlin <kevinloughlin@google.com>
> Link: https://lore.kernel.org/r/cf878810-81ed-3017-52c6-ce6aa41b5f01@amd.com
> ---
>  arch/x86/boot/startup/sev-startup.c | 4 ++--
>  arch/x86/coco/sev/core.c            | 7 ++-----
>  arch/x86/include/asm/sev-internal.h | 1 +
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
> index 36a75c5096b0..f901ce9680e6 100644
> --- a/arch/x86/boot/startup/sev-startup.c
> +++ b/arch/x86/boot/startup/sev-startup.c
> @@ -55,7 +55,7 @@ struct ghcb *boot_ghcb __section(".data");
>  u64 sev_hv_features __ro_after_init;
>  
>  /* Secrets page physical address from the CC blob */
> -static u64 secrets_pa __ro_after_init;
> +u64 sev_secrets_pa __ro_after_init;
>  
>  /* For early boot SVSM communication */
>  struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
> @@ -1367,7 +1367,7 @@ bool __head snp_init(struct boot_params *bp)
>  		return false;
>  
>  	if (cc_info->secrets_phys && cc_info->secrets_len == PAGE_SIZE)
> -		secrets_pa = cc_info->secrets_phys;
> +		sev_secrets_pa = cc_info->secrets_phys;
>  	else
>  		return false;
>  
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 617988a5f3d7..ac400525de73 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -80,9 +80,6 @@ static const char * const sev_status_feat_names[] = {
>  	[MSR_AMD64_SNP_SMT_PROT_BIT]		= "SMTProt",
>  };
>  
> -/* Secrets page physical address from the CC blob */
> -static u64 secrets_pa __ro_after_init;
> -
>  /*
>   * For Secure TSC guests, the BSP fetches TSC_INFO using SNP guest messaging and
>   * initializes snp_tsc_scale and snp_tsc_offset. These values are replicated
> @@ -109,7 +106,7 @@ static u64 __init get_snp_jump_table_addr(void)
>  	void __iomem *mem;
>  	u64 addr;
>  
> -	mem = ioremap_encrypted(secrets_pa, PAGE_SIZE);
> +	mem = ioremap_encrypted(sev_secrets_pa, PAGE_SIZE);
>  	if (!mem) {
>  		pr_err("Unable to locate AP jump table address: failed to map the SNP secrets page.\n");
>  		return 0;
> @@ -1599,7 +1596,7 @@ struct snp_msg_desc *snp_msg_alloc(void)
>  	if (!mdesc)
>  		return ERR_PTR(-ENOMEM);
>  
> -	mem = ioremap_encrypted(secrets_pa, PAGE_SIZE);
> +	mem = ioremap_encrypted(sev_secrets_pa, PAGE_SIZE);
>  	if (!mem)
>  		goto e_free_mdesc;
>  
> diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
> index e54847a69107..a78f97208a39 100644
> --- a/arch/x86/include/asm/sev-internal.h
> +++ b/arch/x86/include/asm/sev-internal.h
> @@ -5,6 +5,7 @@
>  extern struct ghcb boot_ghcb_page;
>  extern struct ghcb *boot_ghcb;
>  extern u64 sev_hv_features;
> +extern u64 sev_secrets_pa;
>  
>  /* #VC handler runtime per-CPU data */
>  struct sev_es_runtime_data {

