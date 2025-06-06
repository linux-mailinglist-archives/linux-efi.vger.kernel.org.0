Return-Path: <linux-efi+bounces-3822-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384EEAD081E
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jun 2025 20:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C413ABB1A
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jun 2025 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0611E9906;
	Fri,  6 Jun 2025 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="YPGMF+D+"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2135.outbound.protection.outlook.com [40.107.101.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F2A13A41F;
	Fri,  6 Jun 2025 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749234641; cv=fail; b=JXIeaKOiMNg2vhmU3S1gAXO7PArJjsgIfb/68BM7m8SqLf9F7pj70o8aqIzQSckvsY00I5RxjxM6+F1oO7Hhe8NR2AJbx4//UfL261WcNSamWqeLKHtS56GN29bwhLgxIjFgJRkKW4j1mZDZY1NwnYH+M9nTp2bVaPDUP2U83pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749234641; c=relaxed/simple;
	bh=79fnhhj6YnyIT63/OxtrBN1LgWsQMfo3uB0I+Fu6Ros=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uyUMsO5au//7cjpgW71sMnoWK8lyUB84Rs1Hjdp4iEWar3qS1i3/jXiaAquJPe2KmEvONI+NIy7718muuO662YFHYNMmF1SluukWJSLqzkr5HQ5Mec/PsPGMUtV/YlbBZB9IuqM1qmsfGttEBPUIpzSiETkGtn+2YE1EZyDuMz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=YPGMF+D+; arc=fail smtp.client-ip=40.107.101.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R23lrfj2n2EhdZuA8ae0ekWo/nee4oEqDJOdKrY3ToB0tx5gQfC3pMXC6vWmYvsI/Yzu4cRlYfF5CsEjwvlXXYy/LcNpIbJk4Rts77nEqbe7KnkeR+K/UPEcuhXmmdS3BWYm2Jqvw6zUhJFQ+ubjfBV/LTFGw45m6WyBv6CnNLQjmRoYaR8Mg9Dm/xHYjLG/vwjbwCUUZaRwVpgcpDKWYDLisqJ/6h9dZLyZXcTTjVwbC6c0ewKnZ2zKiXAjeVoAAUUsQqJxAq0YA30cTXICYtkHWsfkohgk6f3FLTQc1Q9e/ATzaAIcUwjLITejGqOozf8+wCIBwlhQYOqHQ1bnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0xtbHlaADTMbNKM6N2Icm8Ajv3pfd9GQiY5NkrNoFA=;
 b=qvoR5SY4FSpwye4St0J55rR+LLJRfBTw7q5yTHe6EBx/E0kbqIFX770z3KIfvUCqAVQJjMTnhlvgA3XXm+G6TsLRPliKghnwL5QruJQugjOY/g947zsDm+9a1bZV9dJr8KfDHRmk/710SJ/ZZnYITHC6rQoP8Dh3n9V5OXPse13ezOXS7tjdLOCsV3AaowVGgXBpTI52UOUoHdXDhS7yfFYST7wHnXznBUKz0q04/ouGJBV6Ib8G7F8tbXbRqRFIyf+SJ1oVznyV1CUu1BZBSDbmH78UymnV+JuWiR0AJJrF1dXEXz+zRK5hGMG4A3tikVh/B/rry9xtMIKTlpzrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0xtbHlaADTMbNKM6N2Icm8Ajv3pfd9GQiY5NkrNoFA=;
 b=YPGMF+D+XoDc6CpN1ShTUNGxsBE9+CHkWxXN3hSoWR5m/DKzMKQ4Qy0fjaCsvvwUUFZJjytr8gHTlyEw1N40rogRywmRzEbZeLRFFscrPSAAF+ocEnPq7QsmbzUlHbRK6s3cpsf1iOoUcvb1ZhKx4+PeGlWmP96goEM9LR7x0f8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH3PR01MB8470.prod.exchangelabs.com (2603:10b6:610:1a4::21) by
 PH0PR01MB6167.prod.exchangelabs.com (2603:10b6:510:14::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.20; Fri, 6 Jun 2025 18:30:34 +0000
Received: from CH3PR01MB8470.prod.exchangelabs.com
 ([fe80::80c4:7216:f070:e5fd]) by CH3PR01MB8470.prod.exchangelabs.com
 ([fe80::80c4:7216:f070:e5fd%3]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 18:30:34 +0000
Message-ID: <efbc8109-1854-43b2-bff4-095ecd5970cd@os.amperecomputing.com>
Date: Fri, 6 Jun 2025 11:30:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Fix issues with ARM Processor CPER records
To: Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1725429659.git.mchehab+huawei@kernel.org>
 <20241011115707.GCZwkSk5ybx-s9AqMM@fat_crate.local>
 <CAMj1kXGQSgeshrns7-EwTkG_c1dHgaxaVxO_FxWumdFx6m4vRQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Ferguson <danielf@os.amperecomputing.com>
In-Reply-To: <CAMj1kXGQSgeshrns7-EwTkG_c1dHgaxaVxO_FxWumdFx6m4vRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::16) To CH3PR01MB8470.prod.exchangelabs.com
 (2603:10b6:610:1a4::21)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR01MB8470:EE_|PH0PR01MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: c84133c3-da2f-4795-3dbf-08dda52839b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk5nWmRBMXcxNFI1L043azRjZXYrYndZenVmSG92Qnc5bEdJT2pQSDVNVlMw?=
 =?utf-8?B?MXVud2pLOGZZVnFOSnVzS1paZ09ZSVNSRGdBdGc0NWFGcDFTNTB1MjRmNUsr?=
 =?utf-8?B?RWdkVWl0aTZ5UWc5aGFuN2ZMZHJhY1BZTkxEaXhXaEJqYk5GZCszcVluR3Ix?=
 =?utf-8?B?N0JxV203OVRMOWVsbXFBNWZ1elQrUGJDbWZYdFdKUCtlU014TGtSTXZCY2Vh?=
 =?utf-8?B?dmdoVG9WczZ3OWcxcTNZMzdsQ3lRMm5xa1pqUUZXZkQwdUpsc1NwZnllVzlq?=
 =?utf-8?B?YWY0RlVwNVp6eHVMWThMS3VQY0RDak9CU0oydjlxeXRuVk5BZ2tvT291VUR1?=
 =?utf-8?B?NUpsaS9laVkrdXFuSkl3RWdMc2RIckVSR285OS9YVHRRSnlTQzEvV0JKRlA3?=
 =?utf-8?B?WE5leVZ1L1IzNGV4VFRxZElyNUtrVGFucStXUW9VbUpoM2IrZjBkVURicjRL?=
 =?utf-8?B?RkdhLzd4VnZOQk5DclVnMEMwWmtMMDhzaHVsSDc0cHZxVURoUGxpd0k1ZjVZ?=
 =?utf-8?B?L0xMTXE1d1c0NjV1SC9RYTVkZFBOVmNNSVN1RkJJNzNzdzVrMVUzSUdmQUN6?=
 =?utf-8?B?RlV0QVJHS2hsYWhwVForaG9pVXEyRTlJNVVBLzlBVHMvOEJ4R2F2Z2hwb3ZT?=
 =?utf-8?B?dkNjYkdXV096RVYzVENFQ0J6ZVVQRFcyVFB6WlIvT0ppdU1DM0YzVGFmcFRU?=
 =?utf-8?B?ZEdrRzVHZWRDRVBkendJYjBqazVhY2F0M2RUdFFvRWc3SENMMHFjQ1lGc3dC?=
 =?utf-8?B?RnF0cnJUdlRmWjRkVUI2bko3OGZYcWFVZWFFREp2RXRUOWhJSHJrd0R2WE9i?=
 =?utf-8?B?T3lEY0UxWWh3ZDA1aVZ5MGIvaWRuR0dIRlZwNFAyeHJLcWxyczlNYnpnVzBN?=
 =?utf-8?B?STRJeDY0MnZlcnJFRGM3YnBkR0wveUY3VDZJQ1FIdkRBRkJMV1ZHSG5EWGxR?=
 =?utf-8?B?bDEzMFVDT0UrR25LUmNnc1BGS3k0Y2VUQ0N1SkZxeE80RVFqY211ZG5nU0E1?=
 =?utf-8?B?dnlmcW1JSjFCNUF5NzRxOWtaRE5kZmRNcksyOG96VytkWTlIMStraktGZ2VO?=
 =?utf-8?B?aXhZbGhNYmtPMlB0ZExycjlDNWVBdlVsK0FtaERUS055KzFqc3YzTEZneFFn?=
 =?utf-8?B?Q1FZVmdiNGJsdXVHckpQRitRcnVWL1lKZmtId0pPUGk4Y0tZdlduUnA0QnZp?=
 =?utf-8?B?WVhqd3VsVEwrUHpSaEFaV3k4ckZGMWxpK1RFcnIzSWczUXVrZWo4Tm1yT2Nl?=
 =?utf-8?B?T1ZVRlFkcCtrbmF2dmRUcDVTQUlCOS90Nk1qT2VMcDIzSWZRNVducWdmWnF6?=
 =?utf-8?B?U1ZrL1BIOU4wVzY0aW1CVzNPQ1FjWUErVytvTDR6YzdOWmkzekxxSW1ZR0p0?=
 =?utf-8?B?QlJqeHRkMTFVWEM3RiszZzNYVGhWS1UrbmxSWExEeFR0eHlQTkQ4cUdza3Fm?=
 =?utf-8?B?RWhZY3lhL0NwdUdqNXRmVEJOR2xUaDAwQ0pOeXVLNExEL3IrZjMzcDE4a09F?=
 =?utf-8?B?Y0xUVHFMMnppWjh3aDJpUDRnZngwM2N2UGdob1plVnJjNlJxU2kvemhPcE5u?=
 =?utf-8?B?aFNDNDk2LzdSK29WNnpkWHRMdzJCNXVGYng0bVBUUmJCYjIvazN3Y3VPdUhy?=
 =?utf-8?B?aTZtRmNseERhRllIZi93Umtsek41SXErSlQwV3ppRFJad3lPMzBqSi9udjYv?=
 =?utf-8?B?WFZ0eGtON3FWRnlmWWZ3dE1DV0o3aC9jQ1VxbWpwYW50eUxPUStmTUFwWTd1?=
 =?utf-8?B?enQ0ZzRIRWdFMldYQXZ6Y3BGNCtYYnhjUnRTNDZwbWRzZitKZUw3MlBOZjN5?=
 =?utf-8?B?cW95YUM5a3hTczkxblBXRWdpU2ZReTdmeS9QY2tiV0xVUEJZNW1EVXV0TU5j?=
 =?utf-8?B?NVRhS1VpdG4xdWR1VVUyTGZORDRIalNydFVqSCtpcG9wTU9LOFlHdmVhbkdi?=
 =?utf-8?B?Kzh5U09MTTJYU290SFBFR2F3aXJhcHZscEoyTkZydWF4SVhJNXB3MXZ0SVQv?=
 =?utf-8?B?T2FzT282aFJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR01MB8470.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTNpd2ErU0hUL1A0cktRLzFRWnJ0WmsvZ3R1L3RVMG9rczVyRENqZUJQQlZm?=
 =?utf-8?B?WDRpa0JPT2pYUU5ZMEdESTgyd21ranNiVWZnemhLZml4RGJlMGtJRDAxakh0?=
 =?utf-8?B?TkZ3azJacnZNckhyR2dRWW56ckhPclNIQWduemN4V0gvNVNvUFh5YUpGOVZ3?=
 =?utf-8?B?RS9aa2RjMWhHY21EL0hNSm1MOG1SQUpzZmlubDFaUE03UW9Fd0w1dXhrL3hB?=
 =?utf-8?B?UHh4V25EWjA5RHh2cXc4ZnBTbXVJT25PTTBsaitEQ3NUZlh2cFNEZGxlZXdv?=
 =?utf-8?B?UGIxbjN0a2pucCs2c0d4YlRTNnhXZGVXRXlNMGhINHpFdm5qeVJrOENLSVZm?=
 =?utf-8?B?RFZ3VUZQOVhpVElTa01yK1JNaHlXWHVnMjhUb0pJY1JSL3lkZlBOZXFIdy8r?=
 =?utf-8?B?b25vbU5uZVpiYzVYZ1hOSURZYVlmaXRIVGg2ZVZTVFlpVXNYUm5rb2EwRWpL?=
 =?utf-8?B?cFNrYnNvNVcvTFpFa1NaQ2hJSzhXMTdnM0dzRlNNblZWOHNOc1pjYS9NWDYz?=
 =?utf-8?B?KzJ3ak1PYmsyR3pRVFBBQ0VkaDluVy9CSHhjRmhkN0FUVWVwVmhrWGViUTRW?=
 =?utf-8?B?cFBtNmFydi9KendEZEwvZDNRT0MvWnpudXQvN3pxcTVMYWhaY0RtR0hUcEVw?=
 =?utf-8?B?ZVU1V0RONS9FejZIcUVGUzdlODc5M1U1emkrajJkUGtkNDA4MjA0dEF4U3RP?=
 =?utf-8?B?SWZFcXpwU3FDdGhHNnJONDZXZHBzclR2dkozVDIwbjUrSjBTeHBCbDhyK3Vv?=
 =?utf-8?B?bW0yVXlxVy8yWlJkcU0xNkhaVktTZ3FaRFFGdlV1QmVweEVKTzdOSnBmLzgr?=
 =?utf-8?B?a1NCdGJtVks1aGxOUzFVT0I3eUdVOTFjcWpUQlJoSFVVWGFuRkRrWnQrM2pk?=
 =?utf-8?B?WW9UbDlvVExrbk1GazcvS0t0cUgvd0RUWlZjcG4zdGZPWkRicXFJOHR1MDlF?=
 =?utf-8?B?Rko3dmFVZ2lDQjBldnhNd0JBNjVsL2VmYmZ3d3c0Rkt6ek5FLzR5Y0l4a0JN?=
 =?utf-8?B?eXFoU09wSXhGbmRHcUkyWU9YeS9nUWxwMElWUTJmN2QwTmp0RWFxSXpTbG11?=
 =?utf-8?B?RTIzSnRNVC81TEpVM3QwNUR6Y0t1NzBaUUhWOEsvMXY5bVBpYmNmN1A5Vkly?=
 =?utf-8?B?cVNZQXhON2ZqNFFOTnR2cytpcWtqOEZaWFZZZ3JTd2dQdDcyeHFWUzJidUd4?=
 =?utf-8?B?YU5sZ2pBWnMvMWk0alVpMGN4MUgyZFdKTVg5bE55aTFTNVN0N3FkTTM4S3ZF?=
 =?utf-8?B?S2tYTERHeDdwVnozc0pwaEQxQzVCMVFwWDZZTHBDU1lPY1JpSnJ2V2NCcW1z?=
 =?utf-8?B?VC9UTDJXNnlDTTlVdXVBTnQ0QkpoK29SSUlwVGlyaE9vWXhwWlVLenRpa3Zu?=
 =?utf-8?B?ZXl3N1E3RUs5K00vTGQ2WE9ZbFk4MVZpdWtSV0xkb0pNdUJqMXZZZ3dWUE9B?=
 =?utf-8?B?Qk5aYWRkR3hzekloUmlwTS9lbWoreVAxd0NFUzJ4d0JsaWUwRWhvTUVSK25K?=
 =?utf-8?B?bGRNejVzNFR6Yzd5N2MyVDJ4c3VXSkw5RmE4MHdqSVVEc3htdVNkU0hiVXdx?=
 =?utf-8?B?TERKV1VaNWpDKzhLQU8wazZYc3dtOGwycnU4QXpkVWlybWpWd3I2VTNxZStS?=
 =?utf-8?B?QkRJVFZKVzNlNEprc1lNRUcxaG0zUUtEREwyeGthcW15dllxZ1draU5rTFZQ?=
 =?utf-8?B?eTNqMUhCRE52Uyt3ZzI2RFlxRVdBbERyRnVlV0dQSk1ObnluNWkvTGZQRHoy?=
 =?utf-8?B?TjFHdVh2TUFIalY4QmtURy9tUzd5Y09XaXZIajVpUDFsMmtWMU16UGcwMCtO?=
 =?utf-8?B?K1FqMXdtVmtvUTd1U0w0NnExbWswb29Hb1I1Tmx1Qk9YaWM5eDBtS2VVbUxN?=
 =?utf-8?B?bjNKYlN2bDliSE5ZcDg3c2xuakt4cWRDLzd5N08xQXliM3NoODZERm11Mzhp?=
 =?utf-8?B?ZUpweGVUN3FCWFdCbVZjcDNqZGdWTGhXUG84dDN1aDd3RnNlRGJpUHdKV0Ry?=
 =?utf-8?B?ODdNZ2hpSHJJS2ZMaFNpdHhlOTR1L1IrLzFiRk91WUREdTBBRmE2TXgybnQ0?=
 =?utf-8?B?TG1GYnNrZWZyR3lyczdsaGZTaDgwZEhpa0JYN0U1bnBHRmhUR1RNRFF0VHRx?=
 =?utf-8?B?dlhPTDBSUEhKL09lR0VUSngwVXpMZDRmNGh2bmpwSHNveGpheGIyMGRvMm1G?=
 =?utf-8?Q?ZPGgGzBBqE6GRUKg91jIKtk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84133c3-da2f-4795-3dbf-08dda52839b1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR01MB8470.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 18:30:34.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MklcXgzK/QvIAhpgoGAGlzROzTt0jTtmC3zgXwWeFnlC8EUs6azJqThVw1uIrfmUVU5SYWceso1qXSmVb8fI4AAVJPupoMwc5vUNcbt+jQO4WXM43cT6x8RQYfcm7Ooq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6167



On 10/14/2024 3:00 AM, Ard Biesheuvel wrote:
> On Fri, 11 Oct 2024 at 13:57, Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Wed, Sep 04, 2024 at 08:07:13AM +0200, Mauro Carvalho Chehab wrote:
>>> Jason Tian (1):
>>>   RAS: Report all ARM processor CPER information to userspace
>>>
>>> Mauro Carvalho Chehab (4):
>>>   efi/cper: Adjust infopfx size to accept an extra space
>>>   efi/cper: Add a new helper function to print bitmasks
>>>   efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
>>>   docs: efi: add CPER functions to driver-api
>>>
>>>  .../driver-api/firmware/efi/index.rst         | 11 +++-
>>>  drivers/acpi/apei/ghes.c                      | 27 ++++----
>>>  drivers/firmware/efi/cper-arm.c               | 52 ++++++++--------
>>>  drivers/firmware/efi/cper.c                   | 62 ++++++++++++++++++-
>>>  drivers/ras/ras.c                             | 41 +++++++++++-
>>>  include/linux/cper.h                          | 12 ++--
>>>  include/linux/ras.h                           | 16 ++++-
>>>  include/ras/ras_event.h                       | 48 ++++++++++++--
>>>  8 files changed, 210 insertions(+), 59 deletions(-)
>>
>> With the issues to patch 1 fixed:
>>
>> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
>>
>> I'm presuming this'll go through Ard's tree. Alternatively, I can pick it up
>> too with Ard's ack.
>>
> 
> Either works for me.
> 
> Mauro: please put all maintainers on cc of the code you are touching - thanks.

What can I do to help this patch move forward?
I noticed it needs to be rebased as of kernel v6.15.

Would it be helpful if I were to rebase, add all the maintainers to the cc, and
resubmit ?

I did rebase to v6.15 and tested. Everything still seems good to go.


