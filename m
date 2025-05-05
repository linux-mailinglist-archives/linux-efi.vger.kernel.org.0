Return-Path: <linux-efi+bounces-3595-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1032DAA96B7
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 17:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2C817CACA
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF10B24DFFE;
	Mon,  5 May 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rQnIveOs"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318A25A2C6;
	Mon,  5 May 2025 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457105; cv=fail; b=koKFhdygA7aPJf4T2wjy8DlV5EA9b2EuaU2dccM04T+4IEBkA8DX/p4G1H76EZDIyhjFoWDq1flWgfLkmYDNdpBJTbsfnYoMpn22nnDHpWXqFOVLPg+L2218vbH+GGldkbSA1DZ6FhntirO3wIAMp3EyP3bUYA+z/uSbzB95Y8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457105; c=relaxed/simple;
	bh=3rtfCgOXOJxd4E59/YnFZ4siKkY5nuskzGCIQjPTXg4=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=VmpaqAxR9b7hrG8kX38sFc+2kVSzG9XGW4jRWHg3QT/fd/kRQ7/RX4d61fGH+pInDeA02Y9MEhtoNvxrncCbWtqhams97soXUqIxQPlM4+JgupH/rEAocjttqlmLuNVTMefzCnXJam3Cho69euYQgVEFqbttHUZ1IB+vRX0oyYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rQnIveOs; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5xU0+XXac1uAcdsUqBJ8aWN6O89odyHxPktJAWmBgsWTx0z4AyaI5M6aI7wQNbdDBb+KPaODqDMo7zDFequdE+ZmvMOipIskfO/wLBq7zydBL7/GXcvJPYh+pbfidmpO7+h/JGHAMGb0GiUwykPuneTxw+Y6CIJT+SmMHHudBvY275VSSPGCfQktTUg3PqOno/ugRsBOE+dfK7V/3JYb7bJohP1NvOsbgDx8BpDlP8bJJZcvlin5bQh0aRuyAjeFAJohjC0Hd2bPFdyX/x4M3MCk+0s1oa3xe8JhwPWtcBG0A5eubzIkPHKvGTrAJxLacpAUmrhSrBKrxXCZZgsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJSDZSnEJZRkXUAsKPl3njBtRABb9pDue7J1tR7FA8w=;
 b=McWSUL3WIB+u37Q5kmCGrIibNGAyiAhFezdHLunSSa7PRU4eFV5t4/opA+I1jzyRCW9zUMeGZsA4xeXAamPdKhmppc8GQJvPkDyyGNRrVNPhw2HoIEKjrdMEj9KhvrrFquZA/g1UjsNvA5mZ7vVlAGECUvJokaXXM78qIJb8e8phccnJxmPqoMfIYiL/63Om6KwM+g06mNvmM0dEJCv67sgSCK6MwQGNpYkXun17aND6+tuEGjNxWP5iVAWvrbklHu5FyL5iLBEimnJcURaklByDfOpetdr/bn72b2Z2snQjZl5ZvCpFaSkyjuaf1NWREltM3M/nzM//7VPWqPplxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJSDZSnEJZRkXUAsKPl3njBtRABb9pDue7J1tR7FA8w=;
 b=rQnIveOsChmBq7bSXFQF+lxWE0fvoQYKKN7dPWlqzponxmAfMHo0VLfG/zC6dz0GuiNtZMR7cvWEm2QrAMHz4cUs/OulO0MoXP5+UYBRMz5kvF+e+qJLzRcehVnnbfGAWVybPmnEJ6pBDe7MUCWlYcvRbvmUh5kbuEFV6GVZs0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6)
 by CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 14:58:21 +0000
Received: from BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a]) by BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a%3]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:58:21 +0000
Message-ID: <f4750413-a2e6-15c4-7fa5-2595b509500b@amd.com>
Date: Mon, 5 May 2025 09:58:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250504095230.2932860-31-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v2 06/23] x86/sev: Disentangle #VC handling code from
 startup code
In-Reply-To: <20250504095230.2932860-31-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0110.namprd04.prod.outlook.com
 (2603:10b6:806:122::25) To BL1PR12MB5062.namprd12.prod.outlook.com
 (2603:10b6:208:313::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:EE_|CY8PR12MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 0583d86b-cdbd-4a43-69ac-08dd8be546c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NklOTlI1RUJhZ0hZSE4waWh0VWdKeFdhaVdNKy9rTmR4TVIvcnRnTUJXWEhy?=
 =?utf-8?B?dzM3d2RtT2UvNk1zcTEwVTFRN1FVYTg3c05ualQxTm1CMG4yMmV4cHpGMFk5?=
 =?utf-8?B?VDRjNGJhZFl3K2U3b2dMQUtKV1JnR3hTN3ljaWZmQ3NxRXkrY3Boa0s4ai85?=
 =?utf-8?B?Vkk3NWNtOTVGa1hSZFJuT2xOTXRCeUM1bHZIU2xIazNEakpOeEV3YlpvSCtB?=
 =?utf-8?B?S2p6UzZ4K2tYUTdVTndid3B0bFhqRTlweWR6RkFzYS8wMldIQ3BMejZxSVRH?=
 =?utf-8?B?TWNkbFFLeVBJeGNES2NPTDZQeDJ5b2srTHpaUjFxclFlVDUwZTR1TjNWVzQv?=
 =?utf-8?B?UkJ6eGt6VHFsQVRtZzUybzlrMFkwOUJOTDhjc0JZNExzSDZKV05QK1FsUzZ5?=
 =?utf-8?B?aldNWDQvbEhOcUR2M1RBZ3dGR0Z4SHcreEhkUFcrSXkvMnpHTmYyTmozZzEv?=
 =?utf-8?B?NWNwSm1qSnNIdUFVUW5QSmljVktQRU5pQVNLMng1YkVDbFZScjNOZUhKdHRl?=
 =?utf-8?B?cVM3Sm9sVkVvK0ZXeUxxRjJzYS94WW16TWxidXlrSDNRSDlkRmZlZlREeWlL?=
 =?utf-8?B?eEFQRkh1N3RZc2R2dExuNThSc09FVmpSNThWbTl6UG16dHh6aDh3VXY5azJi?=
 =?utf-8?B?cDFHd2FZVHZ5NDNiQ2QvcFFEVkJ6K2dNUU84cldTdndXWjgyaElha3dGaVBa?=
 =?utf-8?B?cnpBM0pRREVNSHNxMVVNcE1CWjhsQitVQTExNDhZVjZub3F4MzBVUi9FMUc1?=
 =?utf-8?B?YXM0aVd2MTNLeVE3SG1JNlQrdklEL2QxRjUyTWdiNXpZcEh3eXNRbnVFVGNP?=
 =?utf-8?B?WHU3b1ZwZ0c0YlM2SnFldFdJaGVjWVpoMUYxeDY4cGNYTTYvVkt4QVZEQXE0?=
 =?utf-8?B?elA5eUtFbk1LUzAzOWg1YTFDMmMvZngrZnZkb3FZdjJDT1ZpY2pWQzJhQU9Q?=
 =?utf-8?B?U0s5TXVWTjQ5UkhsazQxSUIrM2Z3T0hoTDY2T1l6MkhtaE55U3lrKzQzSVN3?=
 =?utf-8?B?WEpKcjZpaDh2UkZHYy9adTI5dCsrWFRWTENWMVJreVZNWDB5Tmt2MGN1NjE1?=
 =?utf-8?B?NWpsOFRZNXBZdHBxRUNITFphZ3hDVjVKYzV6am1HaURaZGFSYzUrZ1FoL0pT?=
 =?utf-8?B?bi9va2xxR3owSms3N05aQXU2Qk1DeklQSkR3YW5nWC9zTXBkV1gwdStPZ1Np?=
 =?utf-8?B?Lzd3VmhGQzRuOWdkRGxOSU8xYzQzSE5aRnpUMUZLMTQwRGxHckNCMElOUWY2?=
 =?utf-8?B?STNoT2dtNnNYL283ZkZSaThKc2pPeDA1NGxtdlNXa0VzRzFVOVdTWWVWTm5Z?=
 =?utf-8?B?TjFCZ2V5RXdTRHVCSjdMbVNEOHB0OFAzZ3pVNjFyVnI4VE1LVDdNZktMVno2?=
 =?utf-8?B?UDJoWnk4c3hzMnhiZUQ1RjgyWUgyOTBZdDFlYlk4dU9PQVd2YktWZUttaEVB?=
 =?utf-8?B?UDdFaDFXdnNFcDIrZVJ2RlFrLzc0d2F2TkFScUE2czF1WGdHdHNFb3FFYTJZ?=
 =?utf-8?B?eDFockhqdS90VXhJbHdXbEdmLzhMUldkVHJsNzlaeFhEd3Z0bmhwbVVHaXhk?=
 =?utf-8?B?REhBWEdtankvZi8xVUJub2JzR2o3UncwWWRBODRsVXFKeHlQV3JrUkJLeUdt?=
 =?utf-8?B?OHZNQkVjcjk0QXNmbTdwUkVYb2Ird0oySjczTHBTVEVlc0tXWWl1VElrOTdh?=
 =?utf-8?B?REJQNC9oVkF4aWNXTmg4M3BXYk90cVBpbnpxMW1mVnV1QjNQZTFVc1Axbisx?=
 =?utf-8?B?WlFJcVl5RUVORGk0aUQ3cWlrcVpEcEN3WWFiK2NpZ3VwSnpmcXE4VUhVM0Fw?=
 =?utf-8?B?dlowWVUvbXFZeEt6VkZkcHYreGMrU1ZKeFBvSzZZamFPWm5Icmt2R0hUcmlm?=
 =?utf-8?B?NVkvS0lSYU93akF5UHJuMVNXdDlqYllhdDVDSlIrSnV4UFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5062.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1dHKzR0K1pwWmp4RzJBalNEa3VkN3lJZnMvdTNGUjJ0bVpHUjlRVExOQ0ox?=
 =?utf-8?B?WFJTY29RaWhvMEM5MDBJRTQ0N2dGM0xUVWxleXI0R3k3MDdhM01MWnVXc2J5?=
 =?utf-8?B?UEk2R1hpRWJ5OHRLa1ZoRVMwanlHRU4zUXRvWXhDK1Zxa1U1V0dqSGlOQ0dn?=
 =?utf-8?B?MjZqTmdMc0RGclBNWnIyU2lzczQxc2M3bERBbnpub3ArbU1CNTlydFZkS1hj?=
 =?utf-8?B?R05Xc1lLWkNOemJXYVUyTEtvY1U4eHZBWENYazVoTWIwN0cxVk4vWXNJZmY2?=
 =?utf-8?B?cUp3T0pqM0dJMExsdEFsSE91b3pPb3J0S1dOSWNKMXI4Zkl2R2lSLyt0Y0lw?=
 =?utf-8?B?UDZWVUVXOVJhNHovVnVhU2xReDIyWHlvVUNmYmI2QmwvRkR3T0d0L0Y1R1Nq?=
 =?utf-8?B?MkM3SGgxalZsU21qb3hTb1hCaC9sNlJ2N0NVQlFaQWxHZkhBSG9NN2htak5m?=
 =?utf-8?B?MXNYSyt4OXNUSEhaYU5yc3FhM3V2YUNNZ3hLNGhVS056UGlRaFNPVmplRXJG?=
 =?utf-8?B?RVV5eW53b2VlSWtSZXFiZ2IxcFNGY0pHM2V1cXZ4MlVaSGhYK3NCdk8rVnYy?=
 =?utf-8?B?UndFVmUxcTlGeC9KTUNUZE5TbXVpd3dlVDNYNHFjeFpHR1hnSGRNZmdKOWc0?=
 =?utf-8?B?WWZ3dGxrQmZpVmFucVkvK2RxZHpqcDNTTzlQSVptazk0SHEvWlU4M1JVT1p6?=
 =?utf-8?B?bVo3V25MQVdhVS8raTFFWWlLdktwUVFNaHhlaGVnM1YrZzdKOE4wcmVBY0FS?=
 =?utf-8?B?dGtDMmFlMDBXY2xnQnJoaFIvWWJQN05hVmRDcGRxMWRlTWZKRWxPYS9ib3RK?=
 =?utf-8?B?QTU0enNtZWdPcFJsQndOWGFxTkt5WDg0aXAyNThvdlczcTVCcERaVE9sOHZI?=
 =?utf-8?B?NmNLd2d0UUJ4THRPTEhBbURYbDI4NnlVYWtLenVoRDk3aTZUc00rcjYrVFRj?=
 =?utf-8?B?cFZJQUo5dHdBYkpXN0FMa3BHdktYTndCcG4xQndlSys5QkIxN2lqMGtIQ28z?=
 =?utf-8?B?U1JSSUlZNkEyOW1tWE84cFpGSlo3amQ5TzVucElyUGNBVXVnc2tBUVNSalVz?=
 =?utf-8?B?N2NTRkMwZVhKMzMxd3BUcEcwWk1ka2pzang2Vlp2RWFKV3pZdS9jeG5NZWdL?=
 =?utf-8?B?RFZBSlRzQXNESHAwbnpDbTNVaVN6TnRsNDRmblc4UmNzZVNpOXluMTNQQkJs?=
 =?utf-8?B?VTBCb3BBTHNKekN1ZHJHYlR5TjQ4NnAyWG5tQ3oxWk5kYVFPQXZKaFZMUmRS?=
 =?utf-8?B?L3lhWnQzcFRGVDByaTE3Um1DU0dPMG51WStRRVFycUYzZG5QUEJpUlJUejdT?=
 =?utf-8?B?NGJOejZaVFZlT0YzMmJGKzN2MDdlSW9lTDREMmZhV2ZuNnhUem1UTWdZMzV5?=
 =?utf-8?B?bFFuMnQ2eXRTdUp0VVFCRkdGdUhNc3pHVXJESHNOdkRnVU93bzN3cDFicDlC?=
 =?utf-8?B?UThEZk5BWmVhMGxSSWpGVWltaTlqMk1lWGpmNk9ObjdBWU1yK3VwV0VGdnkv?=
 =?utf-8?B?ME9MV2QyWHRIOGV3MGFVZWhyN21ORjVpN2RJZ2hvMGpNTkRvckdqQ3V3UEdN?=
 =?utf-8?B?TWt6KzJ4R1ZGanRkdjF0NG1Xam1iVEt1Mm5kdkR5RGthMWFkSWtjWGhqbkdM?=
 =?utf-8?B?aFlZSkVPaTdVekJWelYrSE93NmQyYU1ET29Eb25ycXhqalh5OHA2NHNwNDBv?=
 =?utf-8?B?K0NyVXF3NzdqSThIdXBZTlZvUGFkNGwxNGVPQ1UzTU1qM1p5UkxyT2k2VE05?=
 =?utf-8?B?Y0liWlZLNW9kVnJYODFLZ0cyNlIyTnBzU1Q1TUdtNWRuc3h0a2NZMEtmdVMr?=
 =?utf-8?B?RnkwNnBFa2g3MUwvK1dQWmpiUnFNdUZDMWVyUHFrbjhVcGtEZVBQT3VJRjRX?=
 =?utf-8?B?a2U3VXpCQ3hxUmFSN0RxTWpCNnlqU1h0RXJPRk0yZTFCaXRyWjJqVituTEw5?=
 =?utf-8?B?NTJKMUNJVE5hVTdvajQrYkMyUHFqSUo2VVZVSitPWUJaa2pPVnZCT2VUa3Bv?=
 =?utf-8?B?TVhnRjFUTktoTDE3TytWK3FTWllrNUxaZ3daTTMrNUFsQ2VYMnVxZHlNWHRF?=
 =?utf-8?B?MUZabWtxcnZDQ3ZLV2JHN01KU0ZxcTVWRmJHL3crM2ZjajZtL2RNSjFsMEdy?=
 =?utf-8?Q?wNF7O1EzlIaMKQhcrSqo+80O8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0583d86b-cdbd-4a43-69ac-08dd8be546c7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:58:20.9341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yat0UEPXvy+gnmonSo03d4ozV3ar6690nRllBrykK6B/sZrqYRGbpgAZsOAyVb0DvGw5al+MJoKhPZYiil57qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068

On 5/4/25 04:52, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Most of the SEV support code used to reside in a single C source file
> that was included in two places: the core kernel, and the decompressor.
> 
> The code that is actually shared with the decompressor was moved into a
> separate, shared source file under startup/, on the basis that the
> decompressor also executes from the early 1:1 mapping of memory.
> 
> However, while the elaborate #VC handling and instruction decoding that
> it involves is also performed by the decompressor, it does not actually
> occur in the core kernel at early boot, and therefore, does not need to
> be part of the confined early startup code.
> 
> So split off the #VC handling code and move it back into arch/x86/coco
> where it came from, into another C source file that is included from
> both the decompressor and the core kernel.
> 
> Code movement only - no functional change intended.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/misc.h          |    1 +
>  arch/x86/boot/compressed/sev-handle-vc.c |   83 ++
>  arch/x86/boot/compressed/sev.c           |   96 +-
>  arch/x86/boot/compressed/sev.h           |   19 +
>  arch/x86/boot/startup/sev-shared.c       |  519 +---------
>  arch/x86/boot/startup/sev-startup.c      | 1022 -------------------
>  arch/x86/coco/sev/Makefile               |    2 +-
>  arch/x86/coco/sev/vc-handle.c            | 1061 ++++++++++++++++++++

Probably vc-handler.c would be a better name. And actually the same
format for the compressed file, sev-vc-handler.c, would be nice.

Thanks,
Tom

>  arch/x86/coco/sev/vc-shared.c            |  504 ++++++++++
>  arch/x86/include/asm/sev-internal.h      |    8 -
>  arch/x86/include/asm/sev.h               |   22 +
>  11 files changed, 1694 insertions(+), 1643 deletions(-)
> 

