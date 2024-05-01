Return-Path: <linux-efi+bounces-1010-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B3A8B859F
	for <lists+linux-efi@lfdr.de>; Wed,  1 May 2024 08:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68461F23457
	for <lists+linux-efi@lfdr.de>; Wed,  1 May 2024 06:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376212628C;
	Wed,  1 May 2024 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xuU5uwhj"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2CE1B806;
	Wed,  1 May 2024 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714545535; cv=fail; b=E83ZHoq9ETAhWJnlNE+IjgPyJdIIAOFtvBrDAzd+Z34KfL0R2xyf/DkRv9BUbV60WkpYHBZRwcjbYplrWCRYylTQwD5m5gPXvwJnNtx7EuHMEagbD4NRgzIz6p+rNEsGx5wL/G29x4o3kU9qhVGQcbEiGDBIzDIt2CcH0Y4ur1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714545535; c=relaxed/simple;
	bh=UqHauTQsRnvUOj8hYJBhlN/qx2M1B+MLklMfVUNvYgg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=Yb2wMGGDHC4QoBiRwWAglVoFY1LpR90Ec4UUDNMN1XSiWid9N6YLi0VymbyGKARN2xED43DvWtvhwblZ7+JXFHf9x3rBlfIPDybnyrN4Vu5BwC9XKv1QqnL1laHTIIlLjrwkg4nYE8TsXhgcezvP+niwfZNGGlCYBsSMGvUidro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xuU5uwhj; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbM3lv+IhulJ7Gq9DEoT5UsYVMNJR9+I5PPBj3r7E8irHqr1C3XzF8+kC6CSUiNLi7HUjukhbVY5fy82OTmF6itOlvj2wvFePR8VyAlj5d4G2753chGRyZbDTBIEyfqbMIAH70+JRLybDXQNhLFVftFcTU3ispXZ/LF9PRL2n0EBfLotwiDIW+4WY/wEpWhmJSUtrej7Jk2PkbyJtmJOykyGXtJp8z0Yf0rW35RgoyR7FBxLsofnpAzbVMD7VgVsE/7aRYxzofpEjkuOxi+W9G5pZPaK+iv2OESIF4+wu878IOdV8weUx7aooX8D5HFnL08G5/tECYqBNYaEKNm7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Yo4RGaB0fF8A73cti2WUMt9aip4VUuq/Yts0Lt1jYw=;
 b=EtaxHg2r+BHrNFNgvpgzgkCb1BIs1fUpnKE6k+Q0NvsqYcqcXIHtgPpM+QBgC3cHjrsViivZIaV7GsHgsQ2SBmioy4T+hichBJIgoxGYd3QMpOj5xkl/vrqF57f12dniMF2CprxyTDhcBdEuoBPTb7N9pPTOE9mnFVklGxqDLPv8Q+tYZDqAY308sppGwoHLxcQFpssn/JYjoji+YE2vhXmxZvSxxyIn9uW8brZhxfP8PrLfNS5nnLRnWO5wJA+OTuEseiZI49vbmkgwUvMiX9tQJXebKKHgpYUJXNFqToVjuCs1ZS2Cer8pXBCTRhStKw5KS/pTI8lEipUgGlUg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Yo4RGaB0fF8A73cti2WUMt9aip4VUuq/Yts0Lt1jYw=;
 b=xuU5uwhjxV2Vp6QqUMPy0caLPoLwEb5DukpTIilBaoamq9laiX2cbHUFnmI+S9za5LPyARqFhRLM8y7lJnFjcQ0XYp4zBofFwe30kBWxttmk8wJDCgXrNkZx5uJj4EeG/JtsVklLwRyc4mxyW9jKrpSy+7Sa18ySPubw0X9J0/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 06:38:50 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 06:38:50 +0000
Subject: Re: [PATCH v4 2/2] cxl/pci: Process CPER events
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20240426-cxl-cper3-v4-0-58076cce1624@intel.com>
 <20240426-cxl-cper3-v4-2-58076cce1624@intel.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <c7b8c528-2ebc-4e0f-fa25-049aacd154a7@amd.com>
Date: Tue, 30 Apr 2024 23:38:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20240426-cxl-cper3-v4-2-58076cce1624@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a03:505::18) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: e87f6802-11b1-464d-dc97-08dc69a95c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGxwakJkNkoxK09LaG5uMDhmZTRVanRMMnFzN0piUklVUTZzUXN3QUNLRjFn?=
 =?utf-8?B?YWR3WVNDaXllTWEvTnIwYldaVElkWHhINWlHdUdWVHFTMitqVGFoa2s2alRV?=
 =?utf-8?B?MUhuTExWQ2RGNXRsZmorSy82TksrUUhGTW93ZDRNcVZ3S3p1US9XRHFTNktH?=
 =?utf-8?B?UFFMejBjc3B6clZld1hReWY4U3VMOGh0dlRNaGFLak9rTkEzVlZaSDdyaUxN?=
 =?utf-8?B?Z1BtTnFlRTN5aTNrTVd1TWR2VnVCU1RVUmwrSk81ZkZxeU90V3Rrako1azc5?=
 =?utf-8?B?cGhURVZjZ1BROWpVYXZTa0dJVXo4dTBxMjd2L0pCQm1jYXhMdnNvQTgvajRD?=
 =?utf-8?B?NmdGMjZwT2xvS3pLV2NtbWlqT0pmbjdJa2dEUG5tT3pXd1owQzBsZGtVTUNa?=
 =?utf-8?B?NUdmbHpCSGxpbFFsQXFyR1ZYcHVOYkl5aDlqVS9Ud04ydVdVV3RBTmNaVkRv?=
 =?utf-8?B?bDFFbituejlhd21QQ3hBVmZ0Z0Z2OGVnc0RDM2lwaFJXM014bUtPejdpbDlr?=
 =?utf-8?B?QXR5ZmFuNVFJRnd4K3VYbFc2ZUs3dVlOSzk2VUErT2VCcFp5THRkMThZM2Rj?=
 =?utf-8?B?NllRLzV5S0RPZnBxcE8rYjhkNmF0Y3NXUStUVk92NTYvS3VjRGFUb09BaU1D?=
 =?utf-8?B?RGpNVEFDcm9mYjAyRUJHQlJnWDhFanY3Zmw0dWVqaWQzY054cGJGOWpmWmdO?=
 =?utf-8?B?WVM5TGs2a1MxbHZPaUU1N1FwNXNpUFV1NHlhU2xiSElzS0JLL1loRTJhTVBm?=
 =?utf-8?B?aWY1TDRlQkZkQjhyM1NPM0prdzhjUkIrd2FNZjVJSWRNcUxIRFk4TlpKVE9i?=
 =?utf-8?B?ZXpkVVR6bDdpcVdLQSt0V0dTdFhnUjIzNU9LZGZLdjBaY09EeEdBMk4wcHdw?=
 =?utf-8?B?SW5OaTNWeFYvb0FHN2ZGT25LczNZTnV1TVpmbFdYZjNNZnh4Y0lQYnI5YXJD?=
 =?utf-8?B?RXpnSFk2RG5mK0dWTUs0UnhGT0JibVJJc1VZekREeXErU2RmSHBieHA4OGI2?=
 =?utf-8?B?ZTAxUUgzbVZsZDZnS0tNWUxWTnczWHVBMWxESDBOU04rMmVOUUJSQnR2Ym82?=
 =?utf-8?B?RjB0WmpaN1pFUHo5T0lGNnlJQnNnZllTK3VQOVJTSWsrT2pJM0E3L2Y2Qmox?=
 =?utf-8?B?M216VGFhK21jTTQ3Z1BsVE1FcDZlZFdWOC9Cc2Q4S2htNk9KV1RISVdxQnh5?=
 =?utf-8?B?UURUazYvQmNkRC9kVjE1ejIyTElHVUdXTDFOak1kMmtXd0pmZzRxaVlxdXhj?=
 =?utf-8?B?cWV1OG9TNzV3QlluNmVMMzFNVHVaeFhuQ21OaldHWWNYTWpVSUk4WWZHSDBO?=
 =?utf-8?B?TVdzTWxsQU11RXJhZmxrcEZlZVNSRzVNejhIc29xektHSTM5N2dZbmVOay9s?=
 =?utf-8?B?UUdYVHV0Ym9Hb3B4U0QzTXNSNTBGNnhsYVFCUHBlWndNS2hReG9mTGdTQlQv?=
 =?utf-8?B?VGZqV1Y3Ni85SExNaGREaFdXaGI3MjhtOVVNeTEwSFJlV2VraE9MTXFRR2xX?=
 =?utf-8?B?N09YdGpOdjBYeDBPaWFUZGRYcy9pcm1MWjFtNTFqOFp3UVlBRCt4dmZTbjh6?=
 =?utf-8?B?dXBKeXdnNEVoTXhrT3dvdElvRmNxcFkyRW5mZk1ObTN1bStJcWNoMlFlWk1H?=
 =?utf-8?Q?PZ8fWqY15q/yVz6e+Sbz7HoVSqh0+B/PxXvX8nL/W/sE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzVYaWJFYXJMR2htTmxyZGNuVm10eW9iRlZUMlV0ZVh0M0JqNDBBNXRpd0xs?=
 =?utf-8?B?OWNrcHIvZVFDdDZnMFJodWlQTWVnYmtSZE10eXl3Yk5ZZ05TSlRaT0E1dUF2?=
 =?utf-8?B?VTQ0YTNmK0RnV1NrUlA3ajZ4Zk1lTGVxYW52bXduZEttU2Y0Z1I4M1d3RzA5?=
 =?utf-8?B?QUdBQ1MrRjBqWXdSR2lUNnNkYnVEWXV0M2UzMm42OXNDN1V5blVoeWwwNGFO?=
 =?utf-8?B?bTlaK2hVTWRrREpRdDZMMmh5c1RIby9peFQyQ0M3c3FBeG9KWWlIZkxXcEUy?=
 =?utf-8?B?RlhFY3dVRHJUZnpWU1BubnIvYlVad3lSVGV1dHVEbFN4TEJEcHAzNmhUTjd3?=
 =?utf-8?B?QVhTQXczcGJ0dWtpbWlHb3VHNUx0MHVtWWpnRlBQTjBWVUtwbGRidSsxd2o1?=
 =?utf-8?B?NFNxY1FmMDd2Y3gwVkJVYllwNzczRGZRMjh0NkFGNExoN3doZzRidTFCNFJ0?=
 =?utf-8?B?dzY1M2p3S216Q2pXRnUyemxxSmswYXVIdFhEaFBXcVdjUXpKbDkzQ0ZvTzdZ?=
 =?utf-8?B?QjZzMUhNenNHTlZQM1BtVHVlNFpLcXRYTTVPV1BnTUZ6K1lUaVUrYTVRa3RH?=
 =?utf-8?B?NzRacWt0Q2F2UThaKzlvMDNScENmelN6OG1QZmQxVytHVzBGSW5tbkM1N2Uv?=
 =?utf-8?B?ODZQWUdQVTNYcHY1N3FsSlJxcTNBUDFjSXFMcEwwdG5WK0tHTnhjSXNPL3VI?=
 =?utf-8?B?RG1pWmJmcWdNOEhPZmdYdjczeXNMcEVZMjFNZUtDc3ZYL1d0S214N1lzaCs5?=
 =?utf-8?B?THdsdVNHMUZKSkNmVTA0b01RSVcvUDA1SHNkOEtTcGYwNXhPekJnUWxQSFpm?=
 =?utf-8?B?cVNXOUhrSy9ZbzVCT1dmcVJsRWhXbHZDMThDSjRNVFlpWnIwdlVEOXFIaWZy?=
 =?utf-8?B?eW1BMmEzdWZVOUF4WGtTUmM2Sms3N0tVMHozYVdNVlY4RUFpcGJNVHQxckQr?=
 =?utf-8?B?aWVtSzhtTFh5bnVxVk1mM2cvMjdCejdvcFllZDhUK0dmLzlQVkhObm9tcStr?=
 =?utf-8?B?Q0QxRThqMHNDeDBjUnJ3clJ0VC95dnlnRVVVUDJNMGZ3MHY5dmpJL2ZSMHRN?=
 =?utf-8?B?WURtZ3pPUDVQSEdPdmJwUUhYMUhaUG5KZUdDZ0d0RksyL2FlSUhXbWdKbUZP?=
 =?utf-8?B?VWRVRVVzWGhyUHZPbWwxM0xWWU81ZHA2U29SSGlCa1RmaS92T0UvNHc3K2pa?=
 =?utf-8?B?Y1JRMmUrekVMRDJNZDFkNEhqbW9sb1o4b0xFOG41WlNHK0JWWWlkQ3JzbTJN?=
 =?utf-8?B?ak04MmNPQUovcDJyOGdHcUJOdTRBRUVQZHpmd3VsQU1pTnYvZTJoU3pvR3d3?=
 =?utf-8?B?QnFqVDNhQzhPMlp0SUV0N09IUjdKa2sxbXRrSGhsSDNXZTFQU1NvNnpOSmx2?=
 =?utf-8?B?NlJmVm5CK0FjN2lJdWowYmZabkVNY1ExeWtIWGF2TTkzMlFhNmF3NUlxUU0r?=
 =?utf-8?B?bHBKNTlaOWwvVzJzM2pUKzFVYndTM3FSRHU5RDBFOVl6K0FMbE1RMUFDa3RE?=
 =?utf-8?B?QVJGaWdzTkxsSFN4Sm84bXJhbzQ0VEJ2S3NmOVowNTJZQlN1NHlmd0tQSjYv?=
 =?utf-8?B?akFFK25NVEJqanZMMW43STQwcnBkUlZPajJvOUY4a3RvQ2Z2TzRLeGhteXZB?=
 =?utf-8?B?UmI5ZkExQkdBcjJjME5Id3FudThKRFhGdHVZYUltNWVnKzBkVHRoVCtrR2tv?=
 =?utf-8?B?UUNqNkVYVm9xZzRDQy8xdjcrSG04YnYwUjVTR3N2b2VudU5MT0gvY1hsNkVL?=
 =?utf-8?B?dnRrK2lLaHdhVXRhSWFCOFFhcFhDRktuamZjRENSUlhwY21Xbkl0TGZtY1lr?=
 =?utf-8?B?cFIvYlVvcWNTME9RQXY5Tzg4T2JzYzlSTDJPdnV6OURVT1RWeXc3dGJYaHRH?=
 =?utf-8?B?MUx1dC9PTmZaeWI0SHRrOFlIdG5RYndaaWNKb1JyZzN0Y0ZadlZOV0ExUE5P?=
 =?utf-8?B?bmtWalZvQncxY3IwZWwxcktncm1oUU96Z2xKM3VsdE43eUZjZmh0aVhCU3Vs?=
 =?utf-8?B?S0E2ZjhVc3Q5cWh4eVBQQllNanZwZGFzZlN5ekthcjREYnF1dTg4TmlOWjVD?=
 =?utf-8?B?ZmVMYW1CK0tCRTBMdjNmQ0F2SmpvOThETnUrbFlFaitSdE80anEwUVRlWUx2?=
 =?utf-8?Q?PtdiKA7JXqExAVr7GyB9H9E8B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87f6802-11b1-464d-dc97-08dc69a95c75
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 06:38:50.2334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWAiH5sVR8qE6YAWZR9vykDfG8e7L8TdcPeEeAnuIHPWkw1V6G5QF8BKAIqnPZu2E+OZ4D8NI/iiwwSIgVIG9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410

On 4/26/2024 8:34 PM, Ira Weiny wrote:
> If the firmware has configured CXL event support to be firmware first
> the OS will receive those events through CPER records.  The CXL layer has
> unique DPA to HPA knowledge and existing event trace parsing in
> place.[0]
> 
> Add a CXL CPER work item and register it with the GHES code to process
> CPER events.
> 
> Link: http://lore.kernel.org/r/cover.1711598777.git.alison.schofield@intel.com [0]
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Changes:
> [iweiny: pick up tag]
> [djbw: use proper link format]
> ---
>   drivers/cxl/pci.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 70 insertions(+), 1 deletion(-)
> 

Tested-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

