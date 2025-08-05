Return-Path: <linux-efi+bounces-4516-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B77C1B1BA4D
	for <lists+linux-efi@lfdr.de>; Tue,  5 Aug 2025 20:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF3317B0C90
	for <lists+linux-efi@lfdr.de>; Tue,  5 Aug 2025 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB3229B8C7;
	Tue,  5 Aug 2025 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="AoJvCy/J"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2107.outbound.protection.outlook.com [40.107.236.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854429B78E;
	Tue,  5 Aug 2025 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419034; cv=fail; b=I9FDRDmVgTUFP2baMt0qDDIttbIhfVK7LJBjbSSg51WCzX+2PH+UUE6h5sW1PmZkYvaE3PQ5YcireXuHHRwK5xxBSRpi70oNUmsMTAjWXwuy/GvMGwsxrfDLPPJn+reLNSLxH+EF6ZFfo46j1fKVzjIWZl17RPtHEGfAJFH0sDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419034; c=relaxed/simple;
	bh=VWmmZySvsC0NkQY8VVXYlfvIiROA6vS4HSNzWwgHstY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Kd8FDKbUTqbzfEQkESPADYq13JTJBqg1kptH4SL7hyafNk21qmSun27Zt2iwPHjhfhY60/RQUXhBVyCIDZx9+K6vlQlxSFe9EbM3WuPds1CivNTQtx+m3N0KGjAxOt/O08bk9mRklCFHacZFNlkUhK+zrylkL4+OBDFUj+q18+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=AoJvCy/J; arc=fail smtp.client-ip=40.107.236.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rztQ9Fa9fI5tSX92JyQkqFzLGfharuGQp84MoUbXAUfFLOm2+ZxGyKKIxRkTPc6cQLwBD91jxhlPHEw4S0nvBxED6SoG2Jd+YgPOp/sNKh6dFPCbjX8eBueOJB+sOcmCN8HYx6Stwl8eBF/m2I5gltbIA25XIponxYlazDPTo1Ba5YHdD0pwPPejOsmkhPTA/zv5rGjKA3SRxkrIVC8/Rqr7m4D9ra4VDiZkHEC+EbU6HqKuTkKJfhaVgmtLJ1P4GzRmUZiil1O7kqvYq2Suma1cLelKK9BGJoL7f3ntRul4HPkga7hPz2yZKr/xAkFqZGLQpaE4aW75vybeP48yJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ONZ6VMxeM/i9fNQr6Ks14ia8iihRqfgfE9CGNxrxYY=;
 b=DwoQeaV2+eTdQHO9wWWRa0LYMtqqTPGw7g2V/msPvGQdizItdUmE2HTklqH2j9Bh5hAkzpUEv/zcwzpbehA9uWuiT3HoJtKBJPkOpd45RE0dDUriBGB3GjrbWpLUQwafv6haAG9TkckCVTslxIHpEYwB7JJyiYfOqc6lETOwfQ6biXr0J1t6s4ThHdrDSriP84sI+QOc/+FtKPkeiHgvzhiRlbA48iUC+JRyjE+xfvSklltY7jVPFRCN0+5rnM98uDRl4Es+mQcLSlxiY7DstSVAeWeNRtxXyHvWNdJBJfuOeZY3UQCyc3jEqxcue5bxpnMtOewcAxnD1XyL3LmbDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ONZ6VMxeM/i9fNQr6Ks14ia8iihRqfgfE9CGNxrxYY=;
 b=AoJvCy/J2Lo3lv4s+ODCX5ANsn+dIULqUrjBuG2U0wbiia2jQlX2NhQS6tvmw1nWpdmX6/XDpC0RCVH7dr3FRnqPDD238hNSOjrjsp++GgMwukPt+Dzz5ahV8YPF8i7+Nyu8ZIND5sN+jyZ7mBIjJjNICUvWJ7Ly92rEWlzKiCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 MN0PR01MB7755.prod.exchangelabs.com (2603:10b6:208:37e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Tue, 5 Aug 2025 18:37:07 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 18:37:07 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Tue, 05 Aug 2025 11:35:42 -0700
Subject: [PATCH v4 5/5] docs: efi: add CPER functions to driver-api
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-mauro_v3-v6-16-rev2-v4-5-ea538759841c@os.amperecomputing.com>
References: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
In-Reply-To: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-edac@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: CH0PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:610:74::21) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|MN0PR01MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: fae48010-6245-449c-907f-08ddd44f14f9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N04xeFRHY3Rzd1dvS0tDTjlCTjY2dDZ6K3FkUFA3QXN1Uk9OenpPYktlYUFk?=
 =?utf-8?B?NXdDVnIyS2NXWjMxaW1tQy9sblVmOThJeTIxMmVPTnJKcGxVUG83K0Q0aEly?=
 =?utf-8?B?akVzQkZqYlNEWnFPZGR6ZjJtL3ZRUGo4NUFWbzRpMnlGZnhGWWhXcFN1TVUx?=
 =?utf-8?B?bVF3K0tESkdFcXBwZ0FXcWFaZ1V3RU1IbGl3bzN4WEZ0YVlRbjFmRWRnRElu?=
 =?utf-8?B?YzN0QktFc3EvbXZqemI1SS9BUHpHbk5KVzl2Mk03SVFFWVVQN0VwV1QwOFJw?=
 =?utf-8?B?YmM1Z210NFJLRy9sY3lncHliMXRMR1dNeE02cDNxTkFPZ1ErNFNqeUMxYzNK?=
 =?utf-8?B?OFl5LytzcUpjYkNSSERuNWFCdHorSmdBWnhtYlNlaWs4WXFwREtDTmVaa0lB?=
 =?utf-8?B?Rld5Mkw5Uzd1aXBXa2ZGNEEwenN2NzI3MmNmdmZOd3ZHajFJNFhvN1Z1d2Ny?=
 =?utf-8?B?bFZGY1U3Unp3dm1zOE05MjRZUmpDbEJzby84SVFrVHVScTRVOURMMzRiOEt1?=
 =?utf-8?B?dWM5YkU1ZjZBK1VxK29SL05DZmN1aEN1OFZhdEVlZGd4VEd4OXcyWTZSNzlI?=
 =?utf-8?B?eWpkTUZybVVRUHNpUFB2RkY1YnBrQ2ZsOFNVcEErdjVCV2oxZUFpblljeUtu?=
 =?utf-8?B?TXRINi9RWmpnYU9yZXhYT1JGZWtJUEZudGN1WmJsTzFMcE12RTU3elFsckdl?=
 =?utf-8?B?eWQ3ZUZtUFpjSXo3RFN0eUc0a05uMFpIUGswZXM3U0xPZHJXRnRlZ2xFdStm?=
 =?utf-8?B?a3dtMTFISlFKcXVWdFhwajJYeFhLeGwwaW9FcDNXYzU4ZXhBZHp3dTNzVFFo?=
 =?utf-8?B?L0NGUmpIYzFNdjN4TktUeUEzWHpUTVJJQzY3MGRoa3dVb084a2FSeU5mUzVG?=
 =?utf-8?B?d1FUbktPVUI1MTVFSWRIdnJ5eHh6T1p2Q3JOKzRsQkx1ckdpL2dCTjVQdmpH?=
 =?utf-8?B?TVl6bUtBTEZ6Rk9kNGc1N0svUTdDdWo5NnNGTzJjdTZNVWZ5eUpEKy9IQ1Qz?=
 =?utf-8?B?eC9NQmZpZ0I5QUdoWjNhVW1JOTNkNDNlckNUK0hBSHVDd3IxdS81SzBxbHBr?=
 =?utf-8?B?Z0JnTGNrR0p5THFHWkVuS0l1TFNXNStueGp1U0Z4bkZhRGNsMTRTLytLaGRX?=
 =?utf-8?B?RVFGdlMrL3ZOV0pDbVl1dTZxKzV6MGFKejJXbXMxTlBMNWJIdHV6Yk1lY0JV?=
 =?utf-8?B?YmFVZ0ZTQ2JwMlFYR2NYcjdoN1JJMjZEUlIrQi90QjJXZEFrNjBaTGg5emV5?=
 =?utf-8?B?b1dqaVJQc0Y3ckdXOU5Mc3BlY1J4dmsvM1BVRk1zSE1UY3BodUFoZVBUbllu?=
 =?utf-8?B?K0ZobnB3Vm1CVDV4d3Q0eVlxbU1LYkdkbUJFeGorSHBxY0xMTXQ2clJUTVVl?=
 =?utf-8?B?TVlVVklYM2ZtZVBYTTd4cmpZNnZLNG5RaHJjclZRcnpBSmJKcW5sdFQ5ZUl4?=
 =?utf-8?B?MXNkRmROR2R1TmpHZzI1S1NzUW4rNVIyQWQ4K0tkcng5dGpISHpHNTdYUkR0?=
 =?utf-8?B?VW1NT05zU3RLcW0yZVBUb2t1RENTdnlOQWdQRjB3bUQ4OEpocWVLTzUyN0w0?=
 =?utf-8?B?NEZuL1FxOXMyUVR0SEx3V0owbUxrcEh3YTBaaEUwSWRhTlo1dk5mbDZTeHVM?=
 =?utf-8?B?cW9nbnc1aWxXRVVSYWd3Wmd0UmdqMUc5d1JMd1ZXS29tcWllYXJiNTk4Y0Vi?=
 =?utf-8?B?TGlwQVRhT2lPUWk3Vk53RjFHK2I2MlNJVGVRcWdZQVdNTUd5bWNvMDk3VUda?=
 =?utf-8?B?Z0lBNzY4a0JzRDZHV1JWWS9lQXZXQ3d6L2wzZmZYMWFISFlzdFRiRUx5TzFa?=
 =?utf-8?B?OUJUN2psWVJBcXl5TVp1SVNGTyt5V0VrZ3hDZU9RNXB6N21Sb0J6dkNSM1VI?=
 =?utf-8?B?N3ZkdVYvajVrLzM4WGhTK012NllmMGZIT1BEYUNFWTJ6VUJWNE5vSG5kbVB3?=
 =?utf-8?B?U0ZheHFlZis2cUVwWlRQNTVSVmJ0blEwcDR0dXVOVDlOajRGbklVRDlCKzhS?=
 =?utf-8?B?M0tmQjJVamRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUlEWnpCTGRwUVB1aDRVaXFOVzkyM3RuN3JlOVdpTkY1a1ZvRXRhTCtSMzNw?=
 =?utf-8?B?eWZ4Q0tHY1FwRzdxUmRJTDdadCs3cit4dXBaWURMYytCSHZLNktMQng2Sjho?=
 =?utf-8?B?Wlp6Z3VmSldPZEYxSzUyQVVJWUptRDlBK2hralg0Wm9JRDJLRkRFU3pGNUVL?=
 =?utf-8?B?L1JaTUNxdzF3TnRFVURzcGRsQnZJNXFUN2VibVlVSDViRUxkZ0lsV2JOOXBT?=
 =?utf-8?B?SHl2YzFNSnhaNzNCWnBnRythNXdOT05KcnJyNGZsSkhMOHdkeEhBYnhaT0ZV?=
 =?utf-8?B?QUF5WkQwQVpJZnY4Qm9WcmtKM0RuQ1RtaDhBeDV5QzM1bTdYV3lJR01zcFRF?=
 =?utf-8?B?eHA1YVZobjlNaHBqZEhnRHdaamJLbG5BTFVzbmpGRFg4bHc2MjczYUJINFBj?=
 =?utf-8?B?dkd1KzhMNnYybk83ZExIa3czeTI1M056R3RvUWI1TnVMYS9DcXJFVS9TbHgw?=
 =?utf-8?B?bkQ3eHpNZ1N4T2c1a2EvY0RKa3dIanI0MFZqUGpxc1REblc4WTdTQXhOa1V5?=
 =?utf-8?B?dnpaMTNZekRrM3cxV1pqUk5SdEZLSnVxRGVNN3lXWnVTT2p6S1FTMmNyaStj?=
 =?utf-8?B?Ujl6MTVRcEM5WnZmTFRBSmlwUEY5UFo2L2FkZ2doeUdlL24ydG5rQ1FleDlP?=
 =?utf-8?B?N0R5d2hicUs0aElkT3NKSGhDTU45S1J3Vm1oTVJVN2FkdCtZb0ZZRmJpN21i?=
 =?utf-8?B?RXRvWWhuL0pha1NDR1ZUM1ZHbm1Wb0pldHkrQWIxR1FsUkR6Ui9ST0FpT3NX?=
 =?utf-8?B?dm9pV1o3bURaZWxqZzZnZjZ0S2FsL1Bkem5NU2dVMDMvaUlnUUNYa1hDS0t5?=
 =?utf-8?B?NnpLQkpqajcya2dNb0xLZDlzek5HSDFTWVE4SFNJZFNBa2NKYVJMbXVFMlo2?=
 =?utf-8?B?ZnZEMFNHQVk5S0dSWTBUTEQ2NWduaXN3RG04MkNvM1pUc3FvZVN4c1NHY2FX?=
 =?utf-8?B?dlVCTGc5dFZLTm41VlQwRStleWxGakpiR0VjRTdtSlEyQlJmRFJyeVZrRERD?=
 =?utf-8?B?amJ4YXJHZjJCbnRnaGN4bXhodXZZWllrcEp2U1p0QnZ5amhJUGdUbHVCdTlY?=
 =?utf-8?B?OFRxMGxJdlh4dVpCZ2NnR3pSRkMrWE05NkZKZTAvZm1aWmlCZ0RncjQrTUdm?=
 =?utf-8?B?ODU1WkRVYTByRW4wYlVGdXp0ZmJBNXhCU2UxWnFaUllwVXlmNTV1cVhTZ0V6?=
 =?utf-8?B?MjdlRzc1ekMrYmF4S3g3QmRyUytUTEpVQUNNL3JXWDZjamhsSXZqcXQ0YmNs?=
 =?utf-8?B?a3JpbUpRSnVFSVEvT0FsSU5JM05EYW10QmM1Z25VcTR4QW1UV25CTjdGdHN4?=
 =?utf-8?B?ZmI5Vk0vNFlRUGo0RTZBa0xldzM0d3dSYllrbEtQNHpNaWN0dzdkdTl5aXk5?=
 =?utf-8?B?cXpuN0pRQnlXR05CMG4yYTkxK2tmYktTcEEwaks4anpsME0wQjl5cmhpWXUy?=
 =?utf-8?B?Y0gwYWk5aUVsSmx1Q1FLdkNqLytmcDgrNjdmMmJlU2p3T2VUYjQrdnNkaDBU?=
 =?utf-8?B?VzZJbmJjR2F2dWl1RldvenZRdndNSDh6SXk2OVR5Yk5wSlpwMFMzSy8vQ2lm?=
 =?utf-8?B?Zk5FbW10cHgrVENBc1hWR0lOU1BGVGlnVWNDOGJvQjlvQzg2THdFVFZFU2xr?=
 =?utf-8?B?dnRoamFHVjFxcmg1VWlMdVo1Snd4NVp0OUhVYkE2dlNIWTR1ZEVuRFNvOEZB?=
 =?utf-8?B?K2xpc1BvaEl2aC9sUnp4amZwS0k3anB2b3dzMUxMS1FDaWQwNHQ5TE9NcmU3?=
 =?utf-8?B?TTBaOThJYzJPam5rbkl0Z3drOFVzOUppQlpaRnB5SDRWd1RQSFpEdFJKd1ZL?=
 =?utf-8?B?Tno4SnVuMEVUTXJjS1c4M3BHclRYdGFhZG1WV0U5Zi9EdXRzMDF3T1ZqUlR2?=
 =?utf-8?B?UzhGNnIyaHUxcW1PMUMzblVFaXZYVkNIQVk4Mnk2blJvcXFtb2VKYk5rMGEv?=
 =?utf-8?B?a0h2c01ZK1YrQUhLZmJHblp0OFo2Uys0OTV1QnVrVzh1cGlaZlliUDFudUs4?=
 =?utf-8?B?YWdvWDNsYkE3NzI1R2lXdTFuUGxnblhBWVBUaTFLb1paamxOQklYSU0ydzJD?=
 =?utf-8?B?R0xUMnNadDV5WUVIbERaOTdINjFCL004NjMyR24wZ0hDRWZCd1AvS2s2bmpG?=
 =?utf-8?B?bzN1Nm1WbFJaKzFHNkVrM0xuQ1V0clE2ZTRnOHQ0NVc3ZUJzQmY4N0V5eENO?=
 =?utf-8?Q?5znGj5VzV66xsAqLs+EcOnI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae48010-6245-449c-907f-08ddd44f14f9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:37:07.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKBshg9DRJAbz1yRqhV0Ja66VUGkjLcrxTXQp3dVyFO4qOWG22YXZErdwLM3txkv2ADvK6+9DcVc7ad1qsoid0AuT2mqE6L2Nfb+SRtsm0vATcWEvzIXRyPLdCP4ZVx2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7755

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

There are two kernel-doc like descriptions at cper, which is used
by other parts of cper and on ghes driver. They both have kernel-doc
like descriptions.

Change the tags for them to be actual kernel-doc tags and add them
to the driver-api documentaion at the UEFI section.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/driver-api/firmware/efi/index.rst | 11 ++++++++---
 drivers/firmware/efi/cper.c                     |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/firmware/efi/index.rst b/Documentation/driver-api/firmware/efi/index.rst
index 4fe8abba9fc6bf8ed53443e48e79285730871c32..5a6b6229592c9a9d1eb223966c582e0969ee9514 100644
--- a/Documentation/driver-api/firmware/efi/index.rst
+++ b/Documentation/driver-api/firmware/efi/index.rst
@@ -1,11 +1,16 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-============
-UEFI Support
-============
+====================================================
+Unified Extensible Firmware Interface (UEFI) Support
+====================================================
 
 UEFI stub library functions
 ===========================
 
 .. kernel-doc:: drivers/firmware/efi/libstub/mem.c
    :internal:
+
+UEFI Common Platform Error Record (CPER) functions
+==================================================
+
+.. kernel-doc:: drivers/firmware/efi/cper.c
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 79ba688a64f8da7af2dad097b9331c72afc73864..0232bd040f61c9b4521ae50ec4b6a1b0bfa5cc19 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -70,7 +70,7 @@ const char *cper_severity_str(unsigned int severity)
 }
 EXPORT_SYMBOL_GPL(cper_severity_str);
 
-/*
+/**
  * cper_print_bits - print strings for set bits
  * @pfx: prefix for each line, including log level and prefix string
  * @bits: bit mask

-- 
2.50.0


