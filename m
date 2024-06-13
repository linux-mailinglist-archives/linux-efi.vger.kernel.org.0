Return-Path: <linux-efi+bounces-1218-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4966D907D1D
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 22:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78831F26D90
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 20:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E1582D90;
	Thu, 13 Jun 2024 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PghDA9/O"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76FE57C8D;
	Thu, 13 Jun 2024 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309116; cv=fail; b=ZeF8HC5xgau8eCkoYCAXinCEZhbEjXxAYUDuvdMXbF6Wfp+zSflRWs7aF68zCpVheh08r2M0wp7NlDsVNSujTFIz2NXfOTrOmMpCmA10f13yizlwkwFqET+2sHaXrEp06D1DIp1cq2GDpGoOHjKj21nR618AD3jTr2Mlbrbg2sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309116; c=relaxed/simple;
	bh=23rnbrtrzuPGuPvIBEH44MDCrRkXpyebVQfFNtvlX0k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Re7T0i4c6NkC2lok0hRNqsD8xeHWWnJa7zdD0VYRgdh0VPQFaCqgD07sHGYQwjZ8IRidMvwjkA9W0URxnZLsbY3VxqFBWpZBpndAXF6FlqjTsH2I3CPamCwDJssHZ5pHH9AgVbiOwmbBOMHP7UWTqpyBlcwY3HWLQpXZUBru1wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PghDA9/O; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tod4yUKlPeQ3GgKTR0c9BZca6g+zBrBZJVZ+NEJKfq++ItwSkkdfPsj8IND+2W9ThxYuNC+DbfDLHcJp+fXfZn9EU/h0AriskFZ/UTLNwxyz5zHQ2daRc1Trtwf3hWepLywe6OcGCt6rKDMMQQ8SX+/mIbwkHnbDdjxuXntbOnFjivILoXWw7Be6TzHJ6MwexImu8Q6DvMtMCh7T83PT258a4xUCq0g4I6A0dki5oJi2jRHrweP3YAKrOLqe4o3ardQ91X6B8DXWXjgf8JpMJd2yRWiEelhlUjjA74HVCCpXUdVZzXMwYfiEaYIfMZofpnw62eHGLu5zPGIccgS/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt3gBoX/eGlvsQEvXqdZgigsnpfdtIPH7ifFz+UdOD4=;
 b=AFacSkOIYC1pd7NvL/QRhPlMNxoPcip0zHSeeBYFAQuFNV2Ufu21yrHsMZsM9QwqLqDfdOz/MgzVawURuajXahMCsYJ7fxw6uwYzyhX9zwUHeH7ub54FaiUAXcB3EIfTRYKk2fFelmvlzHS7SxkoA+JGsuXtaiIPINCgjGgQynZvlRMJC78lFRBT+qeZEHdnGJEtO9gZtkTP5mHdA2j6whFSsLPld1hwgclR45FnxAh1Krc2yRK9By0bCadlRm83gEOlXQgWLiNIPG3DZ/8BG0QkkqVyXptZi6fKnz8NKB5jJxVAPMgKFatH+SOdpw/NzE+cMfYKvwTh+4P6hRBSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt3gBoX/eGlvsQEvXqdZgigsnpfdtIPH7ifFz+UdOD4=;
 b=PghDA9/O4VRUcKlhceGZ78LO9kPyQBTPzsMJXCkLHWGeYpV/yKJymh3eWkuhRF8r0KmS0vx+6TGDgWkzPDEO2dSu7mZRkPB4nIhZvweW0TuQLi1MVsiavIfeNG4uWLmoX1jICuotK5k+2kNMV7FtENON9nzr9cGeY2T07Bzo/rE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2759.namprd12.prod.outlook.com (2603:10b6:a03:61::32)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 20:05:11 +0000
Received: from BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::10e0:d1f7:5b28:db15]) by BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::10e0:d1f7:5b28:db15%4]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 20:05:11 +0000
Message-ID: <16131a10-b473-41cc-a96e-d71a4d930353@amd.com>
Date: Thu, 13 Jun 2024 15:05:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/efi: Free EFI memory map only when installing a
 new one.
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Dave Young <dyoung@redhat.com>,
 Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dan Williams <dan.j.williams@intel.com>
References: <20240612135638.298882-2-ardb+git@google.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240612135638.298882-2-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:806:22::33) To BYAPR12MB2759.namprd12.prod.outlook.com
 (2603:10b6:a03:61::32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2759:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: a971990a-a5a4-40bf-9eed-08dc8be421ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MG5tS09WeUhjK0cxSXZ0cDU2Y1JlSGVVc0hrNGdaUVJXVkE5MkpmaHpjMWxJ?=
 =?utf-8?B?NjMva21pQ2NJMXZEejNrTXA2MEpRTmFZcy91NHZRWk9BVkxrWkxMZlpwS0Fp?=
 =?utf-8?B?MkdhK2wrU2oxNWFHS3dEZjRUaldnUVo3aUNyaWl5K2VnS3ZHZUwzckhYUkQ4?=
 =?utf-8?B?M0d2K0RhNWhQQ09lS01xTlBSV3VDQ0d1T2NEUWI0YjFvNmYzZDlPUkVubnZh?=
 =?utf-8?B?NE1TYlFHZlQyRkFJNFhDUElhRTh3QVU0MWIzeFpzTFNXV01NTGltT2htTGtG?=
 =?utf-8?B?NzVvRzhYQWx4Zk9GL0k3S25ESmVHZlk5eks1ZDRFdnpVMnlLM1BTOURBbnFP?=
 =?utf-8?B?WGVyeEswdEhDVm9hVnNIQ2FmYnVRdDhwRXZrTDE4VXBQRkg2aVRuc1RMcFQr?=
 =?utf-8?B?ZDM3R2ZjV1hTaDdVQXhFZ3B2cHBTQm03bW1wZHFBNHhqWEVmQnAxMVdjVEVj?=
 =?utf-8?B?TGwrak9YYnZhanQ1OWhSbHlBVWtSd2RWMmQyL0U3K1ZaSkZEenJ3bHV2dzE2?=
 =?utf-8?B?eTBzdi9uYWpqQVdzTDE5QWFLRHEvblFqaWg2NmNhZlkwdnRMT21OeElRa3FG?=
 =?utf-8?B?eWRPa1FSZXF5d0lvSjREbkxJZG5iaCtpWDJNLzdYY25YeHBiUFY3dG10Tkcv?=
 =?utf-8?B?Z0tFOTdLZWl1c0ZFZ05GMjFBMXNvbTlYakZJc0xsUE1obGo3cFpsaGtxcThV?=
 =?utf-8?B?Ylh1ZThhRm52aG1KSi9Da0NFRzhNYm1XdGdCR29HczEwL3R0U1o4YXgzdHg5?=
 =?utf-8?B?Z3UxMmUvWm1LdU1YazJ3cFo1WGFYMDQ0aXNsSm5zZkdHRi9wVXhUTUxTNkY1?=
 =?utf-8?B?M0VSQ2V0Q2tkUXRkWEhPNW55THJRbTl5dDU0SXExU3JTUkZ3UnRUSkNkVjQw?=
 =?utf-8?B?UmYwRUV4MHZYR0Jod0JxUzN5U0ZVSkVVL3QxR2k2WjdGWUpUcWY3YkgvTXV3?=
 =?utf-8?B?NXZqRGFxRUxPalFicnVFd1YzdVU1Q2YzenZVR01UTVFQR2hXTWYvZ0xGTWRj?=
 =?utf-8?B?SUMxRk5UQ3U5d05yWGtNL1pDNzNLRGExWjhXZjNLVkhSR1czVlJjOTR6YVVB?=
 =?utf-8?B?SWJGQ1V5dFpxdWtZQTZ6TkVxVGo2c0VKWlRJWDVvemtpVGtqL05KS1diZGRt?=
 =?utf-8?B?SVYwaDduZG56c3Qyekw1V2RXS0tCWC96Yjl3VHp1eEl5Si9QMXlLSUhna2JW?=
 =?utf-8?B?NUZaUGMrVGxPSmh4UGZtWlI4Z1MvdjF1VXBzbEw3R08rTkE2aURmREZOajRG?=
 =?utf-8?B?RmptWFRuNUEyU0NCd1JqNGxLSGFWOWRjcnJUQzB6ZzNMNFBadTkySkFmSmw2?=
 =?utf-8?B?SmF1eUlKR0ErZXBURmNOYXQyL1cwbnRYTitFTWplaitmMWZvM29RdVR2VzRl?=
 =?utf-8?B?aFNaRFd0RUVwWXZvbTE5Q1Rycm5JYkpkZS8ySE1xOUptWk1qUHI4YThkd1Jh?=
 =?utf-8?B?ejQvS3hsZ3RYbDlDbk5SckZQUFZGa3pZbExLV0JnbTdWWVprQmZ5eS92bnFH?=
 =?utf-8?B?ZmJyR3ZJR01nbEJ3aWNydTdPV1ZNZzlwUXQrbEZBY3F1amNTR1VLUDZReUx5?=
 =?utf-8?B?QjRjZThuUFJEbG1ZTURwdk5kSHU0V2ZiR2NOcHlsZUZ0MCtCeG5mYVRzVXhj?=
 =?utf-8?B?MUlUeVU1ZysvLzJUTHQ2SThzbHlLYXhHa0xxN1NaV3hIelRhNFk5YklUMG9E?=
 =?utf-8?B?NUFOblBVa2pWY21PM3RROUNlc0R0by9CZy81SE0rRjBFZjNmUURhb1FnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2759.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGlvWCtZTDhoWURmeFBCN0lGdkV2cVRoZi8vcFNZV2U0SThJanB6WjdhSGxv?=
 =?utf-8?B?dWRxOWp4WDhwVjV4Z21KV0ZxaUUwWlBUdjhjUW1TbEViNW5qS1NlbWtrcVFW?=
 =?utf-8?B?NU83UVBHQllKQThwWEZCTXZta094N2dVUm5xYmxvNUVCdWJhaExQemRwaDBQ?=
 =?utf-8?B?SnlzdVBzYXV0c05OQTB3Z2FPWk5JR3J4WGVEVFB0cDZ2RmNGQUh3NVJQanZ1?=
 =?utf-8?B?OXAyN3RIZXdKZzFKZGVZSGRjOUQyK1VWTCtJaWJkNEErR2RZcDcxaVhnOTcv?=
 =?utf-8?B?c0xEUDlpUTdybTBndGI2ZXI0RUpwajhoRU9yRFdzdEV4T3BhelpCaG1LbXpV?=
 =?utf-8?B?ZUNCNVJnaXlWTkQwZ2V3YU9pSDZUSUtRL1NXSERBcFJIUFlYN3ZERVVFUzRu?=
 =?utf-8?B?VThIR05sMGdwNTdTUHNwYkpKcDNqNnZYQWVLOVBNeXdYVUZZNEVicFJOY1Zj?=
 =?utf-8?B?NVg5QitlNGRXUHFWZVJWRXJsOHlLRHp4bklhR3hkRTZEK1dZTmtjTUhaSEM4?=
 =?utf-8?B?Y0xnUDV6a2hNMmlaV0w1Y1IxMkFObjR3a2kzcWU2K1pLV0hxNU1XWHowL201?=
 =?utf-8?B?Y2VjWExGd2J3VFJNZG9Jbldqdi8wOTAweDNCUFhvQnE2eWlPczZ2aHI4dmRO?=
 =?utf-8?B?bzRHR3lNbkNSbVZ0TUVaL2JwZGhyKzg2NDRscFhMUitFU014WElSZUNDWUVy?=
 =?utf-8?B?UE82aVUrV2hVSmpCd3pMNkJFWDEwcTB1NEpMazVEVlJpVlUrOWNJR3NES2FI?=
 =?utf-8?B?MjFRN1FlRTgzQlVvWWk2aEIxMmUzVW1GSDdvdkVlUEE4Z0lFajFCbDlQVWZi?=
 =?utf-8?B?UlYvbVBLUTlPQzJQWjQ1YlpOV3lLV1NmRXUwNUZ6dEFEaC9kQVZXTlY1TkRt?=
 =?utf-8?B?TFFaWVVkS1ZKd2gwVVZPc3hzb2EraDNPUlBlZko0YkVvVEtHR2h2eFlkM3dT?=
 =?utf-8?B?U29HelB6OWpFcXFlOGpncEhUQ2d6cUZRckJIVjlEU0ZyWEo3aHNreUt0SUFB?=
 =?utf-8?B?QVlkSWZ0alJyQ1hOeXJpNE9YMEpISFlwZGw2Q0FtSE5rQzZNZDBBZU9ZdXk1?=
 =?utf-8?B?Wlp1Sk9yVGJUY2hkT1ZDellyMjVSenF4T2RUZEZlOS9VNWxodFpHdG1mdEFi?=
 =?utf-8?B?NUJpVCt1Y0x2L1RSZysrWU53NjRrMFVQM1ZrTTBETmgrQU9iV2lGaTB3cTFt?=
 =?utf-8?B?eDQ2eFc5V01Ub3RuVFMySkNsV2MzKzdxNzM1Q0ZHbU9kTEdRU0g5clNWOGF4?=
 =?utf-8?B?aUhMNjF1NHIvNTJuTnU0Z1V0TFlUOVYxL0hySU9FRTlmZEtqcTQ3bFB0bEt0?=
 =?utf-8?B?OHN2TzY1cTNQOUtXNjVjNjdjMjFzNGYxVzFZSzNTeE56S1ZHRG1XQTJLYjJy?=
 =?utf-8?B?UFdZUllzUTZ5K0liMTUrL1FDbVdjcXVPYUlrNUdvMDQ3OUtNMDJmSmh1bkVu?=
 =?utf-8?B?VTY3N1RHeUZObFdxVjFLMDBxaXAySUxPMUltMWpCYVAwNnc0QjM5NVNYNU5o?=
 =?utf-8?B?TVFoekE5Q05GaWRRL2RicmhZeWVHUU5RTUhRUUsxNjYrU2Q5bFc4dHBpbVhv?=
 =?utf-8?B?ckRQNWNaa0VwcWZOWjVMRHpudHViQTcvZmxON09lS2RFbUZtdlBxYmlnM3Jw?=
 =?utf-8?B?VmV3ZGpnT2xRbDd3WmVCL0J3QzJYTWNXZ2N0bUlSVkEvMGQ0QXp3ZUJScThN?=
 =?utf-8?B?RFMwSFNWaWlsZ25SUTBYY0ZCU2tROEw5V3NYMG5TcjV1VU1WWEt2VmxCK1Fa?=
 =?utf-8?B?cWtScno5Uk8xbzZXVlU5cWErNUJmbFhnMmYzL1N5cHFsNGQyanhVZXNFMytz?=
 =?utf-8?B?ajVDWFpWMTJ4dWtCVjRLSzB4WEprRW1qK1FQY1YzUmYrYnJJWUtDQ0wyWU9M?=
 =?utf-8?B?Y3BQczArWDVhanBrRDZwMVhCUU9NS3dkNXAyMlQ1bDMvNUJ2RFVVU3VoOUVx?=
 =?utf-8?B?cmFXZWt1UWlkUk4ydFJSQ2hLazF4WUZPTXdDaEo1RThUNnJRSVdEMjFMcXN0?=
 =?utf-8?B?R0RiOGorY1FPOUlPcnAwUEIxUUJ4U2RZUXdtWEpySXAzT2ZzR3N1Q2VwQmpv?=
 =?utf-8?B?Tk9ybmdiTWhNZDMweml3S2Y2TVhJeE5qeDRvcWF3VTRWZm01R1N6RWdzenhj?=
 =?utf-8?Q?KnaVNVYEKdRkvK7hSOKMq6EPe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a971990a-a5a4-40bf-9eed-08dc8be421ce
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 20:05:11.7180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goMpuTxqeWpwITYJuJSesQVNYvQhmYl1aLYtogMjCV00wu/auj8AuYnYC27Q2QmU9AVB9Q5Uwh8ylbBhenRJbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543

Hello Ard,

On 6/12/2024 8:56 AM, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The logic in __efi_memmap_init() is shared between two different
> execution flows:
> - mapping the EFI memory map early or late into the kernel VA space, so
>   that its entries can be accessed;
> - cloning the EFI memory map in order to insert new entries that are
>   created as a result of creating a memory reservation
>   (efi_arch_mem_reserve())
>
> In the former case, the underlying memory containing the kernel's view
> of the EFI memory map (which may be heavily modified by the kernel
> itself on x86) is not modified at all, and the only thing that changes
> is the virtual mapping of this memory, which is different between early
> and late boot.
>
> In the latter case, an entirely new allocation is created that carries a
> new, updated version of the kernel's view of the EFI memory map. When
> installing this new version, the old version will no longer be
> referenced, and if the memory was allocated by the kernel, it will leak
> unless it gets freed.
>
> The logic that implements this freeing currently lives on the code path
> that is shared between these two use cases, but it should only apply to
> the latter. So move it to the correct spot.
>
> While at it, move __efi_memmap_free() into its only caller, and drop the
> dummy definition for non-x86 architectures, as that is no longer needed.
>
> Cc: Ashish Kalra <Ashish.Kalra@amd.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Fixes: f0ef6523475f ("efi: Fix efi_memmap_alloc() leaks")
> Link: https://lore.kernel.org/all/36ad5079-4326-45ed-85f6-928ff76483d3@amd.com
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v3:
> - don't move __efi_memmap_free() into what turned out not to be its only
>   caller
> - drop another CPP #define related to the dummy definition
>
> v2:
> - free old memory map only after installing the new one succeeded
> - move __efi_memmap_free() into its only caller
> - drop obsolete dummy declaration from generic code
>
>  arch/x86/include/asm/efi.h     |  1 -
>  arch/x86/platform/efi/memmap.c | 12 +++++++++++-
>  drivers/firmware/efi/memmap.c  |  9 ---------
>  3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 1dc600fa3ba5..481096177500 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -401,7 +401,6 @@ extern int __init efi_memmap_alloc(unsigned int num_entries,
>  				   struct efi_memory_map_data *data);
>  extern void __efi_memmap_free(u64 phys, unsigned long size,
>  			      unsigned long flags);
> -#define __efi_memmap_free __efi_memmap_free
>  
>  extern int __init efi_memmap_install(struct efi_memory_map_data *data);
>  extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
> diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
> index 4ef20b49eb5e..6ed1935504b9 100644
> --- a/arch/x86/platform/efi/memmap.c
> +++ b/arch/x86/platform/efi/memmap.c
> @@ -92,12 +92,22 @@ int __init efi_memmap_alloc(unsigned int num_entries,
>   */
>  int __init efi_memmap_install(struct efi_memory_map_data *data)
>  {
> +	unsigned long size = efi.memmap.desc_size * efi.memmap.nr_map;
> +	unsigned long flags = efi.memmap.flags;
> +	u64 phys = efi.memmap.phys_map;
> +	int ret;
> +
>  	efi_memmap_unmap();
>  
>  	if (efi_enabled(EFI_PARAVIRT))
>  		return 0;
>  
> -	return __efi_memmap_init(data);
> +	ret = __efi_memmap_init(data);
> +	if (ret)
> +		return ret;
> +
> +	__efi_memmap_free(phys, size, flags);
> +	return 0;
>  }
>  
>  /**
> diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> index 3365944f7965..34109fd86c55 100644
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -15,10 +15,6 @@
>  #include <asm/early_ioremap.h>
>  #include <asm/efi.h>
>  
> -#ifndef __efi_memmap_free
> -#define __efi_memmap_free(phys, size, flags) do { } while (0)
> -#endif
> -
>  /**
>   * __efi_memmap_init - Common code for mapping the EFI memory map
>   * @data: EFI memory map data
> @@ -51,11 +47,6 @@ int __init __efi_memmap_init(struct efi_memory_map_data *data)
>  		return -ENOMEM;
>  	}
>  
> -	if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
> -		__efi_memmap_free(efi.memmap.phys_map,
> -				  efi.memmap.desc_size * efi.memmap.nr_map,
> -				  efi.memmap.flags);
> -
>  	map.phys_map = data->phys_map;
>  	map.nr_map = data->size / data->desc_size;
>  	map.map_end = map.map + data->size;

Tested this patch with SNP guest kexec and i do not observe EFI memory map corruption with SNP guest kexec with this patch applied.

I have another question related to the discussion on the following email thread:

Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec - Dave Young (kernel.org) <https://lore.kernel.org/all/CALu+AoQ2jNjb+5MZfFtpT_Y=2gJRWwqEeWTpQkwNt0-U5fpO_w@mail.gmail.com/><https://lore.kernel.org/all/CALu+AoQ2jNjb+5MZfFtpT_Y=2gJRWwqEeWTpQkwNt0-U5fpO_w@mail.gmail.com/>

Do we still want to create another patch for skipping efi_arch_mem_reserve() when the EFI_MEMORY_RUNTIME bit was set already ?

Tested-by: Ashish Kalra <Ashish.Kalra@amd.com>


