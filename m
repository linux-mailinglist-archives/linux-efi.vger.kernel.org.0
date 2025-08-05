Return-Path: <linux-efi+bounces-4517-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E879B1BA59
	for <lists+linux-efi@lfdr.de>; Tue,  5 Aug 2025 20:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5843AFB2D
	for <lists+linux-efi@lfdr.de>; Tue,  5 Aug 2025 18:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE70298CDE;
	Tue,  5 Aug 2025 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Ljkobn0i"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2105.outbound.protection.outlook.com [40.107.236.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5819E98C;
	Tue,  5 Aug 2025 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419187; cv=fail; b=i+bN1tK7pZEHXvWY7CGIA/tHMYvNlLQjuzv5QAtSR3BrHkYMAW3l5VBmLTwvyk3IEHSGa+p2/SisaUEs06rB4fIQ4Xawh1fs5WgLloApvWRGu8jrqAjbqOD9NB6RXI3d+GfsQqS8cKsgOGJp4MnRD9+LHsePBMMoZdPSBPLOogQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419187; c=relaxed/simple;
	bh=/hZ7wIXX34kSVnDZzQxlfvQFV3eqo5eNip0uNdl3gUM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ohAWfMsGzWf9ZlM/CBpDEF9WNWeoBl2pgZ7NS0Wd1VvgCVS3DnLoHzlrm0+QkpCeCaMm7NyyMtB25ikmDaYQ7b9KwmnwKmI5cMM8ArNy3E6YtnmpX434sE+cJyFvJlwAvW3xO4TmjU8j4nJ2kGES0Mj6wyn9wC+N507o0mYCGcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Ljkobn0i; arc=fail smtp.client-ip=40.107.236.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWWgA++TfUohtLNUMvCdK01AEJFW8kkJf7vzZcFL9amyCdGhB2gbX1QYOkaJa7xoK3jzrM6WX/q4lOaaS8yvpS3ckXWnAIAZ9Znc/eQw8aHhOPsTWUlCZt6UEzoVlAPaVSsHwgQ/D74oqEQHYNHbMGW8DB3m+2fNn3xPx+danGV+sNTEiaOeIamZpolKkdH3CFH136y8yUVUguuQyulOnm/PXkB7gGKNhT+JW/iuv+7sH53wg4pegyU8egMPylEi9bcR8MtSTNUvqRTmKG662C9UBlqqz5CU+PkBTItY/2UdU2jKzthR+NuiF5DcDPncHG+07NFeaZTHsPTNdGYI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hZ7wIXX34kSVnDZzQxlfvQFV3eqo5eNip0uNdl3gUM=;
 b=LxA1t6OGg8RHfgCascABCH8q9Y3byMZ822rgkI/6eRi4R1G+LJhDSu7lej0ahrSxwDrQ2wL3CWvdDLdRjagHIYmRjxM0jucZ6MId5PrqAut/a0FRH0o7PHFXEDnn/13xH45hrqJhVPf+eHt6CKJyKCweJdlLBc6qrYBp1RutbiUYg/OXg7Ofhd+uL3esMO4LdicYu5R2E1WcEhWY9h68FfPQf9HJX2CkEGmnigspw6BUPP5zc3mJHb3Bb1v8K9BMNx213BGpNV1dvFgAx6u0o2s++rtxK4K0oJf5yF3JXcCmE+WUwlB/Wkvz/WrOWs4ASrSDkjI1PBHzhyEWSOhL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hZ7wIXX34kSVnDZzQxlfvQFV3eqo5eNip0uNdl3gUM=;
 b=Ljkobn0ifG6Asw6Q8fnTdcJTrpP8flQuEgCi9IA2g4iFVaw6EqrbOMjTNx3Lymqz/GOLJzbsbXR9mHaiVkPYLGcnUeBlZmlVOEbgD3dcI2Ts3FW56PLQzyq9PNv3pVHgMyCo/SXxfvX19+Po5nIh/NWfvUBk7YKpZv7BXgq+upo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 DS7PR01MB9119.prod.exchangelabs.com (2603:10b6:8:252::10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.16; Tue, 5 Aug 2025 18:39:42 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 18:39:42 +0000
Message-ID: <385eca9a-0366-4f3a-95cf-6f19101957ea@os.amperecomputing.com>
Date: Tue, 5 Aug 2025 11:39:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Fix issues with ARM Processor CPER records
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-edac@vger.kernel.org,
 Jason Tian <jason@os.amperecomputing.com>,
 Shengwei Luo <luoshengwei@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>
References: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
Content-Language: en-US
From: Daniel Ferguson <danielf@os.amperecomputing.com>
In-Reply-To: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0161.namprd04.prod.outlook.com
 (2603:10b6:303:85::16) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|DS7PR01MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ec4dfd-de53-4091-5fe4-08ddd44f7126
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDVodlJNaUZyRlduUWJIeWpWQithOVAveU0zOHcyZVRmWk5tOEJoZUZSV1V1?=
 =?utf-8?B?cHhYOTgvaWYxbFVobVB6ZWdScjFDZWVSb2NCZzZxb0RyMU9xdVpWSnBveUxF?=
 =?utf-8?B?azZTdVExSCt5YzU0Q0Z6RjVCZFlLK3pIMHlvT2lTNjZLaGFrTFBjbnlNZ0Iw?=
 =?utf-8?B?SkpCcEx2akhwWGxCcU1xbDYrREN3Wk4yNmlhREFVWTdZMUxTbHFTK2hIRFJT?=
 =?utf-8?B?L212Qk41VUFMR1g2Q0RaQWZXVjh1NjVTQkRmVHk3RGhDck9NaDlDYlJSWXZZ?=
 =?utf-8?B?bkFNUjV1VkdmVWphQWE1TmUzdnhQQmJnSFJWbHVLeGUxRWRLQ05raC8zVDR2?=
 =?utf-8?B?T3pPN0VZNHo4alhKdDRvVmZERlNaYTg5MjlwWGd5bTJjdkpIMVlvNzBYWXJu?=
 =?utf-8?B?ZjRYMWRqVXYwRG1WY2VHM0NKNEF4dnNvdlBTdXdPa01XV3V1SUJJZTVWYzdS?=
 =?utf-8?B?UnlNLzRQOXFraFBaYTBGWnNOYk40UmpQdEFETSs0SmR3aStkNGRVdXA1TlRF?=
 =?utf-8?B?RHFBZkxwUXAvem5QQlF1SXR6NnhVbGNKa1hpU2NuanVWbGszVDRuOHNVc3dF?=
 =?utf-8?B?T1FxYVVCQXpMUUtuOWwrdkZxZDdkWnhYTWNkS2ZqV1NweVp1bGdzN3BtR0k2?=
 =?utf-8?B?b2t5cXAvN1o0RHQ5L1BzdXo3SDhFMWxrQUZxSHBUNytXNE5aOFlGSlY1cG40?=
 =?utf-8?B?YUNPS0xkandleExVL1FMbDhIUnVRdEdTQUk4MDd1VWtjcmh3a3BlMjhsVVFs?=
 =?utf-8?B?dHB3bGlBeUppbXZ4Vk1kd05UeGdRQjNUNk8vSW1VUFNkQTFwcEVkSWxBRXl5?=
 =?utf-8?B?WGIwWjR1bmxkNS9vajJiTzc5RE1GalZ5c0trcHpmb3hBa0tPcXg4RERJVWg0?=
 =?utf-8?B?by8wd2VVdlF1Q3lZNjRCTG8ySDdhSWxiSjg2akdLdkducFlIZmhxZXpHenN5?=
 =?utf-8?B?dmQvRWhvNlZnL0c1cVZoMmtUWVo1SFNrdjJaNTBmSjRuemZncGNaQi9CNUZK?=
 =?utf-8?B?aHltMHNzZFhPeHlZY2Z1Y09SZjNpRTZLay80bS9tdkJLUWIxRFhOVlhYK3Q5?=
 =?utf-8?B?ZUU1UENub3B1bjFGT2RhUTZKUno3VDF1TmdzaGJySWNZMmNsektURGlEQTlw?=
 =?utf-8?B?S2MvUUFTVlovcTNmVGJlRWtuTUFtYWNxY3k5UlU0aEI0K2Z1WmNkZUYvL0lR?=
 =?utf-8?B?c2JMSmhwM1V6dU90RHB0NDZOcU9oVHN0MWhLb1QxU1kzcVk4VmpuTStkREVk?=
 =?utf-8?B?eE5ZRHN1STNMV3NXdlNIREZUOXZIQTVFTWRIclJLcjJUMmNBbWdRZzFQeVNW?=
 =?utf-8?B?TFEwR3BQSTRBcDJjRHBnMFlnS2NwTnhUWUV3M1hGWUp0WXlaR05QS05GdU81?=
 =?utf-8?B?YjhKV2dGcG1maVkwbTdiYlV6dlYwSW5PYlRuV0lMUGpPMDM1WWZuR0YvVDNF?=
 =?utf-8?B?T1E3ejdpS01BWGFMMlVub1NMb3F0R0N5eEpZSVZLNzk5NTBkck9lMlg0Nk43?=
 =?utf-8?B?QXVrK0U1ZEsrRTNGMmVTQitTWVhZRklxaUVQRW5vOU9Id24waHV4em1RVzkx?=
 =?utf-8?B?eUZCVW5rRjNhYmNaamdoYXBCenZheE5PRC9xQzNsRFhjQjBnVnZ2dlNKemRK?=
 =?utf-8?B?NmwzMkFtQ2JWcTVOeklrVU1nUVVCNjBkeGk4bUpWLzJIMmdSaEZGSURweGw0?=
 =?utf-8?B?SGZMVnUzSm1abnhReWZrL0wzWThoSERyQ2swZUlOUlZhVG4reXlMNkIzVGsr?=
 =?utf-8?B?dGRhTThldHZGZ2FmS2dsZjRNWng0NUpDdnBUd3lhdXkzZmxVdGlQMHBTYTJu?=
 =?utf-8?B?TlVud2xOQyt4bG5zckJiQk5hN0RTNmtydU9SOEhuU0UwUnRHc1REc1QrK0Z6?=
 =?utf-8?B?UFB4R1BYWDAwUWhHaWFLLzJGVW1HMENLK2dPeVVRcmFGQWdldmxVdFRnSTFk?=
 =?utf-8?B?eDd2Ymw3S2J0VGVLWWRVbG8xby9kelcyNVYrVzhWbnJMTTFKRW9FYlZRN0tL?=
 =?utf-8?B?Z3V1dzQrbFJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWoxcnZ3c3ZLajVUbHVsdUFUOWVDWU5Id2ZHdVZFOFZzdEFYOFBCRjFCTlJs?=
 =?utf-8?B?cG9kcVQvUDFJQ3EzdDgvN1F3L0hXQmJ4bGtDTVZJdWNzYm9Sb1RIK1B4djNX?=
 =?utf-8?B?L0ZTNFNyb29ZN3ZEZUZtcEhOS0NkcU9pRzd0TkhhUm5sR3lCc21IcW5IRHRw?=
 =?utf-8?B?NU5BNjF0S1l1STA2TFVwc1hHeVVqTDRJRnB5S0ZwMm0zUEFsRERBejc1d1Z6?=
 =?utf-8?B?V0Y3dmZjZThmcC8vMndVNXVCM0FOdXZVOUlOTHBpd1RKRVFCYzlMWSs5SXhZ?=
 =?utf-8?B?cFRPclFzdVZOdWUxMkZZL1NzR0JPQlBvRWw2ZHk2d25zb1lxc3ZYbjFXaE5W?=
 =?utf-8?B?S1QyY3VqSW1Ka2hSRmlia2g0Mk9va0E1dkVTTU4zMTJpL3N5VGp3S0MzK25P?=
 =?utf-8?B?QTlMTnRGb1pXVGJXc3FCYWY2ZVNGVk1MaWFuY2cwZTlTWGlMM2Vab3ZucVVw?=
 =?utf-8?B?eUlLazNNYlVGblFzZWg2L0pVVGVuY2Vpb1VIamplMUswbk41dWNHQWljU0dC?=
 =?utf-8?B?SHNyOVdUVUsrNEt6R0VYazFEYUxtNHJSaVgzTzYrVVFqaVc2aUM1T0FUZ2tH?=
 =?utf-8?B?bEhKWFlnWkxpdXR4S2xjb0xwMWpYa1VzSEwyNWlKVndrcW5tVFU3UjM2ZlMz?=
 =?utf-8?B?cFlLNE5QemJLUlBoMmlid2JsUm00SDdaaFpac0o4T1lOMWxNWml3YlM4djJX?=
 =?utf-8?B?MnUxbmZlK2RCSUg4Q2tFQjI4QXJsenF1UUhkZWx3bEZZa3pkNm50aUE4dkJR?=
 =?utf-8?B?S2xqWlJEUm40NitWMFZPS3JtSC9OSmpLUEhnNzh6THdBNVJ4NTMzRDF0L0hU?=
 =?utf-8?B?cEJtcStOc0JKOE1Hc25zVmtOc1VFekIraS83S25wVzRRVHE2OXJIQ2M1Z2xj?=
 =?utf-8?B?RFQrZ25TbnAxak02RnA3TU5uWSsvb2NzVVZNOUozYXlYRnI2NGs1OGpnTjFV?=
 =?utf-8?B?UE1vNDV1dW16V1lUaTNUdkxMMko1U01GTy9FQ1ZSLytacTJLTEJLUmFGR1Bw?=
 =?utf-8?B?VGtQVy9WVURZSnZxU3h1TnBPQlNsMWlOT01nTEQvaURyREtvVW9uQk1QRVlF?=
 =?utf-8?B?ZzF4bEliNTZyajFkU1NKcjdoa09xcHcwMlVlWFJYQTVkaVVqWlVQMVZMYk1F?=
 =?utf-8?B?SXZIZEFFcEpmZ2loSmpiV3F1Q2xaUzQ4RFFsYmxHWVBmOTFNZGg0d1lub3BO?=
 =?utf-8?B?OCtMZ3JtTDY1TGJ1NVoyc0ZPbUd1SS9YWmc1QnhieTMwV2t6MFlGQlE2bjBi?=
 =?utf-8?B?cURHV2pGOFVCZTVMRE4wcVQrclpYeE9zeVV4TzVwakJDMHAyd0Z2Nk11c2Yz?=
 =?utf-8?B?NlczOVk4dTkrTGNnemJ5dG1qYmpFTlJMc0l3aERSRm9lOUhibndqUVcyRkxO?=
 =?utf-8?B?bEhuaTZobHRqNThyOVRaRlZ0NUxSSGtGUmxvOXhnWnVoYzlIRVJRNzdETmhW?=
 =?utf-8?B?S3JTdFJFZnRHQ3hCNExEYzNWQ3g0eW94SkF2cGpIMENhSXlXaTNlOG81a0NF?=
 =?utf-8?B?YzY4RjdFS2JWNjFiRHRXeVBuQktGQ2dBaVQ2UktUdVVhbEhWRjhCOEQ5R3Fi?=
 =?utf-8?B?RzY4WXBiNE9YVHkvNC9PNjZRSkJGbThEcXR0a21tSkozOXJ6Z2o0WGFtOGdJ?=
 =?utf-8?B?am9wb04xT1V5Sm96Z3kraDllS1JFZk9qS01tQ2d0ZFBEL1ZtSzBaZ1FYMDJh?=
 =?utf-8?B?RzB4YVIwcjQ2L1JQakMxdlBtSTZsUjgxRmhWbHhzVEZ5U0V2UFlJdkhvUCtx?=
 =?utf-8?B?YnVrejM4M2xpWEphbTg3N2lqWDF0TGVscFdWcC9sTm5HdVdwMSt2RWV6TmdY?=
 =?utf-8?B?VUF1aVhoY0tNYkVWc0o0K1NVYmFoMmZENkxIYkJtSXhEa3g4TnV0UUhJOE5N?=
 =?utf-8?B?UmNJSFBYUDRVYmxVQTQyTU9UeENVZDB5VHV3QVNKa2NVZ1RuWnZFRmdUc1Fz?=
 =?utf-8?B?MEpkY3ptWUk2SnJWOEhDaU5vZVUwUVJnMkpFWWRtS0lNaEh5bWtvNmh6UU8v?=
 =?utf-8?B?Y29XYWMyUnRPanJWNWkxOHBxc3A0S1lKcmZBYTN5K0VaVFEvd3ovZWYxV0ow?=
 =?utf-8?B?VWtldlF1eUlUdnFrUWFNcGd4b0NEL25nK2RudnlMd0ZYUnprMDFvUWZyWGJx?=
 =?utf-8?B?RXNSeWw0QUVZSVZJcVJFaW53a0VrYWJUdjh2cWJrVG5veWgrbVhna21NVm1V?=
 =?utf-8?Q?vbRAH2rVECpbJ/qsv+QxiZk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ec4dfd-de53-4091-5fe4-08ddd44f7126
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:39:42.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rcOEuO2q84aFlg6myCNuifCOuV1lZL6gCkmTjcKzIlCkvgpTwtz5IbExJWBIM2nqUNizaCOKUUnm/U+c5NF2Icplhgxy/ZaPpa1D4t7ZbCehcPEu9IriwGGGpxl9AaQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB9119

On 8/5/2025 11:35 AM, Daniel Ferguson wrote:
> [NO NEED FOR INTERNAL REVIEW, THIS IS JUST A TEST]

Yes, PLEASE REVIEW...
I accidentally left that message in...

~Daniel

